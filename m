Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5FDECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231B2217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571194635;
	bh=kFPyd6b/P6+bl9TyeBTGeDsXLM7Vhi42HLiMSW6bkPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ULF9BZBaTu9G2A7sQ4vTzSR2VVSf23a3rCUsHXe3m/aCdtCKYd2OSqjhI2pBQ8Kh1
	 zUd+T5TH9NlgYTKQZchCWdLfGCYQ8TA8dshw0m/NHEA+jhhHI0C2VcjBf96t01+XTe
	 RbDaPo6xVJx5v6f1haTNhFM7JxRRtmv4GAPhlPxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389613AbfJPC5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbfJPC5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:57:10 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F24C2168B;
        Wed, 16 Oct 2019 02:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571194629;
        bh=kFPyd6b/P6+bl9TyeBTGeDsXLM7Vhi42HLiMSW6bkPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yLFH6mDkjPU/sqq96Rzd/uWhevjPwU3yg4dUT6Mjoz0TBAAeSuLZoKb/JrAPvuQ6E
         Ej3luOx0qHeA914TEMrKno6zMBSEcGOFHwhErfjr82R+S2YZRwJydf5ezRfwtXcd8V
         gcB2BL+6mpGyTDLAlTtpvwSqtaLVW9+t/kSr2Qjo=
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
Subject: [PATCH 01/14] sched/vtime: Record CPU under seqcount for kcpustat needs
Date:   Wed, 16 Oct 2019 04:56:47 +0200
Message-Id: <20191016025700.31277-2-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016025700.31277-1-frederic@kernel.org>
References: <20191016025700.31277-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to compute the kcpustat delta on a nohz CPU, we'll need to
fetch the task running on that target. Checking that its vtime
state snapshot actually refers to the relevant target involves recording
that CPU under the seqcount locked on task switch.

This is a step toward making kcpustat moving forward on full nohz CPUs.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h  | 1 +
 kernel/sched/cputime.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2c2e56bd8913..d5d07335a97b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -259,6 +259,7 @@ struct vtime {
 	seqcount_t		seqcount;
 	unsigned long long	starttime;
 	enum vtime_state	state;
+	unsigned int		cpu;
 	u64			utime;
 	u64			stime;
 	u64			gtime;
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index cef23c211f41..40f581692254 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -818,6 +818,7 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	else
 		__vtime_account_kernel(prev, vtime);
 	vtime->state = VTIME_INACTIVE;
+	vtime->cpu = -1;
 	write_seqcount_end(&vtime->seqcount);
 
 	vtime = &current->vtime;
@@ -825,6 +826,7 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	write_seqcount_begin(&vtime->seqcount);
 	vtime->state = VTIME_SYS;
 	vtime->starttime = sched_clock();
+	vtime->cpu = smp_processor_id();
 	write_seqcount_end(&vtime->seqcount);
 }
 
@@ -837,6 +839,7 @@ void vtime_init_idle(struct task_struct *t, int cpu)
 	write_seqcount_begin(&vtime->seqcount);
 	vtime->state = VTIME_SYS;
 	vtime->starttime = sched_clock();
+	vtime->cpu = cpu;
 	write_seqcount_end(&vtime->seqcount);
 	local_irq_restore(flags);
 }
-- 
2.23.0

