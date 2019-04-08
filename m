Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53288C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DE620879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554750911;
	bh=MFnEtxT55xkq6IhxM5qEsLQ9KT+PDNss+AmRB4KhUm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=ZAy6Jbb1N/WTZdINn4np7mUYq0/hk3rgBuUV2a3FeV7K0JT59Z/DmyNk1YFmNK9Gm
	 mfNVIszy3Ysb8iM6KtPFb6tZPPsh/NKNJKZC/LZ+4U+5o+ZE+wAB9mXYByrkl7otvd
	 X+6qCD/q3mRsVoD7qPp+z7hAkmVizSXwSlFFApQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfDHTOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:14:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbfDHTOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:14:35 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2643B21905;
        Mon,  8 Apr 2019 19:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554750875;
        bh=MFnEtxT55xkq6IhxM5qEsLQ9KT+PDNss+AmRB4KhUm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=PE67saR9TKDkkJ2MKsJDWs9U7vrLvdusTW0vjuRExOLoEuiwtH4WCGgJHEdnAJCre
         uY44kbnQViQoppMUtEfEy0vcSIF3QyFyoX3EuD8BtTnTCLasByW3OJ8KAz3YyHPE63
         8u84qZ4suxIcufYnGqg72se+j2bordRm0ED3h9yY=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com, amartin@nvidia.com
Subject: [PATCH 10/13] hrtimer: cpu_chill(): save task state in ->saved_state()
Date:   Mon,  8 Apr 2019 14:14:12 -0500
Message-Id: <0f9545ca84d4d0ec5bedd2b36a4fda0871fad244.1554737688.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.109-rt58-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit d70f218ee02d6fc3832274653aa6c6e98dd9aa43 ]

In the previous change I saved the current task state on stack. This was
bad because while the task is scheduled-out it might receive a wake-up.
The wake up changes the task state and we must not destroy it.

Save the task-state in ->saved_state under a PI-lock to unsure that
state changes during are not missed while the task temporary scheduled
out.

Reported-by: Mike Galbraith <efault@gmx.de>
Tested-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/time/hrtimer.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 6da6b5dded3c..9990b567b089 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1864,20 +1864,28 @@ COMPAT_SYSCALL_DEFINE2(nanosleep, struct compat_timespec __user *, rqtp,
  */
 void cpu_chill(void)
 {
-	ktime_t chill_time;
 	unsigned int freeze_flag = current->flags & PF_NOFREEZE;
-	long saved_state;
+	struct task_struct *self = current;
+	ktime_t chill_time;
 
-	saved_state = current->state;
-	chill_time = ktime_set(0, NSEC_PER_MSEC);
+	raw_spin_lock_irq(&self->pi_lock);
+	self->saved_state = self->state;
 	__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
+	raw_spin_unlock_irq(&self->pi_lock);
+
+	chill_time = ktime_set(0, NSEC_PER_MSEC);
+
 	current->flags |= PF_NOFREEZE;
 	sleeping_lock_inc();
 	schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
 	sleeping_lock_dec();
 	if (!freeze_flag)
 		current->flags &= ~PF_NOFREEZE;
-	__set_current_state_no_track(saved_state);
+
+	raw_spin_lock_irq(&self->pi_lock);
+	__set_current_state_no_track(self->saved_state);
+	self->saved_state = TASK_RUNNING;
+	raw_spin_unlock_irq(&self->pi_lock);
 }
 EXPORT_SYMBOL(cpu_chill);
 #endif
-- 
2.14.1

