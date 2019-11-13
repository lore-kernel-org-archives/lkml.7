Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A08C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43394206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKMVCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:02:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38989 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfKMVC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:02:28 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUzmU-00069D-G1; Wed, 13 Nov 2019 22:02:26 +0100
Message-Id: <20191113210105.671132359@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 21:43:00 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V3 20/20] selftests/x86/iopl: Extend test to cover IOPL
 emulation
References: <20191113204240.767922595@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Add tests that the now emulated iopl() functionality:

    - does not longer allow user space to disable interrupts.

    - does restore a I/O bitmap when IOPL is dropped

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 tools/testing/selftests/x86/iopl.c |  129 +++++++++++++++++++++++++++++++++----
 1 file changed, 118 insertions(+), 11 deletions(-)

--- a/tools/testing/selftests/x86/iopl.c
+++ b/tools/testing/selftests/x86/iopl.c
@@ -35,6 +35,16 @@ static void sethandler(int sig, void (*h
 
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
@@ -42,25 +52,128 @@ static void sigsegv(int sig, siginfo_t *
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




