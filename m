Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1660C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDB4206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="rURTxwYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfFVKQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:16:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56355 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFVKQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:16:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MAE11h2098044
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:14:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MAE11h2098044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198442;
        bh=pN8vPWIgNpcbtttpyOuUlN4blwblrQFFYcPXRvfmUCo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=rURTxwYaZN9BUKxFronxfwQSLBj2E6fzWWLc6+Mzu21WylD4/N+qaEr6MndxZ9GU9
         xQq/W4R3gsYTFznawfTii0Qq2qh/ZA3QHpUkvKp2LvA6t7Uq+IgmoEEoa9obEWbgA9
         GafJPQ1bV70KLzpE2OgSxezK2GsADpHrNF+SDBnYQlslPf+kzlOE07NSEG/hxb0lrR
         mBCnxVqfCfWF/sMrWOV4nOaB1NiAiHYyCLYrSvgh6eFZ4PlX7F9grk9fiPQLyMxBYz
         JoFMtO4hC4rXrwOsOBCfbAQ07lbxUojTqF3hF/MgJDsgT8iqKwqZaMC4OTr1onMtEe
         YRCtukB6EYSZQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MAE1qB2098041;
        Sat, 22 Jun 2019 03:14:01 -0700
Date:   Sat, 22 Jun 2019 03:14:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-2032f1f96ee0da600633c6c627b9c0a2e0f8b8a6@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        chang.seok.bae@intel.com, ravi.v.shankar@intel.com,
        ak@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
        luto@kernel.org
Reply-To: hpa@zytor.com, luto@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          ak@linux.intel.com, ravi.v.shankar@intel.com,
          chang.seok.bae@intel.com
In-Reply-To: <1557309753-24073-17-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-17-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpu: Enable FSGSBASE on 64bit by default and add
 a chicken bit
Git-Commit-ID: 2032f1f96ee0da600633c6c627b9c0a2e0f8b8a6
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

Commit-ID:  2032f1f96ee0da600633c6c627b9c0a2e0f8b8a6
Gitweb:     https://git.kernel.org/tip/2032f1f96ee0da600633c6c627b9c0a2e0f8b8a6
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 8 May 2019 03:02:31 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:38:56 +0200

x86/cpu: Enable FSGSBASE on 64bit by default and add a chicken bit

Now that FSGSBASE is fully supported, remove unsafe_fsgsbase, enable
FSGSBASE by default, and add nofsgsbase to disable it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-17-git-send-email-chang.seok.bae@intel.com

---
 Documentation/admin-guide/kernel-parameters.txt |  3 +--
 arch/x86/kernel/cpu/common.c                    | 32 +++++++++++--------------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b0fa5273b0fc..35bc3c3574c6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2857,8 +2857,7 @@
 	no5lvl		[X86-64] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
-	unsafe_fsgsbase	[X86] Allow FSGSBASE instructions.  This will be
-			replaced with a nofsgsbase flag.
+	nofsgsbase	[X86] Disables FSGSBASE instructions.
 
 	no_console_suspend
 			[HW] Never suspend the console
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 71defe2d1b7c..1305f16b6105 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -366,21 +366,21 @@ out:
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
+	pr_info("FSGSBASE disabled via kernel command line\n");
 	return 1;
 }
-__setup("unsafe_fsgsbase", setup_unsafe_fsgsbase);
+__setup("nofsgsbase", x86_nofsgsbase_setup);
 
 /*
  * Protection Keys are not available in 32-bit mode.
@@ -1387,12 +1387,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
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
