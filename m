Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F45C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3637220692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKUQsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:48:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32915 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfKUQsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:48:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXpcn-0000ZA-LC; Thu, 21 Nov 2019 17:48:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3E4D41C1A3C;
        Thu, 21 Nov 2019 17:48:08 +0100 (CET)
Date:   Thu, 21 Nov 2019 16:48:08 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cputime: Support other fields on kcpustat_field()
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121024430.19938-2-frederic@kernel.org>
References: <20191121024430.19938-2-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157435488818.21853.7585699144904848918.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5a1c95580f1d89c8a736bb02ecd82a8858388b8a
Gitweb:        https://git.kernel.org/tip/5a1c95580f1d89c8a736bb02ecd82a8858388b8a
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 21 Nov 2019 03:44:25 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Nov 2019 07:33:23 +01:00

sched/cputime: Support other fields on kcpustat_field()

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
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Link: https://lkml.kernel.org/r/20191121024430.19938-2-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cputime.c | 54 ++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index e0cd206..27b5406 100644
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
