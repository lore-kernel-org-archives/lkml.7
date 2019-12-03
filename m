Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06FFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEB82073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfLCNqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:46:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54672 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCNqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:46:21 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1ic8VE-000255-VF; Tue, 03 Dec 2019 14:46:09 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v5 2/3] printk-rb: new printk ringbuffer implementation (reader)
References: <20191128015235.12940-1-john.ogness@linutronix.de>
        <20191128015235.12940-3-john.ogness@linutronix.de>
        <20191203120622.zux33do54rmjafns@pathway.suse.cz>
Date:   Tue, 03 Dec 2019 14:46:07 +0100
In-Reply-To: <20191203120622.zux33do54rmjafns@pathway.suse.cz> (Petr Mladek's
        message of "Tue, 3 Dec 2019 13:06:22 +0100")
Message-ID: <87pnh5bjz4.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-03, Petr Mladek <pmladek@suse.com> wrote:
>> Add the reader implementation for the new ringbuffer.
>> 
>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>> ---
>>  kernel/printk/printk_ringbuffer.c | 234 ++++++++++++++++++++++++++++++
>>  kernel/printk/printk_ringbuffer.h |  12 +-
>>  2 files changed, 245 insertions(+), 1 deletion(-)
>> 
>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>> index 09c32e52fd40..f85762713583 100644
>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> @@ -674,3 +674,237 @@ void prb_commit(struct prb_reserved_entry *e)
>>  	local_irq_restore(e->irqflags);
>>  }
>>  EXPORT_SYMBOL(prb_commit);
>> +
>> +/*
>> + * Given @blk_lpos, return a pointer to the raw data from the data block
>> + * and calculate the size of the data part. A NULL pointer is returned
>> + * if @blk_lpos specifies values that could never be legal.
>> + *
>> + * This function (used by readers) performs strict validation on the lpos
>> + * values to possibly detect bugs in the writer code. A WARN_ON_ONCE() is
>> + * triggered if an internal error is detected.
>> + */
>> +static char *get_data(struct prb_data_ring *data_ring,
>> +		      struct prb_data_blk_lpos *blk_lpos,
>> +		      unsigned long *data_size)
>> +{
>> +	struct prb_data_block *db;
>> +
>> +	if (blk_lpos->begin == INVALID_LPOS &&
>> +	    blk_lpos->next == INVALID_LPOS) {
>> +		/* descriptor without a data block */
>> +		return NULL;
>> +	} else if (DATA_WRAPS(data_ring, blk_lpos->begin) ==
>> +		   DATA_WRAPS(data_ring, blk_lpos->next)) {
>> +		/* regular data block */
>> +		if (WARN_ON_ONCE(blk_lpos->next <= blk_lpos->begin))
>> +			return NULL;
>> +		db = to_block(data_ring, blk_lpos->begin);
>> +		*data_size = blk_lpos->next - blk_lpos->begin;
>> +
>> +	} else if ((DATA_WRAPS(data_ring, blk_lpos->begin) + 1 ==
>> +		    DATA_WRAPS(data_ring, blk_lpos->next)) ||
>> +		   ((DATA_WRAPS(data_ring, blk_lpos->begin) ==
>> +		     DATA_WRAPS(data_ring, -1UL)) &&
>> +		    (DATA_WRAPS(data_ring, blk_lpos->next) == 0))) {
>
> I am a bit confused. I would expect that (-1UL + 1) = 0. So the second
> condition after || looks just like a special variant of the first
> valid condition.
>
> Or do I miss anything? Is there a problems with type casting?

Sorry, this code deserves a comment.

Here we are only comparing the number of wraps. For a wrapping data
block, @begin will be 1 wrap less than @next. The first part of the
check is checking the typical case, making sure that:

   1 + WRAPS(@begin) == WRAPS(@next)

There is also the case when the lpos overflows. In that case the number
of wraps starts over at zero (without having overflowed). (Note: The
lpos overflows, _not_ the number of wraps. This is why the first check
is not enough.) In this case, the number of wraps of the highest
possible lpos value (-1UL) should be the same as the number of wraps of
@begin. And the number of wraps of @next should be 0. The simplified
pseudo-code check is:

   WRAPS(@begin) == WRAPS(-1UL)
      &&
   WRAPS(@next) == 0

>> +		/* wrapping data block */
>> +		db = to_block(data_ring, 0);
>> +		*data_size = DATA_INDEX(data_ring, blk_lpos->next);
>> +
>> +	} else {
>> +		WARN_ON_ONCE(1);
>> +		return NULL;
>> +	}
>> +
>> +	/* A valid data block will always be aligned to the ID size. */
>> +	if (WARN_ON_ONCE(blk_lpos->begin !=
>> +			 ALIGN(blk_lpos->begin, sizeof(db->id))) ||
>> +	    WARN_ON_ONCE(blk_lpos->next !=
>> +			 ALIGN(blk_lpos->next, sizeof(db->id)))) {
>> +		return NULL;
>> +	}
>> +
>> +	/* A valid data block will always have at least an ID. */
>> +	if (WARN_ON_ONCE(*data_size < sizeof(db->id)))
>> +		return NULL;
>> +
>> +	/* Subtract descriptor ID space from size. */
>> +	*data_size -= sizeof(db->id);
>> +
>> +	return &db->data[0];
>> +}
>> +
>> +/* Given @blk_lpos, copy an expected @len of data into the provided buffer. */
>> +static bool copy_data(struct prb_data_ring *data_ring,
>> +		      struct prb_data_blk_lpos *blk_lpos, u16 len, char *buf,
>> +		      unsigned int buf_size)
>> +{
>> +	unsigned long data_size;
>> +	char *data;
>> +
>> +	/* Caller might not want the data. */
>> +	if (!buf || !buf_size)
>> +		return true;
>> +
>> +	data = get_data(data_ring, blk_lpos, &data_size);
>> +	if (!data)
>> +		return false;
>> +
>> +	/* Actual cannot be less than expected. */
>> +	if (WARN_ON_ONCE(data_size < len))
>> +		return false;
>
> I do not have a good feeling that the record gets lost here.
>
> I could imagine that a writer would reserve more space than
> needed in the end. Then it would want to modify desc.info.text_len
> and could do a mistake.
>
> By other words, I would expect a bug on the writer side here.
> And I would try to preserve the data by calling:
>
> pr_warn_once("Wrong data_size (%lu) for data: %.*s\n", data_size,
> data_size, data);
>
> Well, I do not resist on it. WARN_ON_ONCE() is fine as well.

Since readers will run in their own kthread, the WARN_ON_ONCE() will not
be sufficient to identify the bug. Attempting to print the bad string
would help. (Although I expect we will not hit these WARN_ON's since we
are the ones implementing printk.)

John Ogness
