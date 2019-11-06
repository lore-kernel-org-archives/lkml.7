Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07514C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E9E217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbfKFU5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:57:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45296 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732167AbfKFU4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:56:50 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSSMB-00033W-UG; Wed, 06 Nov 2019 21:56:48 +0100
Message-Id: <20191106202806.611930277@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 06 Nov 2019 20:35:08 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch 9/9] selftests/x86/iopl: Verify that CLI/STI result in #GP
References: <20191106193459.581614484@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests that the now emulated iopl() functionality does not longer
allow user space to disable interrupts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/x86/iopl.c |  104 +++++++++++++++++++++++++++++++++----
 1 file changed, 93 insertions(+), 11 deletions(-)

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
@@ -42,22 +52,100 @@ static void sigsegv(int sig, siginfo_t *
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
+
+	/* Restore our original state prior to starting the fork test. */
 	if (iopl(0) != 0)
 		err(1, "iopl(0)");
 
@@ -90,14 +178,9 @@ int main(void)
 
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
@@ -133,4 +216,3 @@ int main(void)
 done:
 	return nerrs ? 1 : 0;
 }
-


