Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C24CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BE7222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576757078;
	bh=3tpbtnl8OY57w2rdlJWwXlJgag79sYKXgNFcccIKSe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AGKNDoxOvKTd9ggt9tYs66jDrocPdR8+Ige2hnN/GfrsGjKTCxQDal8McOVMEcJaH
	 9d7A1SuAOYsFnbkHyxE3XTCBwV44JpkO0B3kBXcryDmO+2+/MdOgrFKAcUa/PCSFOe
	 r5ZAHg7jKu9F8K+qYw0H9PezSqEbiWj+gaBUR4IU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfLSMEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:04:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfLSMEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:04:30 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 576E7222C2;
        Thu, 19 Dec 2019 12:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576757069;
        bh=3tpbtnl8OY57w2rdlJWwXlJgag79sYKXgNFcccIKSe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XL+3ciAAMACO2HKpFvxi0nRHLegR8Vt+TjRCNvBEv+grJOqV00RgTzinj0z6gAcrt
         qoQWFRj8DKrlJaVwOnl1Vjs3uyVPVL0Fu5GTgg+i+ScfWenIhTL98VixOPjWirl53d
         tsRxwCPrdQTnfACHG1eQHfjQ/7hRKyL3M4qfVqxY=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, iommu@lists.linuxfoundation.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 10/16] iommu/arm-smmu: Prevent forced unbinding of Arm SMMU drivers
Date:   Thu, 19 Dec 2019 12:03:46 +0000
Message-Id: <20191219120352.382-11-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219120352.382-1-will@kernel.org>
References: <20191219120352.382-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forcefully unbinding the Arm SMMU drivers is a pretty dangerous operation,
since it will likely lead to catastrophic failure for any DMA devices
mastering through the SMMU being unbound. When the driver then attempts
to "handle" the fatal faults, it's very easy to trip over dead data
structures, leading to use-after-free.

On John's machine, he reports that the machine was "unusable" due to
loss of the storage controller following a forced unbind of the SMMUv3
driver:

  | # cd ./bus/platform/drivers/arm-smmu-v3
  | # echo arm-smmu-v3.0.auto > unbind
  | hisi_sas_v2_hw HISI0162:01: CQE_AXI_W_ERR (0x800) found!
  | platform arm-smmu-v3.0.auto: CMD_SYNC timeout at 0x00000146
  | [hwprod 0x00000146, hwcons 0x00000000]

Prevent this forced unbinding of the drivers by setting "suppress_bind_attrs"
to true.

Link: https://lore.kernel.org/lkml/06dfd385-1af0-3106-4cc5-6a5b8e864759@huawei.com
Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 5 +++--
 drivers/iommu/arm-smmu.c    | 7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 68163b1d680d..9d4c9de6172d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3700,8 +3700,9 @@ MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
-		.name		= "arm-smmu-v3",
-		.of_match_table	= of_match_ptr(arm_smmu_of_match),
+		.name			= "arm-smmu-v3",
+		.of_match_table		= of_match_ptr(arm_smmu_of_match),
+		.suppress_bind_attrs	= true,
 	},
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7c768f771001..5cbee88a3b83 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2268,9 +2268,10 @@ static const struct dev_pm_ops arm_smmu_pm_ops = {
 
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
-		.name		= "arm-smmu",
-		.of_match_table	= of_match_ptr(arm_smmu_of_match),
-		.pm		= &arm_smmu_pm_ops,
+		.name			= "arm-smmu",
+		.of_match_table		= of_match_ptr(arm_smmu_of_match),
+		.pm			= &arm_smmu_pm_ops,
+		.suppress_bind_attrs    = true,
 	},
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
-- 
2.24.1.735.g03f4e72817-goog

