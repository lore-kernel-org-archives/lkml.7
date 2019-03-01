Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02E3C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C453E2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbfCAKGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:06:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:42570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728255AbfCAKGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:06:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EDDA5AE98;
        Fri,  1 Mar 2019 10:06:15 +0000 (UTC)
Date:   Fri, 1 Mar 2019 11:06:14 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6] panic: Avoid the extra noise dmesg
Message-ID: <20190301100614.yzor7mhtqd2sydo6@pathway.suse.cz>
References: <1551430186-24169-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551430186-24169-1-git-send-email-feng.tang@intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-03-01 16:49:46, Feng Tang wrote:
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
> 
> For people working in console mode, the screen will first show the panic
> call stack, but immediately overridden by these noisy extra messages, which
> makes debugging much more difficult, as the original context gets lost on
> screen.
> 
> Also these noisy messages will confuse some users, as I have seen many bug
> reporters posted the noisy message into bugzilla, instead of the real panic
> call stack and context.
> 
> Adding a flag "suppress_printk" which gets set in panic() to avoid those
> noisy messages, without changing current kernel behavior that both panic
> blinking and sysrq magic key can work as is, suggested by Petr Mladek.
> 
> To verify this, make sure kernel is not configured to reboot on panic and
> in console
>  # echo c > /proc/sysrq-trigger
> to see if console only prints out the panic call stack.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

The patch looks fine to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
