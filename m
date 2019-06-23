Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E698BC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B272122CED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="s3500vnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfFXBlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:41:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43987 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbfFXBk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNqTjR2859643
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:52:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNqTjR2859643
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561333950;
        bh=BxzixoOusyzFB5MfBVCb4Q2TYJ4MTWYTpifuKqW+23I=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=s3500vnSS78S8RykXAedTjZiUsJtE+QgTMOwrKzdKx6EMiR4w1aB7uI2P4QeyYMI5
         yNvoe2719AK056h4r29LKIBF/tlrpSWzSBtejySQjbOrLEfI8X5DMYEVor4kuekV+l
         bp0YsoPEr3i24rYI1+cjC/5DdT6cVN5hU8yVXm9PQ7qQhny0GrS95Vn0654aVpOM8q
         6QkJ3Q3aLBkdmy8najVat0GQuF9jBUFYpzITIM7PtL5CSz2mRCr/dZeWx+XTpsFySx
         B8MGbovCKVlqCw5lJQLCdKnj6c+AQWe6PfsNWKYIMpCWShtOs0SEg5pZFJ6LlqoHKD
         q4Tff/mHERj8Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNqSB42859640;
        Sun, 23 Jun 2019 16:52:28 -0700
Date:   Sun, 23 Jun 2019 16:52:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-7c1deeeb01308426a27a70d5a506aa5fae66dc62@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        ralf@linux-mips.org, hpa@zytor.com, pcc@google.com,
        shuah@kernel.org, linux@armlinux.org.uk, will.deacon@arm.com,
        tglx@linutronix.de, salyzyn@android.com, sthotton@marvell.com,
        daniel.lezcano@linaro.org, 0x7f454c46@gmail.com,
        andre.przywara@arm.com, linux@rasmusvillemoes.dk,
        huw@codeweavers.com, arnd@arndb.de, catalin.marinas@arm.com,
        paul.burton@mips.com, vincenzo.frascino@arm.com
Reply-To: linux-kernel@vger.kernel.org, ralf@linux-mips.org,
          mingo@kernel.org, hpa@zytor.com, pcc@google.com,
          linux@armlinux.org.uk, shuah@kernel.org, will.deacon@arm.com,
          tglx@linutronix.de, salyzyn@android.com, sthotton@marvell.com,
          daniel.lezcano@linaro.org, 0x7f454c46@gmail.com,
          andre.przywara@arm.com, linux@rasmusvillemoes.dk,
          huw@codeweavers.com, arnd@arndb.de, catalin.marinas@arm.com,
          paul.burton@mips.com, vincenzo.frascino@arm.com
In-Reply-To: <20190621095252.32307-13-vincenzo.frascino@arm.com>
References: <20190621095252.32307-13-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] arm64: compat: VDSO setup for compat layer
Git-Commit-ID: 7c1deeeb01308426a27a70d5a506aa5fae66dc62
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

Commit-ID:  7c1deeeb01308426a27a70d5a506aa5fae66dc62
Gitweb:     https://git.kernel.org/tip/7c1deeeb01308426a27a70d5a506aa5fae66dc62
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Fri, 21 Jun 2019 10:52:39 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 21:21:08 +0200

arm64: compat: VDSO setup for compat layer

If CONFIG_GENERIC_COMPAT_VDSO is enabled, compat vDSO is installed in a
compat (32 bit) process instead of sigpage.

Add the necessary code to setup the vDSO required pages.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shijith Thotton <sthotton@marvell.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Huw Davies <huw@codeweavers.com>
Link: https://lkml.kernel.org/r/20190621095252.32307-13-vincenzo.frascino@arm.com

---
 arch/arm64/kernel/vdso.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index be23efc3f60d..354b11e27c07 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -29,12 +29,22 @@
 #include <asm/vdso.h>
 
 extern char vdso_start[], vdso_end[];
+#ifdef CONFIG_COMPAT_VDSO
+extern char vdso32_start[], vdso32_end[];
+#endif /* CONFIG_COMPAT_VDSO */
 
 /* vdso_lookup arch_index */
 enum arch_vdso_type {
 	ARM64_VDSO = 0,
+#ifdef CONFIG_COMPAT_VDSO
+	ARM64_VDSO32 = 1,
+#endif /* CONFIG_COMPAT_VDSO */
 };
+#ifdef CONFIG_COMPAT_VDSO
+#define VDSO_TYPES		(ARM64_VDSO32 + 1)
+#else
 #define VDSO_TYPES		(ARM64_VDSO + 1)
+#endif /* CONFIG_COMPAT_VDSO */
 
 struct __vdso_abi {
 	const char *name;
@@ -53,6 +63,13 @@ static struct __vdso_abi vdso_lookup[VDSO_TYPES] __ro_after_init = {
 		.vdso_code_start = vdso_start,
 		.vdso_code_end = vdso_end,
 	},
+#ifdef CONFIG_COMPAT_VDSO
+	{
+		.name = "vdso32",
+		.vdso_code_start = vdso32_start,
+		.vdso_code_end = vdso32_end,
+	},
+#endif /* CONFIG_COMPAT_VDSO */
 };
 
 /*
@@ -163,24 +180,52 @@ up_fail:
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
+#ifdef CONFIG_COMPAT_VDSO
+static int aarch32_vdso_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	return __vdso_remap(ARM64_VDSO32, sm, new_vma);
+}
+#endif /* CONFIG_COMPAT_VDSO */
+
 /*
  * aarch32_vdso_pages:
  * 0 - kuser helpers
  * 1 - sigreturn code
+ * or (CONFIG_COMPAT_VDSO):
+ * 0 - kuser helpers
+ * 1 - vdso data
+ * 2 - vdso code
  */
 #define C_VECTORS	0
+#ifdef CONFIG_COMPAT_VDSO
+#define C_VVAR		1
+#define C_VDSO		2
+#define C_PAGES		(C_VDSO + 1)
+#else
 #define C_SIGPAGE	1
 #define C_PAGES		(C_SIGPAGE + 1)
+#endif /* CONFIG_COMPAT_VDSO */
 static struct page *aarch32_vdso_pages[C_PAGES] __ro_after_init;
-static const struct vm_special_mapping aarch32_vdso_spec[C_PAGES] = {
+static struct vm_special_mapping aarch32_vdso_spec[C_PAGES] = {
 	{
 		.name	= "[vectors]", /* ABI */
 		.pages	= &aarch32_vdso_pages[C_VECTORS],
 	},
+#ifdef CONFIG_COMPAT_VDSO
+	{
+		.name = "[vvar]",
+	},
+	{
+		.name = "[vdso]",
+		.mremap = aarch32_vdso_mremap,
+	},
+#else
 	{
 		.name	= "[sigpage]", /* ABI */
 		.pages	= &aarch32_vdso_pages[C_SIGPAGE],
 	},
+#endif /* CONFIG_COMPAT_VDSO */
 };
 
 static int aarch32_alloc_kuser_vdso_page(void)
@@ -203,7 +248,33 @@ static int aarch32_alloc_kuser_vdso_page(void)
 	return 0;
 }
 
-static int __init aarch32_alloc_vdso_pages(void)
+#ifdef CONFIG_COMPAT_VDSO
+static int __aarch32_alloc_vdso_pages(void)
+{
+	int ret;
+
+	vdso_lookup[ARM64_VDSO32].dm = &aarch32_vdso_spec[C_VVAR];
+	vdso_lookup[ARM64_VDSO32].cm = &aarch32_vdso_spec[C_VDSO];
+
+	ret = __vdso_init(ARM64_VDSO32);
+	if (ret)
+		return ret;
+
+	ret = aarch32_alloc_kuser_vdso_page();
+	if (ret) {
+		unsigned long c_vvar =
+			(unsigned long)page_to_virt(aarch32_vdso_pages[C_VVAR]);
+		unsigned long c_vdso =
+			(unsigned long)page_to_virt(aarch32_vdso_pages[C_VDSO]);
+
+		free_page(c_vvar);
+		free_page(c_vdso);
+	}
+
+	return ret;
+}
+#else
+static int __aarch32_alloc_vdso_pages(void)
 {
 	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
 	int sigret_sz = __aarch32_sigret_code_end - __aarch32_sigret_code_start;
@@ -224,6 +295,12 @@ static int __init aarch32_alloc_vdso_pages(void)
 
 	return ret;
 }
+#endif /* CONFIG_COMPAT_VDSO */
+
+static int __init aarch32_alloc_vdso_pages(void)
+{
+	return __aarch32_alloc_vdso_pages();
+}
 arch_initcall(aarch32_alloc_vdso_pages);
 
 static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
@@ -245,6 +322,7 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 	return PTR_ERR_OR_ZERO(ret);
 }
 
+#ifndef CONFIG_COMPAT_VDSO
 static int aarch32_sigreturn_setup(struct mm_struct *mm)
 {
 	unsigned long addr;
@@ -272,6 +350,7 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 out:
 	return PTR_ERR_OR_ZERO(ret);
 }
+#endif /* !CONFIG_COMPAT_VDSO */
 
 int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
@@ -285,7 +364,14 @@ int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (ret)
 		goto out;
 
+#ifdef CONFIG_COMPAT_VDSO
+	ret = __setup_additional_pages(ARM64_VDSO32,
+				       mm,
+				       bprm,
+				       uses_interp);
+#else
 	ret = aarch32_sigreturn_setup(mm);
+#endif /* CONFIG_COMPAT_VDSO */
 
 out:
 	up_write(&mm->mmap_sem);
