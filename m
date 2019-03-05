Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8EFC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B7A208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfCELtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:49:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44413 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfCELtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:49:20 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h18ZR-0004Uu-E0; Tue, 05 Mar 2019 12:49:17 +0100
Subject: [GIT pull] x86/pti update for 5.1
Message-ID: <155178637783.3906.11930692733129846637.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <155178637782.3906.3253567963332039739.tglx@nanos.tec.linutronix.de>
Date:   Tue, 05 Mar 2019 12:49:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-pti-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

Just a single change from the anti-performance departement:

 - Add a new PR_SPEC_DISABLE_NOEXEC option which allows to apply the
   speculation protections on a process without inheriting the state on
   exec. Remedies a situation where a Java-launcher has speculation
   protections enabled because that's the default for JVMs which causes the
   launched regular harmless processes to inherit the protection state
   which results in unintended performance degradation.

Thanks,

	tglx

------------------>
Waiman Long (1):
      x86/speculation: Add PR_SPEC_DISABLE_NOEXEC


 Documentation/userspace-api/spec_ctrl.rst | 27 +++++++++++++++------------
 arch/x86/kernel/cpu/bugs.c                | 12 ++++++++++++
 arch/x86/kernel/process.c                 | 12 ++++++++++++
 include/linux/sched.h                     |  5 +++++
 include/uapi/linux/prctl.h                |  1 +
 tools/include/uapi/linux/prctl.h          |  1 +
 6 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
index c4dbe6f7cdae..1129c7550a48 100644
--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -28,18 +28,20 @@ PR_GET_SPECULATION_CTRL returns the state of the speculation misfeature
 which is selected with arg2 of prctl(2). The return value uses bits 0-3 with
 the following meaning:
 
-==== ===================== ===================================================
-Bit  Define                Description
-==== ===================== ===================================================
-0    PR_SPEC_PRCTL         Mitigation can be controlled per task by
-                           PR_SET_SPECULATION_CTRL.
-1    PR_SPEC_ENABLE        The speculation feature is enabled, mitigation is
-                           disabled.
-2    PR_SPEC_DISABLE       The speculation feature is disabled, mitigation is
-                           enabled.
-3    PR_SPEC_FORCE_DISABLE Same as PR_SPEC_DISABLE, but cannot be undone. A
-                           subsequent prctl(..., PR_SPEC_ENABLE) will fail.
-==== ===================== ===================================================
+==== ====================== ==================================================
+Bit  Define                 Description
+==== ====================== ==================================================
+0    PR_SPEC_PRCTL          Mitigation can be controlled per task by
+                            PR_SET_SPECULATION_CTRL.
+1    PR_SPEC_ENABLE         The speculation feature is enabled, mitigation is
+                            disabled.
+2    PR_SPEC_DISABLE        The speculation feature is disabled, mitigation is
+                            enabled.
+3    PR_SPEC_FORCE_DISABLE  Same as PR_SPEC_DISABLE, but cannot be undone. A
+                            subsequent prctl(..., PR_SPEC_ENABLE) will fail.
+4    PR_SPEC_DISABLE_NOEXEC Same as PR_SPEC_DISABLE, but the state will be
+                            cleared on :manpage:`execve(2)`.
+==== ====================== ==================================================
 
 If all bits are 0 the CPU is not affected by the speculation misfeature.
 
@@ -92,6 +94,7 @@ Speculation misfeature controls
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_ENABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_DISABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_FORCE_DISABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_DISABLE_NOEXEC, 0, 0);
 
 - PR_SPEC_INDIR_BRANCH: Indirect Branch Speculation in User Processes
                         (Mitigate Spectre V2 style attacks against user processes)
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1de0f4170178..2faeaf46347a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -798,15 +798,25 @@ static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 		if (task_spec_ssb_force_disable(task))
 			return -EPERM;
 		task_clear_spec_ssb_disable(task);
+		task_clear_spec_ssb_noexec(task);
 		task_update_spec_tif(task);
 		break;
 	case PR_SPEC_DISABLE:
 		task_set_spec_ssb_disable(task);
+		task_clear_spec_ssb_noexec(task);
 		task_update_spec_tif(task);
 		break;
 	case PR_SPEC_FORCE_DISABLE:
 		task_set_spec_ssb_disable(task);
 		task_set_spec_ssb_force_disable(task);
+		task_clear_spec_ssb_noexec(task);
+		task_update_spec_tif(task);
+		break;
+	case PR_SPEC_DISABLE_NOEXEC:
+		if (task_spec_ssb_force_disable(task))
+			return -EPERM;
+		task_set_spec_ssb_disable(task);
+		task_set_spec_ssb_noexec(task);
 		task_update_spec_tif(task);
 		break;
 	default:
@@ -885,6 +895,8 @@ static int ssb_prctl_get(struct task_struct *task)
 	case SPEC_STORE_BYPASS_PRCTL:
 		if (task_spec_ssb_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
+		if (task_spec_ssb_noexec(task))
+			return PR_SPEC_PRCTL | PR_SPEC_DISABLE_NOEXEC;
 		if (task_spec_ssb_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
 		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 90ae0ca51083..58ac7be52c7a 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -255,6 +255,18 @@ void arch_setup_new_exec(void)
 	/* If cpuid was previously disabled for this task, re-enable it. */
 	if (test_thread_flag(TIF_NOCPUID))
 		enable_cpuid();
+
+	/*
+	 * Don't inherit TIF_SSBD across exec boundary when
+	 * PR_SPEC_DISABLE_NOEXEC is used.
+	 */
+	if (test_thread_flag(TIF_SSBD) &&
+	    task_spec_ssb_noexec(current)) {
+		clear_thread_flag(TIF_SSBD);
+		task_clear_spec_ssb_disable(current);
+		task_clear_spec_ssb_noexec(current);
+		speculation_ctrl_update(task_thread_info(current)->flags);
+	}
 }
 
 static inline void switch_to_bitmap(struct thread_struct *prev,
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2f90fa92468..fc836dc71bba 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1459,6 +1459,7 @@ static inline bool is_percpu_thread(void)
 #define PFA_SPEC_SSB_FORCE_DISABLE	4	/* Speculative Store Bypass force disabled*/
 #define PFA_SPEC_IB_DISABLE		5	/* Indirect branch speculation restricted */
 #define PFA_SPEC_IB_FORCE_DISABLE	6	/* Indirect branch speculation permanently restricted */
+#define PFA_SPEC_SSB_NOEXEC		7	/* Speculative Store Bypass clear on execve() */
 
 #define TASK_PFA_TEST(name, func)					\
 	static inline bool task_##func(struct task_struct *p)		\
@@ -1487,6 +1488,10 @@ TASK_PFA_TEST(SPEC_SSB_DISABLE, spec_ssb_disable)
 TASK_PFA_SET(SPEC_SSB_DISABLE, spec_ssb_disable)
 TASK_PFA_CLEAR(SPEC_SSB_DISABLE, spec_ssb_disable)
 
+TASK_PFA_TEST(SPEC_SSB_NOEXEC, spec_ssb_noexec)
+TASK_PFA_SET(SPEC_SSB_NOEXEC, spec_ssb_noexec)
+TASK_PFA_CLEAR(SPEC_SSB_NOEXEC, spec_ssb_noexec)
+
 TASK_PFA_TEST(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
 TASK_PFA_SET(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
 
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index b4875a93363a..094bb03b9cc2 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -219,6 +219,7 @@ struct prctl_mm_map {
 # define PR_SPEC_ENABLE			(1UL << 1)
 # define PR_SPEC_DISABLE		(1UL << 2)
 # define PR_SPEC_FORCE_DISABLE		(1UL << 3)
+# define PR_SPEC_DISABLE_NOEXEC		(1UL << 4)
 
 /* Reset arm64 pointer authentication keys */
 #define PR_PAC_RESET_KEYS		54
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index b4875a93363a..094bb03b9cc2 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -219,6 +219,7 @@ struct prctl_mm_map {
 # define PR_SPEC_ENABLE			(1UL << 1)
 # define PR_SPEC_DISABLE		(1UL << 2)
 # define PR_SPEC_FORCE_DISABLE		(1UL << 3)
+# define PR_SPEC_DISABLE_NOEXEC		(1UL << 4)
 
 /* Reset arm64 pointer authentication keys */
 #define PR_PAC_RESET_KEYS		54

