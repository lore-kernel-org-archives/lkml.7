Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ED7C4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 20:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B498320830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 20:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfILUIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 16:08:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:35549 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfILUHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 16:07:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 13:07:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="336688212"
Received: from chang-linux-3.sc.intel.com ([172.25.66.185])
  by orsmga004.jf.intel.com with ESMTP; 12 Sep 2019 13:07:52 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     ravi.v.shankar@intel.com, chang.seok.bae@intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v8 02/17] selftests/x86/fsgsbase: Test GS selector on ptracer-induced GS base write
Date:   Thu, 12 Sep 2019 13:06:43 -0700
Message-Id: <1568318818-4091-3-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568318818-4091-1-git-send-email-chang.seok.bae@intel.com>
References: <1568318818-4091-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test validates that the selector is not changed when a ptracer writes
the ptracee's GS base.

Originally-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
---

Changes from v7:
* Trimmed down the changes as most codes from v7 were already merged
* Included Andy's additional comments and messages when testing old
  kernels
* Used 'GS base' consistently, instead of 'GSBASE'
---
 tools/testing/selftests/x86/fsgsbase.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 15a329d..950a48b 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -465,7 +465,7 @@ static void test_ptrace_write_gsbase(void)
 	wait(&status);
 
 	if (WSTOPSIG(status) == SIGTRAP) {
-		unsigned long gs, base;
+		unsigned long gs;
 		unsigned long gs_offset = USER_REGS_OFFSET(gs);
 		unsigned long base_offset = USER_REGS_OFFSET(gs_base);
 
@@ -481,7 +481,6 @@ static void test_ptrace_write_gsbase(void)
 			err(1, "PTRACE_POKEUSER");
 
 		gs = ptrace(PTRACE_PEEKUSER, child, gs_offset, NULL);
-		base = ptrace(PTRACE_PEEKUSER, child, base_offset, NULL);
 
 		/*
 		 * In a non-FSGSBASE system, the nonzero selector will load
@@ -489,11 +488,21 @@ static void test_ptrace_write_gsbase(void)
 		 * selector value is changed or not by the GSBASE write in
 		 * a ptracer.
 		 */
-		if (gs == 0 && base == 0xFF) {
-			printf("[OK]\tGS was reset as expected\n");
-		} else {
+		if (gs != *shared_scratch) {
 			nerrs++;
-			printf("[FAIL]\tGS=0x%lx, GSBASE=0x%lx (should be 0, 0xFF)\n", gs, base);
+			printf("[FAIL]\tGS changed to %lx\n", gs);
+
+			/*
+			 * On older kernels, poking a nonzero value into the
+			 * base would zero the selector.  On newer kernels,
+			 * this behavior has changed -- poking the base
+			 * changes only the base and, if FSGSBASE is not
+			 * available, this may not effect.
+			 */
+			if (gs == 0)
+				printf("\tNote: this is expected behavior on older kernels.\n");
+		} else {
+			printf("[OK]\tGS remained 0x%hx\n", *shared_scratch);
 		}
 	}
 
-- 
2.7.4

