Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645A5C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F596218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp1KSgZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfLRI2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:28:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46717 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRI2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:28:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so1212974wrl.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 00:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yMJjOAhIzheu14B4aOvGzeJWtYIQ1QEezPPz+lKiEmE=;
        b=Lp1KSgZ6INSYA5JSybOiENZq20hSCbKyoto/I24wVBb9/7qnO7zYlauk/WO2Z3tlLw
         MAZ77NiEZCoKXUFBkIlh0d/FMyRUQl0vadGHWJzySQOEqYPZUBl41NU9JPeKcN3yqn7r
         E1XZjGTpYA583Dw4d8X5Pq41EqRVvTTOWhmQ2N2MLn8KUETtRAWKlxYXsDIG105vFlp4
         cIkhLSp9B6wt6oiYzr+mYnO+qcHHrUNz0VuDfsj5znzwj7qifVWHl8ae43M/Bdd8+41K
         dwm2W03a3As+A3UM7DMhkHsmlw0AT3PcxXoYpBf0ZbkbGZtt43r/2Mka7asYsi6T4dDp
         j/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yMJjOAhIzheu14B4aOvGzeJWtYIQ1QEezPPz+lKiEmE=;
        b=oRsavBxqXl8xeDw/W6sj2FeurV2F2f0TExhxScTrBqwLtFDf6eFrmWTib4+1feRgd0
         nDNienbYxoCR3PUVJM2JQkMGYLIO8WL2ZKr0nrPrL3tTMBVM+dQQD64wdwfSzJCUmOsF
         qLmD6iEqdkSNeH8/7vKnTkd8gnabYDLkWH5jrWXyJUHILVpmGl1PXoZtE8QKbKaFuh9y
         yaKXqTVg6MPz7EapFc0veoSSSKg+1Nb2seiqX85eKxXuPsaGWRu6zz+TDuYYKX2UWmJK
         bfpNBZr94CMQVFg7S0bfXu88rae01B4P/aqRLhz+aKYnP0im38mkYWyXMEypI8vYeBQx
         4Tow==
X-Gm-Message-State: APjAAAVw08QIC2UtMu59tTcZ15TX9KIS4wVkEc5k2UpLqVEaUNXo0U91
        4O3mopri5j066ALpxAZfED0=
X-Google-Smtp-Source: APXvYqz2hPmvQA+b5bhpb/9dzuG9/IQOYezjagYgbzpVHXDchyUxdy2KJFxpptGjOdA6bt8fP/Q/TQ==
X-Received: by 2002:a5d:608a:: with SMTP id w10mr1268616wrt.136.1576657702457;
        Wed, 18 Dec 2019 00:28:22 -0800 (PST)
Received: from localhost.localdomain (78-63-27-146.static.zebra.lt. [78.63.27.146])
        by smtp.gmail.com with ESMTPSA id o4sm1683699wrx.25.2019.12.18.00.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 00:28:21 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
X-Google-Original-From: David Abdurachmanov <david.abdurachmanov@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        "Stefan O'Rear" <sorear2@gmail.com>,
        Yash Shah <yash.shah@sifive.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     david.abdurachmanov@gmail.com
Subject: [PATCH v2] define vmemmap before pfn_to_page calls
Date:   Wed, 18 Dec 2019 10:28:11 +0200
Message-Id: <20191218082814.895851-1-david.abdurachmanov@sifive.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pfn_to_page & page_to_pfn depend on vmemmap being available before the calls
if kernel is configured with CONFIG_SPARSEMEM_VMEMMAP=y. This was caused
by NOMMU changes which moved vmemmap definition bellow functions definitions
calling pfn_to_page & page_to_pfn.

Noticed while compiled 5.5-rc2 kernel for Fedora/RISCV.

v2:
- Add a comment for vmemmap in source

Signed-off-by: David Abdurachmanov <david.abdurachmanov@sifive.com>
Fixes: 6bd33e1ece52 ("riscv: add nommu support")
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/pgtable.h | 38 ++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7ff0ed4f292e..36ae01761352 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -90,6 +90,27 @@ extern pgd_t swapper_pg_dir[];
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
+/*
+ * Define vmemmap for pfn_to_page & page_to_pfn calls. Needed if kernel
+ * is configured with CONFIG_SPARSEMEM_VMEMMAP enabled.
+ */
+#define vmemmap		((struct page *)VMEMMAP_START)
+
 static inline int pmd_present(pmd_t pmd)
 {
 	return (pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROT_NONE));
@@ -400,23 +421,6 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
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
2.24.1

