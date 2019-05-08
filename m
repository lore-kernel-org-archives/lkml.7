Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940C7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8D821530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfEHREN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:04:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:5321 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbfEHRDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:03:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 10:03:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,446,1549958400"; 
   d="scan'208";a="169697549"
Received: from chang-linux-3.sc.intel.com ([172.25.66.171])
  by fmsmga002.fm.intel.com with ESMTP; 08 May 2019 10:03:02 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 02/18] selftests/x86/fsgsbase: Test ptracer-induced GSBASE write
Date:   Wed,  8 May 2019 03:02:17 -0700
Message-Id: <1557309753-24073-3-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test validates to make sure the selector is not changed when a
ptracer writes a ptracee's GSBASE.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 tools/testing/selftests/x86/fsgsbase.c | 70 ++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index f249e04..1c2dda0 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -23,6 +23,9 @@
 #include <pthread.h>
 #include <asm/ldt.h>
 #include <sys/mman.h>
+#include <stddef.h>
+#include <sys/ptrace.h>
+#include <sys/wait.h>
 
 #ifndef __x86_64__
 # error This test is 64-bit only
@@ -367,6 +370,71 @@ static void test_unexpected_base(void)
 	}
 }
 
+#define USER_REGS_OFFSET(r) offsetof(struct user_regs_struct, r)
+
+static void test_ptrace_write_gsbase(void)
+{
+	int status;
+	pid_t child = fork();
+
+	if (child < 0)
+		err(1, "fork");
+
+	if (child == 0) {
+		printf("[RUN]\tPTRACE_POKE(), write GSBASE from ptracer\n");
+
+		/*
+		 * Use the LDT setup and fetch the GSBASE from the LDT
+		 * by switching to the (nonzero) selector (again)
+		 */
+		do_unexpected_base();
+		asm volatile ("mov %0, %%gs" : : "rm" ((unsigned short)0x7));
+
+		if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) != 0)
+			err(1, "PTRACE_TRACEME");
+
+		raise(SIGTRAP);
+		_exit(0);
+	}
+
+	wait(&status);
+
+	if (WSTOPSIG(status) == SIGTRAP) {
+		unsigned long gs;
+		unsigned long gs_offset = USER_REGS_OFFSET(gs);
+		unsigned long base_offset = USER_REGS_OFFSET(gs_base);
+
+		gs = ptrace(PTRACE_PEEKUSER, child, gs_offset, NULL);
+
+		if (gs != 0x7) {
+			nerrs++;
+			printf("[FAIL]\tGS is not prepared with nonzero\n");
+			goto END;
+		}
+
+		if (ptrace(PTRACE_POKEUSER, child, base_offset, 0xFF) != 0)
+			err(1, "PTRACE_POKEUSER");
+
+		gs = ptrace(PTRACE_PEEKUSER, child, gs_offset, NULL);
+
+		/*
+		 * In a non-FSGSBASE system, the nonzero selector will load
+		 * GSBASE (again). But what is tested here is whether the
+		 * selector value is changed or not by the GSBASE write in
+		 * a ptracer.
+		 */
+		if (gs != 0x7) {
+			nerrs++;
+			printf("[FAIL]\tGS changed to %lx\n", gs);
+		} else {
+			printf("[OK]\tGS remained 0x7\n");
+		}
+	}
+
+END:
+	ptrace(PTRACE_CONT, child, NULL, NULL);
+}
+
 int main()
 {
 	pthread_t thread;
@@ -423,5 +491,7 @@ int main()
 	if (pthread_join(thread, NULL) != 0)
 		err(1, "pthread_join");
 
+	test_ptrace_write_gsbase();
+
 	return nerrs == 0 ? 0 : 1;
 }
-- 
2.7.4

