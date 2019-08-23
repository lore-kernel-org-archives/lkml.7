Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337D1C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0676222CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfHXGFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:05:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42051 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfHXGFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:05:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id p3so7042191pgb.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uX+PcVPfgxRzZ3oIdr5JDxQ7RnrYn1aUMO4P3a40ifs=;
        b=ra0h1oIVEU6MJRw33Zeun9ZekHBFZP3tW4yYnXiahQHlJ6VC0IuWoIduwFEBBLIvEk
         vzqIMpRgD1dyI6ZA35ZQ9KpwDTLqN9wJvboJNUHDAwG2luAY8ap8xapwilzi3f0TQJH6
         ZARf02Akpe34WBe4IUjv6gWBDqVW4y7eqbgZHYIG3J5HafH4PQXcmTkFWdpwuWPPrn9W
         WaUFNa8y0XywZgBjYgXpQn+xm9GMiPLhvK3lBtQLpeJkZE4omxJ26Qd2nPEYKOoaEqRZ
         enfSK50ckf8lCgz42Vnt06et4UKHxExK2AhN2J7p6cSXc3SnAJATk2ZIV+X9Lc4QFf93
         FTsg==
X-Gm-Message-State: APjAAAWU+IG9wsBDvH0sVpKISgAD89ORQlPfK6JuY2xEiWeBZXIwJ6bM
        dgVnhK28fU0LM7O5tTDTlsQ=
X-Google-Smtp-Source: APXvYqx10PEt3xV5Fy8XmrvHpVcYZIr5cymTOJHvWa2GIs3Gj0i0WK12JXeTiwo0yr9aUiAqX5Tg4w==
X-Received: by 2002:a62:642:: with SMTP id 63mr9324765pfg.257.1566626718098;
        Fri, 23 Aug 2019 23:05:18 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id w2sm4300882pjr.27.2019.08.23.23.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:05:17 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Garnier <thgarnie@chromium.org>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH 4/7] x86: Fix possible caching of current_task
Date:   Fri, 23 Aug 2019 15:44:21 -0700
Message-Id: <20190823224424.15296-5-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823224424.15296-1-namit@vmware.com>
References: <20190823224424.15296-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this_cpu_read_stable() is allowed and supposed to cache and return the
same value, specifically for current_task. It actually does not cache
current_task very well, which hinders possible invalid caching when the
task is switched in __switch_to().

Fix the possible caching by avoiding the use of current in
__switch_to()'s dynamic extent.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/fpu/internal.h    |  7 ++++---
 arch/x86/include/asm/resctrl_sched.h   | 14 +++++++-------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 ++--
 arch/x86/kernel/process_32.c           |  4 ++--
 arch/x86/kernel/process_64.c           |  4 ++--
 5 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 4c95c365058a..b537788600fe 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -588,9 +588,10 @@ static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 
 /*
  * Load PKRU from the FPU context if available. Delay loading of the
- * complete FPU state until the return to userland.
+ * complete FPU state until the return to userland. Avoid reading current during
+ * switch.
  */
-static inline void switch_fpu_finish(struct fpu *new_fpu)
+static inline void switch_fpu_finish(struct task_struct *task, struct fpu *new_fpu)
 {
 	u32 pkru_val = init_pkru_value;
 	struct pkru_state *pk;
@@ -598,7 +599,7 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
 	if (!static_cpu_has(X86_FEATURE_FPU))
 		return;
 
-	set_thread_flag(TIF_NEED_FPU_LOAD);
+	set_ti_thread_flag(task_thread_info(task), TIF_NEED_FPU_LOAD);
 
 	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return;
diff --git a/arch/x86/include/asm/resctrl_sched.h b/arch/x86/include/asm/resctrl_sched.h
index f6b7fe2833cc..9a00d9df9d02 100644
--- a/arch/x86/include/asm/resctrl_sched.h
+++ b/arch/x86/include/asm/resctrl_sched.h
@@ -51,7 +51,7 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
  *   simple as possible.
  * Must be called with preemption disabled.
  */
-static void __resctrl_sched_in(void)
+static void __resctrl_sched_in(struct task_struct *task)
 {
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
 	u32 closid = state->default_closid;
@@ -62,13 +62,13 @@ static void __resctrl_sched_in(void)
 	 * Else use the closid/rmid assigned to this cpu.
 	 */
 	if (static_branch_likely(&rdt_alloc_enable_key)) {
-		if (current->closid)
+		if (task->closid)
 			closid = current->closid;
 	}
 
 	if (static_branch_likely(&rdt_mon_enable_key)) {
-		if (current->rmid)
-			rmid = current->rmid;
+		if (task->rmid)
+			rmid = task->rmid;
 	}
 
 	if (closid != state->cur_closid || rmid != state->cur_rmid) {
@@ -78,15 +78,15 @@ static void __resctrl_sched_in(void)
 	}
 }
 
-static inline void resctrl_sched_in(void)
+static inline void resctrl_sched_in(struct task_struct *task)
 {
 	if (static_branch_likely(&rdt_enable_key))
-		__resctrl_sched_in();
+		__resctrl_sched_in(task);
 }
 
 #else
 
-static inline void resctrl_sched_in(void) {}
+static inline void resctrl_sched_in(struct task_struct *task) {}
 
 #endif /* CONFIG_X86_CPU_RESCTRL */
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a46dee8e78db..5fcf56cbf438 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -311,7 +311,7 @@ static void update_cpu_closid_rmid(void *info)
 	 * executing task might have its own closid selected. Just reuse
 	 * the context switch code.
 	 */
-	resctrl_sched_in();
+	resctrl_sched_in(current);
 }
 
 /*
@@ -536,7 +536,7 @@ static void move_myself(struct callback_head *head)
 
 	preempt_disable();
 	/* update PQR_ASSOC MSR to make resource group go into effect */
-	resctrl_sched_in();
+	resctrl_sched_in(current);
 	preempt_enable();
 
 	kfree(callback);
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index b8ceec4974fe..699a4c95ab13 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -292,10 +292,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	this_cpu_write(current_task, next_p);
 
-	switch_fpu_finish(next_fpu);
+	switch_fpu_finish(next_p, next_fpu);
 
 	/* Load the Intel cache allocation PQR MSR. */
-	resctrl_sched_in();
+	resctrl_sched_in(next_p);
 
 	return prev_p;
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index af64519b2695..bb811808936d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -565,7 +565,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	this_cpu_write(current_task, next_p);
 	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
 
-	switch_fpu_finish(next_fpu);
+	switch_fpu_finish(next_p, next_fpu);
 
 	/* Reload sp0. */
 	update_task_stack(next_p);
@@ -612,7 +612,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	}
 
 	/* Load the Intel cache allocation PQR MSR. */
-	resctrl_sched_in();
+	resctrl_sched_in(next_p);
 
 	return prev_p;
 }
-- 
2.17.1

