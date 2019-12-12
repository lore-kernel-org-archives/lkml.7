Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B258FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90119214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbfLLVVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:21:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:25359 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731019AbfLLVVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:21:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 13:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,307,1571727600"; 
   d="scan'208";a="226062837"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga002.jf.intel.com with ESMTP; 12 Dec 2019 13:20:49 -0800
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
Subject: [PATCH v2 1/3] x86/fpu/xstate: Fix small issues before adding supervisor xstates
Date:   Thu, 12 Dec 2019 13:08:53 -0800
Message-Id: <20191212210855.19260-2-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212210855.19260-1-yu-cheng.yu@intel.com>
References: <20191212210855.19260-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In response to earlier comments, fix small issues before introducing XSAVES
supervisor states:
- Fix comments of xfeature_is_supervisor().
- Replace ((u64)1 << 63) with XCOMP_BV_COMPACTED_FORMAT.

No functional changes from this patch.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 319be936c348..0bd313351650 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -110,12 +110,9 @@ EXPORT_SYMBOL_GPL(cpu_has_xfeatures);
 static int xfeature_is_supervisor(int xfeature_nr)
 {
 	/*
-	 * We currently do not support supervisor states, but if
-	 * we did, we could find out like this.
-	 *
-	 * SDM says: If state component 'i' is a user state component,
-	 * ECX[0] return 0; if state component i is a supervisor
-	 * state component, ECX[0] returns 1.
+	 * Extended State Enumeration Sub-leaves (EAX = 0DH, ECX = n, n > 1)
+	 * returns ECX[0] set to (1) for a supervisor state, and cleared (0)
+	 * for a user state.
 	 */
 	u32 eax, ebx, ecx, edx;
 
@@ -419,7 +416,8 @@ static void __init setup_init_fpu_buf(void)
 	print_xstate_features();
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		init_fpstate.xsave.header.xcomp_bv = (u64)1 << 63 | xfeatures_mask;
+		init_fpstate.xsave.header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT |
+						     xfeatures_mask;
 
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
-- 
2.17.1

