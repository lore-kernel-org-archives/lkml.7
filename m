Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D018C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA26B21873
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554104864;
	bh=cUlo5W/fFFnW9IpeHgR6cZv8aqUJwhJeu1m8mtnmf+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PeXbWibfMshqt4fFgwtrD3NXQtlLQCyFB/UPFih6yN/zO3On+lSE88Qhxz1YlisgA
	 AFujrs6PaZDaGUXpcBr6bgdM5ewbhEbc6CPfapJWhJuk7PYUV8ATkYe1Q5RpI/UZKo
	 M+cSXgxCu0wTA9Vv28aSaUf+vrITZ7eHeBxmVHBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbfDAHrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:47:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46716 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbfDAHrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:47:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so4117790pfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 00:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJEFFn+etEkm7mhrb2GpOa9E7t7qf7JW4mjHjTZjeK0=;
        b=rlym33oI1QDUdvwCBJMsybpZ6qOymYol8cGJRSaifnWhRiLIqwaniBCiT1XSYQA2vI
         V/wQJsc/Bd3JTM1VestRNu/p9ce7c9mfcu6WwcLYQFWoFWKmIOKaAypoM/DbhNsgAQ9n
         dnx11gRuGtX1633aWqMm1ydqjXSSwLiKLzWauUtCBEOo0WR+h9hD1NYuVspSgqJz0veo
         ny5xDEPO2Akb1RXutPC0BULeXnyW/ZBQ/XeOuH4mTAfNI/KZteFMj90NicI/Eso6QeiC
         78yLV50Xn2FiwzL4ZgA8sk4HYpL5YUNf1Y+L/V7Uj9JMQODBM+VteCkPCS1F3X8H/Vbc
         O4XA==
X-Gm-Message-State: APjAAAUL3J3SK6Qo/XzsI0fvOcHjgCXWEQBFo4etaxOUnAJFuJpVSssH
        k83ADTroos6BePcB7MRXeA==
X-Google-Smtp-Source: APXvYqwuIcHuBxkweiCkOdjW78uVbU1EnUm0AWDZsxOt1hhECDFEb7dmmM/jDvilQpewAeyIhBbWdw==
X-Received: by 2002:a63:5150:: with SMTP id r16mr50565255pgl.307.1554104861600;
        Mon, 01 Apr 2019 00:47:41 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id o5sm33428950pfa.135.2019.04.01.00.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 00:47:40 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 1/3] iommu: io-pgtable: Add ARM Mali midgard MMU page table format
Date:   Mon,  1 Apr 2019 02:47:28 -0500
Message-Id: <20190401074730.12241-2-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190401074730.12241-1-robh@kernel.org>
References: <20190401074730.12241-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM Mali midgard GPU is similar to standard 64-bit stage 1 page tables, but
have a few differences. Add a new format type to represent the format. The
input address size is 48-bits and the output address size is 40-bits (and
possibly less?). Note that the later bifrost GPUs follow the standard
64-bit stage 1 format.

The differences in the format compared to 64-bit stage 1 format are:

The 3rd level page entry bits are 0x1 instead of 0x3 for page entries.

The access flags are not read-only and unprivileged, but read and write.
This is similar to stage 2 entries, but the memory attributes field matches
stage 1 being an index.

The nG bit is not set by the vendor driver. This one didn't seem to matter,
but we'll keep it aligned to the vendor driver.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack this as I need to apply it to the drm-misc tree. Or we need a
stable branch with this patch.

v3:
- Rework arm_lpae_prot_to_pte as written by Robin
- Fill in complete register values for TRANSTAB and MEMATTR registers


 drivers/iommu/io-pgtable-arm.c | 93 +++++++++++++++++++++++++---------
 drivers/iommu/io-pgtable.c     |  1 +
 include/linux/io-pgtable.h     |  7 +++
 3 files changed, 77 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index d3700ec15cbd..98551d0cff59 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -172,6 +172,10 @@
 #define ARM_LPAE_MAIR_ATTR_IDX_CACHE	1
 #define ARM_LPAE_MAIR_ATTR_IDX_DEV	2

+#define ARM_MALI_LPAE_TTBR_ADRMODE_TABLE (3u << 0)
+#define ARM_MALI_LPAE_TTBR_READ_INNER	BIT(2)
+#define ARM_MALI_LPAE_TTBR_SHARE_OUTER	BIT(4)
+
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))

@@ -180,11 +184,6 @@

 #define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)

-#define iopte_leaf(pte,l)					\
-	(l == (ARM_LPAE_MAX_LEVELS - 1) ?			\
-		(iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_PAGE) :	\
-		(iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_BLOCK))
-
 struct arm_lpae_io_pgtable {
 	struct io_pgtable	iop;

@@ -198,6 +197,14 @@ struct arm_lpae_io_pgtable {

 typedef u64 arm_lpae_iopte;

+static inline bool iopte_leaf(arm_lpae_iopte pte, int l, enum io_pgtable_fmt fmt)
+{
+	if ((l == (ARM_LPAE_MAX_LEVELS - 1)) && (fmt != ARM_MALI_LPAE))
+		return iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_PAGE;
+
+	return iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_BLOCK;
+}
+
 static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
 				     struct arm_lpae_io_pgtable *data)
 {
@@ -303,12 +310,17 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
 		pte |= ARM_LPAE_PTE_NS;

-	if (lvl == ARM_LPAE_MAX_LEVELS - 1)
-		pte |= ARM_LPAE_PTE_TYPE_PAGE;
-	else
+	if (lvl == ARM_LPAE_MAX_LEVELS - 1) {
+		if (data->iop.fmt == ARM_MALI_LPAE)
+			pte |= ARM_LPAE_PTE_TYPE_BLOCK;
+		else
+			pte |= ARM_LPAE_PTE_TYPE_PAGE;
+	} else
 		pte |= ARM_LPAE_PTE_TYPE_BLOCK;

-	pte |= ARM_LPAE_PTE_AF | ARM_LPAE_PTE_SH_IS;
+	if (data->iop.fmt != ARM_MALI_LPAE)
+		pte |= ARM_LPAE_PTE_AF;
+	pte |= ARM_LPAE_PTE_SH_IS;
 	pte |= paddr_to_iopte(paddr, data);

 	__arm_lpae_set_pte(ptep, pte, &data->iop.cfg);
@@ -321,7 +333,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 {
 	arm_lpae_iopte pte = *ptep;

-	if (iopte_leaf(pte, lvl)) {
+	if (iopte_leaf(pte, lvl, data->iop.fmt)) {
 		/* We require an unmap first */
 		WARN_ON(!selftest_running);
 		return -EEXIST;
@@ -409,7 +421,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		__arm_lpae_sync_pte(ptep, cfg);
 	}

-	if (pte && !iopte_leaf(pte, lvl)) {
+	if (pte && !iopte_leaf(pte, lvl, data->iop.fmt)) {
 		cptep = iopte_deref(pte, data);
 	} else if (pte) {
 		/* We require an unmap first */
@@ -429,31 +441,33 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 	if (data->iop.fmt == ARM_64_LPAE_S1 ||
 	    data->iop.fmt == ARM_32_LPAE_S1) {
 		pte = ARM_LPAE_PTE_nG;
-
 		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
 			pte |= ARM_LPAE_PTE_AP_RDONLY;
-
 		if (!(prot & IOMMU_PRIV))
 			pte |= ARM_LPAE_PTE_AP_UNPRIV;
-
-		if (prot & IOMMU_MMIO)
-			pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
-				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
-		else if (prot & IOMMU_CACHE)
-			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
-				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
 	} else {
 		pte = ARM_LPAE_PTE_HAP_FAULT;
 		if (prot & IOMMU_READ)
 			pte |= ARM_LPAE_PTE_HAP_READ;
 		if (prot & IOMMU_WRITE)
 			pte |= ARM_LPAE_PTE_HAP_WRITE;
+	}
+
+	if (data->iop.fmt == ARM_64_LPAE_S2 ||
+	    data->iop.fmt == ARM_32_LPAE_S2) {
 		if (prot & IOMMU_MMIO)
 			pte |= ARM_LPAE_PTE_MEMATTR_DEV;
 		else if (prot & IOMMU_CACHE)
 			pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
 		else
 			pte |= ARM_LPAE_PTE_MEMATTR_NC;
+	} else {
+		if (prot & IOMMU_MMIO)
+			pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
+				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
+		else if (prot & IOMMU_CACHE)
+			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
+				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
 	}

 	if (prot & IOMMU_NOEXEC)
@@ -511,7 +525,7 @@ static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
 	while (ptep != end) {
 		arm_lpae_iopte pte = *ptep++;

-		if (!pte || iopte_leaf(pte, lvl))
+		if (!pte || iopte_leaf(pte, lvl, data->iop.fmt))
 			continue;

 		__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
@@ -602,7 +616,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
 		__arm_lpae_set_pte(ptep, 0, &iop->cfg);

-		if (!iopte_leaf(pte, lvl)) {
+		if (!iopte_leaf(pte, lvl, iop->fmt)) {
 			/* Also flush any partial walks */
 			io_pgtable_tlb_add_flush(iop, iova, size,
 						ARM_LPAE_GRANULE(data), false);
@@ -621,7 +635,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 		}

 		return size;
-	} else if (iopte_leaf(pte, lvl)) {
+	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
 		/*
 		 * Insert a table at the next level to map the old region,
 		 * minus the part we want to unmap
@@ -669,7 +683,7 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 			return 0;

 		/* Leaf entry? */
-		if (iopte_leaf(pte,lvl))
+		if (iopte_leaf(pte, lvl, data->iop.fmt))
 			goto found_translation;

 		/* Take it to the next level */
@@ -995,6 +1009,32 @@ arm_32_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	return iop;
 }

+static struct io_pgtable *
+arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
+{
+	struct io_pgtable *iop;
+
+	if (cfg->ias != 48 || cfg->oas > 40)
+		return NULL;
+
+	cfg->pgsize_bitmap &= (SZ_4K | SZ_2M | SZ_1G);
+	iop = arm_64_lpae_alloc_pgtable_s1(cfg, cookie);
+	if (iop) {
+		u64 mair, ttbr;
+
+		/* Copy values as union fields overlap */
+		mair = cfg->arm_lpae_s1_cfg.mair[0];
+		ttbr = cfg->arm_lpae_s1_cfg.ttbr[0];
+
+		cfg->arm_mali_lpae_cfg.memattr = mair;
+		cfg->arm_mali_lpae_cfg.transtab = ttbr |
+			ARM_MALI_LPAE_TTBR_READ_INNER |
+			ARM_MALI_LPAE_TTBR_ADRMODE_TABLE;
+	}
+
+	return iop;
+}
+
 struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
 	.alloc	= arm_64_lpae_alloc_pgtable_s1,
 	.free	= arm_lpae_free_pgtable,
@@ -1015,6 +1055,11 @@ struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns = {
 	.free	= arm_lpae_free_pgtable,
 };

+struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
+	.alloc	= arm_mali_lpae_alloc_pgtable,
+	.free	= arm_lpae_free_pgtable,
+};
+
 #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST

 static struct io_pgtable_cfg *cfg_cookie;
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 93f2880be6c6..5227cfdbb65b 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -30,6 +30,7 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 	[ARM_32_LPAE_S2] = &io_pgtable_arm_32_lpae_s2_init_fns,
 	[ARM_64_LPAE_S1] = &io_pgtable_arm_64_lpae_s1_init_fns,
 	[ARM_64_LPAE_S2] = &io_pgtable_arm_64_lpae_s2_init_fns,
+	[ARM_MALI_LPAE] = &io_pgtable_arm_mali_lpae_init_fns,
 #endif
 #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S
 	[ARM_V7S] = &io_pgtable_arm_v7s_init_fns,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 47d5ae559329..76969a564831 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -12,6 +12,7 @@ enum io_pgtable_fmt {
 	ARM_64_LPAE_S1,
 	ARM_64_LPAE_S2,
 	ARM_V7S,
+	ARM_MALI_LPAE,
 	IO_PGTABLE_NUM_FMTS,
 };

@@ -108,6 +109,11 @@ struct io_pgtable_cfg {
 			u32	nmrr;
 			u32	prrr;
 		} arm_v7s_cfg;
+
+		struct {
+			u64	transtab;
+			u64	memattr;
+		} arm_mali_lpae_cfg;
 	};
 };

@@ -209,5 +215,6 @@ extern struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns;
+extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;

 #endif /* __IO_PGTABLE_H */
--
2.19.1
