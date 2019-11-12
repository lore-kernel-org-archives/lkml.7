Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D10C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 03:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20CE2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 03:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfKLDts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 22:49:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60830 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726923AbfKLDts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 22:49:48 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 72B4782E77B507D15B6E;
        Tue, 12 Nov 2019 11:49:46 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 12 Nov 2019
 11:49:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jk@ozlabs.org>, <joel@jms.id.au>, <eajames@linux.ibm.com>,
        <andrew@aj.id.au>, <linux@roeck-us.net>
CC:     <alistair@popple.id.au>, <linux-fsi@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v3 -next] fsi: aspeed: Fix aspeed device free
Date:   Tue, 12 Nov 2019 11:47:44 +0800
Message-ID: <20191112034744.10180-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20191109033634.30544-1-yuehaibing@huawei.com>
References: <20191109033634.30544-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'aspeed' is allocted by devm_kfree(), it should not be kfree().
In fact it will be freed while the device released.
Also we grap reference after fsi_master_register() success,
so should put it in fsi_master_aspeed_remove().

Fixes: 1edac1269c02 ("fsi: Add ast2600 master driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v3: remove unneeded release() and put last reference
v2: fix log typos
---
 drivers/fsi/fsi-master-aspeed.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index f49742b..01a7f24 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -350,14 +350,6 @@ static int aspeed_master_break(struct fsi_master *master, int link)
 	return aspeed_master_write(master, link, 0, addr, &cmd, 4);
 }
 
-static void aspeed_master_release(struct device *dev)
-{
-	struct fsi_master_aspeed *aspeed =
-		to_fsi_master_aspeed(dev_to_fsi_master(dev));
-
-	kfree(aspeed);
-}
-
 /* mmode encoders */
 static inline u32 fsi_mmode_crs0(u32 x)
 {
@@ -483,7 +475,6 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "hub version %08x (%d links)\n", reg, links);
 
 	aspeed->master.dev.parent = &pdev->dev;
-	aspeed->master.dev.release = aspeed_master_release;
 	aspeed->master.dev.of_node = of_node_get(dev_of_node(&pdev->dev));
 
 	aspeed->master.n_links = links;
@@ -522,6 +513,7 @@ static int fsi_master_aspeed_remove(struct platform_device *pdev)
 
 	fsi_master_unregister(&aspeed->master);
 	clk_disable_unprepare(aspeed->clk);
+	put_device(&aspeed->master.dev);
 
 	return 0;
 }
-- 
2.7.4


