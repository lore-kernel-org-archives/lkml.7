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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669CBC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBB62465E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plvvtq6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfLRNmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:42:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40762 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfLRNmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:42:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so1943796wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 05:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3rAFL7K9Q66L7E0oU9UDZZEL6mZmsWSXH1Q6ZKBGZs=;
        b=Plvvtq6hNBzRemtmfg0OOQVAKEe2ZS0q6GtZhWvDhDXvc8xilZ19uFoCpjx74jEXpJ
         ks8P8qCAJWKBqhbaDtBQL1Hih4Ql/EFZcnQYmPK8Aa3/syWbywIPuENOUCwYMg8OWM0N
         Kta3CaS8pcL1eVz+IsmUITZ1gBjilPkpT22E5GKOS+U+dOu3PajJeL3B2YPKRofAlOJa
         3lBOjImT4w83A8/YZWoTyR1N4boV1D1OLTN9LClsnhPVs1lUYRU3EPq1MT+v93zwns+h
         v3CI/i+73+x+7Vvtu8JjixWZXmrddJnac4ndk4DEu9LRISgOWpzi626BNfCgGsz/3sdd
         ktVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3rAFL7K9Q66L7E0oU9UDZZEL6mZmsWSXH1Q6ZKBGZs=;
        b=KhNuFK9VkQlAOXSRBYdRg4iG1D/4EsaH1GRJau0n+ibxV404Of+YsccvugilOLCI9h
         FW1IcmlsLiP0HDxXjF8Ud9G0mDEtMZRCwTqO1Q+bZmco0x6bplz1hHdkNH0xkrpgDvcM
         z3yMkq1IokVC/kiiIkAfvSd+QMpXvmtsKUd9UAd9ib6gP/NkoDqAi/FWJySTaLuyWKto
         MwcD6tIOD7+vTGpC04HN63lvsqanoahls5Qudyu1dTdSjpYXw2sD3dKO43cjh2CdoOJD
         QzH05ZMWmRFdP/zLAy8o6zZEHyg0FdXLjWS27tpVzYoGekD1xAVZJ8zlpR3l+sVPq0ha
         6QrQ==
X-Gm-Message-State: APjAAAUFIREDogZz1SBN9FXuodbRJAYIb9/qY68zF8tYjZwGaclhQUM6
        MNEGw+EyW/maKv9LsUTp638=
X-Google-Smtp-Source: APXvYqyJ1+myPu5YtHK5IGKXWRZX/+yLfGrjNRT7nLErzDPqwiTRHjmJdpEdLCQnss548bO8HuF5Ag==
X-Received: by 2002:a1c:6809:: with SMTP id d9mr3439282wmc.70.1576676538578;
        Wed, 18 Dec 2019 05:42:18 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id q11sm2667810wrp.24.2019.12.18.05.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 05:42:17 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v3 4/5] iommu: intel: Use generic_iommu_put_resv_regions()
Date:   Wed, 18 Dec 2019 14:42:04 +0100
Message-Id: <20191218134205.1271740-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218134205.1271740-1-thierry.reding@gmail.com>
References: <20191218134205.1271740-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Use the new standard function instead of open-coding it.

Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/intel-iommu.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 42966611a192..a6d5b7cf9183 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5744,15 +5744,6 @@ static void intel_iommu_get_resv_regions(struct device *device,
 	list_add_tail(&reg->list, head);
 }
 
-static void intel_iommu_put_resv_regions(struct device *dev,
-					 struct list_head *head)
-{
-	struct iommu_resv_region *entry, *next;
-
-	list_for_each_entry_safe(entry, next, head, list)
-		kfree(entry);
-}
-
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 {
 	struct device_domain_info *info;
@@ -5987,7 +5978,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.add_device		= intel_iommu_add_device,
 	.remove_device		= intel_iommu_remove_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
-	.put_resv_regions	= intel_iommu_put_resv_regions,
+	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.apply_resv_region	= intel_iommu_apply_resv_region,
 	.device_group		= pci_device_group,
 	.dev_has_feat		= intel_iommu_dev_has_feat,
-- 
2.24.1

