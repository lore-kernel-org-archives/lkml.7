Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D99C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F08A20740
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQmFVNA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfLZWRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:17:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46264 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfLZWRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:17:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id y8so10937185pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 14:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tubUT90M6ZUsQq/NCNWX8+4auD3W82M3BMPow6ghbj8=;
        b=UQmFVNA7UILTF3d5FkPUjDuMXwndbRHZm1U93zjabv/K6dGhtSfmt4s9JIg+xMq75d
         Y23XDZw4It10l4QHXqaDJ2gjQ7UgsgsYKUABY6o6xlTM6PcI9JGpvxzOiNBkPbauQJQX
         rOb03V74Q2iuvkeRbjoJ25qWSvTN+tewTjT3wPd/ueVoyCzibclmSE33cOkd0g/LLhFE
         PwN21iKGHN6E0QaX+a9jOmpxp/0FWhAO0E6515STbaiPfJvHp37nOVMDlntvCQ+pVwZD
         /Ct2qloyyzoXbev8IsVQDmVybAPP5fOQHljHSIHCexni+dNs47E8KE1BxAOlCHWLI6ls
         AFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tubUT90M6ZUsQq/NCNWX8+4auD3W82M3BMPow6ghbj8=;
        b=tCP8MVb9QOSR1QwP9+LcxYRbI0/cpbnllOJHCalR6W5FVkf7xXgtZigOGIMZqEl+5k
         cFk127PCzxozF0nuS1O+s8haPrxitSc2qjOpEW6QAHoR6ellpxbxsHzcE4VgSQTI/eEb
         zEeAstI1CfNalLP0h1POaqErp4biCwcjA10al/PMdRTts858Wj2Y4nrExuQheg+AaJYw
         bamXOXTsM8dNKcdpTds+MivnZ7GfOjkKF1Z1NDzqBvnclG9upLahPoJ84RKokN0vsCDO
         K5Xn3cd/ahHSdUoqRnnrRWsf6u+M+lLzTZOP4V68DbQ1PONCkBAt5U+l7RBAsTT7DsCC
         dHLg==
X-Gm-Message-State: APjAAAWw1stFirBkKz59dGpJA6+okE2UwtZVdNhPuniO23MWmtf77GKn
        dxJ/VfPjoHxPdjMPrdu1/nnh3w==
X-Google-Smtp-Source: APXvYqzsnGwMryOZ8OSkxJxnL0bgVLu9XUOFhXRRLNcQ4apGus/dVePA/bPEIWlQsBQNQtZUk1Rydw==
X-Received: by 2002:a17:90a:9f04:: with SMTP id n4mr22039896pjp.76.1577398665952;
        Thu, 26 Dec 2019 14:17:45 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 2sm11779409pjh.19.2019.12.26.14.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 14:17:45 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Patrick Daly <pdaly@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH 1/3] iommu/arm-smmu: Don't blindly use first SMR to calculate mask
Date:   Thu, 26 Dec 2019 14:17:07 -0800
Message-Id: <20191226221709.3844244-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191226221709.3844244-1-bjorn.andersson@linaro.org>
References: <20191226221709.3844244-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Changes since RFC:
- Deal with EXIDS
- Use arm_smmu_gr0_read/write()

 drivers/iommu/arm-smmu.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 4f1a350d9529..6ca6a4e072c8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -945,24 +945,43 @@ static void arm_smmu_write_sme(struct arm_smmu_device *smmu, int idx)
  */
 static void arm_smmu_test_smr_masks(struct arm_smmu_device *smmu)
 {
+	u32 s2cr;
 	u32 smr;
+	int idx;
 
 	if (!smmu->smrs)
 		return;
 
+	for (idx = 0; idx < smmu->num_mapping_groups; idx++) {
+		if (smmu->features & ARM_SMMU_FEAT_EXIDS) {
+			s2cr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_S2CR(idx));
+			if (!FIELD_GET(S2CR_EXIDVALID, s2cr))
+				break;
+		} else {
+			smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(idx));
+			if (!FIELD_GET(SMR_VALID, smr))
+				break;
+		}
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
 	smr = FIELD_PREP(SMR_ID, smmu->streamid_mask);
-	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_SMR(0), smr);
-	smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(0));
+	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_SMR(idx), smr);
+	smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(idx));
 	smmu->streamid_mask = FIELD_GET(SMR_ID, smr);
 
 	smr = FIELD_PREP(SMR_MASK, smmu->streamid_mask);
-	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_SMR(0), smr);
-	smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(0));
+	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_SMR(idx), smr);
+	smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(idx));
 	smmu->smr_mask_mask = FIELD_GET(SMR_MASK, smr);
 }
 
-- 
2.24.0

