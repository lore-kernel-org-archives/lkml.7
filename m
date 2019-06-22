Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3EDC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651F620665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Qa4Cz5mT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfFVKMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:12:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43767 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVKMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:12:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MACbXx2097844
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:12:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MACbXx2097844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198358;
        bh=5grXnVpARn5pwODS/ybaHBW1OgEpszL1JBgqVgjjhFo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Qa4Cz5mT039vhejV1OvWj5WeMqTJXjeDfl0DehSN+62avxfrz5cTw7nuFkLlw4Z4Y
         ARVM4aPBXruP7L2hkGHWV9CaWz7IHeOvP53kiU1UB4JZ8KbpjOKkZrgHZ9y07m+r4T
         Q5GPDXpOJXcFuHlEFTKm9FSMuV0FSYhjzw1NRJ+g3Pd8aeJxRxSukC2jzLFbAIh70u
         2tisUY473vcPsSufsoVGwScZpg+zh/p2ID6cBQnxpRqNKEC4vELkx7qPzFOnSVQuxR
         HdUcTxbYM26vFGe5bJ/6twU1qr0SPS5WvpMTZChyzuaa4conBW+vq+GWXHOytost45
         ExH34jDOltz0g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MACblp2097841;
        Sat, 22 Jun 2019 03:12:37 -0700
Date:   Sat, 22 Jun 2019 03:12:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-9ad75a0922e1533b08f3d1451bd908d19e5db41e@git.kernel.org>
Cc:     ak@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        ravi.v.shankar@intel.com, tglx@linutronix.de,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: luto@kernel.org, hpa@zytor.com, ak@linux.intel.com,
          tglx@linutronix.de, chang.seok.bae@intel.com,
          linux-kernel@vger.kernel.org, ravi.v.shankar@intel.com,
          mingo@kernel.org
In-Reply-To: <1557309753-24073-15-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-15-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] selftests/x86/fsgsbase: Test RD/WRGSBASE
Git-Commit-ID: 9ad75a0922e1533b08f3d1451bd908d19e5db41e
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

Commit-ID:  9ad75a0922e1533b08f3d1451bd908d19e5db41e
Gitweb:     https://git.kernel.org/tip/9ad75a0922e1533b08f3d1451bd908d19e5db41e
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 8 May 2019 03:02:29 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:38:55 +0200

selftests/x86/fsgsbase: Test RD/WRGSBASE

This validates that GS and GSBASE are independently preserved across
context switches.

[ chang: Use FSGSBASE instructions directly instead of .byte ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-15-git-send-email-chang.seok.bae@intel.com

---
 tools/testing/selftests/x86/fsgsbase.c | 102 ++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index b02ddce49bbb..afd029897c79 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -26,6 +26,7 @@
 #include <stddef.h>
 #include <sys/ptrace.h>
 #include <sys/wait.h>
+#include <setjmp.h>
 
 #ifndef __x86_64__
 # error This test is 64-bit only
@@ -74,6 +75,43 @@ static void sigsegv(int sig, siginfo_t *si, void *ctx_void)
 
 }
 
+static jmp_buf jmpbuf;
+
+static void sigill(int sig, siginfo_t *si, void *ctx_void)
+{
+	siglongjmp(jmpbuf, 1);
+}
+
+static bool have_fsgsbase;
+
+static inline unsigned long rdgsbase(void)
+{
+	unsigned long gsbase;
+
+	asm volatile("rdgsbase %0" : "=r" (gsbase) :: "memory");
+
+	return gsbase;
+}
+
+static inline unsigned long rdfsbase(void)
+{
+	unsigned long fsbase;
+
+	asm volatile("rdfsbase %0" : "=r" (fsbase) :: "memory");
+
+	return fsbase;
+}
+
+static inline void wrgsbase(unsigned long gsbase)
+{
+	asm volatile("wrgsbase %0" :: "r" (gsbase) : "memory");
+}
+
+static inline void wrfsbase(unsigned long fsbase)
+{
+	asm volatile("wrfsbase %0" :: "r" (fsbase) : "memory");
+}
+
 enum which_base { FS, GS };
 
 static unsigned long read_base(enum which_base which)
@@ -202,14 +240,16 @@ static void do_remote_base()
 	       to_set, hard_zero ? " and clear gs" : "", sel);
 }
 
-void do_unexpected_base(void)
+static __thread int set_thread_area_entry_number = -1;
+
+static void do_unexpected_base(void)
 {
 	/*
 	 * The goal here is to try to arrange for GS == 0, GSBASE !=
 	 * 0, and for the the kernel the think that GSBASE == 0.
 	 *
 	 * To make the test as reliable as possible, this uses
-	 * explicit descriptorss.  (This is not the only way.  This
+	 * explicit descriptors.  (This is not the only way.  This
 	 * could use ARCH_SET_GS with a low, nonzero base, but the
 	 * relevant side effect of ARCH_SET_GS could change.)
 	 */
@@ -242,7 +282,7 @@ void do_unexpected_base(void)
 			MAP_PRIVATE | MAP_ANONYMOUS | MAP_32BIT, -1, 0);
 		memcpy(low_desc, &desc, sizeof(desc));
 
-		low_desc->entry_number = -1;
+		low_desc->entry_number = set_thread_area_entry_number;
 
 		/* 32-bit set_thread_area */
 		long ret;
@@ -257,6 +297,8 @@ void do_unexpected_base(void)
 			return;
 		}
 		printf("\tother thread: using GDT slot %d\n", desc.entry_number);
+		set_thread_area_entry_number = desc.entry_number;
+
 		asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)((desc.entry_number << 3) | 0x3)));
 	}
 
@@ -268,6 +310,34 @@ void do_unexpected_base(void)
 	asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)0));
 }
 
+void test_wrbase(unsigned short index, unsigned long base)
+{
+	unsigned short newindex;
+	unsigned long newbase;
+
+	printf("[RUN]\tGS = 0x%hx, GSBASE = 0x%lx\n", index, base);
+
+	asm volatile ("mov %0, %%gs" : : "rm" (index));
+	wrgsbase(base);
+
+	remote_base = 0;
+	ftx = 1;
+	syscall(SYS_futex, &ftx, FUTEX_WAKE, 0, NULL, NULL, 0);
+	while (ftx != 0)
+		syscall(SYS_futex, &ftx, FUTEX_WAIT, 1, NULL, NULL, 0);
+
+	asm volatile ("mov %%gs, %0" : "=rm" (newindex));
+	newbase = rdgsbase();
+
+	if (newindex == index && newbase == base) {
+		printf("[OK]\tIndex and base were preserved\n");
+	} else {
+		printf("[FAIL]\tAfter switch, GS = 0x%hx and GSBASE = 0x%lx\n",
+		       newindex, newbase);
+		nerrs++;
+	}
+}
+
 static void *threadproc(void *ctx)
 {
 	while (1) {
@@ -439,6 +509,17 @@ int main()
 {
 	pthread_t thread;
 
+	/* Probe FSGSBASE */
+	sethandler(SIGILL, sigill, 0);
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		rdfsbase();
+		have_fsgsbase = true;
+		printf("\tFSGSBASE instructions are enabled\n");
+	} else {
+		printf("\tFSGSBASE instructions are disabled\n");
+	}
+	clearhandler(SIGILL);
+
 	sethandler(SIGSEGV, sigsegv, 0);
 
 	check_gs_value(0);
@@ -485,6 +566,21 @@ int main()
 
 	test_unexpected_base();
 
+	if (have_fsgsbase) {
+		unsigned short ss;
+
+		asm volatile ("mov %%ss, %0" : "=rm" (ss));
+
+		test_wrbase(0, 0);
+		test_wrbase(0, 1);
+		test_wrbase(0, 0x200000000);
+		test_wrbase(0, 0xffffffffffffffff);
+		test_wrbase(ss, 0);
+		test_wrbase(ss, 1);
+		test_wrbase(ss, 0x200000000);
+		test_wrbase(ss, 0xffffffffffffffff);
+	}
+
 	ftx = 3;  /* Kill the thread. */
 	syscall(SYS_futex, &ftx, FUTEX_WAKE, 0, NULL, NULL, 0);
 
