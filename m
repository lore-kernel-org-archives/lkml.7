Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50360C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD942082F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ENZeW8wE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V5eq3529"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfHTTGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:06:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45242 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfHTTGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:06:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6483761112; Tue, 20 Aug 2019 19:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566328003;
        bh=yf4KbiMcwWuAOC3/YzyfVZGuYYAc192j4/wc6uDR1eE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENZeW8wEm2x/+0HwKwiCPLFSbU8UYDtgcMdvAYT8LQLf9Nt118c24rn2klDoRXXlu
         47DC3JBGW6aiQdY/aQCJAsV0C3llohlVQVX9pRPoBADYDp7ZfvMK+1sS2TaHGFepZD
         UGdvEzwCA0rZXG5dX+YD7bSEcSOiF6+kyAFlZepQ=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D662660F3B;
        Tue, 20 Aug 2019 19:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566328002;
        bh=yf4KbiMcwWuAOC3/YzyfVZGuYYAc192j4/wc6uDR1eE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5eq3529o9GLKf4CR+s250JMtUhyKHm+uRJ+x+QqAeY38tMkk0gtU3WVq/VhgTNcx
         WE+Opu/0m9nG63xUwRt9QhUJ3PCMQk6u+3Jd9imYe0S/7XMQGRWKbY60/ab9KW33Wr
         QPPGaV3ihwUQGZ5rdTmc/TRU8+sVn3MYiI5qVD64=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D662660F3B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/7] iommu/arm-smmu: Add a SMMU variant for the Adreno GPU
Date:   Tue, 20 Aug 2019 13:06:28 -0600
Message-Id: <1566327992-362-4-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566327992-362-1-git-send-email-jcrouse@codeaurora.org>
References: <1566327992-362-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a SMMU model for the Adreno GPU and use it to enable split
pagetable support if the conditions are right.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm-smmu-impl.c | 15 +++++++++++++++
 drivers/iommu/arm-smmu.c      |  2 ++
 drivers/iommu/arm-smmu.h      |  1 +
 3 files changed, 18 insertions(+)

diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
index 3f88cd0..5d197dd 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -147,6 +147,18 @@ static const struct arm_smmu_impl arm_mmu500_impl = {
 	.reset = arm_mmu500_reset,
 };
 
+static int qcom_adreno_init_context(struct arm_smmu_domain *smmu_domain)
+{
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
+		smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH64)
+		smmu_domain->split_pagetables = true;
+
+	return 0;
+}
+
+static const struct arm_smmu_impl qcom_adreno_impl = {
+	.init_context = qcom_adreno_init_context,
+};
 
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 {
@@ -162,6 +174,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 		break;
 	case CAVIUM_SMMUV2:
 		return cavium_smmu_impl_init(smmu);
+	case QCOM_ADRENO_SMMUV2:
+		smmu->impl = &qcom_adreno_impl;
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 39e81ef..3f41cf7 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1858,6 +1858,7 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
 ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
 ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
 ARM_SMMU_MATCH_DATA(qcom_smmuv2, ARM_SMMU_V2, QCOM_SMMUV2);
+ARM_SMMU_MATCH_DATA(qcom_adreno_smmuv2, ARM_SMMU_V2, QCOM_ADRENO_SMMUV2);
 
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
@@ -1867,6 +1868,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
 	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
 	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
+	{ .compatible = "qcom,adreno-smmu-v2", .data = &qcom_adreno_smmuv2 },
 	{ },
 };
 
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 91a4eb8..e5a2cc8 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -222,6 +222,7 @@ enum arm_smmu_implementation {
 	ARM_MMU500,
 	CAVIUM_SMMUV2,
 	QCOM_SMMUV2,
+	QCOM_ADRENO_SMMUV2,
 };
 
 struct arm_smmu_device {
-- 
2.7.4

