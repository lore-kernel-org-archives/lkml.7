Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F5DCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC79217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572447089;
	bh=brW6fp/UFvGvOgU4UgFazFj3pgvjI/gIURAsSARgRYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vooiZKcqvu8s4kWcRzmiPSxqP+GLA/kPGJQnn4KDO+dxXgP2KmEPJJxrXnRyzuJAq
	 hpLo3NmbqDtRjkL49ZQpkO4PdrZ9vjO7HeahnbREO1O3N9smXYAdEssZwmx3QDMOH9
	 CJDIDYE3uKulT4bUO2ENT2524JEfPz3ojLyo0KPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfJ3Ov2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:51:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfJ3Ov0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:51:26 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 783E320856;
        Wed, 30 Oct 2019 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572447085;
        bh=brW6fp/UFvGvOgU4UgFazFj3pgvjI/gIURAsSARgRYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XIjO0eEVu91Yt6zUTaoq86dVh4rXOhNOfTRdyapva17xNxBeD1C8H/vL3nxe2VIDQ
         af0e3xO8kIv9h6Hi5GsS9E9t6PDZMiuAUZEKfYHCXo+ScanHBfARinzpfWyZq5iNSJ
         mTpfaW3or5H5IYKOiF6DySxwfdLY4H6u0JDLz9Wg=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4/7] Revert "iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular"
Date:   Wed, 30 Oct 2019 14:51:09 +0000
Message-Id: <20191030145112.19738-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030145112.19738-1-will@kernel.org>
References: <20191030145112.19738-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c07b6426df922d21a13a959cf785d46e9c531941.

Let's get the SMMUv3 driver building as a module, which means putting
back some dead code that we used to carry.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 8da93e730d6f..2ad8e2ca0583 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -21,8 +21,7 @@
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
-#include <linux/init.h>
-#include <linux/moduleparam.h>
+#include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -384,10 +383,6 @@
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
-/*
- * not really modular, but the easiest way to keep compat with existing
- * bootargs behaviour is to continue using module_param_named here.
- */
 static bool disable_bypass = 1;
 module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
@@ -3683,25 +3678,37 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void arm_smmu_device_shutdown(struct platform_device *pdev)
+static int arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
 	arm_smmu_device_disable(smmu);
+
+	return 0;
+}
+
+static void arm_smmu_device_shutdown(struct platform_device *pdev)
+{
+	arm_smmu_device_remove(pdev);
 }
 
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v3", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name		= "arm-smmu-v3",
 		.of_match_table	= of_match_ptr(arm_smmu_of_match),
-		.suppress_bind_attrs = true,
 	},
 	.probe	= arm_smmu_device_probe,
+	.remove	= arm_smmu_device_remove,
 	.shutdown = arm_smmu_device_shutdown,
 };
-builtin_platform_driver(arm_smmu_driver);
+module_platform_driver(arm_smmu_driver);
+
+MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
+MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.24.0.rc0.303.g954a862665-goog

