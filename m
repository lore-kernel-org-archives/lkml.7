Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BF2C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9D420717
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="twFugwKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfLQNPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:15:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39644 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbfLQNPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:15:44 -0500
Received: by mail-lf1-f68.google.com with SMTP id y1so6943166lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 05:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sU3/bXls/KxSfTSBjP7Np2j+r9tPORCUpNYt9Wkb3H0=;
        b=twFugwKSClwiFK9pIgO7mjoL4y1fANzpnWPPg1wTwIqKjgn28prcOM+dKfdME6pPlr
         mCdNiBpOP+4uMXMLqy5xOkm+8ju4XmEzlmbOZv+jp9MJcBW8Tpsa+43t30Q0QyeF4fz/
         V7KhLWSeYmhf7QGIyronz1vpg1TNGz5Wdjack0nIBKi02PK0lyfges9NJP8KXzWsQfGu
         l/7U42ugm/C1W8txFBY3pz1L1Hw0HTDMxmSVa2G+t4wojhhLcIE5AsfyHoLx4/A8F5S8
         4Ys7J8x8oGdJtp4M1ovdF2QfV52sG6TRqJlZ24+s0vMgy360bKS1/NDdT1NwxRXIsV73
         fw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sU3/bXls/KxSfTSBjP7Np2j+r9tPORCUpNYt9Wkb3H0=;
        b=tUjrZ+bxfqlwifLutlfefk1VgSf7ddNIHZjTzEX5/vcUlTBMXDfM5fBUEzcQkpGIf3
         0IyWTh64ydGfd1/x/fbSjxEhcDZH+XEytrRtOIpiiEAR7MY+PnU+UYJzqLtVlJSjZrvM
         pjTd5Dyb/LMF6ZMuil+hJxMk+xE/vorBikfUyrXMZ4uJSND40ggZ6vJ2uasHxrB67pRS
         XtXlU5E8L+kdxZ/BPlRbuAFheVFcxrRmregG2eu/j/u+PeGDSwDjT9mVMgF4DSpXBeHH
         6HApuND3Swet7Dbh3ez/XqECcoJnox7HNJeyAk9cMssjEIFV20WlUsLhfOXJh5qyULj4
         IuBA==
X-Gm-Message-State: APjAAAUW3O32FVK7pacU/uv6JTiuJFFr3hy3mVXlRDKqIWl5sBFsGJl6
        1Tg/X1WJNycKTKvn6daOSrU=
X-Google-Smtp-Source: APXvYqywhi8tqotujrJmmue0owfK8Nn+XvY+KJWNp05k9D+frrRUuC1R33dTRUTctM4JFWfvDFsyvg==
X-Received: by 2002:ac2:4436:: with SMTP id w22mr2676170lfl.185.1576588542951;
        Tue, 17 Dec 2019 05:15:42 -0800 (PST)
Received: from localhost.localdomain (78-63-27-146.static.zebra.lt. [78.63.27.146])
        by smtp.gmail.com with ESMTPSA id q14sm12548416ljm.68.2019.12.17.05.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 05:15:42 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
X-Google-Original-From: David Abdurachmanov <david.abdurachmanov@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     david.abdurachmanov@gmail.com
Subject: [PATCH] define vmemmap before pfn_to_page calls
Date:   Tue, 17 Dec 2019 15:15:28 +0200
Message-Id: <20191217131530.513096-1-david.abdurachmanov@sifive.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pfn_to_page call depends on `vmemmap` being available before the call.
This caused compilation errors in Fedora/RISCV with 5.5-rc2 and was caused
by NOMMU changes which moved declarations after functions definitions.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@sifive.com>
Fixes: 6bd33e1ece52 ("riscv: add nommu support")
---
 arch/riscv/include/asm/pgtable.h | 34 ++++++++++++++++----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7ff0ed4f292e..d8c89e6e6b3d 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -90,6 +90,23 @@ extern pgd_t swapper_pg_dir[];
 #define __S110	PAGE_SHARED_EXEC
 #define __S111	PAGE_SHARED_EXEC
 
+#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
+#define VMALLOC_END      (PAGE_OFFSET - 1)
+#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
+
+/*
+ * Roughly size the vmemmap space to be large enough to fit enough
+ * struct pages to map half the virtual address space. Then
+ * position vmemmap directly below the VMALLOC region.
+ */
+#define VMEMMAP_SHIFT \
+	(CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
+#define VMEMMAP_SIZE	BIT(VMEMMAP_SHIFT)
+#define VMEMMAP_END	(VMALLOC_START - 1)
+#define VMEMMAP_START	(VMALLOC_START - VMEMMAP_SIZE)
+
+#define vmemmap		((struct page *)VMEMMAP_START)
+
 static inline int pmd_present(pmd_t pmd)
 {
 	return (pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROT_NONE));
@@ -400,23 +417,6 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
-#define VMALLOC_END      (PAGE_OFFSET - 1)
-#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
-
-/*
- * Roughly size the vmemmap space to be large enough to fit enough
- * struct pages to map half the virtual address space. Then
- * position vmemmap directly below the VMALLOC region.
- */
-#define VMEMMAP_SHIFT \
-	(CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
-#define VMEMMAP_SIZE	BIT(VMEMMAP_SHIFT)
-#define VMEMMAP_END	(VMALLOC_START - 1)
-#define VMEMMAP_START	(VMALLOC_START - VMEMMAP_SIZE)
-
-#define vmemmap		((struct page *)VMEMMAP_START)
-
 #define PCI_IO_SIZE      SZ_16M
 #define PCI_IO_END       VMEMMAP_START
 #define PCI_IO_START     (PCI_IO_END - PCI_IO_SIZE)
-- 
2.23.0

