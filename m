Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E7BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 04:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD90A2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 04:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfCAEJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 23:09:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:47609 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCAEJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 23:09:30 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 20:09:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,425,1544515200"; 
   d="scan'208";a="147543536"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.147.114])
  by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2019 20:09:26 -0800
Date:   Fri, 1 Mar 2019 12:11:31 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20190301041131.ypg6oaxhzyrgkkfu@shbuild888>
References: <1550815226-34194-1-git-send-email-feng.tang@intel.com>
 <20190222060959.pe3u4yvcjw6yj347@shbuild888>
 <20190228120014.19c0ab9227809341c1d5acc6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228120014.19c0ab9227809341c1d5acc6@linux-foundation.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks for the review!

On Thu, Feb 28, 2019 at 12:00:14PM -0800, Andrew Morton wrote:
> On Fri, 22 Feb 2019 14:09:59 +0800 Feng Tang <feng.tang@intel.com> wrote:
> 
> > When kernel panic happens, it will first print the panic call stack,
> > then the ending msg like:
> > 
> > [   35.743249] ---[ end Kernel panic - not syncing: Fatal exception
> > [   35.749975] ------------[ cut here ]------------
> > 
> > The above message are very useful for debugging.
> > 
> > But if system is configured to not reboot on panic, say the "panic_timeout"
> > parameter equals 0, it will likely print out many noisy message like
> > WARN() call stack for each and every CPU except the panic one, messages
> > like below:
> > 
> > 	WARNING: CPU: 1 PID: 280 at kernel/sched/core.c:1198 set_task_cpu+0x183/0x190
> > 	Call Trace:
> > 	<IRQ>
> > 	try_to_wake_up
> > 	default_wake_function
> > 	autoremove_wake_function
> > 	__wake_up_common
> > 	__wake_up_common_lock
> > 	__wake_up
> > 	wake_up_klogd_work_func
> > 	irq_work_run_list
> > 	irq_work_tick
> > 	update_process_times
> > 	tick_sched_timer
> > 	__hrtimer_run_queues
> > 	hrtimer_interrupt
> > 	smp_apic_timer_interrupt
> > 	apic_timer_interrupt
> 
> It's a fairly ugly-looking patch but I am inclined to agree.

Yes, it's ugly :) we've changed 3 methods to tackle this.

> The panicing CPU is spinning and blinking a LED and all CPUs have
> interrupts enabled and the system is known to be in a messed up state. 
> All sorts of kernel code could emit all sorts of output in such
> circumstances.  So a global printk-killing knob seems appropriate.
> 
> Thoughts:
> 
> - why do the suppression in vprintk_emit()?  Doing it right at entry
>   to printk() seems cleaner, more explicit?

Yes, I put it in printk() in one earlier post, and Petr suggested to
put it into vprintk_emit so that it works for all printk() interfaces,
like the devkmsg_write -> printk_emit -> vprintk_emit path.

> 
> - Other code sites may wish to suppress all printks.  Perhaps
>   `panic_suppress_printk' should just be called `suppress_printk'?
Ok, then I'll move the definition from panic.c to printk code.

Thanks,
Feng

