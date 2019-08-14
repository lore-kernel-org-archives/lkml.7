Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C09C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D282064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEFmOTX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfHNWNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 18:13:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40498 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbfHNWNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 18:13:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so226125pla.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 15:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o3iTgpB3GXZ+kQcPnDKxJUeeBPOFZQS1HDP+dtSl8iI=;
        b=HEFmOTX7vqz6H06xnoRwJnyjwS4ngqlcblSxxBe9uJf91C2C3l3H3afY81WwkxEetJ
         EbUuQcyViX1xj4UfRyAAAdKQkMJMp+A+qWSGvq1zWUQw8DQ77jCsLpCgcMhfLo6nNVda
         wPT3QzNUctnrmjktXM3EnsOkJ9WFmmfmF6P3JP5768lVtArSlAJdr5XkaQydkdBmUDdH
         uDi58nt19hPwUpCeJaQPKGXa/z2gZnqlXC+ryopFfLScSWgENEVIXSevTZyjazE3ppis
         zLF2GWdAmdB59Sq/EJsbTmRz5IiKtqn37DU/qrZVhnWBWkDLht8AheY3rvNIjk4LdN7S
         2yNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o3iTgpB3GXZ+kQcPnDKxJUeeBPOFZQS1HDP+dtSl8iI=;
        b=GR8ATldQHsr6ouYarufsxXBn06uN5i1se+x5bj/X9DrWSdryTcOjHOevgOMcH8F7vm
         Pwy0jnlDzOqJnPgNfsqGBtVSyldNo3n6phYpoYSZjeZ1+3uLB99D9//AGoC4PMYhKDAY
         k8ngQUieZ6JCD7sFvVImICFK1J1Xtz6PUe9enDcWg/3Rq9lFhYaibkaUEsPVUFMPkDdG
         Re8huZSadP5C1MalCHO2eoVfQjTcJQqla7kJ+IaEGddCqw62jetgNsOFtHo4ZvxEvSPw
         PtMNKkkG8kQDDt4HQuMAkEEZsgb9E5cJvK6EOvwKRI6hgotuC4QkD6lVTuzG+aOPMpV0
         x2dw==
X-Gm-Message-State: APjAAAUZBW4EoTlzVybqUrXkAsuq30ueMj0xURGb8I7MEI7jNeQ4YQ5v
        kfkwVPvqLraeYHaiN8zVXBo=
X-Google-Smtp-Source: APXvYqyti+vq96Q0pE8Yd5FkzLw83ZjuNfSd6SNA8pgDAWZgNSvONObYFjog77tG3BgdbQT4MUollQ==
X-Received: by 2002:a17:902:ac87:: with SMTP id h7mr1561600plr.36.1565820800768;
        Wed, 14 Aug 2019 15:13:20 -0700 (PDT)
Received: from localhost ([100.118.89.196])
        by smtp.gmail.com with ESMTPSA id g1sm633892pgg.27.2019.08.14.15.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 15:13:20 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Christoph Hellwig <hch@lst.de>, Rob Clark <robdclark@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@mips.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wolfram Sang <wsa@the-dreams.de>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] arm: add arch_sync_dma_for_*()
Date:   Wed, 14 Aug 2019 14:59:59 -0700
Message-Id: <20190814220011.26934-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814220011.26934-1-robdclark@gmail.com>
References: <20190814220011.26934-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 arch/arm/Kconfig                |  2 ++
 arch/arm/mm/dma-mapping-nommu.c | 14 ++++++++++++++
 arch/arm/mm/dma-mapping.c       | 28 ++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 33b00579beff..a48a7263a2c1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -18,6 +18,8 @@ config ARM
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_TEARDOWN_DMA_OPS if MMU
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index 52b82559d99b..4a3df952151f 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -84,6 +84,13 @@ static void __dma_page_cpu_to_dev(phys_addr_t paddr, size_t size,
 		outer_clean_range(paddr, paddr + size);
 }
 
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
+{
+	__dma_page_cpu_to_dev(paddr, size, dir);
+}
+EXPORT_SYMBOL_GPL(arch_sync_dma_for_device);
+
 static void __dma_page_dev_to_cpu(phys_addr_t paddr, size_t size,
 				  enum dma_data_direction dir)
 {
@@ -93,6 +100,13 @@ static void __dma_page_dev_to_cpu(phys_addr_t paddr, size_t size,
 	}
 }
 
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
+{
+	__dma_page_dev_to_cpu(paddr, size, dir);
+}
+EXPORT_SYMBOL_GPL(arch_sync_dma_for_cpu);
+
 static dma_addr_t arm_nommu_dma_map_page(struct device *dev, struct page *page,
 					 unsigned long offset, size_t size,
 					 enum dma_data_direction dir,
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6774b03aa405..8ead93196194 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -979,6 +979,13 @@ static void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
 	/* FIXME: non-speculating: flush on bidirectional mappings? */
 }
 
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
+{
+	__dma_page_cpu_to_dev(phys_to_page(paddr), paddr % PAGE_SIZE, size, dir);
+}
+EXPORT_SYMBOL_GPL(arch_sync_dma_for_device);
+
 static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
 	size_t size, enum dma_data_direction dir)
 {
@@ -1013,6 +1020,27 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
 	}
 }
 
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
+{
+	__dma_page_dev_to_cpu(phys_to_page(paddr), paddr % PAGE_SIZE, size, dir);
+}
+EXPORT_SYMBOL_GPL(arch_sync_dma_for_cpu);
+
+/*
+ * arch_dma_{alloc,free} fail-stubs needed to avoid link-errors in dma/direct.c
+ * (which is not actually used on arch/arm)
+ */
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t flags, unsigned long attrs)
+{
+	return NULL;
+}
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_handle, unsigned long attrs)
+{
+}
+
 /**
  * arm_dma_map_sg - map a set of SG buffers for streaming mode DMA
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
-- 
2.21.0

