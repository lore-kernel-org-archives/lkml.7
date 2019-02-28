Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D261C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167DB218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551384020;
	bh=zW61m0+J9CynTM7mvwP9OrGq6ZS5vWwO6gG9+Sk+gqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=l2XypgdQv2GIALCleXFwniYKTwTNeZ7xqXpp1h7xvbaCPzpuwXcawQ/lVOckA0jPB
	 neHLy9UiDPJbl3XZ+CyeRryOzSsutDlCoowejZgw6b2+1gQdsiFiM6g/Vs2EuN49Qu
	 m55QvdEloTElqM9niZnFTTGidMg1bbpt4Qa/GyKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388164AbfB1UAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:00:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55332 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfB1UAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:00:17 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 013AFB1EB;
        Thu, 28 Feb 2019 20:00:15 +0000 (UTC)
Date:   Thu, 28 Feb 2019 12:00:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5] panic: Avoid the extra noise dmesg
Message-Id: <20190228120014.19c0ab9227809341c1d5acc6@linux-foundation.org>
In-Reply-To: <20190222060959.pe3u4yvcjw6yj347@shbuild888>
References: <1550815226-34194-1-git-send-email-feng.tang@intel.com>
        <20190222060959.pe3u4yvcjw6yj347@shbuild888>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 14:09:59 +0800 Feng Tang <feng.tang@intel.com> wrote:

> When kernel panic happens, it will first print the panic call stack,
> then the ending msg like:
> 
> [   35.743249] ---[ end Kernel panic - not syncing: Fatal exception
> [   35.749975] ------------[ cut here ]------------
> 
> The above message are very useful for debugging.
> 
> But if system is configured to not reboot on panic, say the "panic_timeout"
> parameter equals 0, it will likely print out many noisy message like
> WARN() call stack for each and every CPU except the panic one, messages
> like below:
> 
> 	WARNING: CPU: 1 PID: 280 at kernel/sched/core.c:1198 set_task_cpu+0x183/0x190
> 	Call Trace:
> 	<IRQ>
> 	try_to_wake_up
> 	default_wake_function
> 	autoremove_wake_function
> 	__wake_up_common
> 	__wake_up_common_lock
> 	__wake_up
> 	wake_up_klogd_work_func
> 	irq_work_run_list
> 	irq_work_tick
> 	update_process_times
> 	tick_sched_timer
> 	__hrtimer_run_queues
> 	hrtimer_interrupt
> 	smp_apic_timer_interrupt
> 	apic_timer_interrupt

It's a fairly ugly-looking patch but I am inclined to agree.

The panicing CPU is spinning and blinking a LED and all CPUs have
interrupts enabled and the system is known to be in a messed up state. 
All sorts of kernel code could emit all sorts of output in such
circumstances.  So a global printk-killing knob seems appropriate.

Thoughts:

- why do the suppression in vprintk_emit()?  Doing it right at entry
  to printk() seems cleaner, more explicit?

- Other code sites may wish to suppress all printks.  Perhaps
  `panic_suppress_printk' should just be called `suppress_printk'?


