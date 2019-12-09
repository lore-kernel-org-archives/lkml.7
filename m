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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC28C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4169E207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYdOxD2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLIOuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:50:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40590 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfLIOuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:50:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so16508074wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I3aVjWdLXvLOfDvHl+80UOXgd4T3MYRIvZkx/WAfvow=;
        b=XYdOxD2z70YIt3ZS9joDPOLCuZDMHOr+p5n+49OM1+kg4Yc/Hxhrk5rkXDN4vE8qEl
         dQYNDkBLp/eGMnRMlGljZnwMFHJV+E147Pvt2Acjoc+c+81H012A8L14Uy5ZN4+i/SKl
         7S7a4eteQjj9rVp7uX9smhSTLH0jqehZdOB940kVbuSiI6RoMRiax35WQ9KxsrlYUPbA
         jR0uSuV6tFMZKWuZNPY+UDm8OcIR95YPafvM7+wGa4ufN5NPyemPAjtFMtXmyYtnGVyM
         RHD4FmCCnCamgojLAXcDcLT6ZJRRZ68IGI393N4Aa7h9N1Sv9zUIJ6OA4cVV8XXMeg//
         tdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I3aVjWdLXvLOfDvHl+80UOXgd4T3MYRIvZkx/WAfvow=;
        b=BztPm1LNc58bA0j0xkryjdLxCQTdhgoaSesgMqfebT4mldgRvDiSmglc75xmwNIiIM
         8hXXl+n9ENqvBAQ+PB9r5iHMhYmdPDBDCAot5aT3wtuVysdfh3JFIdDE0tv5iqQGPqgk
         r4dhgRgp1JcROQWBiBgIy4dmmDQl55qmNoCGsInTs2H51XegLG9VibEUdOD0Kyn0+cGU
         uzaueCo0Oj+Cs7MX7gTI9TlgMfRlnpZ4BBj0Zwh9bForQCGR2w4H5gPSJox03DUATE56
         Hy3TaKEbSMCpCCywCi7mT/6X/waGTTZn0X15TJQGf6tr8iLeVp0hAcUY0zWWe2W4Q2dY
         Gixw==
X-Gm-Message-State: APjAAAUkBbqdfoarPGrLBVH4PBLP7NhAnlzXLiWaAQiM5LUIuldndBKw
        c8CT1BItRobBVSG12KDOiOJhxK2F
X-Google-Smtp-Source: APXvYqyzb+Gr3fnT6bZnw6Qeyd7z43gdd6oakIDoqaNzca4I3GYvDjohjO+w8mvyuTBM2hpMZlM+/Q==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr2615868wrl.117.1575903018924;
        Mon, 09 Dec 2019 06:50:18 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id x17sm27547138wrt.74.2019.12.09.06.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:50:17 -0800 (PST)
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
Subject: [PATCH v2 4/5] iommu: intel: Use iommu_put_resv_regions_simple()
Date:   Mon,  9 Dec 2019 15:50:06 +0100
Message-Id: <20191209145007.2433144-5-thierry.reding@gmail.com>
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

Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/intel-iommu.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0c8d81f56a30..480f424f6a47 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5752,15 +5752,6 @@ static void intel_iommu_get_resv_regions(struct device *device,
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
@@ -5995,7 +5986,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.add_device		= intel_iommu_add_device,
 	.remove_device		= intel_iommu_remove_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
-	.put_resv_regions	= intel_iommu_put_resv_regions,
+	.put_resv_regions	= iommu_put_resv_regions_simple,
 	.apply_resv_region	= intel_iommu_apply_resv_region,
 	.device_group		= pci_device_group,
 	.dev_has_feat		= intel_iommu_dev_has_feat,
-- 
2.23.0

