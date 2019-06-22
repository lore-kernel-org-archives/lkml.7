Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFF0C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4B2206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Qke3KaYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFVKGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:06:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43729 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFVKGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:06:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MA5Uqo2095542
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:05:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MA5Uqo2095542
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561197931;
        bh=WudhpO4VNtcA78d0IaB0yZlC+sz/LglTxQ6rF2byRw4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Qke3KaYw3RX/2QW+CaHk2dgiF93uA4LBKuuFF0l6d1m+gubksXUW5W2MMIJY1bHR7
         hgSoeuzTX9ol0gLFOIlFnvjoruStEVqZEoK1Um79Y/vNpOYAutMLDemw76vpu8Zjmu
         qX7u+RpQNQ/AAzJHqGo+qNYPxdcAtqP3qCeyib8VXCGF0iYkc0IXgauyEEgz4XXfFk
         JWs2k1eGpfHCm7pIsPxrnTxUCIMZpZD4bxi3Tb3R1ONo55a/o/KOoNWcOu76mcIMpY
         e8IYTva34ayTCzhlRo9LzJRLIk6JKNk3UZEzbYOsipFcqaXM6Y6xTx4m5Eezx4JWc6
         cHnX+6TJtwi7Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MA5Td22095534;
        Sat, 22 Jun 2019 03:05:29 -0700
Date:   Sat, 22 Jun 2019 03:05:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-b64ed19b93c368be0fb6acf05377e8e3a694c92b@git.kernel.org>
Cc:     mingo@kernel.org, ak@linux.intel.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com,
        luto@kernel.org, hpa@zytor.com, rdunlap@infradead.org,
        ravi.v.shankar@intel.com, tglx@linutronix.de
Reply-To: ravi.v.shankar@intel.com, tglx@linutronix.de,
          akpm@linux-foundation.org, chang.seok.bae@intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          ak@linux.intel.com, luto@kernel.org, hpa@zytor.com,
          rdunlap@infradead.org
In-Reply-To: <1557309753-24073-4-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-4-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
Git-Commit-ID: b64ed19b93c368be0fb6acf05377e8e3a694c92b
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

Commit-ID:  b64ed19b93c368be0fb6acf05377e8e3a694c92b
Gitweb:     https://git.kernel.org/tip/b64ed19b93c368be0fb6acf05377e8e3a694c92b
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 8 May 2019 03:02:18 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:38:51 +0200

x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE

This is temporary.  It will allow the next few patches to be tested
incrementally.

Setting unsafe_fsgsbase is a root hole.  Don't do it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-4-git-send-email-chang.seok.bae@intel.com

---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/x86/kernel/cpu/common.c                    | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 138f6664b2e2..b0fa5273b0fc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2857,6 +2857,9 @@
 	no5lvl		[X86-64] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
+	unsafe_fsgsbase	[X86] Allow FSGSBASE instructions.  This will be
+			replaced with a nofsgsbase flag.
+
 	no_console_suspend
 			[HW] Never suspend the console
 			Disable suspending of consoles during suspend and
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index dad20bc891d5..71defe2d1b7c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -366,6 +366,22 @@ out:
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
+/*
+ * Temporary hack: FSGSBASE is unsafe until a few kernel code paths are
+ * updated. This allows us to get the kernel ready incrementally.
+ *
+ * Once all the pieces are in place, these will go away and be replaced with
+ * a nofsgsbase chicken flag.
+ */
+static bool unsafe_fsgsbase;
+
+static __init int setup_unsafe_fsgsbase(char *arg)
+{
+	unsafe_fsgsbase = true;
+	return 1;
+}
+__setup("unsafe_fsgsbase", setup_unsafe_fsgsbase);
+
 /*
  * Protection Keys are not available in 32-bit mode.
  */
@@ -1370,6 +1386,14 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_smap(c);
 	setup_umip(c);
 
+	/* Enable FSGSBASE instructions if available. */
+	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
+		if (unsafe_fsgsbase)
+			cr4_set_bits(X86_CR4_FSGSBASE);
+		else
+			clear_cpu_cap(c, X86_FEATURE_FSGSBASE);
+	}
+
 	/*
 	 * The vendor-specific functions might have changed features.
 	 * Now we do "generic changes."
