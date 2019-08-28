Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80FDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C683208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfH1QoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:44:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:35050 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726767AbfH1QoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:44:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45884B622;
        Wed, 28 Aug 2019 16:43:59 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Breno Leitao <leitao@debian.org>,
        Russell Currey <ruscur@russell.cc>,
        Nicolai Stange <nstange@suse.de>,
        Michael Neuling <mikey@neuling.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] powerpc/64: make buildable without CONFIG_COMPAT
Date:   Wed, 28 Aug 2019 18:43:50 +0200
Message-Id: <0ad51b41aebf65b3f3fcb9922f0f00b47932725d.1567007242.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1567007242.git.msuchanek@suse.de>
References: <cover.1567007242.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are numerous references to 32bit functions in generic and 64bit
code so ifdef them out.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2:
- fix 32bit ifdef condition in signal.c
- simplify the compat ifdef condition in vdso.c - 64bit is redundant
- simplify the compat ifdef condition in callchain.c - 64bit is redundant
v3:
- use IS_ENABLED and maybe_unused where possible
- do not ifdef declarations
- clean up Makefile
---
 arch/powerpc/kernel/Makefile     |  9 +++++----
 arch/powerpc/kernel/entry_64.S   |  2 ++
 arch/powerpc/kernel/signal.c     |  2 +-
 arch/powerpc/kernel/syscall_64.c |  2 +-
 arch/powerpc/kernel/vdso.c       |  5 ++---
 arch/powerpc/perf/callchain.c    | 13 +++++++++----
 6 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 1d646a94d96c..de1fbb21daf5 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -44,16 +44,17 @@ CFLAGS_btext.o += -DDISABLE_BRANCH_PROFILING
 endif
 
 obj-y				:= cputable.o ptrace.o syscalls.o \
-				   irq.o align.o signal_32.o pmc.o vdso.o \
+				   irq.o align.o signal_$(BITS).o pmc.o vdso.o \
 				   process.o systbl.o idle.o \
 				   signal.o sysfs.o cacheinfo.o time.o \
 				   prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o misc_$(BITS).o \
 				   of_platform.o prom_parse.o
-obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
-				   signal_64.o ptrace32.o \
-				   paca.o nvram_64.o firmware.o \
+obj-$(CONFIG_PPC64)		+= setup_64.o paca.o nvram_64.o firmware.o \
 				   syscall_64.o
+ifdef CONFIG_COMPAT
+obj-y				+= sys_ppc32.o ptrace32.o signal_32.o
+endif
 obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2ec825a85f5b..a2dbf216f607 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -51,8 +51,10 @@
 SYS_CALL_TABLE:
 	.tc sys_call_table[TC],sys_call_table
 
+#ifdef CONFIG_COMPAT
 COMPAT_SYS_CALL_TABLE:
 	.tc compat_sys_call_table[TC],compat_sys_call_table
+#endif
 
 /* This value is used to mark exception frames on the stack. */
 exception_marker:
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 60436432399f..73d0f53ffc1a 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -277,7 +277,7 @@ static void do_signal(struct task_struct *tsk)
 
 	rseq_signal_deliver(&ksig, tsk->thread.regs);
 
-	if (is32) {
+	if ((IS_ENABLED(CONFIG_PPC32) || IS_ENABLED(CONFIG_COMPAT)) && is32) {
         	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
 			ret = handle_rt_signal32(&ksig, oldset, tsk);
 		else
diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/syscall_64.c
index 98ed970796d5..bdd9dcf156f8 100644
--- a/arch/powerpc/kernel/syscall_64.c
+++ b/arch/powerpc/kernel/syscall_64.c
@@ -100,7 +100,7 @@ long system_call_exception(long r3, long r4, long r5, long r6, long r7, long r8,
 	/* May be faster to do array_index_nospec? */
 	barrier_nospec();
 
-	if (unlikely(ti_flags & _TIF_32BIT)) {
+	if (IS_ENABLED(CONFIG_COMPAT) && unlikely(ti_flags & _TIF_32BIT)) {
 		f = (void *)compat_sys_call_table[r0];
 
 		r3 &= 0x00000000ffffffffULL;
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index d60598113a9f..6d4a077f74d6 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -667,9 +667,7 @@ static void __init vdso_setup_syscall_map(void)
 {
 	unsigned int i;
 	extern unsigned long *sys_call_table;
-#ifdef CONFIG_PPC64
 	extern unsigned long *compat_sys_call_table;
-#endif
 	extern unsigned long sys_ni_syscall;
 
 
@@ -678,7 +676,8 @@ static void __init vdso_setup_syscall_map(void)
 		if (sys_call_table[i] != sys_ni_syscall)
 			vdso_data->syscall_map_64[i >> 5] |=
 				0x80000000UL >> (i & 0x1f);
-		if (compat_sys_call_table[i] != sys_ni_syscall)
+		if (IS_ENABLED(CONFIG_COMPAT) &&
+		    compat_sys_call_table[i] != sys_ni_syscall)
 			vdso_data->syscall_map_32[i >> 5] |=
 				0x80000000UL >> (i & 0x1f);
 #else /* CONFIG_PPC64 */
diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index c84bbd4298a0..d4e6bf22e0cc 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -15,7 +15,7 @@
 #include <asm/sigcontext.h>
 #include <asm/ucontext.h>
 #include <asm/vdso.h>
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_COMPAT
 #include "../kernel/ppc32.h"
 #endif
 #include <asm/pte-walk.h>
@@ -165,6 +165,7 @@ static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
 	return read_user_stack_slow(ptr, ret, 8);
 }
 
+__maybe_unused
 static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
 {
 	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
@@ -341,6 +342,7 @@ static inline int valid_user_sp(unsigned long sp, int is_64)
 
 #endif /* CONFIG_PPC64 */
 
+#if defined(CONFIG_PPC32) || defined(CONFIG_COMPAT)
 /*
  * Layout for non-RT signal frames
  */
@@ -482,12 +484,15 @@ static void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
 		sp = next_sp;
 	}
 }
+#endif /* 32bit */
 
 void
 perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
 {
-	if (current_is_64bit())
-		perf_callchain_user_64(entry, regs);
-	else
+#if defined(CONFIG_PPC32) || defined(CONFIG_COMPAT)
+	if (!current_is_64bit())
 		perf_callchain_user_32(entry, regs);
+	else
+#endif
+		perf_callchain_user_64(entry, regs);
 }
-- 
2.22.0

