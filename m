Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3C9C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F30E2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfEOKzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:55:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:32830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbfEOKzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:55:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DBD7AADC7;
        Wed, 15 May 2019 10:55:41 +0000 (UTC)
Date:   Wed, 15 May 2019 12:55:40 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Liu Chuansheng <chuansheng.liu@intel.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] kernel/hung_task.c: Monitor killed tasks.
Message-ID: <20190515105540.vyzh6n62rqi5imqv@pathway.suse.cz>
References: <1557745331-10367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557745331-10367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-05-13 20:02:11, Tetsuo Handa wrote:
> syzbot's second top report is "no output from test machine" where the
> userspace process failed to spawn a new test process for 300 seconds
> for some reason. One of reasons which can result in this report is that
> an already spawned test process was unable to terminate (e.g. trapped at
> an unkillable retry loop due to some bug) after SIGKILL was sent to that
> process. Therefore, reporting when a thread is failing to terminate
> despite a fatal signal is pending would give us more useful information.
> 
> This version shares existing sysctl settings (e.g. check interval,
> timeout, whether to panic) used for detecting TASK_UNINTERRUPTIBLE
> threads, for I don't know whether people want to use a new kernel
> config option and different sysctl settings for monitoring killed
> threads.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>  include/linux/sched.h |  1 +
>  kernel/hung_task.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index a2cd1585..d42bdd7 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -850,6 +850,7 @@ struct task_struct {
>  #ifdef CONFIG_DETECT_HUNG_TASK
>  	unsigned long			last_switch_count;
>  	unsigned long			last_switch_time;
> +	unsigned long			killed_time;

I would call this fatal_signal_time to make the meaning more clear.

>  #endif
>  	/* Filesystem information: */
>  	struct fs_struct		*fs;
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index f108a95..34e7b84 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -141,6 +141,47 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  	touch_nmi_watchdog();
>  }
>  
> +static void check_killed_task(struct task_struct *t, unsigned long timeout)
> +{
> +	unsigned long stamp = t->killed_time;
> +
> +	/*
> +	 * Ensure the task is not frozen.
> +	 * Also, skip vfork and any other user process that freezer should skip.
> +	 */
> +	if (unlikely(t->flags & (PF_FROZEN | PF_FREEZER_SKIP)))
> +		return;
> +	/*
> +	 * Skip threads which are already inside do_exit(), for exit_mm() etc.
> +	 * might take many seconds.
> +	 */
> +	if (t->flags & PF_EXITING)
> +		return;
> +	if (!stamp) {
> +		stamp = jiffies;
> +		if (!stamp)
> +			stamp++;
> +		t->killed_time = stamp;
> +		return;
> +	}

I might be too dumb but the above code looks pretty tricky to me.
It would deserve a comment. Or better, I would remove
trick to handle overflow. If it happens, we would just
lose one check period.

Alternative solution would be to set the timestamp in
complete_signal(). Then we would know that the timestamp
is always valid when a fatal signal is pending.


> +	if (time_is_after_jiffies(stamp + timeout * HZ))
> +		return;
> +	trace_sched_process_hang(t);
> +	if (sysctl_hung_task_panic) {
> +		console_verbose();
> +		hung_task_call_panic = true;

IMHO, the delayed task exit is much less fatal than sleeping
in an uninterruptible state.

Anyway, the check is much less reliable. In case of hung_task,
it is enough when the task gets scheduled. In the new check,
the task has to do some amount of work until the signal
gets handled and do_exit() is called.

The panic should either get enabled separately or we should
never panic in this case.

Best Regards,
Petr
