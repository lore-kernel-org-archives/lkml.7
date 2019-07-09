Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79354C606D8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DB221707
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfGIIdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 04:33:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55562 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbfGIIdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 04:33:19 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 86E573B8373AE9BD1C22;
        Tue,  9 Jul 2019 16:33:14 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 9 Jul 2019
 16:33:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>, <thierry.reding@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] dmaengine: tegra210-adma: Fix unused function warnings
Date:   Tue, 9 Jul 2019 16:32:58 +0800
Message-ID: <20190709083258.57112-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PM is not set, build warnings:

drivers/dma/tegra210-adma.c:747:12: warning: tegra_adma_runtime_resume defined but not used [-Wunused-function]
 static int tegra_adma_runtime_resume(struct device *dev)
drivers/dma/tegra210-adma.c:715:12: warning: tegra_adma_runtime_suspend defined but not used [-Wunused-function]
 static int tegra_adma_runtime_suspend(struct device *dev)

Mark the two function as __maybe_unused.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/dma/tegra210-adma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 2805853..b33cf6e 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -712,7 +712,7 @@ static struct dma_chan *tegra_dma_of_xlate(struct of_phandle_args *dma_spec,
 	return chan;
 }
 
-static int tegra_adma_runtime_suspend(struct device *dev)
+static int __maybe_unused tegra_adma_runtime_suspend(struct device *dev)
 {
 	struct tegra_adma *tdma = dev_get_drvdata(dev);
 	struct tegra_adma_chan_regs *ch_reg;
@@ -744,7 +744,7 @@ static int tegra_adma_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_adma_runtime_resume(struct device *dev)
+static int __maybe_unused tegra_adma_runtime_resume(struct device *dev)
 {
 	struct tegra_adma *tdma = dev_get_drvdata(dev);
 	struct tegra_adma_chan_regs *ch_reg;
-- 
2.7.4


