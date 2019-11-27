Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DFEC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B952070A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfK0KkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:40:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:56752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727309AbfK0KkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:40:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7FBADB50C;
        Wed, 27 Nov 2019 10:40:01 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Breno Leitao <leitao@debian.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        Daniel Axtens <dja@axtens.net>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Romero <gromero@linux.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 rebase 28/34] powerpc: move common register copy functions from signal_32.c to signal.c
Date:   Wed, 27 Nov 2019 11:39:04 +0100
Message-Id: <4e08277f965e45e65d8a9a0ea865778bf550f2c2.1574803685.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574803684.git.msuchanek@suse.de>
References: <cover.1574803684.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are required for 64bit as well.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/signal.c    | 141 ++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/signal_32.c | 140 -------------------------------
 2 files changed, 141 insertions(+), 140 deletions(-)

diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index e6c30cee6abf..60436432399f 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -18,12 +18,153 @@
 #include <linux/syscalls.h>
 #include <asm/hw_breakpoint.h>
 #include <linux/uaccess.h>
+#include <asm/switch_to.h>
 #include <asm/unistd.h>
 #include <asm/debug.h>
 #include <asm/tm.h>
 
 #include "signal.h"
 
+#ifdef CONFIG_VSX
+unsigned long copy_fpr_to_user(void __user *to,
+			       struct task_struct *task)
+{
+	u64 buf[ELF_NFPREG];
+	int i;
+
+	/* save FPR copy to local buffer then write to the thread_struct */
+	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
+		buf[i] = task->thread.TS_FPR(i);
+	buf[i] = task->thread.fp_state.fpscr;
+	return __copy_to_user(to, buf, ELF_NFPREG * sizeof(double));
+}
+
+unsigned long copy_fpr_from_user(struct task_struct *task,
+				 void __user *from)
+{
+	u64 buf[ELF_NFPREG];
+	int i;
+
+	if (__copy_from_user(buf, from, ELF_NFPREG * sizeof(double)))
+		return 1;
+	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
+		task->thread.TS_FPR(i) = buf[i];
+	task->thread.fp_state.fpscr = buf[i];
+
+	return 0;
+}
+
+unsigned long copy_vsx_to_user(void __user *to,
+			       struct task_struct *task)
+{
+	u64 buf[ELF_NVSRHALFREG];
+	int i;
+
+	/* save FPR copy to local buffer then write to the thread_struct */
+	for (i = 0; i < ELF_NVSRHALFREG; i++)
+		buf[i] = task->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
+	return __copy_to_user(to, buf, ELF_NVSRHALFREG * sizeof(double));
+}
+
+unsigned long copy_vsx_from_user(struct task_struct *task,
+				 void __user *from)
+{
+	u64 buf[ELF_NVSRHALFREG];
+	int i;
+
+	if (__copy_from_user(buf, from, ELF_NVSRHALFREG * sizeof(double)))
+		return 1;
+	for (i = 0; i < ELF_NVSRHALFREG ; i++)
+		task->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
+	return 0;
+}
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+unsigned long copy_ckfpr_to_user(void __user *to,
+				  struct task_struct *task)
+{
+	u64 buf[ELF_NFPREG];
+	int i;
+
+	/* save FPR copy to local buffer then write to the thread_struct */
+	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
+		buf[i] = task->thread.TS_CKFPR(i);
+	buf[i] = task->thread.ckfp_state.fpscr;
+	return __copy_to_user(to, buf, ELF_NFPREG * sizeof(double));
+}
+
+unsigned long copy_ckfpr_from_user(struct task_struct *task,
+					  void __user *from)
+{
+	u64 buf[ELF_NFPREG];
+	int i;
+
+	if (__copy_from_user(buf, from, ELF_NFPREG * sizeof(double)))
+		return 1;
+	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
+		task->thread.TS_CKFPR(i) = buf[i];
+	task->thread.ckfp_state.fpscr = buf[i];
+
+	return 0;
+}
+
+unsigned long copy_ckvsx_to_user(void __user *to,
+				  struct task_struct *task)
+{
+	u64 buf[ELF_NVSRHALFREG];
+	int i;
+
+	/* save FPR copy to local buffer then write to the thread_struct */
+	for (i = 0; i < ELF_NVSRHALFREG; i++)
+		buf[i] = task->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET];
+	return __copy_to_user(to, buf, ELF_NVSRHALFREG * sizeof(double));
+}
+
+unsigned long copy_ckvsx_from_user(struct task_struct *task,
+					  void __user *from)
+{
+	u64 buf[ELF_NVSRHALFREG];
+	int i;
+
+	if (__copy_from_user(buf, from, ELF_NVSRHALFREG * sizeof(double)))
+		return 1;
+	for (i = 0; i < ELF_NVSRHALFREG ; i++)
+		task->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
+	return 0;
+}
+#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+#else
+inline unsigned long copy_fpr_to_user(void __user *to,
+				      struct task_struct *task)
+{
+	return __copy_to_user(to, task->thread.fp_state.fpr,
+			      ELF_NFPREG * sizeof(double));
+}
+
+inline unsigned long copy_fpr_from_user(struct task_struct *task,
+					void __user *from)
+{
+	return __copy_from_user(task->thread.fp_state.fpr, from,
+			      ELF_NFPREG * sizeof(double));
+}
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+inline unsigned long copy_ckfpr_to_user(void __user *to,
+					 struct task_struct *task)
+{
+	return __copy_to_user(to, task->thread.ckfp_state.fpr,
+			      ELF_NFPREG * sizeof(double));
+}
+
+inline unsigned long copy_ckfpr_from_user(struct task_struct *task,
+						 void __user *from)
+{
+	return __copy_from_user(task->thread.ckfp_state.fpr, from,
+				ELF_NFPREG * sizeof(double));
+}
+#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+#endif
+
 /* Log an error when sending an unhandled signal to a process. Controlled
  * through debug.exception-trace sysctl.
  */
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 98600b276f76..c93c937ea568 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -235,146 +235,6 @@ struct rt_sigframe {
 	int			abigap[56];
 };
 
-#ifdef CONFIG_VSX
-unsigned long copy_fpr_to_user(void __user *to,
-			       struct task_struct *task)
-{
-	u64 buf[ELF_NFPREG];
-	int i;
-
-	/* save FPR copy to local buffer then write to the thread_struct */
-	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
-		buf[i] = task->thread.TS_FPR(i);
-	buf[i] = task->thread.fp_state.fpscr;
-	return __copy_to_user(to, buf, ELF_NFPREG * sizeof(double));
-}
-
-unsigned long copy_fpr_from_user(struct task_struct *task,
-				 void __user *from)
-{
-	u64 buf[ELF_NFPREG];
-	int i;
-
-	if (__copy_from_user(buf, from, ELF_NFPREG * sizeof(double)))
-		return 1;
-	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
-		task->thread.TS_FPR(i) = buf[i];
-	task->thread.fp_state.fpscr = buf[i];
-
-	return 0;
-}
-
-unsigned long copy_vsx_to_user(void __user *to,
-			       struct task_struct *task)
-{
-	u64 buf[ELF_NVSRHALFREG];
-	int i;
-
-	/* save FPR copy to local buffer then write to the thread_struct */
-	for (i = 0; i < ELF_NVSRHALFREG; i++)
-		buf[i] = task->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
-	return __copy_to_user(to, buf, ELF_NVSRHALFREG * sizeof(double));
-}
-
-unsigned long copy_vsx_from_user(struct task_struct *task,
-				 void __user *from)
-{
-	u64 buf[ELF_NVSRHALFREG];
-	int i;
-
-	if (__copy_from_user(buf, from, ELF_NVSRHALFREG * sizeof(double)))
-		return 1;
-	for (i = 0; i < ELF_NVSRHALFREG ; i++)
-		task->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
-	return 0;
-}
-
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-unsigned long copy_ckfpr_to_user(void __user *to,
-				  struct task_struct *task)
-{
-	u64 buf[ELF_NFPREG];
-	int i;
-
-	/* save FPR copy to local buffer then write to the thread_struct */
-	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
-		buf[i] = task->thread.TS_CKFPR(i);
-	buf[i] = task->thread.ckfp_state.fpscr;
-	return __copy_to_user(to, buf, ELF_NFPREG * sizeof(double));
-}
-
-unsigned long copy_ckfpr_from_user(struct task_struct *task,
-					  void __user *from)
-{
-	u64 buf[ELF_NFPREG];
-	int i;
-
-	if (__copy_from_user(buf, from, ELF_NFPREG * sizeof(double)))
-		return 1;
-	for (i = 0; i < (ELF_NFPREG - 1) ; i++)
-		task->thread.TS_CKFPR(i) = buf[i];
-	task->thread.ckfp_state.fpscr = buf[i];
-
-	return 0;
-}
-
-unsigned long copy_ckvsx_to_user(void __user *to,
-				  struct task_struct *task)
-{
-	u64 buf[ELF_NVSRHALFREG];
-	int i;
-
-	/* save FPR copy to local buffer then write to the thread_struct */
-	for (i = 0; i < ELF_NVSRHALFREG; i++)
-		buf[i] = task->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET];
-	return __copy_to_user(to, buf, ELF_NVSRHALFREG * sizeof(double));
-}
-
-unsigned long copy_ckvsx_from_user(struct task_struct *task,
-					  void __user *from)
-{
-	u64 buf[ELF_NVSRHALFREG];
-	int i;
-
-	if (__copy_from_user(buf, from, ELF_NVSRHALFREG * sizeof(double)))
-		return 1;
-	for (i = 0; i < ELF_NVSRHALFREG ; i++)
-		task->thread.ckfp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
-	return 0;
-}
-#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
-#else
-inline unsigned long copy_fpr_to_user(void __user *to,
-				      struct task_struct *task)
-{
-	return __copy_to_user(to, task->thread.fp_state.fpr,
-			      ELF_NFPREG * sizeof(double));
-}
-
-inline unsigned long copy_fpr_from_user(struct task_struct *task,
-					void __user *from)
-{
-	return __copy_from_user(task->thread.fp_state.fpr, from,
-			      ELF_NFPREG * sizeof(double));
-}
-
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-inline unsigned long copy_ckfpr_to_user(void __user *to,
-					 struct task_struct *task)
-{
-	return __copy_to_user(to, task->thread.ckfp_state.fpr,
-			      ELF_NFPREG * sizeof(double));
-}
-
-inline unsigned long copy_ckfpr_from_user(struct task_struct *task,
-						 void __user *from)
-{
-	return __copy_from_user(task->thread.ckfp_state.fpr, from,
-				ELF_NFPREG * sizeof(double));
-}
-#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
-#endif
-
 /*
  * Save the current user registers on the user stack.
  * We only save the altivec/spe registers if the process has used
-- 
2.23.0

