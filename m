Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077E1C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31592081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfCGMG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:06:56 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54167 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGMG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:06:56 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1h1rnJ-0007Zn-8G; Thu, 07 Mar 2019 13:06:37 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-9-john.ogness@linutronix.de>
        <20190304073856.GA552@jagdpanzerIV>
Date:   Thu, 07 Mar 2019 13:06:34 +0100
Message-ID: <87va0uopmd.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-04, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>> +	/* the printk kthread never exits */
>> +	for (;;) {
>> +		ret = prb_iter_wait_next(&iter, buf,
>> +					 PRINTK_RECORD_MAX, &master_seq);
>> +		if (ret == -ERESTARTSYS) {
>> +			continue;
>> +		} else if (ret < 0) {
>> +			/* iterator invalid, start over */
>> +			prb_iter_init(&iter, &printk_rb, NULL);
>> +			continue;
>> +		}
>> +
>> +		msg = (struct printk_log *)buf;
>> +		format_text(msg, master_seq, ext_text, &ext_len, text,
>> +			    &len, printk_time);
>> +
>> +		console_lock();
>> +		if (len > 0 || ext_len > 0) {
>> +			call_console_drivers(ext_text, ext_len, text, len);
>> +			boot_delay_msec(msg->level);
>> +			printk_delay();
>> +		}
>> +		console_unlock();
>> +	}
>
> This, theoretically, creates a whole new world of possibilities for
> console drivers. Now they can do GFP_KERNEL allocations and stall
> printk_kthread during OOM; or they can explicitly reschedule from
> ->write() callback (via console_conditional_schedule()) because
> console_lock() sets console_may_schedule.

This was the intention. Although, as I mentioned in a previous
response[0], perhaps we should not loosen the requirements on write().

> It's one thing to do cond_resched() (or to let preemption to take
> over) after call_console_drivers() (when we are done printing a
> message to all console drivers) and another thing to let preemption to
> take over while we are printing a messages to the consoles. It
> probably would make sense to disable preemption around
> call_console_drivers().

I could see disabling preemption and interrupts for emergency messages
in the printk-kthread in order to synchronize against an irq_work
secondary printer as suggested in my response[0]. But I don't see an
advantage to disabling preemption in general for
call_console_drivers(). It is exactly that disable_preempt() that is so
harmful for realtime tasks.

John Ogness

[0] https://lkml.kernel.org/r/87lg1rggcz.fsf@linutronix.de
