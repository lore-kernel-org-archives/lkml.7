Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0109C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C836D20898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574337012;
	bh=SotMOuPWIrMiL0yTNTEDFwTlwwkDrUW8iTMn+N3o4L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fMsG1IfKqA4rbIZR8J4paycwSVr1/Isq4qoJXCmgFUcUh2BfsrRqNY3VmcqCLyegz
	 WXYCFqHyb2+KnDiM59qxwQDQ2ay+6fQkModhT5XVr4xMQhwWlibf4u2g9H1yXpNVk0
	 85dXL7sIRcCqZnsVjwupnt/tZbbi4TWOKmw5mW4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfKULtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:49:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfKULtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:49:49 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 923E7208CC;
        Thu, 21 Nov 2019 11:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574336988;
        bh=SotMOuPWIrMiL0yTNTEDFwTlwwkDrUW8iTMn+N3o4L8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=loov8qiFuIwKifyJ6F90iRuygUo5ssnkVK2wqqoEx+ZJqR+HwRGpFKzaluhuJzcQk
         kS8cG7BXOKztYorQjVY9SUb+USi8nnXkkSBPxOI3DB8N1tY/7oIBWIGmDAixc05qQu
         ewuz+PTOSLMJkiVxnhy/XtwodiCzWo6a5k4tjn1A=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 09/14] iommu/arm-smmu: Prevent forced unbinding of Arm SMMU drivers
Date:   Thu, 21 Nov 2019 11:49:13 +0000
Message-Id: <20191121114918.2293-10-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121114918.2293-1-will@kernel.org>
References: <20191121114918.2293-1-will@kernel.org>
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
index 2ad8e2ca0583..3fd75abce3bb 100644
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
index 53bbe0663b9e..d6c83bd69555 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2237,9 +2237,10 @@ static const struct dev_pm_ops arm_smmu_pm_ops = {
 
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
2.24.0.432.g9d3f5f5b63-goog

