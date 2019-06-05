Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D374BC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9A720866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VxvqG2PW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfFEVJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:09:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41955 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfFEVJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:09:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so61209pfq.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 14:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ry1vQBxsMbP00vdiIcPrZlm4iIMXw6h5SGLwwG/iVbM=;
        b=VxvqG2PW0+5pSp9t5XCA4qowHutScYDHRE+nsLAcjwkD761a4tLnjjrKTbCLu5r/P5
         A3y9IdCB35zNuT4KlIhFtfr2gqIzPm2q3CCscrHUC3ttodvJI6lc4/l75psvQbELxPZ9
         8lOrONhJe4mXYue0Zaz8Kg413VqyaC+RFEeOZlZGYLCoNaDjIsK0rZ0+crw5uSHC9hqD
         Y0AR7672VjKnZlm44qEvrfmPKN/h8zW9V/htrWXI1cYQq5fj3cKiM3pjv7BsD1YpDNSp
         Cz7mECl9WTz15xhD74clwsWi0Da3MuyOIETFx9YDnaBM07TcGGiaGunskRGqq5O0X7Mw
         8BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ry1vQBxsMbP00vdiIcPrZlm4iIMXw6h5SGLwwG/iVbM=;
        b=gnkQjgCiZ8rhp0JZzpId3nvKg6uOI5O8zrb4S8xN4FirG5HQ7c9ChL9f5oCYFWj2F1
         2PSDHApIWKquLt0tWlqbWECL4Isy7Svt9AdYb+ALGiq+w60hZSrDeX3U95KopR9oRFDU
         4HtoK4yB0r/hIkH96o/2wqPtDfG+W08u0vm/1PTsg0hZZrdRUufnOFnnf6puF21t8W3U
         aYpksss5mL+CRjfsytR8Y02ckQDVMGxjq1MTkDBk3qrD1hxhWXPjf+ACxp2VTS7QQFGQ
         XSNOFqutbrLXzS4FmqAChsv31Z4qNJyr5jKnxslWXRD5te+86e0U+IFAGf3KDSJ3nHkC
         QTgg==
X-Gm-Message-State: APjAAAW9CaGWIT2g1fNLHiipMsxOwO523zS5FiJvAeJNCCOX5BOPuBSN
        Xg3i1i9XD2capxq7jEoACAMmxw==
X-Google-Smtp-Source: APXvYqwLjPbJRcoaAugB6k9b8sqHmGnHrT4H05jhzViLueVW5rfhjOYyfkZm+C2OANbT62nCKvlMNA==
X-Received: by 2002:a17:90a:b30a:: with SMTP id d10mr22253135pjr.8.1559768941840;
        Wed, 05 Jun 2019 14:09:01 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z68sm5093374pfb.37.2019.06.05.14.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 14:09:01 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Patrick Daly <pdaly@codeaurora.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [RFC 2/2] iommu: arm-smmu: Don't blindly use first SMR to calculate mask
Date:   Wed,  5 Jun 2019 14:08:56 -0700
Message-Id: <20190605210856.20677-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190605210856.20677-1-bjorn.andersson@linaro.org>
References: <20190605210856.20677-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the SMRs inherited from the bootloader the first SMR might actually
be valid and in use. As such probing the SMR mask using the first SMR
might break a stream in use. Search for an unused stream and use this to
probe the SMR mask.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/iommu/arm-smmu.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c8629a656b42..0c6f5fe6f382 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1084,23 +1084,35 @@ static void arm_smmu_test_smr_masks(struct arm_smmu_device *smmu)
 {
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	u32 smr;
+	int idx;
 
 	if (!smmu->smrs)
 		return;
 
+	for (idx = 0; idx < smmu->num_mapping_groups; idx++) {
+		smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(idx));
+		if (!(smr & SMR_VALID))
+			break;
+	}
+
+	if (idx == smmu->num_mapping_groups) {
+		dev_err(smmu->dev, "Unable to compute streamid_mask\n");
+		return;
+	}
+
 	/*
 	 * SMR.ID bits may not be preserved if the corresponding MASK
 	 * bits are set, so check each one separately. We can reject
 	 * masters later if they try to claim IDs outside these masks.
 	 */
 	smr = smmu->streamid_mask << SMR_ID_SHIFT;
-	writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(0));
-	smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(0));
+	writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(idx));
+	smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(idx));
 	smmu->streamid_mask = smr >> SMR_ID_SHIFT;
 
 	smr = smmu->streamid_mask << SMR_MASK_SHIFT;
-	writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(0));
-	smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(0));
+	writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(idx));
+	smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(idx));
 	smmu->smr_mask_mask = smr >> SMR_MASK_SHIFT;
 }
 
-- 
2.18.0

