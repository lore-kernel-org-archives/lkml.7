Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FB5C2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDD02068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIbbmsAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLIOuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:50:20 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34070 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfLIOuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:50:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so16562128wrr.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=li3aL6AKer4CD9SxvytTfEJufU4SX6U6gX8As2O4Eqk=;
        b=sIbbmsAKQOinyqrXzcC99G76KdGrMEBizkBgPtvaRxn8ZKhsfY5X977UavqreA+/rf
         6IRczi+ABL0XqlQHMKt9eOe/MtYJQ8CvDjSThFwoQD3J3AyC56sPJTUrEaZLgLEja96e
         dK3bdVprHh6nx24uLGY2MnQvm+2b2lI+H6jfYdfzuO/LR6dBLTl/wDDhsIg6/WLdtBs3
         yqlMPfNu6+7i4kwgT6zFfxpN42GOZF6RWrvZRmmMr9cC0Y8YBjMEUsyaLLL56p2ZicIE
         B5eHoYivdlm1CdYuboV2OPBvt7Kjl4Ce5zeh2hZgXUTSES5/2vzXNFrlcSxEi9+doRrC
         Gk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=li3aL6AKer4CD9SxvytTfEJufU4SX6U6gX8As2O4Eqk=;
        b=Lx9BoisndePlINsBzMNssglpzQigwDQGb9PD+4EE0LJD+suTS47c7DhAAIzEgmsftJ
         z91JP1c61zq1TFFGg4Yhrck3pWLAFHVG7GT0cc5a6oQxZBA1Thi//t84RZ/I+giMpRZ1
         rOLo6IAozlsz2Atmow/N8TjGFuGT0V3qv3LcjNLL/LLGhs8hdb3hMMt3LuVo+ytklHFH
         ZkR+RHm4+GdxmZ4PQMF3ckqhHXN2HmF8dGypDdaXY6P+zyYg9Mx/mC2QtnGecTwnBZds
         4uEOYCUtfXwW4qlZRj2B2wlTYmF3zubDCUeQgf/w4nygwccpMckHO9n5lKrpAvJnu61k
         UTvQ==
X-Gm-Message-State: APjAAAWtOy0xfECDtg6hDC2bshPYWT2PEEothoheox/qC/r+b9KLVSAO
        MK40m/JIiuMHKugSYgSU/r0=
X-Google-Smtp-Source: APXvYqzHwIqbGPCxhT3/97guWDjWbFdKkbF4/OZcFZLfBqZtJeRr9aLwAe1boBI+1nQud1IyWHXeDA==
X-Received: by 2002:a5d:6ac5:: with SMTP id u5mr2572334wrw.271.1575903016835;
        Mon, 09 Dec 2019 06:50:16 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id d186sm8590wmf.7.2019.12.09.06.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:50:15 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] iommu: amd: Use iommu_put_resv_regions_simple()
Date:   Mon,  9 Dec 2019 15:50:05 +0100
Message-Id: <20191209145007.2433144-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191209145007.2433144-1-thierry.reding@gmail.com>
References: <20191209145007.2433144-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Use the new standard function instead of open-coding it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/amd_iommu.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index bd25674ee4db..5896cbe6106b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2641,15 +2641,6 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 	list_add_tail(&region->list, head);
 }
 
-static void amd_iommu_put_resv_regions(struct device *dev,
-				     struct list_head *head)
-{
-	struct iommu_resv_region *entry, *next;
-
-	list_for_each_entry_safe(entry, next, head, list)
-		kfree(entry);
-}
-
 static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 					 struct device *dev)
 {
@@ -2688,7 +2679,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.device_group = amd_iommu_device_group,
 	.domain_get_attr = amd_iommu_domain_get_attr,
 	.get_resv_regions = amd_iommu_get_resv_regions,
-	.put_resv_regions = amd_iommu_put_resv_regions,
+	.put_resv_regions = iommu_put_resv_regions_simple,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
-- 
2.23.0

