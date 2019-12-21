Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF363C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 16:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866612070C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 16:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576945204;
	bh=wHrnOxkxYF3nyUk532PZoXiuXDyI8WnCGuv/ftqPjkQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=rGcg0rTuQm6MKOEBRPD8yqvHeQzYqvnv8kYrALfoKACcn3EpLKMLNPdmy5mmtrRH7
	 2n2XJEqth4hBCSRSnE+agHCevcHoT23RrbJZZlWAiVQNKxZ5Hx+StV3o1pjEuh3bFO
	 5hNVRmo7XwEsROUBb9kJI8OGWgwoEg565dAkxgT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfLUQUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 11:20:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52916 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfLUQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 11:20:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so11855788wmc.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 08:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OB2pEWpXztjbOrSXiaXBxW4rKDvn8yaoe0gx19PGPF0=;
        b=lkDNRbnVmxYlg0nojOiI2geZvKuXLHJJVoyomdGrOV8MjNncDTCHSsRe7T2jvFGSmK
         NvBy1qrlwrM3/MpSJFSvWRPLdPC8N+G1NlDg2CinZDnLZ/pDjuLvA3Ruqgt0p9/wARxS
         y1cAvcRboD4zFvEe02R1TkYQ5UG0yc1BXLM12eLtNbBvQypOXTlDxA5udFvs/2qptKsV
         M/3Un/rEw3TbloFZLiZWRxrIfSnb/EPcFLGNDasofQykldAoAm9D6HWUoU3E5VPKqAgM
         MatpjG7NVR/5UrhYFFdI47esJIpmFI3/jD02uYnBEZsvORqc4e+amRz1j4SN7Qg7zkVN
         9Omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=OB2pEWpXztjbOrSXiaXBxW4rKDvn8yaoe0gx19PGPF0=;
        b=YS+B7GuxZXblWRd0p08h5b36jhEKLne2MTpbIvdJUm20SoxgWaObVyB3+xk1j3ifA0
         o29XqcF/ObL5wXJYm1Qev+kOixP8cGla4lud0YC4iaFmoBAUryZuu5L6RITk+MtvhBiC
         AvLtaHU1tPiVdd3LpXdWgu7yp5GTO2lVxFkgNoTkm1ga/g3QCtAGxCQhi9QEEMp9VSBl
         nnLGgsIAhFGotqloAb0NouL5qE+4aUe7hhIginZZxp9LiL5uYGIDS5bDl4Atp465kzvI
         mWevgh0se4xIBSDoaO0pgKPhXPhats/0X94p7Rxdhw/VBoNlSq59dMoLGlTIHdvxxMg0
         B4ZQ==
X-Gm-Message-State: APjAAAVJYJCeyKTj68GHIfWdIYXzTyg4GUwPf31FG8PTn2TNQ/IlmiF6
        6B1QzQGa6Z4yWj8bEpvl/d/iyiuO
X-Google-Smtp-Source: APXvYqxwoHJVcfs/f7yEww+Kjiu3pN1wKHXIQJBEipR0OecYx2MN4YEPKbOZq6ejFVIBPEHx7noskw==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr23277297wmc.154.1576945200531;
        Sat, 21 Dec 2019 08:20:00 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q15sm14227107wrr.11.2019.12.21.08.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 08:20:00 -0800 (PST)
Date:   Sat, 21 Dec 2019 17:19:58 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20191221161958.GA15732@gmail.com>
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

   # HEAD: 6cf82d559e1a1d89f06ff4d428aca479c1dd0be6 sched/cfs: fix spurious active migration

Misc fixes: a (rare) PSI crash fix, a CPU affinity related balancing fix, 
and a toning down of active migration attempts.

 Thanks,

	Ingo

------------------>
Johannes Weiner (2):
      sched/psi: Fix sampling error and rare div0 crashes with cgroups and high uptime
      psi: Fix a division error in psi poll()

Vincent Guittot (2):
      sched/fair: Fix find_idlest_group() to handle CPU affinity
      sched/cfs: fix spurious active migration


 kernel/sched/fair.c | 13 ++++++++++++-
 kernel/sched/psi.c  |  5 +++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e97a01..ba749f579714 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7328,7 +7328,14 @@ static int detach_tasks(struct lb_env *env)
 			    load < 16 && !env->sd->nr_balance_failed)
 				goto next;
 
-			if (load/2 > env->imbalance)
+			/*
+			 * Make sure that we don't migrate too much load.
+			 * Nevertheless, let relax the constraint if
+			 * scheduler fails to find a good waiting task to
+			 * migrate.
+			 */
+			if (load/2 > env->imbalance &&
+			    env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
 				goto next;
 
 			env->imbalance -= load;
@@ -8417,6 +8424,10 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 	if (!idlest)
 		return NULL;
 
+	/* The local group has been skipped because of CPU affinity */
+	if (!local)
+		return idlest;
+
 	/*
 	 * If the local group is idler than the selected idlest group
 	 * don't try and push the task.
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 517e3719027e..ce8f6748678a 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -185,7 +185,8 @@ static void group_init(struct psi_group *group)
 
 	for_each_possible_cpu(cpu)
 		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
-	group->avg_next_update = sched_clock() + psi_period;
+	group->avg_last_update = sched_clock();
+	group->avg_next_update = group->avg_last_update + psi_period;
 	INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
 	mutex_init(&group->avgs_lock);
 	/* Init trigger-related members */
@@ -481,7 +482,7 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 		u32 remaining;
 
 		remaining = win->size - elapsed;
-		growth += div_u64(win->prev_growth * remaining, win->size);
+		growth += div64_u64(win->prev_growth * remaining, win->size);
 	}
 
 	return growth;
