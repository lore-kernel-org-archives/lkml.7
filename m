Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F93FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE022171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BL9sEj0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfCMFn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 01:43:26 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17409 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfCMFnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 01:43:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c8898700000>; Tue, 12 Mar 2019 22:43:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Mar 2019 22:43:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Mar 2019 22:43:23 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 05:43:23 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Mar 2019 05:43:23 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c8898790000>; Tue, 12 Mar 2019 22:43:23 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 2/2] dmaengine: tegra210-adma: update system sleep callbacks
Date:   Wed, 13 Mar 2019 11:13:14 +0530
Message-ID: <1552455794-24946-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552455794-24946-1-git-send-email-spujar@nvidia.com>
References: <1552455794-24946-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552455792; bh=k9ehGwwejEf14UMGn+UZBswSlpSM6nXosszfnU2vyUk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=BL9sEj0ZrnS5j7wXidy2YOvRTNc8HzBQgOPG2LzkyZrH0huOrndCntdG8OSVyPX9o
         o2Q6yIciKmUXvW0Fx7P4Kf0HY3n/Hrr4yhMor76QhCMOb1WCzu6CXzeWivMTl/16YW
         ZGzYZ/m11FDsxzx2JpzIAMy+SlbhE+O+Jnw3HbBf4tQsV2gYMYEe3LuuDA9cntLGUy
         jfIjSg+4F1HeSWW1ktaiKoPsLeOqXNz0yJxUINn8fI/8BbDd4HgvBt1Pb2y0APg6Hm
         K2neBEtxa6GSXA3BXHAhdEUCvF7KCC7ysSidYGEQpE11ZhdhEbOtlDdU19i8J0J8nf
         QGOkSjTbnPO5w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the driver is active till late suspend, where runtime PM cannot run,
force suspend is essential in such case to put the device in low power
state. Thus pm_runtime_force_suspend and pm_runtime_force_resume are
used as system sleep callbacks during system wide PM transitions.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 650cd9c..be29171 100644
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
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 static struct platform_driver tegra_admac_driver = {
-- 
2.7.4

