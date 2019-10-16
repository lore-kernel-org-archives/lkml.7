Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED220ECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15A820663
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571194640;
	bh=IrJ0f172vAjwmK3qdmn8vbxW/x6xSzkYeX7ccY77LEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UEvbyiD46+B6uzV3OTYWJslr3nZP/HM0y49KTwF0+KlNUoarlL8Z+mJaGTqgAydvq
	 0r2/djdQLJORCyT8jG9UEYaznAC31oqviHm/RVoO647NKMVUCfUjNoKXnz/DBe8LI0
	 LDNgzDQaJ9XRotTog2ZGIJ+FsdfePC+biqbj52dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390703AbfJPC5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbfJPC5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:57:16 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E79214AE;
        Wed, 16 Oct 2019 02:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571194635;
        bh=IrJ0f172vAjwmK3qdmn8vbxW/x6xSzkYeX7ccY77LEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4IxlAMAvQW4IWs17ObhTsFNlT5IeFei7LiMVjohQT2s7rMoTG156tg72VY2Eboaz
         0agZhqDPgYBcCpiIqBU+XPGhsmcssmjTnD3Xsm1jnNTzSXprmq/bzp5rY2mj0eM7TK
         tXldoIPf0VOLqz8MRX3bgySyZXqAKXZICtTPmY1A=
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
Subject: [PATCH 03/14] sched/cputime: Add vtime guest task state
Date:   Wed, 16 Oct 2019 04:56:49 +0200
Message-Id: <20191016025700.31277-4-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016025700.31277-1-frederic@kernel.org>
References: <20191016025700.31277-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record guest as a VTIME state instead of guessing it from VTIME_SYS and
PF_VCPU. This is going to simplify the cputime read side especially as
its state machine is going to further expand in order to fully support
kcpustat on nohz_full.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h  |  2 ++
 kernel/sched/cputime.c | 18 +++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4ae19be2c126..988c4da00c31 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -255,6 +255,8 @@ enum vtime_state {
 	VTIME_SYS,
 	/* Task runs in userspace in a CPU with VTIME active: */
 	VTIME_USER,
+	/* Task runs as guests in a CPU with VTIME active: */
+	VTIME_GUEST,
 };
 
 struct vtime {
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 2e885e870aa1..34086afc3518 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -733,7 +733,7 @@ static void __vtime_account_kernel(struct task_struct *tsk,
 				   struct vtime *vtime)
 {
 	/* We might have scheduled out from guest path */
-	if (tsk->flags & PF_VCPU)
+	if (vtime->state == VTIME_GUEST)
 		vtime_account_guest(tsk, vtime);
 	else
 		vtime_account_system(tsk, vtime);
@@ -788,6 +788,7 @@ void vtime_guest_enter(struct task_struct *tsk)
 	write_seqcount_begin(&vtime->seqcount);
 	vtime_account_system(tsk, vtime);
 	tsk->flags |= PF_VCPU;
+	vtime->state = VTIME_GUEST;
 	write_seqcount_end(&vtime->seqcount);
 }
 EXPORT_SYMBOL_GPL(vtime_guest_enter);
@@ -799,6 +800,7 @@ void vtime_guest_exit(struct task_struct *tsk)
 	write_seqcount_begin(&vtime->seqcount);
 	vtime_account_guest(tsk, vtime);
 	tsk->flags &= ~PF_VCPU;
+	vtime->state = VTIME_SYS;
 	write_seqcount_end(&vtime->seqcount);
 }
 EXPORT_SYMBOL_GPL(vtime_guest_exit);
@@ -826,6 +828,8 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	write_seqcount_begin(&vtime->seqcount);
 	if (is_idle_task(current))
 		vtime->state = VTIME_IDLE;
+	else if (current->flags & PF_VCPU)
+		vtime->state = VTIME_GUEST;
 	else
 		vtime->state = VTIME_SYS;
 	vtime->starttime = sched_clock();
@@ -860,7 +864,7 @@ u64 task_gtime(struct task_struct *t)
 		seq = read_seqcount_begin(&vtime->seqcount);
 
 		gtime = t->gtime;
-		if (vtime->state == VTIME_SYS && t->flags & PF_VCPU)
+		if (vtime->state == VTIME_GUEST)
 			gtime += vtime->gtime + vtime_delta(vtime);
 
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
@@ -898,13 +902,13 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 		delta = vtime_delta(vtime);
 
 		/*
-		 * Task runs either in user or kernel space, add pending nohz time to
-		 * the right place.
+		 * Task runs either in user (including guest) or kernel space,
+		 * add pending nohz time to the right place.
 		 */
-		if (vtime->state == VTIME_USER || t->flags & PF_VCPU)
-			*utime += vtime->utime + delta;
-		else if (vtime->state == VTIME_SYS)
+		if (vtime->state == VTIME_SYS)
 			*stime += vtime->stime + delta;
+		else
+			*utime += vtime->utime + delta;
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
-- 
2.23.0

