Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53360C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2D02072D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfLIJJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:09:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37959 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLIJJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:09:36 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1ieF2c-0005Gv-91; Mon, 09 Dec 2019 10:09:18 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
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
        <20191209084300.GD88619@google.com>
Date:   Mon, 09 Dec 2019 10:09:16 +0100
In-Reply-To: <20191209084300.GD88619@google.com> (Sergey Senozhatsky's message
        of "Mon, 9 Dec 2019 17:43:00 +0900")
Message-ID: <87r21dzwzn.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-09, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
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
>> +
>> +	data_size = min_t(u16, buf_size, len);
>> +
>> +	if (!WARN_ON_ONCE(!data_size))
>> +		memcpy(&buf[0], data, data_size);
>> +	return true;
>> +}
>> +
>> +/*
>> + * Read the record @id and verify that it is committed and has the sequence
>> + * number @seq.
>> + *
>> + * Error return values:
>> + * -EINVAL: The record @seq does not exist.
>> + * -ENOENT: The record @seq exists, but its data is not available. This is a
>> + *          valid record, so readers should continue with the next seq.
>> + */
>> +static int desc_read_committed(struct prb_desc_ring *desc_ring, u32 id,
>> +			       u64 seq, struct prb_desc *desc)
>> +{
>> +	enum desc_state d_state;
>> +
>> +	d_state = desc_read(desc_ring, id, desc);
>> +	if (desc->info.seq != seq)
>> +		return -EINVAL;
>> +	else if (d_state == desc_reusable)
>> +		return -ENOENT;
>> +	else if (d_state != desc_committed)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Copy the ringbuffer data from the record with @seq to the provided
>> + * @r buffer. On success, 0 is returned.
>> + *
>> + * See desc_read_committed() for error return values.
>> + */
>> +static int prb_read(struct printk_ringbuffer *rb, u64 seq,
>> +		    struct printk_record *r)
>> +{
>> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>> +	struct prb_desc *rdesc = to_desc(desc_ring, seq);
>> +	atomic_t *state_var = &rdesc->state_var;
>> +	struct prb_desc desc;
>> +	int err;
>> +	u32 id;
>> +
>> +	/* Get a reliable local copy of the descriptor and check validity. */
>> +	id = DESC_ID(atomic_read(state_var));
>> +	err = desc_read_committed(desc_ring, id, seq, &desc);
>> +	if (err)
>> +		return err;
>> +
>> +	/* If requested, copy meta data. */
>> +	if (r->info)
>> +		memcpy(r->info, &desc.info, sizeof(*(r->info)));
>
> I wonder if those WARN_ON-s will trigger false positive sometimes.
>
> A theoretical case.
>
> What if reader gets preempted/interrupted in the middle of
> desc_read_committed()->desc_read()->memcpy(). The context which
> interrupts the reader recycles the descriptor and pushes new
> data. Suppose that reader was interrupted right after it copied
> ->info.seq and ->info.text_len.  So the first desc_read_committed()
> will pass - we have matching ->seq and committed state. copy_data(),
> however, most likely, will generate WARNs. The final
> desc_read_committed() will notice that local copy of desc was in
> non-consistent state and everything is fine, but we have WARNs in the
> log buffer now.

Be aware that desc_read_committed() is filling a copy of the descriptor
in the local variable @desc. If desc_read_committed() succeeded, that
local copy _must_ be consistent. If the WARNs trigger, either
desc_read_committed() or the writer code is broken.

John Ogness
