Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AB4C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AC72464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfLESlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:41:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:4158 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729924AbfLESlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 13:41:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 10:41:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,282,1571727600"; 
   d="scan'208";a="214263534"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga003.jf.intel.com with ESMTP; 05 Dec 2019 10:41:09 -0800
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
Subject: [PATCH 2/3] x86/fpu/xstate: Make xfeature_is_supervisor()/xfeature_is_user() return bool
Date:   Thu,  5 Dec 2019 10:26:47 -0800
Message-Id: <20191205182648.32257-3-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205182648.32257-1-yu-cheng.yu@intel.com>
References: <20191205182648.32257-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous patch, xfeature_is_supervisor()'s description is revised,
and since xfeature_is_supervisor()/xfeature_is_user() are used only in
boolean context, make both return bool.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index cfcac7b42e5e..912bdfce10dd 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -107,7 +107,7 @@ int cpu_has_xfeatures(u64 xfeatures_needed, const char **feature_name)
 }
 EXPORT_SYMBOL_GPL(cpu_has_xfeatures);
 
-static int xfeature_is_supervisor(int xfeature_nr)
+static bool xfeature_is_supervisor(int xfeature_nr)
 {
 	/*
 	 * Extended State Enumeration Sub-leaves (EAX = 0DH, ECX = n, n > 1)
@@ -117,10 +117,10 @@ static int xfeature_is_supervisor(int xfeature_nr)
 	u32 eax, ebx, ecx, edx;
 
 	cpuid_count(XSTATE_CPUID, xfeature_nr, &eax, &ebx, &ecx, &edx);
-	return !!(ecx & 1);
+	return ecx & 1;
 }
 
-static int xfeature_is_user(int xfeature_nr)
+static bool xfeature_is_user(int xfeature_nr)
 {
 	return !xfeature_is_supervisor(xfeature_nr);
 }
-- 
2.17.1

