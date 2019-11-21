Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB89C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7ADB208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574304282;
	bh=wAA4khObfinmYR2XRJKV1R0nOvJgJ3iSw0Lt15fbVTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fKM289X+SqxvLC4Qitj3UY+HpXxEXC2enJLU1fCh40b2VhVpGMlkcKCyogiEuyV01
	 cOnTGnLqoxvkbloSGBewlmzl6/mIFgBqnq3zM8kZq3iAHTowo8Hz71zjGm+1XvksXE
	 BgPyWCmWkBeV5KF+fBSeKbRKsUeCCtcAKe7fktTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfKUCol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:44:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfKUCok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 21:44:40 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C760720878;
        Thu, 21 Nov 2019 02:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574304279;
        bh=wAA4khObfinmYR2XRJKV1R0nOvJgJ3iSw0Lt15fbVTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LeTQpluY1PZqn1mWGTI9iholhQB3uTlZmvQyY1kqfHaChL6E95k2z3h3VfS8EroH0
         YTTVAm6MZRKEKv/D8Xf1ivt5vCkgIM1wi30lpx85rLob/ZC/Dtcu5FMcLEA/0frG9L
         rpvy3+Z/pq8L7T1VEpi52YMWn8uYNCqfxqfkKD0o=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 1/6] sched/cputime: Support other fields on kcpustat_field()
Date:   Thu, 21 Nov 2019 03:44:25 +0100
Message-Id: <20191121024430.19938-2-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121024430.19938-1-frederic@kernel.org>
References: <20191121024430.19938-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide support for user, nice, guest and guest_nice fields through
kcpustat_field().

Whether we account the delta to a nice or not nice field is decided on
top of the nice value snapshot taken at the time we call kcpustat_field().
If the nice value of the task has been changed since the last vtime
update, we may have inacurrate distribution of the nice VS unnice
cputime.

However this is considered as a minor issue compared to the proper fix
that would involve interrupting the target on nice updates, which is
undesired on nohz_full CPUs.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cputime.c | 54 +++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index e0cd20693ef5..27b5406222fc 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -912,11 +912,21 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 }
 
+static u64 kcpustat_user_vtime(struct vtime *vtime)
+{
+	if (vtime->state == VTIME_USER)
+		return vtime->utime + vtime_delta(vtime);
+	else if (vtime->state == VTIME_GUEST)
+		return vtime->gtime + vtime_delta(vtime);
+	return 0;
+}
+
 static int kcpustat_field_vtime(u64 *cpustat,
-				struct vtime *vtime,
+				struct task_struct *tsk,
 				enum cpu_usage_stat usage,
 				int cpu, u64 *val)
 {
+	struct vtime *vtime = &tsk->vtime;
 	unsigned int seq;
 	int err;
 
@@ -946,9 +956,37 @@ static int kcpustat_field_vtime(u64 *cpustat,
 
 		*val = cpustat[usage];
 
-		if (vtime->state == VTIME_SYS)
-			*val += vtime->stime + vtime_delta(vtime);
-
+		/*
+		 * Nice VS unnice cputime accounting may be inaccurate if
+		 * the nice value has changed since the last vtime update.
+		 * But proper fix would involve interrupting target on nice
+		 * updates which is a no go on nohz_full (although the scheduler
+		 * may still interrupt the target if rescheduling is needed...)
+		 */
+		switch (usage) {
+		case CPUTIME_SYSTEM:
+			if (vtime->state == VTIME_SYS)
+				*val += vtime->stime + vtime_delta(vtime);
+			break;
+		case CPUTIME_USER:
+			if (task_nice(tsk) <= 0)
+				*val += kcpustat_user_vtime(vtime);
+			break;
+		case CPUTIME_NICE:
+			if (task_nice(tsk) > 0)
+				*val += kcpustat_user_vtime(vtime);
+			break;
+		case CPUTIME_GUEST:
+			if (vtime->state == VTIME_GUEST && task_nice(tsk) <= 0)
+				*val += vtime->gtime + vtime_delta(vtime);
+			break;
+		case CPUTIME_GUEST_NICE:
+			if (vtime->state == VTIME_GUEST && task_nice(tsk) > 0)
+				*val += vtime->gtime + vtime_delta(vtime);
+			break;
+		default:
+			break;
+		}
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 
 	return 0;
@@ -965,15 +1003,10 @@ u64 kcpustat_field(struct kernel_cpustat *kcpustat,
 	if (!vtime_accounting_enabled_cpu(cpu))
 		return cpustat[usage];
 
-	/* Only support sys vtime for now */
-	if (usage != CPUTIME_SYSTEM)
-		return cpustat[usage];
-
 	rq = cpu_rq(cpu);
 
 	for (;;) {
 		struct task_struct *curr;
-		struct vtime *vtime;
 
 		rcu_read_lock();
 		curr = rcu_dereference(rq->curr);
@@ -982,8 +1015,7 @@ u64 kcpustat_field(struct kernel_cpustat *kcpustat,
 			return cpustat[usage];
 		}
 
-		vtime = &curr->vtime;
-		err = kcpustat_field_vtime(cpustat, vtime, usage, cpu, &val);
+		err = kcpustat_field_vtime(cpustat, curr, usage, cpu, &val);
 		rcu_read_unlock();
 
 		if (!err)
-- 
2.23.0

