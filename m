Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED54DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CA8204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="RiMOv91D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfF1Ps2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:48:28 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44128 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfF1Pr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:47:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45b1PP3NXYzB09ZN;
        Fri, 28 Jun 2019 17:47:53 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=RiMOv91D; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id eSQlq_-Bw_7o; Fri, 28 Jun 2019 17:47:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45b1PP2C6CzB09ZV;
        Fri, 28 Jun 2019 17:47:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1561736873; bh=l80pzCIIZ6foJcBRTjS/7OLd5DSosdKkxxyG8xTYujg=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=RiMOv91DsQjXtdnBJA7J4KFHRJUshUZoT5RMNCpbp259TzSKkj+4afQtyjEGj9yfQ
         Cvu8FRlGBecDEo/xC2FpMF81GCKmeZrCNOqkYV5RBAJYuEf2XDNicNfy9T7vcOi8zT
         SymzbZSgKbupzBnUEeScwEGbYMH8/3Pxfq3T6sKQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CBA578B955;
        Fri, 28 Jun 2019 17:47:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LX90mky3NlPI; Fri, 28 Jun 2019 17:47:54 +0200 (CEST)
Received: from localhost.localdomain (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EDDAB8B977;
        Fri, 28 Jun 2019 17:47:53 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id B5DA368DBC; Fri, 28 Jun 2019 15:47:53 +0000 (UTC)
Message-Id: <920fe735d5f3dd882331b36a895bb756bd415fe7.1561735587.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1561735587.git.christophe.leroy@c-s.fr>
References: <cover.1561735587.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 04/12] powerpc/ptrace: split out VSX related functions.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 28 Jun 2019 15:47:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move CONFIG_VSX functions out of ptrace.c, into
ptrace-vsx.c and ptrace-novsx.c

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/ptrace/Makefile       |   4 +
 arch/powerpc/kernel/ptrace/ptrace-decl.h  |  26 +++++
 arch/powerpc/kernel/ptrace/ptrace-novsx.c |  83 ++++++++++++++
 arch/powerpc/kernel/ptrace/ptrace-vsx.c   | 177 ++++++++++++++++++++++++++++++
 arch/powerpc/kernel/ptrace/ptrace.c       | 175 +----------------------------
 5 files changed, 293 insertions(+), 172 deletions(-)
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-decl.h
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-novsx.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-vsx.c

diff --git a/arch/powerpc/kernel/ptrace/Makefile b/arch/powerpc/kernel/ptrace/Makefile
index 02fb28eb3b55..238c27189078 100644
--- a/arch/powerpc/kernel/ptrace/Makefile
+++ b/arch/powerpc/kernel/ptrace/Makefile
@@ -7,3 +7,7 @@ CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
 obj-y				+= ptrace.o
 obj-$(CONFIG_PPC64)		+= ptrace32.o
+obj-$(CONFIG_VSX)		+= ptrace-vsx.o
+ifneq ($(CONFIG_VSX),y)
+obj-y				+= ptrace-novsx.o
+endif
diff --git a/arch/powerpc/kernel/ptrace/ptrace-decl.h b/arch/powerpc/kernel/ptrace/ptrace-decl.h
new file mode 100644
index 000000000000..764df4ee9362
--- /dev/null
+++ b/arch/powerpc/kernel/ptrace/ptrace-decl.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* ptrace-(no)vsx */
+
+int fpr_get(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+int fpr_set(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count,
+	    const void *kbuf, const void __user *ubuf);
+
+/* ptrace-vsx */
+
+int vsr_active(struct task_struct *target, const struct user_regset *regset);
+int vsr_get(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf);
+int vsr_set(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count,
+	    const void *kbuf, const void __user *ubuf);
+
+/* ptrace */
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+void flush_tmregs_to_thread(struct task_struct *tsk);
+#else
+static inline void flush_tmregs_to_thread(struct task_struct *tsk) { }
+#endif
diff --git a/arch/powerpc/kernel/ptrace/ptrace-novsx.c b/arch/powerpc/kernel/ptrace/ptrace-novsx.c
new file mode 100644
index 000000000000..55fbbb4aa9d7
--- /dev/null
+++ b/arch/powerpc/kernel/ptrace/ptrace-novsx.c
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/errno.h>
+#include <linux/ptrace.h>
+#include <linux/regset.h>
+#include <linux/tracehook.h>
+#include <linux/elf.h>
+#include <linux/user.h>
+#include <linux/security.h>
+#include <linux/signal.h>
+#include <linux/seccomp.h>
+#include <linux/audit.h>
+#include <trace/syscall.h>
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
+#include <linux/context_tracking.h>
+#include <linux/nospec.h>
+
+#include <linux/uaccess.h>
+#include <linux/pkeys.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/switch_to.h>
+#include <asm/tm.h>
+#include <asm/asm-prototypes.h>
+#include <asm/debug.h>
+#include <asm/hw_breakpoint.h>
+
+#include <kernel/ptrace/ptrace-decl.h>
+
+/*
+ * Regardless of transactions, 'fp_state' holds the current running
+ * value of all FPR registers and 'ckfp_state' holds the last checkpointed
+ * value of all FPR registers for the current transaction.
+ *
+ * Userspace interface buffer layout:
+ *
+ * struct data {
+ *	u64	fpr[32];
+ *	u64	fpscr;
+ * };
+ */
+int fpr_get(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+{
+	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
+		     offsetof(struct thread_fp_state, fpr[32]));
+
+	flush_fp_to_thread(target);
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				   &target->thread.fp_state, 0, -1);
+}
+
+/*
+ * Regardless of transactions, 'fp_state' holds the current running
+ * value of all FPR registers and 'ckfp_state' holds the last checkpointed
+ * value of all FPR registers for the current transaction.
+ *
+ * Userspace interface buffer layout:
+ *
+ * struct data {
+ *	u64	fpr[32];
+ *	u64	fpscr;
+ * };
+ *
+ */
+int fpr_set(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count,
+	    const void *kbuf, const void __user *ubuf)
+{
+	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
+		     offsetof(struct thread_fp_state, fpr[32]));
+
+	flush_fp_to_thread(target);
+
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				  &target->thread.fp_state, 0, -1);
+}
diff --git a/arch/powerpc/kernel/ptrace/ptrace-vsx.c b/arch/powerpc/kernel/ptrace/ptrace-vsx.c
new file mode 100644
index 000000000000..1d94210cdf63
--- /dev/null
+++ b/arch/powerpc/kernel/ptrace/ptrace-vsx.c
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/errno.h>
+#include <linux/ptrace.h>
+#include <linux/regset.h>
+#include <linux/tracehook.h>
+#include <linux/elf.h>
+#include <linux/user.h>
+#include <linux/security.h>
+#include <linux/signal.h>
+#include <linux/seccomp.h>
+#include <linux/audit.h>
+#include <trace/syscall.h>
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
+#include <linux/context_tracking.h>
+#include <linux/nospec.h>
+
+#include <linux/uaccess.h>
+#include <linux/pkeys.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/switch_to.h>
+#include <asm/tm.h>
+#include <asm/asm-prototypes.h>
+#include <asm/debug.h>
+#include <asm/hw_breakpoint.h>
+
+#include <kernel/ptrace/ptrace-decl.h>
+
+/*
+ * Regardless of transactions, 'fp_state' holds the current running
+ * value of all FPR registers and 'ckfp_state' holds the last checkpointed
+ * value of all FPR registers for the current transaction.
+ *
+ * Userspace interface buffer layout:
+ *
+ * struct data {
+ *	u64	fpr[32];
+ *	u64	fpscr;
+ * };
+ */
+int fpr_get(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+{
+	u64 buf[33];
+	int i;
+
+	flush_fp_to_thread(target);
+
+	/* copy to local buffer then write that out */
+	for (i = 0; i < 32 ; i++)
+		buf[i] = target->thread.TS_FPR(i);
+	buf[32] = target->thread.fp_state.fpscr;
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
+}
+
+/*
+ * Regardless of transactions, 'fp_state' holds the current running
+ * value of all FPR registers and 'ckfp_state' holds the last checkpointed
+ * value of all FPR registers for the current transaction.
+ *
+ * Userspace interface buffer layout:
+ *
+ * struct data {
+ *	u64	fpr[32];
+ *	u64	fpscr;
+ * };
+ *
+ */
+int fpr_set(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count,
+	    const void *kbuf, const void __user *ubuf)
+{
+	u64 buf[33];
+	int i;
+
+	flush_fp_to_thread(target);
+
+	for (i = 0; i < 32 ; i++)
+		buf[i] = target->thread.TS_FPR(i);
+	buf[32] = target->thread.fp_state.fpscr;
+
+	/* copy to local buffer then write that out */
+	i = user_regset_copyin(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
+	if (i)
+		return i;
+
+	for (i = 0; i < 32 ; i++)
+		target->thread.TS_FPR(i) = buf[i];
+	target->thread.fp_state.fpscr = buf[32];
+	return 0;
+}
+
+/*
+ * Currently to set and and get all the vsx state, you need to call
+ * the fp and VMX calls as well.  This only get/sets the lower 32
+ * 128bit VSX registers.
+ */
+
+int vsr_active(struct task_struct *target, const struct user_regset *regset)
+{
+	flush_vsx_to_thread(target);
+	return target->thread.used_vsr ? regset->n : 0;
+}
+
+/*
+ * Regardless of transactions, 'fp_state' holds the current running
+ * value of all FPR registers and 'ckfp_state' holds the last
+ * checkpointed value of all FPR registers for the current
+ * transaction.
+ *
+ * Userspace interface buffer layout:
+ *
+ * struct data {
+ *	u64	vsx[32];
+ * };
+ */
+int vsr_get(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count, void *kbuf, void __user *ubuf)
+{
+	u64 buf[32];
+	int ret, i;
+
+	flush_tmregs_to_thread(target);
+	flush_fp_to_thread(target);
+	flush_altivec_to_thread(target);
+	flush_vsx_to_thread(target);
+
+	for (i = 0; i < 32 ; i++)
+		buf[i] = target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  buf, 0, 32 * sizeof(double));
+
+	return ret;
+}
+
+/*
+ * Regardless of transactions, 'fp_state' holds the current running
+ * value of all FPR registers and 'ckfp_state' holds the last
+ * checkpointed value of all FPR registers for the current
+ * transaction.
+ *
+ * Userspace interface buffer layout:
+ *
+ * struct data {
+ *	u64	vsx[32];
+ * };
+ */
+int vsr_set(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count,
+	    const void *kbuf, const void __user *ubuf)
+{
+	u64 buf[32];
+	int ret,i;
+
+	flush_tmregs_to_thread(target);
+	flush_fp_to_thread(target);
+	flush_altivec_to_thread(target);
+	flush_vsx_to_thread(target);
+
+	for (i = 0; i < 32 ; i++)
+		buf[i] = target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 buf, 0, 32 * sizeof(double));
+	if (!ret)
+		for (i = 0; i < 32 ; i++)
+			target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
+
+	return ret;
+}
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index cc8efcb404d6..3d0a0b8f8c07 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -48,6 +48,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
+#include <kernel/ptrace/ptrace-decl.h>
+
 struct pt_regs_offset {
 	const char *name;
 	int offset;
@@ -112,7 +114,7 @@ static const struct pt_regs_offset regoffset_table[] = {
 };
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-static void flush_tmregs_to_thread(struct task_struct *tsk)
+void flush_tmregs_to_thread(struct task_struct *tsk)
 {
 	/*
 	 * If task is not current, it will have been flushed already to
@@ -132,8 +134,6 @@ static void flush_tmregs_to_thread(struct task_struct *tsk)
 		tm_save_sprs(&(tsk->thread));
 	}
 }
-#else
-static inline void flush_tmregs_to_thread(struct task_struct *tsk) { }
 #endif
 
 /**
@@ -415,91 +415,6 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
 	return ret;
 }
 
-/*
- * Regardless of transactions, 'fp_state' holds the current running
- * value of all FPR registers and 'ckfp_state' holds the last checkpointed
- * value of all FPR registers for the current transaction.
- *
- * Userspace interface buffer layout:
- *
- * struct data {
- *	u64	fpr[32];
- *	u64	fpscr;
- * };
- */
-static int fpr_get(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
-{
-#ifdef CONFIG_VSX
-	u64 buf[33];
-	int i;
-
-	flush_fp_to_thread(target);
-
-	/* copy to local buffer then write that out */
-	for (i = 0; i < 32 ; i++)
-		buf[i] = target->thread.TS_FPR(i);
-	buf[32] = target->thread.fp_state.fpscr;
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
-#else
-	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
-		     offsetof(struct thread_fp_state, fpr[32]));
-
-	flush_fp_to_thread(target);
-
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &target->thread.fp_state, 0, -1);
-#endif
-}
-
-/*
- * Regardless of transactions, 'fp_state' holds the current running
- * value of all FPR registers and 'ckfp_state' holds the last checkpointed
- * value of all FPR registers for the current transaction.
- *
- * Userspace interface buffer layout:
- *
- * struct data {
- *	u64	fpr[32];
- *	u64	fpscr;
- * };
- *
- */
-static int fpr_set(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   const void *kbuf, const void __user *ubuf)
-{
-#ifdef CONFIG_VSX
-	u64 buf[33];
-	int i;
-
-	flush_fp_to_thread(target);
-
-	for (i = 0; i < 32 ; i++)
-		buf[i] = target->thread.TS_FPR(i);
-	buf[32] = target->thread.fp_state.fpscr;
-
-	/* copy to local buffer then write that out */
-	i = user_regset_copyin(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
-	if (i)
-		return i;
-
-	for (i = 0; i < 32 ; i++)
-		target->thread.TS_FPR(i) = buf[i];
-	target->thread.fp_state.fpscr = buf[32];
-	return 0;
-#else
-	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
-		     offsetof(struct thread_fp_state, fpr[32]));
-
-	flush_fp_to_thread(target);
-
-	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.fp_state, 0, -1);
-#endif
-}
-
 #ifdef CONFIG_ALTIVEC
 /*
  * Get/set all the altivec registers vr0..vr31, vscr, vrsave, in one go.
@@ -624,90 +539,6 @@ static int vr_set(struct task_struct *target, const struct user_regset *regset,
 }
 #endif /* CONFIG_ALTIVEC */
 
-#ifdef CONFIG_VSX
-/*
- * Currently to set and and get all the vsx state, you need to call
- * the fp and VMX calls as well.  This only get/sets the lower 32
- * 128bit VSX registers.
- */
-
-static int vsr_active(struct task_struct *target,
-		      const struct user_regset *regset)
-{
-	flush_vsx_to_thread(target);
-	return target->thread.used_vsr ? regset->n : 0;
-}
-
-/*
- * Regardless of transactions, 'fp_state' holds the current running
- * value of all FPR registers and 'ckfp_state' holds the last
- * checkpointed value of all FPR registers for the current
- * transaction.
- *
- * Userspace interface buffer layout:
- *
- * struct data {
- *	u64	vsx[32];
- * };
- */
-static int vsr_get(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   void *kbuf, void __user *ubuf)
-{
-	u64 buf[32];
-	int ret, i;
-
-	flush_tmregs_to_thread(target);
-	flush_fp_to_thread(target);
-	flush_altivec_to_thread(target);
-	flush_vsx_to_thread(target);
-
-	for (i = 0; i < 32 ; i++)
-		buf[i] = target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
-
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  buf, 0, 32 * sizeof(double));
-
-	return ret;
-}
-
-/*
- * Regardless of transactions, 'fp_state' holds the current running
- * value of all FPR registers and 'ckfp_state' holds the last
- * checkpointed value of all FPR registers for the current
- * transaction.
- *
- * Userspace interface buffer layout:
- *
- * struct data {
- *	u64	vsx[32];
- * };
- */
-static int vsr_set(struct task_struct *target, const struct user_regset *regset,
-		   unsigned int pos, unsigned int count,
-		   const void *kbuf, const void __user *ubuf)
-{
-	u64 buf[32];
-	int ret,i;
-
-	flush_tmregs_to_thread(target);
-	flush_fp_to_thread(target);
-	flush_altivec_to_thread(target);
-	flush_vsx_to_thread(target);
-
-	for (i = 0; i < 32 ; i++)
-		buf[i] = target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
-
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				 buf, 0, 32 * sizeof(double));
-	if (!ret)
-		for (i = 0; i < 32 ; i++)
-			target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
-
-	return ret;
-}
-#endif /* CONFIG_VSX */
-
 #ifdef CONFIG_SPE
 
 /*
-- 
2.13.3

