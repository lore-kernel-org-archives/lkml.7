Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559A7C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1790122CF6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="rUg/d3Xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfFXBlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:41:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43987 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbfFXBlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:41:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNpl932859584
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:51:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNpl932859584
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561333908;
        bh=FL9ElRP2NbGlm6mzGfn/VOTynle12eJGugbYHDBNIq4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=rUg/d3Xk5aGEGkrifgFzZ9rPswCm4tUvVX+c1XDFzPw0WJ6isGkESU96Cf/ooazrz
         qb/XoC3qxDCa0kxvE7ACmGANIPKQCMluzaDaJL+h7yPQPqRu2uXOXEfkEklYSQjvdJ
         ob0x9GD+1gi3ug9aYlO53z7kJ9GqqfcweuHfRfJIb2QLcSlL6MnLcRkvfUK6+UhlmE
         ZqkrjCSQGeQMf5tiD9SSPMZtt/DfRRqOc0a693UBrX4v8/ShdPEQI1mDrV92BrZC21
         tA8MewVsLwoX9qxO111D9b2ihqLx+yvJHqwFJLyIdaXP2drtf5c2YJbfygm6OdADTk
         fKzqsbsYqgrNA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNpk3l2859580;
        Sun, 23 Jun 2019 16:51:46 -0700
Date:   Sun, 23 Jun 2019 16:51:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-c7aa2d71020d74d4c673922e295b07f6adafd6e0@git.kernel.org>
Cc:     ralf@linux-mips.org, sthotton@marvell.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux@rasmusvillemoes.dk, hpa@zytor.com, pcc@google.com,
        shuah@kernel.org, linux@armlinux.org.uk, mingo@kernel.org,
        huw@codeweavers.com, 0x7f454c46@gmail.com, paul.burton@mips.com,
        daniel.lezcano@linaro.org, arnd@arndb.de, salyzyn@android.com,
        vincenzo.frascino@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, andre.przywara@arm.com
Reply-To: linux@rasmusvillemoes.dk, hpa@zytor.com, pcc@google.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          ralf@linux-mips.org, sthotton@marvell.com, huw@codeweavers.com,
          0x7f454c46@gmail.com, mingo@kernel.org, shuah@kernel.org,
          linux@armlinux.org.uk, arnd@arndb.de, daniel.lezcano@linaro.org,
          paul.burton@mips.com, will.deacon@arm.com,
          andre.przywara@arm.com, catalin.marinas@arm.com,
          vincenzo.frascino@arm.com, salyzyn@android.com
In-Reply-To: <20190621095252.32307-12-vincenzo.frascino@arm.com>
References: <20190621095252.32307-12-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] arm64: vdso: Refactor vDSO code
Git-Commit-ID: c7aa2d71020d74d4c673922e295b07f6adafd6e0
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

Commit-ID:  c7aa2d71020d74d4c673922e295b07f6adafd6e0
Gitweb:     https://git.kernel.org/tip/c7aa2d71020d74d4c673922e295b07f6adafd6e0
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Fri, 21 Jun 2019 10:52:38 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 21:21:08 +0200

arm64: vdso: Refactor vDSO code

Most of the code for initializing the vDSOs in arm64 and compat will be
shared, hence refactoring of the current code is required to avoid
duplication and to simplify maintainability.

No functional change.

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
Link: https://lkml.kernel.org/r/20190621095252.32307-12-vincenzo.frascino@arm.com

---
 arch/arm64/kernel/vdso.c | 215 +++++++++++++++++++++++++++++++----------------
 1 file changed, 144 insertions(+), 71 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 478ec865a413..be23efc3f60d 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -29,7 +29,31 @@
 #include <asm/vdso.h>
 
 extern char vdso_start[], vdso_end[];
-static unsigned long vdso_pages __ro_after_init;
+
+/* vdso_lookup arch_index */
+enum arch_vdso_type {
+	ARM64_VDSO = 0,
+};
+#define VDSO_TYPES		(ARM64_VDSO + 1)
+
+struct __vdso_abi {
+	const char *name;
+	const char *vdso_code_start;
+	const char *vdso_code_end;
+	unsigned long vdso_pages;
+	/* Data Mapping */
+	struct vm_special_mapping *dm;
+	/* Code Mapping */
+	struct vm_special_mapping *cm;
+};
+
+static struct __vdso_abi vdso_lookup[VDSO_TYPES] __ro_after_init = {
+	{
+		.name = "vdso",
+		.vdso_code_start = vdso_start,
+		.vdso_code_end = vdso_end,
+	},
+};
 
 /*
  * The vDSO data page.
@@ -40,10 +64,110 @@ static union {
 } vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data = vdso_data_store.data;
 
+static int __vdso_remap(enum arch_vdso_type arch_index,
+			const struct vm_special_mapping *sm,
+			struct vm_area_struct *new_vma)
+{
+	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
+	unsigned long vdso_size = vdso_lookup[arch_index].vdso_code_end -
+				  vdso_lookup[arch_index].vdso_code_start;
+
+	if (vdso_size != new_size)
+		return -EINVAL;
+
+	current->mm->context.vdso = (void *)new_vma->vm_start;
+
+	return 0;
+}
+
+static int __vdso_init(enum arch_vdso_type arch_index)
+{
+	int i;
+	struct page **vdso_pagelist;
+	unsigned long pfn;
+
+	if (memcmp(vdso_lookup[arch_index].vdso_code_start, "\177ELF", 4)) {
+		pr_err("vDSO is not a valid ELF object!\n");
+		return -EINVAL;
+	}
+
+	vdso_lookup[arch_index].vdso_pages = (
+			vdso_lookup[arch_index].vdso_code_end -
+			vdso_lookup[arch_index].vdso_code_start) >>
+			PAGE_SHIFT;
+
+	/* Allocate the vDSO pagelist, plus a page for the data. */
+	vdso_pagelist = kcalloc(vdso_lookup[arch_index].vdso_pages + 1,
+				sizeof(struct page *),
+				GFP_KERNEL);
+	if (vdso_pagelist == NULL)
+		return -ENOMEM;
+
+	/* Grab the vDSO data page. */
+	vdso_pagelist[0] = phys_to_page(__pa_symbol(vdso_data));
+
+
+	/* Grab the vDSO code pages. */
+	pfn = sym_to_pfn(vdso_lookup[arch_index].vdso_code_start);
+
+	for (i = 0; i < vdso_lookup[arch_index].vdso_pages; i++)
+		vdso_pagelist[i + 1] = pfn_to_page(pfn + i);
+
+	vdso_lookup[arch_index].dm->pages = &vdso_pagelist[0];
+	vdso_lookup[arch_index].cm->pages = &vdso_pagelist[1];
+
+	return 0;
+}
+
+static int __setup_additional_pages(enum arch_vdso_type arch_index,
+				    struct mm_struct *mm,
+				    struct linux_binprm *bprm,
+				    int uses_interp)
+{
+	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
+	void *ret;
+
+	vdso_text_len = vdso_lookup[arch_index].vdso_pages << PAGE_SHIFT;
+	/* Be sure to map the data page */
+	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
+
+	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
+	if (IS_ERR_VALUE(vdso_base)) {
+		ret = ERR_PTR(vdso_base);
+		goto up_fail;
+	}
+
+	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
+				       VM_READ|VM_MAYREAD,
+				       vdso_lookup[arch_index].dm);
+	if (IS_ERR(ret))
+		goto up_fail;
+
+	vdso_base += PAGE_SIZE;
+	mm->context.vdso = (void *)vdso_base;
+	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
+				       VM_READ|VM_EXEC|
+				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       vdso_lookup[arch_index].cm);
+	if (IS_ERR(ret))
+		goto up_fail;
+
+	return 0;
+
+up_fail:
+	mm->context.vdso = NULL;
+	return PTR_ERR(ret);
+}
+
 #ifdef CONFIG_COMPAT
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
+/*
+ * aarch32_vdso_pages:
+ * 0 - kuser helpers
+ * 1 - sigreturn code
+ */
 #define C_VECTORS	0
 #define C_SIGPAGE	1
 #define C_PAGES		(C_SIGPAGE + 1)
@@ -172,18 +296,18 @@ out:
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
-	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
-	unsigned long vdso_size = vdso_end - vdso_start;
-
-	if (vdso_size != new_size)
-		return -EINVAL;
-
-	current->mm->context.vdso = (void *)new_vma->vm_start;
-
-	return 0;
+	return __vdso_remap(ARM64_VDSO, sm, new_vma);
 }
 
-static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
+/*
+ * aarch64_vdso_pages:
+ * 0 - vvar
+ * 1 - vdso
+ */
+#define A_VVAR		0
+#define A_VDSO		1
+#define A_PAGES		(A_VDSO + 1)
+static struct vm_special_mapping vdso_spec[A_PAGES] __ro_after_init = {
 	{
 		.name	= "[vvar]",
 	},
@@ -195,37 +319,10 @@ static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
 
 static int __init vdso_init(void)
 {
-	int i;
-	struct page **vdso_pagelist;
-	unsigned long pfn;
-
-	if (memcmp(vdso_start, "\177ELF", 4)) {
-		pr_err("vDSO is not a valid ELF object!\n");
-		return -EINVAL;
-	}
-
-	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
-
-	/* Allocate the vDSO pagelist, plus a page for the data. */
-	vdso_pagelist = kcalloc(vdso_pages + 1, sizeof(struct page *),
-				GFP_KERNEL);
-	if (vdso_pagelist == NULL)
-		return -ENOMEM;
-
-	/* Grab the vDSO data page. */
-	vdso_pagelist[0] = phys_to_page(__pa_symbol(vdso_data));
-
+	vdso_lookup[ARM64_VDSO].dm = &vdso_spec[A_VVAR];
+	vdso_lookup[ARM64_VDSO].cm = &vdso_spec[A_VDSO];
 
-	/* Grab the vDSO code pages. */
-	pfn = sym_to_pfn(vdso_start);
-
-	for (i = 0; i < vdso_pages; i++)
-		vdso_pagelist[i + 1] = pfn_to_page(pfn + i);
-
-	vdso_spec[0].pages = &vdso_pagelist[0];
-	vdso_spec[1].pages = &vdso_pagelist[1];
-
-	return 0;
+	return __vdso_init(ARM64_VDSO);
 }
 arch_initcall(vdso_init);
 
@@ -233,41 +330,17 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 				int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
-	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
-	void *ret;
-
-	vdso_text_len = vdso_pages << PAGE_SHIFT;
-	/* Be sure to map the data page */
-	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
+	int ret;
 
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
-	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
-	if (IS_ERR_VALUE(vdso_base)) {
-		ret = ERR_PTR(vdso_base);
-		goto up_fail;
-	}
-	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
-				       VM_READ|VM_MAYREAD,
-				       &vdso_spec[0]);
-	if (IS_ERR(ret))
-		goto up_fail;
-
-	vdso_base += PAGE_SIZE;
-	mm->context.vdso = (void *)vdso_base;
-	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
-				       VM_READ|VM_EXEC|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
-				       &vdso_spec[1]);
-	if (IS_ERR(ret))
-		goto up_fail;
 
+	ret = __setup_additional_pages(ARM64_VDSO,
+				       mm,
+				       bprm,
+				       uses_interp);
 
 	up_write(&mm->mmap_sem);
-	return 0;
 
-up_fail:
-	mm->context.vdso = NULL;
-	up_write(&mm->mmap_sem);
-	return PTR_ERR(ret);
+	return ret;
 }
