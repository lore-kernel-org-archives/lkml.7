Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F4AC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D787820678
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfK0ITv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:19:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43985 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfK0ITo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:19:44 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZsXu-0002Rj-1S; Wed, 27 Nov 2019 09:19:34 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 502A81C1E72;
        Wed, 27 Nov 2019 09:19:30 +0100 (CET)
Date:   Wed, 27 Nov 2019 08:19:30 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] selftests/x86/single_step_syscall: Check SYSENTER directly
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157484277024.21853.2643521750694270592.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3300c4f3afbb59a1f4bfdbe0f0b6c91e241541b1
Gitweb:        https://git.kernel.org/tip/3300c4f3afbb59a1f4bfdbe0f0b6c91e241541b1
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 20 Nov 2019 12:22:46 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 Nov 2019 21:53:34 +01:00

selftests/x86/single_step_syscall: Check SYSENTER directly

We used to test SYSENTER only through the vDSO.  Test it directly
too, just in case.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/single_step_syscall.c | 94 ++++++++++++--
 1 file changed, 85 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/x86/single_step_syscall.c b/tools/testing/selftests/x86/single_step_syscall.c
index 50ce6c3..1063328 100644
--- a/tools/testing/selftests/x86/single_step_syscall.c
+++ b/tools/testing/selftests/x86/single_step_syscall.c
@@ -43,7 +43,19 @@ static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		err(1, "sigaction");
 }
 
-static volatile sig_atomic_t sig_traps;
+static void clearhandler(int sig)
+{
+	struct sigaction sa;
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = SIG_DFL;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static volatile sig_atomic_t sig_traps, sig_eflags;
+sigjmp_buf jmpbuf;
+static unsigned char altstack_data[SIGSTKSZ];
 
 #ifdef __x86_64__
 # define REG_IP REG_RIP
@@ -90,6 +102,25 @@ static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
 	}
 }
 
+static char const * const signames[] = {
+	[SIGSEGV] = "SIGSEGV",
+	[SIGBUS] = "SIBGUS",
+	[SIGTRAP] = "SIGTRAP",
+	[SIGILL] = "SIGILL",
+};
+
+static void print_and_longjmp(int sig, siginfo_t *si, void *ctx_void)
+{
+	ucontext_t *ctx = ctx_void;
+
+	printf("\tGot %s with RIP=%lx, TF=%ld\n", signames[sig],
+	       (unsigned long)ctx->uc_mcontext.gregs[REG_IP],
+	       (unsigned long)ctx->uc_mcontext.gregs[REG_EFL] & X86_EFLAGS_TF);
+
+	sig_eflags = (unsigned long)ctx->uc_mcontext.gregs[REG_EFL];
+	siglongjmp(jmpbuf, 1);
+}
+
 static void check_result(void)
 {
 	unsigned long new_eflags = get_eflags();
@@ -109,6 +140,22 @@ static void check_result(void)
 	sig_traps = 0;
 }
 
+static void fast_syscall_no_tf(void)
+{
+	sig_traps = 0;
+	printf("[RUN]\tFast syscall with TF cleared\n");
+	fflush(stdout);  /* Force a syscall */
+	if (get_eflags() & X86_EFLAGS_TF) {
+		printf("[FAIL]\tTF is now set\n");
+		exit(1);
+	}
+	if (sig_traps) {
+		printf("[FAIL]\tGot SIGTRAP\n");
+		exit(1);
+	}
+	printf("[OK]\tNothing unexpected happened\n");
+}
+
 int main()
 {
 #ifdef CAN_BUILD_32
@@ -163,17 +210,46 @@ int main()
 	check_result();
 
 	/* Now make sure that another fast syscall doesn't set TF again. */
-	printf("[RUN]\tFast syscall with TF cleared\n");
-	fflush(stdout);  /* Force a syscall */
-	if (get_eflags() & X86_EFLAGS_TF) {
-		printf("[FAIL]\tTF is now set\n");
-		exit(1);
+	fast_syscall_no_tf();
+
+	/*
+	 * And do a forced SYSENTER to make sure that this works even if
+	 * fast syscalls don't use SYSENTER.
+	 *
+	 * Invoking SYSENTER directly breaks all the rules.  Just handle
+	 * the SIGSEGV.
+	 */
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		unsigned long nr = SYS_getpid;
+		printf("[RUN]\tSet TF and check SYSENTER\n");
+		stack_t stack = {
+			.ss_sp = altstack_data,
+			.ss_size = SIGSTKSZ,
+		};
+		if (sigaltstack(&stack, NULL) != 0)
+			err(1, "sigaltstack");
+		sethandler(SIGSEGV, print_and_longjmp,
+			   SA_RESETHAND | SA_ONSTACK);
+		sethandler(SIGILL, print_and_longjmp, SA_RESETHAND);
+		set_eflags(get_eflags() | X86_EFLAGS_TF);
+		/* Clear EBP first to make sure we segfault cleanly. */
+		asm volatile ("xorl %%ebp, %%ebp; SYSENTER" : "+a" (nr) :: "flags", "rcx"
+#ifdef __x86_64__
+				, "r11"
+#endif
+			);
+
+		/* We're unreachable here.  SYSENTER forgets RIP. */
 	}
-	if (sig_traps) {
-		printf("[FAIL]\tGot SIGTRAP\n");
+	clearhandler(SIGSEGV);
+	clearhandler(SIGILL);
+	if (!(sig_eflags & X86_EFLAGS_TF)) {
+		printf("[FAIL]\tTF was cleared\n");
 		exit(1);
 	}
-	printf("[OK]\tNothing unexpected happened\n");
+
+	/* Now make sure that another fast syscall doesn't set TF again. */
+	fast_syscall_no_tf();
 
 	return 0;
 }
