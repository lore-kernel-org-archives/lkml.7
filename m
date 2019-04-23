Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D4CC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796C321738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfDWHlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:41:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7227 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726503AbfDWHkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:40:25 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4D8709554B718190BC2D;
        Tue, 23 Apr 2019 15:40:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Apr 2019 15:40:11 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH next 17/25] mmc: omap_hsmmc: Use dev_get_drvdata()
Date:   Tue, 23 Apr 2019 15:50:12 +0800
Message-ID: <20190423075020.173734-18-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_get_drvdata directly.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/mmc/host/omap_hsmmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 29a1ddaa7466..952fa4063ff8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2077,7 +2077,7 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 	unsigned long flags;
 	int ret = 0;
 
-	host = platform_get_drvdata(to_platform_device(dev));
+	host = dev_get_drvdata(dev);
 	omap_hsmmc_context_save(host);
 	dev_dbg(dev, "disabled\n");
 
@@ -2118,7 +2118,7 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 	struct omap_hsmmc_host *host;
 	unsigned long flags;
 
-	host = platform_get_drvdata(to_platform_device(dev));
+	host = dev_get_drvdata(dev);
 	omap_hsmmc_context_restore(host);
 	dev_dbg(dev, "enabled\n");
 
-- 
2.20.1

