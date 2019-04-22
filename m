Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15945C282E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 07:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84E920857
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 07:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Wi6frBnN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JQmuOtU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfDVHKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 03:10:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46022 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfDVHKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 03:10:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B24F6615E6; Mon, 22 Apr 2019 07:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555917052;
        bh=uAi5cYsiLvl7oGhOuwY5p/liIWrZ/Lrhjglq9hnUl30=;
        h=From:To:Cc:Subject:Date:From;
        b=Wi6frBnNeHaQCUYQDXOynObh9f4+b1pDnzN1iRQ2rs0+DOMg80SltYoS7xx7De6sh
         4btrlahjphjQ3S5AYGoVy8y9bIr8RWjfgnxIiCDfZHyP3HgQ+PrIU3OVy5fIUdpS2T
         pRDiaKha55RU5KrOzdU7rI3YeFPDT7Loi8WB280U=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C9B2604BE;
        Mon, 22 Apr 2019 07:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555917051;
        bh=uAi5cYsiLvl7oGhOuwY5p/liIWrZ/Lrhjglq9hnUl30=;
        h=From:To:Cc:Subject:Date:From;
        b=JQmuOtU2ah7B6C7mVcRpEkmW2qLjBOh3hpxe/xQt/+0ryoq3WpXiVr+hq4YF25L8+
         iG5rmswtXF5+lbpN8arkLctshQLYZj/RhRaWM2MvRnvXy6vHCG73oQ7aixh4p6N0D5
         qMAVQn8R5jNLad6CeQCSVb4cnnENWYALoYs4ZHSY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C9B2604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org
Cc:     vivek.gautam@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org
Subject: [PATCH v2 1/1] iommu/arm-smmu: Log CBFRSYNRA register on context fault
Date:   Mon, 22 Apr 2019 12:40:36 +0530
Message-Id: <20190422071036.32671-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bits[15:0] in CBFRSYNRA register contain information about
StreamID of the incoming transaction that generated the
fault. Dump CBFRSYNRA register to get this info.
This is specially useful in a distributed SMMU architecture
where multiple masters are connected to the SMMU.
SID information helps to quickly identify the faulting
master device.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
 - Addressed review comments, given by Bjorn, for nits.

 drivers/iommu/arm-smmu-regs.h | 2 ++
 drivers/iommu/arm-smmu.c      | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
index a1226e4ab5f8..e9132a926761 100644
--- a/drivers/iommu/arm-smmu-regs.h
+++ b/drivers/iommu/arm-smmu-regs.h
@@ -147,6 +147,8 @@ enum arm_smmu_s2cr_privcfg {
 #define CBAR_IRPTNDX_SHIFT		24
 #define CBAR_IRPTNDX_MASK		0xff
 
+#define ARM_SMMU_GR1_CBFRSYNRA(n)	(0x400 + ((n) << 2))
+
 #define ARM_SMMU_GR1_CBA2R(n)		(0x800 + ((n) << 2))
 #define CBA2R_RW64_32BIT		(0 << 0)
 #define CBA2R_RW64_64BIT		(1 << 0)
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 045d93884164..e000473f8205 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -575,7 +575,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	void __iomem *gr1_base = ARM_SMMU_GR1(smmu);
 	void __iomem *cb_base;
+	u32 cbfrsynra;
 
 	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
 	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
@@ -585,10 +587,11 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 
 	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
 	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
+	cbfrsynra = readl_relaxed(gr1_base + ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
 
 	dev_err_ratelimited(smmu->dev,
-	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
-			    fsr, iova, fsynr, cfg->cbndx);
+	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
+			    fsr, iova, fsynr, cbfrsynra, cfg->cbndx);
 
 	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
 	return IRQ_HANDLED;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

