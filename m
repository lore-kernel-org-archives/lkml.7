Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D340C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C1621530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfEHRDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:03:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:5321 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728994AbfEHRDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:03:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 10:03:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,446,1549958400"; 
   d="scan'208";a="169697599"
Received: from chang-linux-3.sc.intel.com ([172.25.66.171])
  by fmsmga002.fm.intel.com with ESMTP; 08 May 2019 10:03:05 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 16/18] x86/fsgsbase/64: Enable FSGSBASE by default and add a chicken bit
Date:   Wed,  8 May 2019 03:02:31 -0700
Message-Id: <1557309753-24073-17-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

Now that FSGSBASE is fully supported, remove unsafe_fsgsbase, enable
FSGSBASE by default, and add nofsgsbase to disable it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +--
 arch/x86/kernel/cpu/common.c                    | 32 +++++++++++--------------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7fe1da0..bea4d2b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2827,8 +2827,7 @@
 	no5lvl		[X86-64] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
-	unsafe_fsgsbase	[X86] Allow FSGSBASE instructions.  This will be
-			replaced with a nofsgsbase flag.
+	nofsgsbase	[X86] Disables FSGSBASE instructions.
 
 	no_console_suspend
 			[HW] Never suspend the console
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5743cb9..fd7ef49 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -365,21 +365,21 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
-/*
- * Temporary hack: FSGSBASE is unsafe until a few kernel code paths are
- * updated. This allows us to get the kernel ready incrementally.
- *
- * Once all the pieces are in place, these will go away and be replaced with
- * a nofsgsbase chicken flag.
- */
-static bool unsafe_fsgsbase;
-
-static __init int setup_unsafe_fsgsbase(char *arg)
+static __init int x86_nofsgsbase_setup(char *arg)
 {
-	unsafe_fsgsbase = true;
+	/* Require an exact match without trailing characters. */
+	if (strlen(arg))
+		return 0;
+
+	/* Do not emit a message if the feature is not present. */
+	if (!boot_cpu_has(X86_FEATURE_FSGSBASE))
+		return 1;
+
+	setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
+	pr_info("nofsgsbase: FSGSBASE disabled\n");
 	return 1;
 }
-__setup("unsafe_fsgsbase", setup_unsafe_fsgsbase);
+__setup("nofsgsbase", x86_nofsgsbase_setup);
 
 /*
  * Protection Keys are not available in 32-bit mode.
@@ -1361,12 +1361,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_umip(c);
 
 	/* Enable FSGSBASE instructions if available. */
-	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
-		if (unsafe_fsgsbase)
-			cr4_set_bits(X86_CR4_FSGSBASE);
-		else
-			clear_cpu_cap(c, X86_FEATURE_FSGSBASE);
-	}
+	if (cpu_has(c, X86_FEATURE_FSGSBASE))
+		cr4_set_bits(X86_CR4_FSGSBASE);
 
 	/*
 	 * The vendor-specific functions might have changed features.
-- 
2.7.4

