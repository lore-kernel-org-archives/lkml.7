Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B64C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3328420850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiB5wkBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfFNNNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:13:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46900 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFNNNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:13:06 -0400
Received: by mail-qk1-f195.google.com with SMTP id x18so1570828qkn.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+tFDksFffEpGXWf74d3vaKdXMAyKwc+2Rp4MyFwCKVQ=;
        b=fiB5wkBVxsKeL5k+KkAGrFlUmSk1byl/GiN2Xo9gy/7cEid5eY0hXmwLwDRizYspa4
         oopJRiJUoBO3mRPxNIL+uwsH37O7Fa8SQLVmSYYd/uE18+Nret8ONqT3S4xaq/6sVxAN
         uhn9N23jWd41HX1joxngZLUZ6P27FDH/hpovd4G11oOn9gkdRuMNDhIa7/4opnT8GGn8
         fF9y9/AW4idvXftY6zMTtrI9fDg8TTQSo6pCrDFHW+Z30Ggi6MuRNvZVwguGP2u4sMnS
         3lD8R+PSQNxpbYIdTWbLpGf0Bzs78+O/M/FTdJJi1FKjsP/7oE9MRWhcf8EN1EdonIn8
         Zn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+tFDksFffEpGXWf74d3vaKdXMAyKwc+2Rp4MyFwCKVQ=;
        b=razBzapivphs7iiSzwrHy69UKtSrRdWm/WgYA96eH/uu3vIoHpuuK5KsJg3hF0uDt/
         BThepQ5Rais8l8dyvQ+tsyRuj0o1d55drQEvup6+QDsrAE0mBAo/HIg6Ak3CA+9i68KA
         llTUGkQNdfgbD8j9fvbXVwQFrZkCjN7a7pGfbkHUIREhvEc8Jxzc074Xe6IhEtdwN7N7
         /NIMBhv8Vt5bmxxD1yuxXpWGZT7+P1x4Jw/3owqL0FFHS+BIcPSgYoB4p5gCgpIs5NEl
         kpeu9MDurBGIof6v1u83e7xo2DVFJctOy5AEcnpvK5HZg/OylWNPhMIzDQMj23MNyJZf
         AfGw==
X-Gm-Message-State: APjAAAX63WAcra+ukK1OFevdaMqO0CA+QaQV43dt2UjnktNOT1W7mi3I
        r/r/kJavRqkJr0h079eEZw==
X-Google-Smtp-Source: APXvYqwCZcVCKo1fyJFmDmeZVjNujYgLtaS2EAtung+hF1kdgQvDNS6dXhUFlZJN2BWHrufFLDkWgg==
X-Received: by 2002:a37:5407:: with SMTP id i7mr3763273qkb.149.1560517985220;
        Fri, 14 Jun 2019 06:13:05 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i30sm1563893qtb.18.2019.06.14.06.13.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 06:13:04 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>
Subject: [PATCH v2] arm64/mm: Correct the cache line size warning with non coherent device
Date:   Fri, 14 Jun 2019 09:11:41 -0400
Message-Id: <20190614131141.4428-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

If the cache line size is greater than ARCH_DMA_MINALIGN (128),
the warning shows and it's tainted as TAINT_CPU_OUT_OF_SPEC.

However, it's not good because as discussed in the thread [1], the cpu
cache line size will be problem only on non-coherent devices.

Since the coherent flag is already introduced to struct device,
show the warning only if the device is non-coherent device and
ARCH_DMA_MINALIGN is smaller than the cpu cache size.

[1] https://lore.kernel.org/linux-arm-kernel/20180514145703.celnlobzn3uh5tc2@localhost/

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Tested-by: Zhang Lei <zhang.lei@jp.fujitsu.com>
---
 arch/arm64/include/asm/cache.h |  7 +++++++
 arch/arm64/kernel/cacheinfo.c  |  4 +---
 arch/arm64/mm/dma-mapping.c    | 14 ++++++++++----
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 758af6340314..d24b7c1ecd9b 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -91,6 +91,13 @@ static inline u32 cache_type_cwg(void)
 
 #define __read_mostly __attribute__((__section__(".data..read_mostly")))
 
+static inline int cache_line_size_of_cpu(void)
+{
+	u32 cwg = cache_type_cwg();
+
+	return cwg ? 4 << cwg : ARCH_DMA_MINALIGN;
+}
+
 int cache_line_size(void);
 
 /*
diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 6eaf1c07aa4e..7fa6828bb488 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -19,12 +19,10 @@
 
 int cache_line_size(void)
 {
-	u32 cwg = cache_type_cwg();
-
 	if (coherency_max_size != 0)
 		return coherency_max_size;
 
-	return cwg ? 4 << cwg : ARCH_DMA_MINALIGN;
+	return cache_line_size_of_cpu();
 }
 EXPORT_SYMBOL_GPL(cache_line_size);
 
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 1669618db08a..379589dc7113 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -38,10 +38,6 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 
 static int __init arm64_dma_init(void)
 {
-	WARN_TAINT(ARCH_DMA_MINALIGN < cache_line_size(),
-		   TAINT_CPU_OUT_OF_SPEC,
-		   "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
-		   ARCH_DMA_MINALIGN, cache_line_size());
 	return dma_atomic_pool_init(GFP_DMA32, __pgprot(PROT_NORMAL_NC));
 }
 arch_initcall(arm64_dma_init);
@@ -56,7 +52,17 @@ void arch_teardown_dma_ops(struct device *dev)
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
+	int cls = cache_line_size_of_cpu();
+
 	dev->dma_coherent = coherent;
+
+	if (!coherent)
+		WARN_TAINT(cls > ARCH_DMA_MINALIGN,
+			TAINT_CPU_OUT_OF_SPEC,
+			"%s %s: ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
+			dev_driver_string(dev), dev_name(dev),
+			ARCH_DMA_MINALIGN, cls);
+
 	if (iommu)
 		iommu_setup_dma_ops(dev, dma_base, size);
 
-- 
2.20.1

