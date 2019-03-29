Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E07C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F98217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553867288;
	bh=VF7L0We6Dn8bpIXY425Ny41eKVdQiiWtz/9Dj9T73w8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=y0SwR4RkUimTBA7PLsE14GTrhf18tn2eopl6XJMIsC5uv0vzE3KpQGqrCBVbH4Nea
	 5JpafvtocwFMvxv4UfZtm597zEWhXo8b1frW07OnqiFlZw6uiCRb3upF9u9fMmsn9v
	 v8GFu8IU9rGasKL0C/v4Dadvo9xM/wwC4A6hSlOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfC2NsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729477AbfC2NsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:48:07 -0400
Received: from localhost.localdomain (unknown [60.186.217.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56A442173C;
        Fri, 29 Mar 2019 13:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553867285;
        bh=VF7L0We6Dn8bpIXY425Ny41eKVdQiiWtz/9Dj9T73w8=;
        h=From:To:Cc:Subject:Date:From;
        b=hAjxw8jTIoqgmeMpOqK4PXBMq/KxUjNqSi7N8g06mP3mrisglY6H/2pi/JirKNeZH
         Lo//wto926mIdzpW7dl1Wf4YAcRVkr862L+jmfoXloA+5JxKuqvSqdkREM1aeK2o3U
         aO6YofHXoRQEjuGujCcHW2Y1fxp7Wnx90PWFf3Tc=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        ren_guo@c-sky.com
Subject: [PATCH] csky: Remove pre-processing pte-dirty&young in entry.S
Date:   Fri, 29 Mar 2019 21:47:14 +0800
Message-Id: <1553867234-3769-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

do_page_fault()->
  handle_mm_fault()->
    __handle_mm_fault()->
      handle_pte_fault()

The handle_pte_fault() will call pte_mkdirty() and pte_mkyoung() to set
up dirty or valid bit in page-table entry. So there is no need to
pre-process first-access and first-write in entry.S with assembly code.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/abiv1/inc/abi/entry.h |  20 --------
 arch/csky/abiv2/inc/abi/entry.h |  24 ----------
 arch/csky/include/asm/pgtable.h |  10 ++--
 arch/csky/kernel/entry.S        | 101 ++++++++--------------------------------
 4 files changed, 24 insertions(+), 131 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/entry.h b/arch/csky/abiv1/inc/abi/entry.h
index 7dacce4..9e343f4 100644
--- a/arch/csky/abiv1/inc/abi/entry.h
+++ b/arch/csky/abiv1/inc/abi/entry.h
@@ -126,30 +126,10 @@
 .endm
 
 /* MMU registers operators. */
-.macro RD_MIR	rx
-	cprcr   \rx, cpcr0
-.endm
-
 .macro RD_MEH	rx
 	cprcr   \rx, cpcr4
 .endm
 
-.macro RD_MCIR	rx
-	cprcr   \rx, cpcr8
-.endm
-
-.macro RD_PGDR  rx
-	cprcr   \rx, cpcr29
-.endm
-
-.macro WR_MEH	rx
-	cpwcr   \rx, cpcr4
-.endm
-
-.macro WR_MCIR	rx
-	cpwcr   \rx, cpcr8
-.endm
-
 .macro SETUP_MMU rx
 	lrw	\rx, PHYS_OFFSET | 0xe
 	cpwcr	\rx, cpcr30
diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
index ea376ed..eb8fecc 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -141,34 +141,10 @@
 .endm
 
 /* MMU registers operators. */
-.macro RD_MIR rx
-	mfcr	\rx, cr<0, 15>
-.endm
-
 .macro RD_MEH rx
 	mfcr	\rx, cr<4, 15>
 .endm
 
-.macro RD_MCIR rx
-	mfcr	\rx, cr<8, 15>
-.endm
-
-.macro RD_PGDR rx
-	mfcr	\rx, cr<29, 15>
-.endm
-
-.macro RD_PGDR_K rx
-	mfcr	\rx, cr<28, 15>
-.endm
-
-.macro WR_MEH rx
-	mtcr	\rx, cr<4, 15>
-.endm
-
-.macro WR_MCIR rx
-	mtcr	\rx, cr<8, 15>
-.endm
-
 .macro SETUP_MMU rx
 	lrw	\rx, PHYS_OFFSET | 0xe
 	mtcr	\rx, cr<30, 15>
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index dcea277..60382aa 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -218,17 +218,15 @@ static inline pte_t pte_mkwrite(pte_t pte)
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	pte_val(pte) |= _PAGE_MODIFIED;
-	if (pte_val(pte) & _PAGE_WRITE)
-		pte_val(pte) |= _PAGE_DIRTY;
+	pte_val(pte) |= _PAGE_MODIFIED | _PAGE_DIRTY;
+
 	return pte;
 }
 
 static inline pte_t pte_mkyoung(pte_t pte)
 {
-	pte_val(pte) |= _PAGE_ACCESSED;
-	if (pte_val(pte) & _PAGE_READ)
-		pte_val(pte) |= _PAGE_VALID;
+	pte_val(pte) |= _PAGE_ACCESSED | _PAGE_VALID;
+
 	return pte;
 }
 
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index ecc6e7d..6d89837 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -13,91 +13,24 @@
 #include <asm/page.h>
 #include <asm/thread_info.h>
 
-#define PTE_INDX_MSK    0xffc
-#define PTE_INDX_SHIFT  10
-#define _PGDIR_SHIFT    22
-
-.macro tlbop_begin name, val0, val1, val2
-ENTRY(csky_\name)
-	mtcr    a3, ss2
-	mtcr    r6, ss3
-	mtcr    a2, ss4
-
-	RD_PGDR	r6
-	RD_MEH	a3
+.macro tlbop_begin
+	SAVE_ALL EPC_KEEP
 #ifdef CONFIG_CPU_HAS_TLBI
-	tlbi.vaas a3
+	RD_MEH	a2
+	tlbi.vaas a2
 	sync.is
-
-	btsti	a3, 31
-	bf	1f
-	RD_PGDR_K r6
-1:
 #else
 	bgeni	a2, 31
 	WR_MCIR	a2
 	bgeni	a2, 25
 	WR_MCIR	a2
 #endif
-	bclri   r6, 0
-	lrw	a2, PHYS_OFFSET
-	subu	r6, a2
-	bseti	r6, 31
-
-	mov     a2, a3
-	lsri    a2, _PGDIR_SHIFT
-	lsli    a2, 2
-	addu    r6, a2
-	ldw     r6, (r6)
-
-	lrw	a2, PHYS_OFFSET
-	subu	r6, a2
-	bseti	r6, 31
-
-	lsri    a3, PTE_INDX_SHIFT
-	lrw     a2, PTE_INDX_MSK
-	and     a3, a2
-	addu    r6, a3
-	ldw     a3, (r6)
-
-	movi	a2, (_PAGE_PRESENT | \val0)
-	and     a3, a2
-	cmpne   a3, a2
-	bt	\name
-
-	/* First read/write the page, just update the flags */
-	ldw     a3, (r6)
-	bgeni   a2, PAGE_VALID_BIT
-	bseti   a2, PAGE_ACCESSED_BIT
-	bseti   a2, \val1
-	bseti   a2, \val2
-	or      a3, a2
-	stw     a3, (r6)
-
-	/* Some cpu tlb-hardrefill bypass the cache */
-#ifdef CONFIG_CPU_NEED_TLBSYNC
-	movi	a2, 0x22
-	bseti	a2, 6
-	mtcr	r6, cr22
-	mtcr	a2, cr17
-	sync
-#endif
-
-	mfcr    a3, ss2
-	mfcr    r6, ss3
-	mfcr    a2, ss4
-	rte
-\name:
-	mfcr    a3, ss2
-	mfcr    r6, ss3
-	mfcr    a2, ss4
-	SAVE_ALL EPC_KEEP
 .endm
-.macro tlbop_end is_write
+
+.macro tlbop_end
+	mov     a0, sp
 	RD_MEH	a2
 	psrset  ee, ie
-	mov     a0, sp
-	movi    a1, \is_write
 	jbsr    do_page_fault
 	movi    r11_sig, 0             /* r11 = 0, Not a syscall. */
 	jmpi    ret_from_exception
@@ -105,17 +38,23 @@ ENTRY(csky_\name)
 
 .text
 
-tlbop_begin tlbinvalidl, _PAGE_READ, PAGE_VALID_BIT, PAGE_ACCESSED_BIT
-tlbop_end 0
+ENTRY(csky_tlbinvalidl)
+	tlbop_begin
+	movi	a1, 0
+	tlbop_end
 
-tlbop_begin tlbinvalids, _PAGE_WRITE, PAGE_DIRTY_BIT, PAGE_MODIFIED_BIT
-tlbop_end 1
+ENTRY(csky_tlbinvalids)
+	tlbop_begin
+	movi	a1, 1
+	tlbop_end
 
-tlbop_begin tlbmodified, _PAGE_WRITE, PAGE_DIRTY_BIT, PAGE_MODIFIED_BIT
+ENTRY(csky_tlbmodified)
+	tlbop_begin
 #ifndef CONFIG_CPU_HAS_LDSTEX
-jbsr csky_cmpxchg_fixup
+	jbsr csky_cmpxchg_fixup
 #endif
-tlbop_end 1
+	movi	a1, 1
+	tlbop_end
 
 ENTRY(csky_systemcall)
 	SAVE_ALL EPC_INCREASE
-- 
2.7.4

