Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37ABC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85975206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403777AbfIZGf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 02:35:26 -0400
Received: from mx.socionext.com ([202.248.49.38]:23324 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388934AbfIZGf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 02:35:26 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 26 Sep 2019 15:35:25 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 99B90605F8;
        Thu, 26 Sep 2019 15:35:25 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 26 Sep 2019 15:35:25 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 6BA071A0E9F;
        Thu, 26 Sep 2019 15:35:25 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net] net: socionext: ave: Avoid using netdev_err() before calling register_netdev()
Date:   Thu, 26 Sep 2019 15:35:10 +0900
Message-Id: <1569479710-32314-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until calling register_netdev(), ndev->dev_name isn't specified, and
netdev_err() displays "(unnamed net_device)".

    ave 65000000.ethernet (unnamed net_device) (uninitialized): invalid phy-mode setting
    ave: probe of 65000000.ethernet failed with error -22

This replaces netdev_err() with dev_err() before calling register_netdev().

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/socionext/sni_ave.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 10d0c3e..f20f6c4 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1662,19 +1662,19 @@ static int ave_probe(struct platform_device *pdev)
 					       "socionext,syscon-phy-mode",
 					       1, 0, &args);
 	if (ret) {
-		netdev_err(ndev, "can't get syscon-phy-mode property\n");
+		dev_err(dev, "can't get syscon-phy-mode property\n");
 		goto out_free_netdev;
 	}
 	priv->regmap = syscon_node_to_regmap(args.np);
 	of_node_put(args.np);
 	if (IS_ERR(priv->regmap)) {
-		netdev_err(ndev, "can't map syscon-phy-mode\n");
+		dev_err(dev, "can't map syscon-phy-mode\n");
 		ret = PTR_ERR(priv->regmap);
 		goto out_free_netdev;
 	}
 	ret = priv->data->get_pinmode(priv, phy_mode, args.args[0]);
 	if (ret) {
-		netdev_err(ndev, "invalid phy-mode setting\n");
+		dev_err(dev, "invalid phy-mode setting\n");
 		goto out_free_netdev;
 	}
 
-- 
2.7.4

