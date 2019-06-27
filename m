Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD83BC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 04:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8772B2187F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 04:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561610788;
	bh=6vzbfhIZQItZusxbZ3B57FOIszhglW9mEe2rAHhF5WM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BqxeHV4ZnNh7DYljYEWNTNjibBdXBgPOzInh6uk0hMEEaqTGsZtTGVLu498spzhSe
	 0LJE7tg//zejVmpSdipiIEQstSifQxiY0k0+ImEWt2j5eacgn80SFNo923cDlWHEC8
	 Y9585prnfx1jX2gM7umxoLi3MnT4ySkWHiUTKhJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfF0Eq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 00:46:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0Eq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 00:46:27 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73C7421855;
        Thu, 27 Jun 2019 04:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561610786;
        bh=6vzbfhIZQItZusxbZ3B57FOIszhglW9mEe2rAHhF5WM=;
        h=From:To:Cc:Subject:Date:From;
        b=fAqrKeDD6m3OuCXa06TjEPKMTd3nBbvFSLBNgp8BK3LRGdkZrn/QAGhK9wUuM6QHU
         JLkYUtA+5Dkw2HqEtkzHGSlXADBsgBew5H3RrF7NZik1mL8rs4WIBwaH/0cOkqQ/Yz
         R8IMmQHPQWAijAv1G9zOUYktvvX4XfU58+MPJAng=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: Remove gate area stubs
Date:   Wed, 26 Jun 2019 21:46:18 -0700
Message-Id: <d7f5a3b26eb4f7a41a24baf89ad70b3f37894a6e.1561610736.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a6c19dfe3994 ("arm64,ia64,ppc,s390,sh,tile,um,x86,mm:
remove default gate area"), which predates riscv's inclusion in
Linux by almost three years, the default behavior wrt the gate area
is sane.  Remove riscv's gate area stubs.

Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/riscv/include/asm/page.h |  4 ----
 arch/riscv/kernel/vdso.c      | 19 -------------------
 2 files changed, 23 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 8ddb6c7fedac..d3e5f6c0c21a 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -115,8 +115,4 @@ extern unsigned long min_low_pfn;
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
 
-/* vDSO support */
-/* We do define AT_SYSINFO_EHDR but don't use the gate mechanism */
-#define __HAVE_ARCH_GATE_AREA
-
 #endif /* _ASM_RISCV_PAGE_H */
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index a0084c36d270..c9c21e0d5641 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -92,22 +92,3 @@ const char *arch_vma_name(struct vm_area_struct *vma)
 		return "[vdso]";
 	return NULL;
 }
-
-/*
- * Function stubs to prevent linker errors when AT_SYSINFO_EHDR is defined
- */
-
-int in_gate_area_no_mm(unsigned long addr)
-{
-	return 0;
-}
-
-int in_gate_area(struct mm_struct *mm, unsigned long addr)
-{
-	return 0;
-}
-
-struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
-{
-	return NULL;
-}
-- 
2.21.0

