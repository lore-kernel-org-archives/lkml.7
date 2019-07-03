Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345F5C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39C42189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="yqFbOm7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfGCPOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:14:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51591 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCPOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:14:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63FD71n3341274
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 08:13:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63FD71n3341274
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562166788;
        bh=sfUb27s9S0TVnU9n/Q4QI9oz4WitoxNFmy5+dHSubIk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=yqFbOm7LEIKlQJ3AoB7ZE6OErV9I++jwo2PzRJH/ExhKmxfpbtsUfls77ZmfepReG
         TPDjP4+S2NkoUm+hAilK/LuKf3yMpARHiI8e70+te0Co40rnku6dv6jF4bq4tXLi0M
         4OpsUTKJlyLQXtqUfK4EOku9AJUTT6MNoQhTJjoumGW8v+JOBwv7TYhlbILqGS//nr
         RDlZQUH2Da1fV9L95JQUipu/bczepoCxBm8QxEbYRWjwQTFYVvCJdIE5F9Kdnq1JFB
         mgi1Bb3ThBojK8OG3YgWsNf+fPF8NTeTceYyjkQIrMuS7PSEQCMZm3oEHxBsFQGiHd
         A6m11DsWIH3Mw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63FD6ZX3341271;
        Wed, 3 Jul 2019 08:13:06 -0700
Date:   Wed, 3 Jul 2019 08:13:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-697096b14444f458fb81212d1c82d7846e932455@git.kernel.org>
Cc:     luto@kernel.org, chang.seok.bae@intel.com, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, ak@linux.intel.com,
        bp@alien8.de
Reply-To: bp@alien8.de, ak@linux.intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          peterz@infradead.org, tglx@linutronix.de, luto@kernel.org,
          chang.seok.bae@intel.com
In-Reply-To: <bab29c84f2475e2c30ddb00f1b877fcd7f4f96a8.1562125333.git.luto@kernel.org>
References: <bab29c84f2475e2c30ddb00f1b877fcd7f4f96a8.1562125333.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] selftests/x86/fsgsbase: Fix some test case bugs
Git-Commit-ID: 697096b14444f458fb81212d1c82d7846e932455
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

Commit-ID:  697096b14444f458fb81212d1c82d7846e932455
Gitweb:     https://git.kernel.org/tip/697096b14444f458fb81212d1c82d7846e932455
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Tue, 2 Jul 2019 20:43:04 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 3 Jul 2019 16:24:56 +0200

selftests/x86/fsgsbase: Fix some test case bugs

This refactors do_unexpected_base() to clean up some code.  It also
fixes the following bugs in test_ptrace_write_gsbase():

 - Incorrect printf() format string caused crashes.

 - Hardcoded 0x7 for the gs selector was not reliably correct.

It also documents the fact that the test is expected to fail on old
kernels.

Fixes: a87730cc3acc ("selftests/x86/fsgsbase: Test ptracer-induced GSBASE write with FSGSBASE")
Fixes: 1b6858d5a2eb ("selftests/x86/fsgsbase: Test ptracer-induced GSBASE write")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc:  "BaeChang Seok" <chang.seok.bae@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: "BaeChang Seok" <chang.seok.bae@intel.com>
Link: https://lkml.kernel.org/r/bab29c84f2475e2c30ddb00f1b877fcd7f4f96a8.1562125333.git.luto@kernel.org


---
 tools/testing/selftests/x86/fsgsbase.c | 74 ++++++++++++++++++----------------
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
