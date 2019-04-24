Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A10C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDD821773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbfDXPqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:46:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbfDXPqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:46:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3BD79308FEDE;
        Wed, 24 Apr 2019 15:46:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id E5A725D9CD;
        Wed, 24 Apr 2019 15:46:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 24 Apr 2019 17:46:21 +0200 (CEST)
Date:   Wed, 24 Apr 2019 17:46:19 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Message-ID: <20190424154619.GG16167@redhat.com>
References: <20190405174708.1010-1-guro@fb.com>
 <20190405174708.1010-5-guro@fb.com>
 <20190419151912.GA12152@redhat.com>
 <20190419161118.GA23357@tower.DHCP.thefacebook.com>
 <20190419162600.GC12228@redhat.com>
 <20190419165600.GC23357@tower.DHCP.thefacebook.com>
 <20190420105838.GA17468@redhat.com>
 <20190422221116.GA10341@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422221116.GA10341@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 24 Apr 2019 15:46:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/22, Roman Gushchin wrote:
>
> > > Hm, it might work too, but I'm not sure I like it more. IMO, the best option
> > > is to have a single cgroup_leave_frozen(true) in signal.c, it's just simpler.
> > > If a user changed the desired state of cgroup twice, there is no need to avoid
> > > state transitions. Or maybe I don't see it yet.
> >
> > Then why do we need cgroup_leave_frozen(false) in wait_for_vfork_done() ? How
> > does it differ from get_signal() ?
>
> We need it because sleeping in vfork is a special state which we want to
> account as frozen. And if the parent process wakes up while the cgroup is frozen
> (because of the child death, for example), we want to push it into the "proper"
> frozen state without changing the state of the cgroup.

Again, I do not see how vfork() differs from get_signal() in this respect.

Let me provide another example. A TASK_STOPPED task reacts to SIGCONT and
returns to get_signal(), current->frozen is true.

If this races with CGRP_FREEZE, the task should not return to user-space,
just like vfork(). I see no difference.

They differ in that wait_for_vfork_done() should guarentee TIF_SIGPENDING
in this case, but this is another story...

>
> > If nothing else. Suppose that wait_for_vfork_done() calls leave(false) and this
> > races with freezer, CGRP_FREEZE is already set but JOBCTL_TRAP_FREEZE is not.
> >
> > This sets TIF_SIGPENDING to ensure the task won't return to user mode, thus it
> > calls get_signal().
> >
> > get_signal() doesn't see JOBCTL_TRAP_FREEZE, it notices ->frozen == T and does
> > cgroup_leave_frozen(true) which clears ->frozen.
> >
> > Then the task calls dequeue_signal(), clears TIF_SIGPENDING and returns to user
> > mode?
>
> Got it, a good catch! So if the freezer races with vfork() completion, we might
> have a spurious frozen->unfrozen->frozen transition of the cgroup state.
>
> Switching to cgroup_leave_frozen(false) seems to solve it, but I'm slightly
> concerned that we're basically putting the task in a busy loop between
> the setting CGRP_FREEZE and setting TRAP_FREEZE.

Yes, yes. Didn't I say I dislike the new ->frozen check in recalc() ? ;)

OK, how about the ABSOLUTELY UNTESTED patch below? For the start.

Oleg.

diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 3bfbb3c..b5ccc87 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -132,26 +132,21 @@ void cgroup_leave_frozen(bool always_leave)
 {
 	struct cgroup *cgrp;
 
+	WARN_ON_ONCE(!current->frozen);
+
 	spin_lock_irq(&css_set_lock);
 	cgrp = task_dfl_cgroup(current);
 	if (always_leave || !test_bit(CGRP_FREEZE, &cgrp->flags)) {
 		cgroup_dec_frozen_cnt(cgrp);
 		cgroup_update_frozen(cgrp);
-		WARN_ON_ONCE(!current->frozen);
 		current->frozen = false;
+	} else if (!(current->jobctl & JOBCTL_TRAP_FREEZE)) {
+		spin_lock(&current->sighand->siglock);
+		current->jobctl |= JOBCTL_TRAP_FREEZE;
+		set_thread_flag(TIF_SIGPENDING);
+		spin_unlock(&current->sighand->siglock);
 	}
 	spin_unlock_irq(&css_set_lock);
-
-	if (unlikely(current->frozen)) {
-		/*
-		 * If the task remained in the frozen state,
-		 * make sure it won't reach userspace without
-		 * entering the signal handling loop.
-		 */
-		spin_lock_irq(&current->sighand->siglock);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
 }
 
 /*
diff --git a/kernel/signal.c b/kernel/signal.c
index e46d527..155b273 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2515,7 +2515,7 @@ bool get_signal(struct ksignal *ksig)
 		 */
 		if (unlikely(cgroup_task_frozen(current))) {
 			spin_unlock_irq(&sighand->siglock);
-			cgroup_leave_frozen(true);
+			cgroup_leave_frozen(false);
 			goto relock;
 		}
 


