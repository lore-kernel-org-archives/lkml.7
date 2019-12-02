Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57149C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE28215E5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575317028;
	bh=ObMQXij7UNQyPLmBCJawoB22jXPqknRYW9MQXk1d6Qc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=W9OLbAiIFB92aWsqNlDsxHKbYIfJdSeek1NUPIuCZpPBQJISW979y5f21FmQp+rbw
	 8Bp5rCKf3GjIYEDSrTSHj8ZH/RcV4D2kcKa/o6kAfkunjPXZYYEIzJgD46LdI8z455
	 icXE7dafzSPFE9MyzJcoqVSQSp6pePHQw+piTEzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfLBUDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbfLBUDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:03:46 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54486214AF;
        Mon,  2 Dec 2019 20:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575317025;
        bh=ObMQXij7UNQyPLmBCJawoB22jXPqknRYW9MQXk1d6Qc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eeu9wllFSpwrVG7DeebZ5Kk2eE76wfP+aPTiq/70Oa3FBMABvq74LbN7CV6LzaErn
         UrKFBnBIsMTtMy4c7VHElAOz0eGtl7AGFkxNlXF5LiHLuOTASkZkzs76jigYBW+5kM
         XmUrwHFaRvJ5BwawvdGjQ7qFys7RX0qRI7/BSGzg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 207AA3520649; Mon,  2 Dec 2019 12:03:45 -0800 (PST)
Date:   Mon, 2 Dec 2019 12:03:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] kernel: set taint flag 'L' at any kind of lockup
Message-ID: <20191202200345.GV2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <157503370645.8187.6335564487789994134.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157503370645.8187.6335564487789994134.stgit@buzz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 04:21:46PM +0300, Konstantin Khlebnikov wrote:
> Any lockup or stall notifies about unexpected lack of progress.
> It's better to know about them for further problem investigations.
> 
> Right now only softlockup has own taint flag. Let's generalize it.
> 
> This patch renames TAINT_SOFTLOCKUP into TAINT_LOCKUP at sets it for:
> - softlockup
> - hardlockup
> - RCU stalls
> - stuck in workqueues
> - detected task hung
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

From an RCU perspective,

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  Documentation/admin-guide/sysctl/kernel.rst   |    2 +-
>  Documentation/admin-guide/tainted-kernels.rst |    8 ++++++--
>  include/linux/kernel.h                        |    2 +-
>  kernel/hung_task.c                            |    2 ++
>  kernel/panic.c                                |    2 +-
>  kernel/rcu/tree_stall.h                       |    1 +
>  kernel/watchdog.c                             |    2 +-
>  kernel/watchdog_hld.c                         |    1 +
>  kernel/workqueue.c                            |    1 +
>  tools/debugging/kernel-chktaint               |    2 +-
>  10 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 032c7cd3cede..60867ec525a4 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1082,7 +1082,7 @@ ORed together. The letters are seen in "Tainted" line of Oops reports.
>    2048  `(I)`  workaround for bug in platform firmware applied
>    4096  `(O)`  externally-built ("out-of-tree") module was loaded
>    8192  `(E)`  unsigned module was loaded
> - 16384  `(L)`  soft lockup occurred
> + 16384  `(L)`  lockup occurred
>   32768  `(K)`  kernel has been live patched
>   65536  `(X)`  Auxiliary taint, defined and used by for distros
>  131072  `(T)`  The kernel was built with the struct randomization plugin
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index 71e9184a9079..fc76d0aad9f5 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -96,7 +96,7 @@ Bit  Log  Number  Reason that got the kernel tainted
>   11  _/I    2048  workaround for bug in platform firmware applied
>   12  _/O    4096  externally-built ("out-of-tree") module was loaded
>   13  _/E    8192  unsigned module was loaded
> - 14  _/L   16384  soft lockup occurred
> + 14  _/L   16384  lockup occurred
>   15  _/K   32768  kernel has been live patched
>   16  _/X   65536  auxiliary taint, defined for and used by distros
>   17  _/T  131072  kernel was built with the struct randomization plugin
> @@ -152,7 +152,11 @@ More detailed explanation for tainting
>   13) ``E`` if an unsigned module has been loaded in a kernel supporting
>       module signature.
>  
> - 14) ``L`` if a soft lockup has previously occurred on the system.
> + 14) ``L`` if some kind of lockup has previously occurred on the system:
> +     - soft/hardlockup, see Documentation/admin-guide/lockup-watchdogs.rst
> +     - RCU stall, see Documentation/RCU/stallwarn.txt
> +     - hung task detected, see CONFIG_DETECT_HUNG_TASK
> +     - kernel workqueue lockup, see CONFIG_WQ_WATCHDOG
>  
>   15) ``K`` if the kernel has been live patched.
>  
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index d83d403dac2e..e8a6808e4f2f 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -591,7 +591,7 @@ extern enum system_states {
>  #define TAINT_FIRMWARE_WORKAROUND	11
>  #define TAINT_OOT_MODULE		12
>  #define TAINT_UNSIGNED_MODULE		13
> -#define TAINT_SOFTLOCKUP		14
> +#define TAINT_LOCKUP			14
>  #define TAINT_LIVEPATCH			15
>  #define TAINT_AUX			16
>  #define TAINT_RANDSTRUCT		17
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 14a625c16cb3..521eb2fbf5fc 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -139,6 +139,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  		hung_task_show_lock = true;
>  	}
>  
> +	add_taint(TAINT_LOCKUP, LOCKDEP_STILL_OK);
> +
>  	touch_nmi_watchdog();
>  }
>  
> diff --git a/kernel/panic.c b/kernel/panic.c
> index f470a038b05b..d7750a45ca8d 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -372,7 +372,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
>  	[ TAINT_FIRMWARE_WORKAROUND ]	= { 'I', ' ', false },
>  	[ TAINT_OOT_MODULE ]		= { 'O', ' ', true },
>  	[ TAINT_UNSIGNED_MODULE ]	= { 'E', ' ', true },
> -	[ TAINT_SOFTLOCKUP ]		= { 'L', ' ', false },
> +	[ TAINT_LOCKUP ]		= { 'L', ' ', false },
>  	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
>  	[ TAINT_AUX ]			= { 'X', ' ', true },
>  	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index c0b8c458d8a6..181495efff80 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -74,6 +74,7 @@ early_initcall(check_cpu_stall_init);
>  /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
>  static void panic_on_rcu_stall(void)
>  {
> +	add_taint(TAINT_LOCKUP, LOCKDEP_STILL_OK);
>  	if (sysctl_panic_on_rcu_stall)
>  		panic("RCU Stall\n");
>  }
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index f41334ef0971..d60b195708f7 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -466,7 +466,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  			smp_mb__after_atomic();
>  		}
>  
> -		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
> +		add_taint(TAINT_LOCKUP, LOCKDEP_STILL_OK);
>  		if (softlockup_panic)
>  			panic("softlockup: hung tasks");
>  		__this_cpu_write(soft_watchdog_warn, true);
> diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
> index 247bf0b1582c..f77256f47422 100644
> --- a/kernel/watchdog_hld.c
> +++ b/kernel/watchdog_hld.c
> @@ -152,6 +152,7 @@ static void watchdog_overflow_callback(struct perf_event *event,
>  				!test_and_set_bit(0, &hardlockup_allcpu_dumped))
>  			trigger_allbutself_cpu_backtrace();
>  
> +		add_taint(TAINT_LOCKUP, LOCKDEP_STILL_OK);
>  		if (hardlockup_panic)
>  			nmi_panic(regs, "Hard LOCKUP");
>  
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index bc2e09a8ea61..825a92893882 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5741,6 +5741,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
>  			pr_cont_pool_info(pool);
>  			pr_cont(" stuck for %us!\n",
>  				jiffies_to_msecs(jiffies - pool_ts) / 1000);
> +			add_taint(TAINT_LOCKUP, LOCKDEP_STILL_OK);
>  		}
>  	}
>  
> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
> index 2240cb56e6e5..9f24719d8c80 100755
> --- a/tools/debugging/kernel-chktaint
> +++ b/tools/debugging/kernel-chktaint
> @@ -168,7 +168,7 @@ if [ `expr $T % 2` -eq 0 ]; then
>  	addout " "
>  else
>  	addout "L"
> -	echo " * soft lockup occurred (#14)"
> +	echo " * lockup occurred (#14)"
>  fi
>  
>  T=`expr $T / 2`
> 
