Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47538C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142CD20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfDSSyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:54:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbfDSSya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:54:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9B1F19D223;
        Fri, 19 Apr 2019 15:19:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9124360BF7;
        Fri, 19 Apr 2019 15:19:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 19 Apr 2019 17:19:14 +0200 (CEST)
Date:   Fri, 19 Apr 2019 17:19:12 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Message-ID: <20190419151912.GA12152@redhat.com>
References: <20190405174708.1010-1-guro@fb.com>
 <20190405174708.1010-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405174708.1010-5-guro@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 19 Apr 2019 15:19:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05, Roman Gushchin wrote:
>
> +void cgroup_leave_frozen(bool always_leave)
> +{
> +	struct cgroup *cgrp;
> +
> +	spin_lock_irq(&css_set_lock);
> +	cgrp = task_dfl_cgroup(current);
> +	if (always_leave || !test_bit(CGRP_FREEZE, &cgrp->flags)) {
> +		cgroup_dec_frozen_cnt(cgrp);
> +		cgroup_update_frozen(cgrp);
> +		WARN_ON_ONCE(!current->frozen);
> +		current->frozen = false;
> +	}
> +	spin_unlock_irq(&css_set_lock);
> +
> +	if (unlikely(current->frozen)) {
> +		/*
> +		 * If the task remained in the frozen state,
> +		 * make sure it won't reach userspace without
> +		 * entering the signal handling loop.
> +		 */
> +		spin_lock_irq(&current->sighand->siglock);
> +		recalc_sigpending();
> +		spin_unlock_irq(&current->sighand->siglock);

I still can't understand this logic.

Once again, suppose we race with CGRP_FREEZE. If JOBCTL_TRAP_FREEZE is already
set then signal_pending() must be already T and we do not need recalc_sigpending?
If JOBCTL_TRAP_FREEZE is not set yet, how can recalc_sigpending() help?

> +static void cgroup_freeze_task(struct task_struct *task, bool freeze)
> +{
> +	unsigned long flags;
> +
> +	/* If the task is about to die, don't bother with freezing it. */
> +	if (!lock_task_sighand(task, &flags))
> +		return;
> +
> +	if (freeze) {
> +		task->jobctl |= JOBCTL_TRAP_FREEZE;
> +		signal_wake_up(task, false);
> +	} else {
> +		task->jobctl &= ~JOBCTL_TRAP_FREEZE;
> +		wake_up_process(task);

wake_up_interruptible() ?

>  static int ptrace_signal(int signr, kernel_siginfo_t *info)
>  {
>  	/*
> @@ -2442,6 +2483,10 @@ bool get_signal(struct ksignal *ksig)
>  		ksig->info.si_signo = signr = SIGKILL;
>  		sigdelset(&current->pending.signal, SIGKILL);
>  		recalc_sigpending();
> +		current->jobctl &= ~JOBCTL_TRAP_FREEZE;
> +		spin_unlock_irq(&sighand->siglock);
> +		if (unlikely(cgroup_task_frozen(current)))
> +			cgroup_leave_frozen(true);

Oh, and another leave_frozen below...

I feel this must be simplified somehow, but nothing comes to my mind right now.

> +		/*
> +		 * If the task is leaving the frozen state, let's update
> +		 * cgroup counters and reset the frozen bit.
> +		 */
> +		if (unlikely(cgroup_task_frozen(current))) {
>  			spin_unlock_irq(&sighand->siglock);
> +			cgroup_leave_frozen(true);
>  			goto relock;
>  		}

afaics cgroup_leave_frozen(false) makes more sense here.

Oleg.

