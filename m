Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007E0C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4DD20723
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfKPLv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 06:51:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45231 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfKPLv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 06:51:27 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVwbq-00026G-BP; Sat, 16 Nov 2019 12:51:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0D3B71C1901;
        Sat, 16 Nov 2019 12:51:22 +0100 (CET)
Date:   Sat, 16 Nov 2019 11:51:21 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] selftests/x86/iopl: Extend test to cover IOPL emulation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157390508200.12247.14682981591292814407.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/iopl branch of tip:

Commit-ID:     e638ad00809a323cbe13dfa0952d4234d9b36732
Gitweb:        https://git.kernel.org/tip/e638ad00809a323cbe13dfa0952d4234d9b36732
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 11 Nov 2019 23:03:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 16 Nov 2019 11:24:06 +01:00

selftests/x86/iopl: Extend test to cover IOPL emulation

Add tests that the now emulated iopl() functionality:

    - does not longer allow user space to disable interrupts.

    - does restore a I/O bitmap when IOPL is dropped

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 tools/testing/selftests/x86/iopl.c | 129 +++++++++++++++++++++++++---
 1 file changed, 118 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/x86/iopl.c b/tools/testing/selftests/x86/iopl.c
index 6aa27f3..bab2f6e 100644
--- a/tools/testing/selftests/x86/iopl.c
+++ b/tools/testing/selftests/x86/iopl.c
@@ -35,6 +35,16 @@ static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 
 }
 
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
 static jmp_buf jmpbuf;
 
 static void sigsegv(int sig, siginfo_t *si, void *ctx_void)
@@ -42,25 +52,128 @@ static void sigsegv(int sig, siginfo_t *si, void *ctx_void)
 	siglongjmp(jmpbuf, 1);
 }
 
+static bool try_outb(unsigned short port)
+{
+	sethandler(SIGSEGV, sigsegv, SA_RESETHAND);
+	if (sigsetjmp(jmpbuf, 1) != 0) {
+		return false;
+	} else {
+		asm volatile ("outb %%al, %w[port]"
+			      : : [port] "Nd" (port), "a" (0));
+		return true;
+	}
+	clearhandler(SIGSEGV);
+}
+
+static void expect_ok_outb(unsigned short port)
+{
+	if (!try_outb(port)) {
+		printf("[FAIL]\toutb to 0x%02hx failed\n", port);
+		exit(1);
+	}
+
+	printf("[OK]\toutb to 0x%02hx worked\n", port);
+}
+
+static void expect_gp_outb(unsigned short port)
+{
+	if (try_outb(port)) {
+		printf("[FAIL]\toutb to 0x%02hx worked\n", port);
+		nerrs++;
+	}
+
+	printf("[OK]\toutb to 0x%02hx failed\n", port);
+}
+
+static bool try_cli(void)
+{
+	sethandler(SIGSEGV, sigsegv, SA_RESETHAND);
+	if (sigsetjmp(jmpbuf, 1) != 0) {
+		return false;
+	} else {
+		asm volatile ("cli");
+		return true;
+	}
+	clearhandler(SIGSEGV);
+}
+
+static bool try_sti(void)
+{
+	sethandler(SIGSEGV, sigsegv, SA_RESETHAND);
+	if (sigsetjmp(jmpbuf, 1) != 0) {
+		return false;
+	} else {
+		asm volatile ("sti");
+		return true;
+	}
+	clearhandler(SIGSEGV);
+}
+
+static void expect_gp_sti(void)
+{
+	if (try_sti()) {
+		printf("[FAIL]\tSTI worked\n");
+		nerrs++;
+	} else {
+		printf("[OK]\tSTI faulted\n");
+	}
+}
+
+static void expect_gp_cli(void)
+{
+	if (try_cli()) {
+		printf("[FAIL]\tCLI worked\n");
+		nerrs++;
+	} else {
+		printf("[OK]\tCLI faulted\n");
+	}
+}
+
 int main(void)
 {
 	cpu_set_t cpuset;
+
 	CPU_ZERO(&cpuset);
 	CPU_SET(0, &cpuset);
 	if (sched_setaffinity(0, sizeof(cpuset), &cpuset) != 0)
 		err(1, "sched_setaffinity to CPU 0");
 
 	/* Probe for iopl support.  Note that iopl(0) works even as nonroot. */
-	if (iopl(3) != 0) {
+	switch(iopl(3)) {
+	case 0:
+		break;
+	case -ENOSYS:
+		printf("[OK]\tiopl() nor supported\n");
+		return 0;
+	default:
 		printf("[OK]\tiopl(3) failed (%d) -- try running as root\n",
 		       errno);
 		return 0;
 	}
 
-	/* Restore our original state prior to starting the test. */
+	/* Make sure that CLI/STI are blocked even with IOPL level 3 */
+	expect_gp_cli();
+	expect_gp_sti();
+	expect_ok_outb(0x80);
+
+	/* Establish an I/O bitmap to test the restore */
+	if (ioperm(0x80, 1, 1) != 0)
+		err(1, "ioperm(0x80, 1, 1) failed\n");
+
+	/* Restore our original state prior to starting the fork test. */
 	if (iopl(0) != 0)
 		err(1, "iopl(0)");
 
+	/*
+	 * Verify that IOPL emulation is disabled and the I/O bitmap still
+	 * works.
+	 */
+	expect_ok_outb(0x80);
+	expect_gp_outb(0xed);
+	/* Drop the I/O bitmap */
+	if (ioperm(0x80, 1, 0) != 0)
+		err(1, "ioperm(0x80, 1, 0) failed\n");
+
 	pid_t child = fork();
 	if (child == -1)
 		err(1, "fork");
@@ -90,14 +203,9 @@ int main(void)
 
 	printf("[RUN]\tparent: write to 0x80 (should fail)\n");
 
-	sethandler(SIGSEGV, sigsegv, 0);
-	if (sigsetjmp(jmpbuf, 1) != 0) {
-		printf("[OK]\twrite was denied\n");
-	} else {
-		asm volatile ("outb %%al, $0x80" : : "a" (0));
-		printf("[FAIL]\twrite was allowed\n");
-		nerrs++;
-	}
+	expect_gp_outb(0x80);
+	expect_gp_cli();
+	expect_gp_sti();
 
 	/* Test the capability checks. */
 	printf("\tiopl(3)\n");
@@ -133,4 +241,3 @@ int main(void)
 done:
 	return nerrs ? 1 : 0;
 }
-
