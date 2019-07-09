Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DF2C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3484520645
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfGIKVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 06:21:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44704 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfGIKVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 06:21:10 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hknF8-0004PR-S0; Tue, 09 Jul 2019 12:21:02 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH POC] printk_ringbuffer: Alternative implementation of lockless printk ringbuffer
References: <20190621140516.h36g4in26pe3rmly@pathway.suse.cz>
        <20190704103321.10022-1-pmladek@suse.com>
        <20190704103321.10022-1-pmladek@suse.com>
        <87r275j15h.fsf@linutronix.de>
        <20190708152311.7u6hs453phhjif3q@pathway.suse.cz>
        <20190708152311.7u6hs453phhjif3q@pathway.suse.cz>
        <874l3wng7g.fsf@linutronix.de>
        <20190709090609.shx7j2mst7wlkbqm@pathway.suse.cz>
Date:   Tue, 09 Jul 2019 12:21:01 +0200
In-Reply-To: <20190709090609.shx7j2mst7wlkbqm@pathway.suse.cz> (Petr Mladek's
        message of "Tue, 9 Jul 2019 11:06:09 +0200")
Message-ID: <87tvbv33w2.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-09, Petr Mladek <pmladek@suse.com> wrote:
>>>> 1. The code claims that the cmpxchg(seq_newest) in
>>>> prb_reserve_desc() guarantees that "The descriptor is ours until
>>>> the COMMITTED bit is set."  This is not true if in that wind
>>>> seq_newest wraps, allowing another writer to gain ownership of the
>>>> same descriptor. For small descriptor arrays (such as in my test
>>>> module), this situation is quite easy to reproduce.
>>>
>> Let me inline the function are talking about and add commentary to
>> illustrate what I am saying:
>> 
>> static int prb_reserve_desc(struct prb_reserved_entry *entry)
>> {
>> 	unsigned long seq, seq_newest, seq_prev_wrap;
>> 	struct printk_ringbuffer *rb = entry->rb;
>> 	struct prb_desc *desc;
>> 	int err;
>> 
>> 	/* Get descriptor for the next sequence number. */
>> 	do {
>> 		seq_newest = READ_ONCE(rb->seq_newest);
>> 		seq = (seq_newest + 1) & PRB_SEQ_MASK;
>> 		seq_prev_wrap = (seq - PRB_DESC_SIZE(rb)) & PRB_SEQ_MASK;
>> 
>> 		/*
>> 		 * Remove conflicting descriptor from the previous wrap
>> 		 * if ever used. It might fail when the related data
>> 		 * have not been committed yet.
>> 		 */
>> 		if (seq_prev_wrap == READ_ONCE(rb->seq_oldest)) {
>> 			err = prb_remove_desc_oldest(rb, seq_prev_wrap);
>> 			if (err)
>> 				return err;
>> 		}
>> 	} while (cmpxchg(&rb->seq_newest, seq_newest, seq) != seq_newest);
>> 
>> I am referring to this point in the code, after the
>> cmpxchg(). seq_newest has been incremented but the descriptor is
>> still in the unused state and seq is still 1 wrap behind. If an NMI
>> occurs here and the NMI (or some other CPU) inserts enough entries to
>> wrap the descriptor array, this descriptor will be reserved again,
>> even though it has already been reserved.
>
> Not really, the NMI will not reach the cmpxchg() in this case.
> prb_remove_desc_oldest() will return error.

Why will prb_remove_desc_oldest() fail? IIUC, it will return success
because the descriptor is in the desc_miss state.

> It will not be able to remove the conflicting descriptor because
> it will still be occupied by a two-wraps-old descriptor.

Please explain why with more details. Perhaps providing a function call
chain?  Sorry if I'm missing the obvious here.

This is really the critical point that drove me to use lists: multiple
writers expiring and reserving the same descriptors.

John Ogness
