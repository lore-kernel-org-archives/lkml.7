Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC32ECE59E
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41BC21835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571194636;
	bh=jyXQZt3rR+7E6+k4aVkGGHkSAn7O69Pic8rxKSBFd0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0X/e7DjNca2XkP821nMppVvJSHNzRWqM3+7bKyag26ioouV1H9U1rl/QUETQjJdkR
	 gCne32jq+J5Mq8dqa3CNBvS4DNwD3KdBjYT+j8EVC9wJLSbkIMLC8Zn1yiwkrLKN+D
	 nUIktH0XwOMX5TEBdexpCI7d/Dr5LtNjbAhu8Tf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390650AbfJPC5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbfJPC5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:57:13 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED4DC20873;
        Wed, 16 Oct 2019 02:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571194632;
        bh=jyXQZt3rR+7E6+k4aVkGGHkSAn7O69Pic8rxKSBFd0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p3qYHi2VJplyDy/amxCHIjyuyIhAJY4kc3hDOECvVJs2vyc2nadKZ4QioxwybA+z5
         1KoxU35DgoG6Zod/bdwnq6O2o87cn7luwHDkcKD8RmIsQR6JGMgghNxHb6kK7pBX51
         DYlem9WWypDeYYsg6jjzZbCO63yABMWMQenAmgug=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 02/14] sched/cputime: Add vtime idle task state
Date:   Wed, 16 Oct 2019 04:56:48 +0200
Message-Id: <20191016025700.31277-3-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016025700.31277-1-frederic@kernel.org>
References: <20191016025700.31277-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record idle as a VTIME state instead of guessing it from VTIME_SYS and
is_idle_task(). This is going to simplify the cputime read side
especially as its state machine is going to further expand in order to
fully support kcpustat on nohz_full.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h  |  6 ++++--
 kernel/sched/cputime.c | 13 ++++++++-----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d5d07335a97b..4ae19be2c126 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -249,10 +249,12 @@ struct prev_cputime {
 enum vtime_state {
 	/* Task is sleeping or running in a CPU with VTIME inactive: */
 	VTIME_INACTIVE = 0,
-	/* Task runs in userspace in a CPU with VTIME active: */
-	VTIME_USER,
+	/* Task is idle */
+	VTIME_IDLE,
 	/* Task runs in kernelspace in a CPU with VTIME active: */
 	VTIME_SYS,
+	/* Task runs in userspace in a CPU with VTIME active: */
+	VTIME_USER,
 };
 
 struct vtime {
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 40f581692254..2e885e870aa1 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -813,7 +813,7 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	struct vtime *vtime = &prev->vtime;
 
 	write_seqcount_begin(&vtime->seqcount);
-	if (is_idle_task(prev))
+	if (vtime->state == VTIME_IDLE)
 		vtime_account_idle(prev);
 	else
 		__vtime_account_kernel(prev, vtime);
@@ -824,7 +824,10 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	vtime = &current->vtime;
 
 	write_seqcount_begin(&vtime->seqcount);
-	vtime->state = VTIME_SYS;
+	if (is_idle_task(current))
+		vtime->state = VTIME_IDLE;
+	else
+		vtime->state = VTIME_SYS;
 	vtime->starttime = sched_clock();
 	vtime->cpu = smp_processor_id();
 	write_seqcount_end(&vtime->seqcount);
@@ -837,7 +840,7 @@ void vtime_init_idle(struct task_struct *t, int cpu)
 
 	local_irq_save(flags);
 	write_seqcount_begin(&vtime->seqcount);
-	vtime->state = VTIME_SYS;
+	vtime->state = VTIME_IDLE;
 	vtime->starttime = sched_clock();
 	vtime->cpu = cpu;
 	write_seqcount_end(&vtime->seqcount);
@@ -888,8 +891,8 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 		*utime = t->utime;
 		*stime = t->stime;
 
-		/* Task is sleeping, nothing to add */
-		if (vtime->state == VTIME_INACTIVE || is_idle_task(t))
+		/* Task is sleeping or idle, nothing to add */
+		if (vtime->state < VTIME_SYS)
 			continue;
 
 		delta = vtime_delta(vtime);
-- 
2.23.0

