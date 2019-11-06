Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F53C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF908222D1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573009705;
	bh=FY1ULSsv/m4KeS6j75Kr1Gk64teXNk6rPl8eIfF7oJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UGnje3CiZiVN32NphZMa/mOmwLFJniIN784ED0N3kLftmVZ0I5x/YUREwGrIskov/
	 hGEKblaHg6dxpZxtx0HRYVw/fLesUKyTW4bezv9vDmsvjyc1I7yJtncg01xE/lWJb/
	 SvDnauzIdGE87Z9AjB/bBoJ+HoDLA2PL7awEuXpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388249AbfKFDIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388206AbfKFDIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:20 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B482C217F5;
        Wed,  6 Nov 2019 03:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573009699;
        bh=FY1ULSsv/m4KeS6j75Kr1Gk64teXNk6rPl8eIfF7oJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ml0dlh0KV+7eBeF3tkY0twbTJV6KEMeGldDUmWc6xIubPI4xgabXnaoObevAMUfta
         xvJTZLA6ypzj1RDWA92Ii6/+QW+8LXEEMsjrqp7XN6XjCjBXuh2b544tMRPFSwrufF
         oa5d6ixS0MBooKzwVmKbZ6GEyQWfogvovU4WP694=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Pavel Machek <pavel@ucw.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 1/9] sched/cputime: Allow to pass cputime index on user/guest accounting
Date:   Wed,  6 Nov 2019 04:07:59 +0100
Message-Id: <20191106030807.31091-2-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030807.31091-1-frederic@kernel.org>
References: <20191106030807.31091-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we account user or guest cputime, we decide to add the delta either
to the nice fields or the normal fields of kcpustat and this depends on
the nice value for the task passed in parameter.

Since we are going to track the nice-ness from vtime instead, we'll need
to be able to pass custom kcpustat destination index fields to the
accounting functions.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cputime.c | 50 +++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index e0cd20693ef5..738ed7db615e 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -109,6 +109,20 @@ static inline void task_group_account_field(struct task_struct *p, int index,
 	cgroup_account_cputime_field(p, index, tmp);
 }
 
+static void account_user_time_index(struct task_struct *p,
+				    u64 cputime, enum cpu_usage_stat index)
+{
+	/* Add user time to process. */
+	p->utime += cputime;
+	account_group_user_time(p, cputime);
+
+	/* Add user time to cpustat. */
+	task_group_account_field(p, index, cputime);
+
+	/* Account for user time used */
+	acct_account_cputime(p);
+}
+
 /*
  * Account user CPU time to a process.
  * @p: the process that the CPU time gets accounted to
@@ -116,27 +130,14 @@ static inline void task_group_account_field(struct task_struct *p, int index,
  */
 void account_user_time(struct task_struct *p, u64 cputime)
 {
-	int index;
-
-	/* Add user time to process. */
-	p->utime += cputime;
-	account_group_user_time(p, cputime);
+	enum cpu_usage_stat index;
 
 	index = (task_nice(p) > 0) ? CPUTIME_NICE : CPUTIME_USER;
-
-	/* Add user time to cpustat. */
-	task_group_account_field(p, index, cputime);
-
-	/* Account for user time used */
-	acct_account_cputime(p);
+	account_user_time_index(p, cputime, index);
 }
 
-/*
- * Account guest CPU time to a process.
- * @p: the process that the CPU time gets accounted to
- * @cputime: the CPU time spent in virtual machine since the last update
- */
-void account_guest_time(struct task_struct *p, u64 cputime)
+static void account_guest_time_index(struct task_struct *p,
+				     u64 cputime, enum cpu_usage_stat index)
 {
 	u64 *cpustat = kcpustat_this_cpu->cpustat;
 
@@ -146,7 +147,7 @@ void account_guest_time(struct task_struct *p, u64 cputime)
 	p->gtime += cputime;
 
 	/* Add guest time to cpustat. */
-	if (task_nice(p) > 0) {
+	if (index == CPUTIME_GUEST_NICE) {
 		cpustat[CPUTIME_NICE] += cputime;
 		cpustat[CPUTIME_GUEST_NICE] += cputime;
 	} else {
@@ -155,6 +156,19 @@ void account_guest_time(struct task_struct *p, u64 cputime)
 	}
 }
 
+/*
+ * Account guest CPU time to a process.
+ * @p: the process that the CPU time gets accounted to
+ * @cputime: the CPU time spent in virtual machine since the last update
+ */
+void account_guest_time(struct task_struct *p, u64 cputime)
+{
+	enum cpu_usage_stat index;
+
+	index = (task_nice(p) > 0) ? CPUTIME_GUEST_NICE : CPUTIME_GUEST;
+	account_guest_time_index(p, cputime, index);
+}
+
 /*
  * Account system CPU time to a process and desired cpustat field
  * @p: the process that the CPU time gets accounted to
-- 
2.23.0

