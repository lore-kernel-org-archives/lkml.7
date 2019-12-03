Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD00C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233AB2154A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLCOOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:14:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54788 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfLCONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:13:47 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1ic8vq-0002i0-2z; Tue, 03 Dec 2019 15:13:38 +0100
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
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer implementation (writer)
References: <20191128015235.12940-1-john.ogness@linutronix.de>
        <20191128015235.12940-2-john.ogness@linutronix.de>
        <20191202154841.qikvuvqt4btudxzg@pathway.suse.cz>
Date:   Tue, 03 Dec 2019 15:13:36 +0100
In-Reply-To: <20191202154841.qikvuvqt4btudxzg@pathway.suse.cz> (Petr Mladek's
        message of "Mon, 2 Dec 2019 16:48:41 +0100")
Message-ID: <87fti1bipb.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-02, Petr Mladek <pmladek@suse.com> wrote:
>> +/*
>> + * Sanity checker for reserve size. The ringbuffer code assumes that a data
>> + * block does not exceed the maximum possible size that could fit within the
>> + * ringbuffer. This function provides that basic size check so that the
>> + * assumption is safe.
>> + */
>> +static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
>> +{
>> +	struct prb_data_block *db = NULL;
>> +
>> +	/* Writers are not allowed to write data-less records. */
>> +	if (size == 0)
>> +		return false;
>
> I would personally let this decision to the API caller.
>
> The code actually have to support data-less records. They are used
> when the descriptor is reserved but the data block can't get reserved.

Exactly. Data-less records are how the ringbuffer identifies that data
has been lost. If users were allowed to store data-less records, that
destinction is no longer possible (unless I created some extra field in
the descriptor). Does it even make sense for printk to store data-less
records explicitly?

The current printk implementation silently ignores empty messages.

> The above statement might create false feeling that it could not
> happen later in the code. It might lead to bugs in writer code.

Then let me change the statement to describe that data-less records are
used internally by the ringbuffer and cannot be explicitly created by
writers.

> Also reader API users might not expect to get a "valid" data-less
> record.

Readers will never see them. The reader API implementation skips over
data-less records.

John Ogness
