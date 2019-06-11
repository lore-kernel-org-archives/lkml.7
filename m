Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3E8C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0276A21773
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laSYdg+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404841AbfFKPTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:19:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44693 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387563AbfFKPTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:19:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so14944858qtk.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3YajPL9keBD1PgFsRAQ5XHEZUjp++ldFMZE5mzh7qVo=;
        b=laSYdg+9mu5jmzB9fvg85XGBfsrnwK/KXgXp15a3LOmkxgOs/DghF5QngvMMmGMdx/
         TGNnm9EC7gpOtHPHUZ7zts03XHFu6aTTDBQGRYdKANebjHM47x97+tQa3g1cbq86A2lU
         tGOhzqNJFYnsV9wGJzGdz3WfZVbZGSkRoIOh2cn3UJXKmCbjxoYtJ+P8rIo7lx/nuFTP
         UKR5ADwuNlSaT1rCnvRPVDvgeD+w2RFZzQxyoUldcKKGBmrUrNQoIPRYOGr7uvu0Gai4
         DVRLB5kVBVwtJ8eB2sQ67+BtCuiVkgGzgIXZb6HBc0MYNjM8cIQ1I14BJe7oP0zwO1fi
         Jl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3YajPL9keBD1PgFsRAQ5XHEZUjp++ldFMZE5mzh7qVo=;
        b=YvCu8GfF0Rr1OsKtClWPXChW5QuV75m7qYj4sEFWaTkRNEN+ItjDABv6cviJGwcxGp
         Y8g+NqOncqvGMVRpsh4VM7mepKsbr1fNprJF+lgHVl6Z4s4H0HrtSauRu12x1C+Lo6aK
         lepDFCIe8Ohm5UAQ0bgH2Jq3OXBKr/aYVVbEiCuKlqKEXwP/Yo3cw54FUQ+RlNAwacFF
         00NhhqBcjvhUrE5Yf7SzXqpsRHi1v0OXg5MaH9zNWCRCXMoJ6jcHJaVdXbmtMc7ZV3J4
         HeCUq0wyAQWZ5ohHt6kg67acbD0BDxfZxOQAdUlF2kMmmbuLBwJevIJGV/kKGULRpekI
         I0PQ==
X-Gm-Message-State: APjAAAU1pK0ji3GbH4PSAoGcUF1l85LKgOz/V1oEqiXoMBmgDTc92sqV
        POW/xkRrOUYgbfJJ4uDcpg==
X-Google-Smtp-Source: APXvYqwEyV6qnh3/vMG8T9LAybCDQp3YsE/QBpvtrlsyD4nZCWkj8cWN3gJnDks2/t0FKmrSooRGVA==
X-Received: by 2002:a0c:9253:: with SMTP id 19mr13908484qvz.180.1560266378888;
        Tue, 11 Jun 2019 08:19:38 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z57sm6538533qta.62.2019.06.11.08.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:19:38 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>
Subject: [PATCH 1/2] arm64/mm: check cpu cache line size with non-coherent device
Date:   Tue, 11 Jun 2019 11:17:30 -0400
Message-Id: <20190611151731.6135-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611151731.6135-1-msys.mizuma@gmail.com>
References: <20190611151731.6135-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

As discussed in the thread [1], the cpu cache line size will be problem
only on non-coherent devices. And, the coherent flag is already introduced
to struct device.

Show the warning only if the device is non-coherent device and
ARCH_DMA_MINALIGN is smaller than the cpu cache size.

[1] https://lore.kernel.org/linux-arm-kernel/20180514145703.celnlobzn3uh5tc2@localhost/

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Tested-by: Zhang Lei <zhang.lei@jp.fujitsu.com>
---
 arch/arm64/mm/dma-mapping.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 674860e3e478..c0c09890c845 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -91,10 +91,6 @@ static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
 
 static int __init arm64_dma_init(void)
 {
-	WARN_TAINT(ARCH_DMA_MINALIGN < cache_line_size(),
-		   TAINT_CPU_OUT_OF_SPEC,
-		   "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
-		   ARCH_DMA_MINALIGN, cache_line_size());
 	return dma_atomic_pool_init(GFP_DMA32, __pgprot(PROT_NORMAL_NC));
 }
 arch_initcall(arm64_dma_init);
@@ -473,6 +469,11 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
 	dev->dma_coherent = coherent;
+
+	if (!coherent && (cache_line_size() > ARCH_DMA_MINALIGN))
+		dev_WARN(dev, "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
+				ARCH_DMA_MINALIGN, cache_line_size());
+
 	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
 
 #ifdef CONFIG_XEN
-- 
2.20.1

