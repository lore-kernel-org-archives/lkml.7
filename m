Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738C9C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1F7206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qYBVTU7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfGBGti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 02:49:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55167 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfGBGth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 02:49:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x626n2Y72680229
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 1 Jul 2019 23:49:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x626n2Y72680229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562050142;
        bh=6gDaNN1asqqnRJ57GWP/SIwyP+r0O1WgnoKH/rGEa8Y=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qYBVTU7ARwx4dzz0XNbSPrrYSIgqDOli27p5woFHcUJCpOQ/pYel3h8zk1BH31SO+
         RKwofBa0DsUZRQE/AXoPQJIdBhZOaMizGKEOAsRfXz18e2Uf+JiBX6NMBbCuBM4vN6
         4A1dXM3xXIPXKnkWaeKZLIx7+z7tfWkxVWWCsmHAShsYujPh7WcCUBUos6tbyaZGNv
         aM6H2EEmSzlsVx3Xu+oUUnG60WCIJ5uWnXy09vtOTpyyYmfv8NgjK4V8ffqcC0hj06
         jxw7/2JzqKNLECotzCcbrhcVR1wuI5m1QVfBPeIBlz347LeUz4oz1WeCMaYHnb8mNk
         9W3ztVVxxwHSA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x626n0Ta2680222;
        Mon, 1 Jul 2019 23:49:00 -0700
Date:   Mon, 1 Jul 2019 23:49:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-9402eaf4c11f0b892eda7b2bcb4654ab34ce34f9@git.kernel.org>
Cc:     bp@alien8.de, peterz@infradead.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        chang.seok.bae@intel.com, hpa@zytor.com, mingo@kernel.org,
        vegard.nossum@oracle.com, luto@kernel.org
Reply-To: chang.seok.bae@intel.com, tglx@linutronix.de,
          pbonzini@redhat.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, bp@alien8.de, luto@kernel.org,
          vegard.nossum@oracle.com, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <5f5de10441ab2e3005538b4c33be9b1965d1bb63.1562035429.git.luto@kernel.org>
References: <5f5de10441ab2e3005538b4c33be9b1965d1bb63.1562035429.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] selftests/x86: Test SYSCALL and SYSENTER manually
 with TF set
Git-Commit-ID: 9402eaf4c11f0b892eda7b2bcb4654ab34ce34f9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9402eaf4c11f0b892eda7b2bcb4654ab34ce34f9
Gitweb:     https://git.kernel.org/tip/9402eaf4c11f0b892eda7b2bcb4654ab34ce34f9
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Mon, 1 Jul 2019 20:43:19 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 2 Jul 2019 08:45:20 +0200

selftests/x86: Test SYSCALL and SYSENTER manually with TF set

Make sure that both variants of the nasty TF-in-compat-syscall are
exercised regardless of what vendor's CPU is running the tests.

Also change the intentional signal after SYSCALL to use ud2, which
is a lot more comprehensible.

This crashes the kernel due to an FSGSBASE bug right now.

This test *also* detects a bug in KVM when run on an Intel host.  KVM
people, feel free to use it to help debug.  There's a bunch of code in this
test to warn instead of going into an infinite looping when the bug gets
triggered.

Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc:  "BaeChang Seok" <chang.seok.bae@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Cc: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Link: https://lkml.kernel.org/r/5f5de10441ab2e3005538b4c33be9b1965d1bb63.1562035429.git.luto@kernel.org

---
 tools/testing/selftests/x86/Makefile            |   5 +-
 tools/testing/selftests/x86/syscall_arg_fault.c | 112 ++++++++++++++++++++++--
 2 files changed, 110 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 186520198de7..fa07d526fe39 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -12,8 +12,9 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl mpx-mini-test ioperm \
-			protection_keys test_vdso test_vsyscall mov_ss_trap
-TARGETS_C_32BIT_ONLY := entry_from_vm86 syscall_arg_fault test_syscall_vdso unwind_vdso \
+			protection_keys test_vdso test_vsyscall mov_ss_trap \
+			syscall_arg_fault
+TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip
diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index 4e25d38c8bbd..bc0ecc2e862e 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -15,9 +15,30 @@
 #include <setjmp.h>
 #include <errno.h>
 
+#ifdef __x86_64__
+# define WIDTH "q"
+#else
+# define WIDTH "l"
+#endif
+
 /* Our sigaltstack scratch space. */
 static unsigned char altstack_data[SIGSTKSZ];
 
+static unsigned long get_eflags(void)
+{
+	unsigned long eflags;
+	asm volatile ("pushf" WIDTH "\n\tpop" WIDTH " %0" : "=rm" (eflags));
+	return eflags;
+}
+
+static void set_eflags(unsigned long eflags)
+{
+	asm volatile ("push" WIDTH " %0\n\tpopf" WIDTH
+		      : : "rm" (eflags) : "flags");
+}
+
+#define X86_EFLAGS_TF (1UL << 8)
+
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
@@ -35,13 +56,22 @@ static sigjmp_buf jmpbuf;
 
 static volatile sig_atomic_t n_errs;
 
+#ifdef __x86_64__
+#define REG_AX REG_RAX
+#define REG_IP REG_RIP
+#else
+#define REG_AX REG_EAX
+#define REG_IP REG_EIP
+#endif
+
 static void sigsegv_or_sigbus(int sig, siginfo_t *info, void *ctx_void)
 {
 	ucontext_t *ctx = (ucontext_t*)ctx_void;
+	long ax = (long)ctx->uc_mcontext.gregs[REG_AX];
 
-	if (ctx->uc_mcontext.gregs[REG_EAX] != -EFAULT) {
-		printf("[FAIL]\tAX had the wrong value: 0x%x\n",
-		       ctx->uc_mcontext.gregs[REG_EAX]);
+	if (ax != -EFAULT && ax != -ENOSYS) {
+		printf("[FAIL]\tAX had the wrong value: 0x%lx\n",
+		       (unsigned long)ax);
 		n_errs++;
 	} else {
 		printf("[OK]\tSeems okay\n");
@@ -50,9 +80,42 @@ static void sigsegv_or_sigbus(int sig, siginfo_t *info, void *ctx_void)
 	siglongjmp(jmpbuf, 1);
 }
 
+static volatile sig_atomic_t sigtrap_consecutive_syscalls;
+
+static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
+{
+	/*
+	 * KVM has some bugs that can cause us to stop making progress.
+	 * detect them and complain, but don't infinite loop or fail the
+	 * test.
+	 */
+
+	ucontext_t *ctx = (ucontext_t*)ctx_void;
+	unsigned short *ip = (unsigned short *)ctx->uc_mcontext.gregs[REG_IP];
+
+	if (*ip == 0x340f || *ip == 0x050f) {
+		/* The trap was on SYSCALL or SYSENTER */
+		sigtrap_consecutive_syscalls++;
+		if (sigtrap_consecutive_syscalls > 3) {
+			printf("[WARN]\tGot stuck single-stepping -- you probably have a KVM bug\n");
+			siglongjmp(jmpbuf, 1);
+		}
+	} else {
+		sigtrap_consecutive_syscalls = 0;
+	}
+}
+
 static void sigill(int sig, siginfo_t *info, void *ctx_void)
 {
-	printf("[SKIP]\tIllegal instruction\n");
+	ucontext_t *ctx = (ucontext_t*)ctx_void;
+	unsigned short *ip = (unsigned short *)ctx->uc_mcontext.gregs[REG_IP];
+
+	if (*ip == 0x0b0f) {
+		/* one of the ud2 instructions faulted */
+		printf("[OK]\tSYSCALL returned normally\n");
+	} else {
+		printf("[SKIP]\tIllegal instruction\n");
+	}
 	siglongjmp(jmpbuf, 1);
 }
 
@@ -120,9 +183,48 @@ int main()
 			"movl $-1, %%ebp\n\t"
 			"movl $-1, %%esp\n\t"
 			"syscall\n\t"
-			"pushl $0"	/* make sure we segfault cleanly */
+			"ud2"		/* make sure we recover cleanly */
+			: : : "memory", "flags");
+	}
+
+	printf("[RUN]\tSYSENTER with TF and invalid state\n");
+	sethandler(SIGTRAP, sigtrap, SA_ONSTACK);
+
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		sigtrap_consecutive_syscalls = 0;
+		set_eflags(get_eflags() | X86_EFLAGS_TF);
+		asm volatile (
+			"movl $-1, %%eax\n\t"
+			"movl $-1, %%ebx\n\t"
+			"movl $-1, %%ecx\n\t"
+			"movl $-1, %%edx\n\t"
+			"movl $-1, %%esi\n\t"
+			"movl $-1, %%edi\n\t"
+			"movl $-1, %%ebp\n\t"
+			"movl $-1, %%esp\n\t"
+			"sysenter"
+			: : : "memory", "flags");
+	}
+	set_eflags(get_eflags() & ~X86_EFLAGS_TF);
+
+	printf("[RUN]\tSYSCALL with TF and invalid state\n");
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		sigtrap_consecutive_syscalls = 0;
+		set_eflags(get_eflags() | X86_EFLAGS_TF);
+		asm volatile (
+			"movl $-1, %%eax\n\t"
+			"movl $-1, %%ebx\n\t"
+			"movl $-1, %%ecx\n\t"
+			"movl $-1, %%edx\n\t"
+			"movl $-1, %%esi\n\t"
+			"movl $-1, %%edi\n\t"
+			"movl $-1, %%ebp\n\t"
+			"movl $-1, %%esp\n\t"
+			"syscall\n\t"
+			"ud2"		/* make sure we recover cleanly */
 			: : : "memory", "flags");
 	}
+	set_eflags(get_eflags() & ~X86_EFLAGS_TF);
 
 	return 0;
 }
