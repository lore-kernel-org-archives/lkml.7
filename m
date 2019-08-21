Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DF4C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265BE22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfHUNFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:05:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56542 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbfHUNFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:05:31 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E95078B02D24C510BD64;
        Wed, 21 Aug 2019 21:05:20 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 21 Aug 2019
 21:05:14 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <ynezz@true.cz>, <tglx@linutronix.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] ezchip: nps_enet: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 21 Aug 2019 21:05:09 +0800
Message-ID: <20190821130509.71916-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/ezchip/nps_enet.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ezchip/nps_enet.c b/drivers/net/ethernet/ezchip/nps_enet.c
index 027225e..815fb62 100644
--- a/drivers/net/ethernet/ezchip/nps_enet.c
+++ b/drivers/net/ethernet/ezchip/nps_enet.c
@@ -576,7 +576,6 @@ static s32 nps_enet_probe(struct platform_device *pdev)
 	struct nps_enet_priv *priv;
 	s32 err = 0;
 	const char *mac_addr;
-	struct resource *res_regs;
 
 	if (!dev->of_node)
 		return -ENODEV;
@@ -595,8 +594,7 @@ static s32 nps_enet_probe(struct platform_device *pdev)
 	/* FIXME :: no multicast support yet */
 	ndev->flags &= ~IFF_MULTICAST;
 
-	res_regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs_base = devm_ioremap_resource(dev, res_regs);
+	priv->regs_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->regs_base)) {
 		err = PTR_ERR(priv->regs_base);
 		goto out_netdev;
-- 
2.7.4


