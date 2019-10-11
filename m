Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B39ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 03:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9B7206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 03:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5EHwYs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfJKDrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 23:47:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46760 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfJKDrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 23:47:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id q24so3791611plr.13;
        Thu, 10 Oct 2019 20:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JdptEyYfrrVWOU3k4HBsHHiS/OxBHfbh3xSJxXoFOXg=;
        b=i5EHwYs/CszsgLgBqVaJ2rCHwBUm8/t6StaUxrR+WK1K3elXfzXSp5NiLQkk3nUJp/
         4oMKE4l/wd4Nc3pLvXzaf6wJQoCyOobPN/HfU1guzjPZsW3VmHpBnGHdb3CM2jYB2Wu0
         XQDL7Lu9aLPIZqrBHm/u23rG9xXJtCQzGmhsg42twwkb0pkN9CXo+2LFSMMXSPGda6kS
         hhgFZ40mIpkqVTb5PBrsRxakHxQ1b9OA1qzxchzU8er9OrhxIRLNWBKcfO3qMhR/g2ZD
         F00814nx3FnVZLdEPKScSSOtHsocSROA6S/JeStl8/3KoPS2Jtyw4X9/np2wn6o1A/2u
         7cSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JdptEyYfrrVWOU3k4HBsHHiS/OxBHfbh3xSJxXoFOXg=;
        b=OwmoJCdP15oI+P4PvNPJWxkQLlGWBmjktzZxZBdVAcPyESuyaDoKD1T4s7pWVl7Vmk
         O/uSfF22zfpJWuy4anjtpSXV6iyLOYSzvQ8Y+dpfSwEra7YMkYeoV/yqwfDjWKY6vjB1
         oFW5F1DbI52QNYoQdPSMszuIlTw0NUA1jGZPugml1m1hZ3hg/ggMpGX73rbl6SQeLWuw
         ORPl/HtP5jW/+p9F8sdONzCANtodek5MMgjH+bdkVknyOfOO9RjNLZDf2dONlyCJEKmw
         lfDO7IfOMFnf9yYaqXkir7Q3Ggqf/vGAJbfubwPQFu9eyN20ppTZbl4Xc0wpG2PU5FpP
         pWvQ==
X-Gm-Message-State: APjAAAXPdPhZXOyWPX7hpTQfxxGTYXHhb7EehyAQ/aHZ4YNCI4uNssVM
        1WvzLxX1xlvalMUu6WniXCM=
X-Google-Smtp-Source: APXvYqwN0/l64V8pBpT3gRAc/OW6eNRZqdFuJPu6MfrrbbPyWTZph1XrL7MD9euTm+lbzWqRsdkvvA==
X-Received: by 2002:a17:902:fe86:: with SMTP id x6mr13108364plm.320.1570765636491;
        Thu, 10 Oct 2019 20:47:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id u3sm7493267pfn.134.2019.10.10.20.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 20:47:15 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        will@kernel.org, robin.murphy@arm.com
Cc:     vdumpa@nvidia.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] iommu/arm-smmu: Read optional "input-address-size" property
Date:   Thu, 10 Oct 2019 20:46:09 -0700
Message-Id: <20191011034609.13319-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011034609.13319-1-nicoleotsuka@gmail.com>
References: <20191011034609.13319-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SMMU instances may not connect all input address lines physically
but drive some upper address bits to logical zero, depending on their
SoC designs. Some of them even connect only 39 bits that is not in the
list of IAS/OAS from SMMU internal IDR registers.

After the "input-address-size" property is added to DT bindings, this
patch reads and applies to va_size as an input virtual address width.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/arm-smmu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index b18aac4c105e..b80a869de45b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1805,12 +1805,14 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 			 "failed to set DMA mask for table walker\n");
 
 	if (smmu->version < ARM_SMMU_V2) {
-		smmu->va_size = smmu->ipa_size;
+		if (!smmu->va_size)
+			smmu->va_size = smmu->ipa_size;
 		if (smmu->version == ARM_SMMU_V1_64K)
 			smmu->features |= ARM_SMMU_FEAT_FMT_AARCH64_64K;
 	} else {
 		size = FIELD_GET(ID2_UBS, id);
-		smmu->va_size = arm_smmu_id_size_to_bits(size);
+		if (!smmu->va_size)
+			smmu->va_size = arm_smmu_id_size_to_bits(size);
 		if (id & ID2_PTFS_4K)
 			smmu->features |= ARM_SMMU_FEAT_FMT_AARCH64_4K;
 		if (id & ID2_PTFS_16K)
@@ -1950,6 +1952,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	const struct arm_smmu_match_data *data;
 	struct device *dev = &pdev->dev;
 	bool legacy_binding;
+	u32 va_size;
 
 	if (of_property_read_u32(dev->of_node, "#global-interrupts",
 				 &smmu->num_global_irqs)) {
@@ -1976,6 +1979,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	if (of_dma_is_coherent(dev->of_node))
 		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
 
+	if (!of_property_read_u32(dev->of_node, "input-address-size", &va_size))
+		smmu->va_size = va_size;
+
 	return 0;
 }
 
-- 
2.17.1

