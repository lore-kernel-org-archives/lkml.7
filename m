Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1E0C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 14:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821082190F
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570892325;
	bh=d3PqrLi2njQ5KGWr4gCmLk0EzFELgcCp9AVcQpO4If8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bqTlNjQils4JsTOexfZKk8t3D6L6M+gP+Y8m25DDU8FG0ogaKvEvVZloFuj/qDNfq
	 nKzRr0lOABFZrtUKAI/9VG2F0SaxT0FgN9J4syah08cPEymUxDc9c0LOUoIHcYep/V
	 brDThfdljSUXMe+RkDPadC/JUGPjzBWI5ftNf9Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfJLO6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 10:58:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54398 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfJLO6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 10:58:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so13027579wmp.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iGLY8d/D4G7kg+xTBf2AZ8kCjai2DGQYs9gICDzu+ME=;
        b=XNTuP1uiRWGDJ/60GwwunJoYdwpAPxtgi3yvjy+ZEQZrh4U2IkkYSaCEoQis+gYMkR
         IDxzrrfLAc+Ty4Bo97wU2vrcGySoo7ktRmN23FHT7ox5Gw9luKmQqOJJ/igV5jln9Ykn
         eAVIChbhrDMZngA68IVzt+xRKjzutu7xT/QiU8QnWnhZ41yl0ar5OJkd4mY7nT8FRgrs
         rHf5/Qpw0ACo3olrtrjaJ/Km9KNoUkYIF8M9n23DvAO8L09VuL0N51FijPrX0A3N4qhG
         LyAxvSKYkOhydc0pQFJLQTlecQIsLeRfPa3zDpQTuOR1ygZ3YWpiJ+4EfxpwXyJolEwF
         t8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=iGLY8d/D4G7kg+xTBf2AZ8kCjai2DGQYs9gICDzu+ME=;
        b=DnF6GsWgsjVwNA4i4jyAQS466OM8YL2dyrLReXV3IqVS7D3I/x0j+0cKVojIyzHNn4
         dhkwJH41WzrkZ1ZTXxqxflfP265SGQIkRooicvzoFiqagHw1/Nm41jLcEub45ULFwtC/
         JRmAwplPfsy+B7Teckmoi6xnZ8WKlU8b3S48euUXJgpOSOhnYt/pHSRWBE94q4XqutDU
         GeJAKmyoIrbTa4BoFZEYRa0Sir9uJi+kxGH+7eOBZv0VRe9TOKIZQ4GS2dg6ZdimHvyr
         rSL01PUCA3WOixJmYeYcgFtVw/zozL/AZE+lly7tmgFNMIoenKWagJCMjIc89v1q2qVJ
         5BeA==
X-Gm-Message-State: APjAAAV2eski7opCIhVLkQwIXakzE+uVrQdZsWmawGz/wvFWo21X0Bbt
        IqfG8EXmNOYekasfc4Dnwe8=
X-Google-Smtp-Source: APXvYqyhcIF5f1ekufNhvpCoE+YwwtCOL4WZSjRVz7+26+sVUIEf6tjRmm+6jVDRNTbfVOrQQn8JjQ==
X-Received: by 2002:a7b:c4c6:: with SMTP id g6mr7700143wmk.126.1570892318896;
        Sat, 12 Oct 2019 07:58:38 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g3sm16378211wro.14.2019.10.12.07.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 07:58:38 -0700 (PDT)
Date:   Sat, 12 Oct 2019 16:58:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20191012145836.GA15662@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: 68e7a4d66b0ce04bf18ff2ffded5596ab3618585 sched/vtime: Fix guest/system mis-accounting on task switch

Two fixes: a guest-cputime accounting fix, and a cgroup bandwidth quota 
precision fix.

 Thanks,

	Ingo

------------------>
Frederic Weisbecker (1):
      sched/vtime: Fix guest/system mis-accounting on task switch

Xuewei Zhang (1):
      sched/fair: Scale bandwidth quota and period without losing quota/period ratio precision


 kernel/sched/cputime.c |  6 +++---
 kernel/sched/fair.c    | 36 ++++++++++++++++++++++--------------
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 2305ce89a26c..46ed4e1383e2 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -740,7 +740,7 @@ void vtime_account_system(struct task_struct *tsk)
 
 	write_seqcount_begin(&vtime->seqcount);
 	/* We might have scheduled out from guest path */
-	if (current->flags & PF_VCPU)
+	if (tsk->flags & PF_VCPU)
 		vtime_account_guest(tsk, vtime);
 	else
 		__vtime_account_system(tsk, vtime);
@@ -783,7 +783,7 @@ void vtime_guest_enter(struct task_struct *tsk)
 	 */
 	write_seqcount_begin(&vtime->seqcount);
 	__vtime_account_system(tsk, vtime);
-	current->flags |= PF_VCPU;
+	tsk->flags |= PF_VCPU;
 	write_seqcount_end(&vtime->seqcount);
 }
 EXPORT_SYMBOL_GPL(vtime_guest_enter);
@@ -794,7 +794,7 @@ void vtime_guest_exit(struct task_struct *tsk)
 
 	write_seqcount_begin(&vtime->seqcount);
 	vtime_account_guest(tsk, vtime);
-	current->flags &= ~PF_VCPU;
+	tsk->flags &= ~PF_VCPU;
 	write_seqcount_end(&vtime->seqcount);
 }
 EXPORT_SYMBOL_GPL(vtime_guest_exit);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 83ab35e2374f..682a754ea3e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4926,20 +4926,28 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 		if (++count > 3) {
 			u64 new, old = ktime_to_ns(cfs_b->period);
 
-			new = (old * 147) / 128; /* ~115% */
-			new = min(new, max_cfs_quota_period);
-
-			cfs_b->period = ns_to_ktime(new);
-
-			/* since max is 1s, this is limited to 1e9^2, which fits in u64 */
-			cfs_b->quota *= new;
-			cfs_b->quota = div64_u64(cfs_b->quota, old);
-
-			pr_warn_ratelimited(
-	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
-				smp_processor_id(),
-				div_u64(new, NSEC_PER_USEC),
-				div_u64(cfs_b->quota, NSEC_PER_USEC));
+			/*
+			 * Grow period by a factor of 2 to avoid losing precision.
+			 * Precision loss in the quota/period ratio can cause __cfs_schedulable
+			 * to fail.
+			 */
+			new = old * 2;
+			if (new < max_cfs_quota_period) {
+				cfs_b->period = ns_to_ktime(new);
+				cfs_b->quota *= 2;
+
+				pr_warn_ratelimited(
+	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us = %lld, cfs_quota_us = %lld)\n",
+					smp_processor_id(),
+					div_u64(new, NSEC_PER_USEC),
+					div_u64(cfs_b->quota, NSEC_PER_USEC));
+			} else {
+				pr_warn_ratelimited(
+	"cfs_period_timer[cpu%d]: period too short, but cannot scale up without losing precision (cfs_period_us = %lld, cfs_quota_us = %lld)\n",
+					smp_processor_id(),
+					div_u64(old, NSEC_PER_USEC),
+					div_u64(cfs_b->quota, NSEC_PER_USEC));
+			}
 
 			/* reset count so we don't come right back in here */
 			count = 0;
