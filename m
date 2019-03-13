Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFD5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDA82147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ITH4PHWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCMLcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:32:46 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10273 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfCMLcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:32:45 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c88ea5a0002>; Wed, 13 Mar 2019 04:32:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 04:32:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 13 Mar 2019 04:32:43 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 11:32:43 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Mar 2019 11:32:43 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c88ea590001>; Wed, 13 Mar 2019 04:32:43 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v3 2/2] dmaengine: tegra210-adma: update system sleep callbacks
Date:   Wed, 13 Mar 2019 17:02:37 +0530
Message-ID: <1552476757-22360-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552476757-22360-1-git-send-email-spujar@nvidia.com>
References: <1552476757-22360-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552476762; bh=LK4vbbhJXqGCjgspe2hBPkWsV/9mOH9yZUEqUfc+kBo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=ITH4PHWW6HaKzCKC5Z2iZimEa1geEGBe/UPGkVkuxDZ5xfkO3Sg9XiST42v16coR+
         QXc2szTimwAWbT2O/CfhN8QYBSP9ktn9xyCfC/HbEx5EZ5R/woScKj913piwU5V7c/
         0qPZ/b2VkzdPgqbu2H6djosj8VfNEdUvcNu7DC4ixEz3P7Sx9pMojgggjK1WGtmqZo
         vtT6UWo1XK6ry0S030CAEESaMxUhgLOQYXA1ZjFCcxKwnymkGnrJkLk0KH/NpsRLEo
         I38xztpDYmBjQ4+Mnw/rJxCSVUzfgBYCQSCY3IyjA/2vG4vNExt9JJzGFn5k6ZEdTp
         tcRFF+09x62GQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the driver is active till late suspend, where runtime PM cannot run,
force suspend is essential in such case to put the device in low power
state. Thus pm_runtime_force_suspend and pm_runtime_force_resume are
used as system sleep callbacks during system wide PM transitions.
Late system sleep callbacks are used to ensure, for instance, that the
sound core has suspended any on-going activity, including stopping the
ADMA if active, before we attempt to suspend the ADMA.

Suggested-by: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 650cd9c..253d312 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -796,17 +796,11 @@ static int tegra_adma_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int tegra_adma_pm_suspend(struct device *dev)
-{
-	return pm_runtime_suspended(dev) == false;
-}
-#endif
-
 static const struct dev_pm_ops tegra_adma_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_adma_runtime_suspend,
 			   tegra_adma_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(tegra_adma_pm_suspend, NULL)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				     pm_runtime_force_resume)
 };
 
 static struct platform_driver tegra_admac_driver = {
-- 
2.7.4

