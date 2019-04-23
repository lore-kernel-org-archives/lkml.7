Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4D9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB4821738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfDWHlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:41:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726718AbfDWHkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:40:25 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 534EB15614CA2AE89A38;
        Tue, 23 Apr 2019 15:40:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Apr 2019 15:40:13 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
Subject: [PATCH next 19/25] net: calxedaxgmac: Use dev_get_drvdata()
Date:   Tue, 23 Apr 2019 15:50:14 +0800
Message-ID: <20190423075020.173734-20-wangkefeng.wang@huawei.com>
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

Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/net/ethernet/calxeda/xgmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
index 13741ee49b9b..a71390c7c9de 100644
--- a/drivers/net/ethernet/calxeda/xgmac.c
+++ b/drivers/net/ethernet/calxeda/xgmac.c
@@ -1866,7 +1866,7 @@ static void xgmac_pmt(void __iomem *ioaddr, unsigned long mode)
 
 static int xgmac_suspend(struct device *dev)
 {
-	struct net_device *ndev = platform_get_drvdata(to_platform_device(dev));
+	struct net_device *ndev = dev_get_drvdata(dev);
 	struct xgmac_priv *priv = netdev_priv(ndev);
 	u32 value;
 
@@ -1892,7 +1892,7 @@ static int xgmac_suspend(struct device *dev)
 
 static int xgmac_resume(struct device *dev)
 {
-	struct net_device *ndev = platform_get_drvdata(to_platform_device(dev));
+	struct net_device *ndev = dev_get_drvdata(dev);
 	struct xgmac_priv *priv = netdev_priv(ndev);
 	void __iomem *ioaddr = priv->base;
 
-- 
2.20.1

