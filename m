Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C79C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5E920848
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgAIVRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:17:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:44432 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgAIVRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:17:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 13:16:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="212025756"
Received: from yyu32-desk.sc.intel.com ([143.183.136.51])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2020 13:16:59 -0800
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 2/3] x86/fpu/xstate: Fix XSAVES offsets in setup_xstate_comp()
Date:   Thu,  9 Jan 2020 13:14:51 -0800
Message-Id: <20200109211452.27369-3-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200109211452.27369-1-yu-cheng.yu@intel.com>
References: <20200109211452.27369-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In setup_xstate_comp(), each XSAVES component offset starts from the end of
its preceding component plus alignment.  A disabled feature does not take
space and its offset should be set to the end of its preceding one with no
alignment.  However, in this case, alignment is incorrectly added to the
offset, which can cause the next component to have a wrong offset.

This problem has not been visible because currently there is no xfeature
requiring alignment.

Fix it by tracking the next starting offset only from enabled xfeatures.
To make it clear, also change the function name to setup_xstate_comp_
offsets().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 3ef3603bcfc5..73314e8fce02 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -344,9 +344,9 @@ static int xfeature_is_aligned(int xfeature_nr)
  * xsave area. This supports both standard format and compacted format
  * of the xsave aread.
  */
-static void __init setup_xstate_comp(void)
+static void __init setup_xstate_comp_offsets(void)
 {
-	unsigned int xstate_comp_sizes[XFEATURE_MAX];
+	unsigned int next_offset;
 	int i;
 
 	/*
@@ -360,31 +360,23 @@ static void __init setup_xstate_comp(void)
 
 	if (!boot_cpu_has(X86_FEATURE_XSAVES)) {
 		for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-			if (xfeature_enabled(i)) {
+			if (xfeature_enabled(i))
 				xstate_comp_offsets[i] = xstate_offsets[i];
-				xstate_comp_sizes[i] = xstate_sizes[i];
-			}
 		}
 		return;
 	}
 
-	xstate_comp_offsets[FIRST_EXTENDED_XFEATURE] =
-		FXSAVE_SIZE + XSAVE_HDR_SIZE;
+	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		if (xfeature_enabled(i))
-			xstate_comp_sizes[i] = xstate_sizes[i];
-		else
-			xstate_comp_sizes[i] = 0;
+		if (!xfeature_enabled(i))
+			continue;
 
-		if (i > FIRST_EXTENDED_XFEATURE) {
-			xstate_comp_offsets[i] = xstate_comp_offsets[i-1]
-					+ xstate_comp_sizes[i-1];
+		if (xfeature_is_aligned(i))
+			next_offset = ALIGN(next_offset, 64);
 
-			if (xfeature_is_aligned(i))
-				xstate_comp_offsets[i] =
-					ALIGN(xstate_comp_offsets[i], 64);
-		}
+		xstate_comp_offsets[i] = next_offset;
+		next_offset += xstate_sizes[i];
 	}
 }
 
@@ -778,7 +770,7 @@ void __init fpu__init_system_xstate(void)
 
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
-	setup_xstate_comp();
+	setup_xstate_comp_offsets();
 	print_xstate_offset_size();
 
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
-- 
2.21.0

