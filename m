Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CE2C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99ECE20989
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562125388;
	bh=V5TNc50NhI7kE3wy8X/bLf8OSdoQjyrxB8hT9OZ7/N4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HvSoR+0hIh3aK6QBl64e1m/o8JxdiXiA47QyyHELOoLbtXk/ZJR6sUMVfpjxsYPxT
	 Pg4R7cTYQfF0O1R8hoU2zujO7AVgTpL7hpbOKQfs+cNQcekuF3RYesi88UkhwNenCF
	 kdHynMN49K3xAbPwIL3DS1gGtODMGPHInoOsY5Z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfGCDnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfGCDnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:43:07 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 135F92085A;
        Wed,  3 Jul 2019 03:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562125386;
        bh=V5TNc50NhI7kE3wy8X/bLf8OSdoQjyrxB8hT9OZ7/N4=;
        h=From:To:Cc:Subject:Date:From;
        b=iRVzKGTUYFrnoGIS49ej9gfB43YnrrioDPF0/AX+/w8U2OJB7WvJHl/7tWF7Nr1XC
         2OwId6QSt6VZo2lhDihRc2EViMXGjrPvL2e27rMFCvmLS+9O1q+3XvSqz7vAWMJlTX
         PxkweJIjcpCFtR64thZHbbsH4d6Gv0YInAxIoUIA=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2] selftests/x86/fsgsbase: Fix some test case bugs
Date:   Tue,  2 Jul 2019 20:43:04 -0700
Message-Id: <bab29c84f2475e2c30ddb00f1b877fcd7f4f96a8.1562125333.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This refactors do_unexpected_base() to clean up some code.  It also
fixes the following bugs in test_ptrace_write_gsbase():

 - Incorrect printf() format string caused crashes.

 - Hardcoded 0x7 for the gs selector was not reliably correct.

It also documents the fact that the test is expected to fail on old
kernels.

Fixes: a87730cc3acc ("selftests/x86/fsgsbase: Test ptracer-induced GSBASE write with FSGSBASE")
Fixes: 1b6858d5a2eb ("selftests/x86/fsgsbase: Test ptracer-induced GSBASE write")
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc:  "BaeChang Seok" <chang.seok.bae@intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---

Changes from v1:
 - Fix one more 0x7 (Chang)
 - This time, I explicitly tested it with modify_ldt() disabled

 tools/testing/selftests/x86/fsgsbase.c | 74 ++++++++++++++------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 21fd4f94b5b0..5ab4c60c100e 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -35,6 +35,8 @@
 static volatile sig_atomic_t want_segv;
 static volatile unsigned long segv_addr;
 
+static unsigned short *shared_scratch;
+
 static int nerrs;
 
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
@@ -242,16 +244,11 @@ static void do_remote_base()
 
 static __thread int set_thread_area_entry_number = -1;
 
-static void do_unexpected_base(void)
+static unsigned short load_gs(void)
 {
 	/*
-	 * The goal here is to try to arrange for GS == 0, GSBASE !=
-	 * 0, and for the the kernel the think that GSBASE == 0.
-	 *
-	 * To make the test as reliable as possible, this uses
-	 * explicit descriptors.  (This is not the only way.  This
-	 * could use ARCH_SET_GS with a low, nonzero base, but the
-	 * relevant side effect of ARCH_SET_GS could change.)
+	 * Sets GS != 0 and GSBASE != 0 but arranges for the kernel to think
+	 * that GSBASE == 0 (i.e. thread.gsbase == 0).
 	 */
 
 	/* Step 1: tell the kernel that we have GSBASE == 0. */
@@ -271,8 +268,9 @@ static void do_unexpected_base(void)
 		.useable         = 0
 	};
 	if (syscall(SYS_modify_ldt, 1, &desc, sizeof(desc)) == 0) {
-		printf("\tother thread: using LDT slot 0\n");
+		printf("\tusing LDT slot 0\n");
 		asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)0x7));
+		return 0x7;
 	} else {
 		/* No modify_ldt for us (configured out, perhaps) */
 
@@ -294,20 +292,15 @@ static void do_unexpected_base(void)
 
 		if (ret != 0) {
 			printf("[NOTE]\tcould not create a segment -- test won't do anything\n");
-			return;
+			return 0;
 		}
-		printf("\tother thread: using GDT slot %d\n", desc.entry_number);
+		printf("\tusing GDT slot %d\n", desc.entry_number);
 		set_thread_area_entry_number = desc.entry_number;
 
-		asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)((desc.entry_number << 3) | 0x3)));
+		unsigned short gs = (unsigned short)((desc.entry_number << 3) | 0x3);
+		asm volatile ("mov %0, %%gs" : : "rm" (gs));
+		return gs;
 	}
-
-	/*
-	 * Step 3: set the selector back to zero.  On AMD chips, this will
-	 * preserve GSBASE.
-	 */
-
-	asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)0));
 }
 
 void test_wrbase(unsigned short index, unsigned long base)
@@ -346,12 +339,19 @@ static void *threadproc(void *ctx)
 		if (ftx == 3)
 			return NULL;
 
-		if (ftx == 1)
+		if (ftx == 1) {
 			do_remote_base();
-		else if (ftx == 2)
-			do_unexpected_base();
-		else
+		} else if (ftx == 2) {
+			/*
+			 * On AMD chips, this causes GSBASE != 0, GS == 0, and
+			 * thread.gsbase == 0.
+			 */
+
+			load_gs();
+			asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)0));
+		} else {
 			errx(1, "helper thread got bad command");
+		}
 
 		ftx = 0;
 		syscall(SYS_futex, &ftx, FUTEX_WAKE, 0, NULL, NULL, 0);
@@ -453,12 +453,7 @@ static void test_ptrace_write_gsbase(void)
 	if (child == 0) {
 		printf("[RUN]\tPTRACE_POKE(), write GSBASE from ptracer\n");
 
-		/*
-		 * Use the LDT setup and fetch the GSBASE from the LDT
-		 * by switching to the (nonzero) selector (again)
-		 */
-		do_unexpected_base();
-		asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)0x7));
+		*shared_scratch = load_gs();
 
 		if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) != 0)
 			err(1, "PTRACE_TRACEME");
@@ -476,7 +471,7 @@ static void test_ptrace_write_gsbase(void)
 
 		gs = ptrace(PTRACE_PEEKUSER, child, gs_offset, NULL);
 
-		if (gs != 0x7) {
+		if (gs != *shared_scratch) {
 			nerrs++;
 			printf("[FAIL]\tGS is not prepared with nonzero\n");
 			goto END;
@@ -494,16 +489,24 @@ static void test_ptrace_write_gsbase(void)
 		 * selector value is changed or not by the GSBASE write in
 		 * a ptracer.
 		 */
-		if (gs != 0x7) {
+		if (gs != *shared_scratch) {
 			nerrs++;
 			printf("[FAIL]\tGS changed to %lx\n", gs);
+
+			/*
+			 * On older kernels, poking a nonzero value into the
+			 * base would zero the selector.  On newer kernels,
+			 * this behavior has changed -- poking the base
+			 * changes only the base and, if FSGSBASE is not
+			 * available, this may have no effect.
+			 */
+			if (gs == 0)
+				printf("\tNote: this is expected behavior on older kernels.\n");
 		} else if (have_fsgsbase && (base != 0xFF)) {
 			nerrs++;
 			printf("[FAIL]\tGSBASE changed to %lx\n", base);
 		} else {
-			printf("[OK]\tGS remained 0x7 %s");
-			if (have_fsgsbase)
-				printf("and GSBASE changed to 0xFF");
+			printf("[OK]\tGS remained 0x%hx%s", *shared_scratch, have_fsgsbase ? " and GSBASE changed to 0xFF" : "");
 			printf("\n");
 		}
 	}
@@ -516,6 +519,9 @@ int main()
 {
 	pthread_t thread;
 
+	shared_scratch = mmap(NULL, 4096, PROT_READ | PROT_WRITE,
+			      MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+
 	/* Probe FSGSBASE */
 	sethandler(SIGILL, sigill, 0);
 	if (sigsetjmp(jmpbuf, 1) == 0) {
-- 
2.21.0

