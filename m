Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F36AC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA632084C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfGSBEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 21:04:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39107 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfGSBD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 21:03:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so13660568pgi.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 18:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QUqGa8au0uDH1tINq6znit6jPqnzQUOjsfwZbBIMFT0=;
        b=N9HDba9d04eKCE2btEs3UJYzQEVUEx2u08namUXFk/wR87/FEdq4EC86nMsQ/D/ndp
         dTHvzntHvqzZk3oGXgIDkoHodo4MMnBvktQNT0uPbBFspQ6CjdIYXuqxn0bGNEYoQtGs
         YUQGvaeYw/zVcSlIBDNukedDzomUs0BJlReNTkwfn2fmeqgo9OSib5AtWf+sQhMsn7SL
         NP7VYndrY/44Kb5BH6LhuiNLn2KFLbapmglt0VVQfmD7Z5P+62cJw3HP7tFYMY6R24pR
         yz/2wa8Abwt7wFcj7YPn9JAukrt79sFlkk87s0aFNDgF54vndCRnGZcJbxwkYZSjIMN1
         1n7A==
X-Gm-Message-State: APjAAAUtG3NS8NyVRY451hsvJO19r2WVc7t6pKdJWlCpZ5fif9YE9fkA
        +89tfrJXCI3dnw6SWIj4A0Y=
X-Google-Smtp-Source: APXvYqzpTsNJrZ8Mdkw8naoXjSTxrnQl24WVdHNA7zUA29Berhm2UK7JfrFA00fickSHQwCmB/TqNQ==
X-Received: by 2002:a63:506:: with SMTP id 6mr50053303pgf.434.1563498234951;
        Thu, 18 Jul 2019 18:03:54 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q144sm28887612pfc.103.2019.07.18.18.03.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 18:03:54 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [RFC 4/7] x86: Fix possible caching of current_task
Date:   Thu, 18 Jul 2019 10:41:07 -0700
Message-Id: <20190718174110.4635-5-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718174110.4635-1-namit@vmware.com>
References: <20190718174110.4635-1-namit@vmware.com>
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
index bf3034994754..71bd82a6e3c6 100644
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
index 250e4c4ac6d9..e945bc744804 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -575,7 +575,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	this_cpu_write(current_task, next_p);
 	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
 
-	switch_fpu_finish(next_fpu);
+	switch_fpu_finish(next_p, next_fpu);
 
 	/* Reload sp0. */
 	update_task_stack(next_p);
@@ -622,7 +622,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	}
 
 	/* Load the Intel cache allocation PQR MSR. */
-	resctrl_sched_in();
+	resctrl_sched_in(next_p);
 
 	return prev_p;
 }
-- 
2.17.1

