Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C811C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B8D21479
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dbwlt4du"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDZRNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:13:04 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37422 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfDZRND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:13:03 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3QHCwZn105167;
        Fri, 26 Apr 2019 12:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556298778;
        bh=Tj8olacDYfKcF5PnqXI2on8sVfvgWdBZkNzjcXWmEn0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dbwlt4du4jdx2qBZ4hOAs1r4a3RdPIF9O8ZRhM8pXtP8EE9xj/Wj36opSWUZebWO3
         wh96RdMQlvxDeaZKA9VNDW348Tb2YaFe95pwsK9kYIXdsicQPTi8VIVeiE+IOCUxN6
         LSvM3Tjtr+pjMiCl4OhhpxzfrD9NgRU7/LQ8cpJA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3QHCwpr122746
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Apr 2019 12:12:58 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 26
 Apr 2019 12:12:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 26 Apr 2019 12:12:58 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3QHCvQv019320;
        Fri, 26 Apr 2019 12:12:58 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next v2 07/20] net: ethernet: ti: cpsw: use devm_alloc_etherdev_mqs()
Date:   Fri, 26 Apr 2019 20:12:29 +0300
Message-ID: <1556298762-8632-8-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_alloc_etherdev_mqs() and simplify code.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index e771e4269af8..ddc259c45481 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -3399,7 +3399,8 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 	struct cpsw_priv		*priv_sl2;
 	int ret = 0;
 
-	ndev = alloc_etherdev_mq(sizeof(struct cpsw_priv), CPSW_MAX_QUEUES);
+	ndev = devm_alloc_etherdev_mqs(cpsw->dev, sizeof(struct cpsw_priv),
+				       CPSW_MAX_QUEUES, CPSW_MAX_QUEUES);
 	if (!ndev) {
 		dev_err(cpsw->dev, "cpsw: error allocating net_device\n");
 		return -ENOMEM;
@@ -3433,11 +3434,8 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 	/* register the network device */
 	SET_NETDEV_DEV(ndev, cpsw->dev);
 	ret = register_netdev(ndev);
-	if (ret) {
+	if (ret)
 		dev_err(cpsw->dev, "cpsw: error registering net device\n");
-		free_netdev(ndev);
-		ret = -ENODEV;
-	}
 
 	return ret;
 }
@@ -3481,7 +3479,8 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	cpsw->dev = dev;
 
-	ndev = alloc_etherdev_mq(sizeof(struct cpsw_priv), CPSW_MAX_QUEUES);
+	ndev = devm_alloc_etherdev_mqs(dev, sizeof(struct cpsw_priv),
+				       CPSW_MAX_QUEUES, CPSW_MAX_QUEUES);
 	if (!ndev) {
 		dev_err(dev, "error allocating net_device\n");
 		return -ENOMEM;
@@ -3499,7 +3498,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	if (IS_ERR(mode)) {
 		ret = PTR_ERR(mode);
 		dev_err(dev, "gpio request failed, ret %d\n", ret);
-		goto clean_ndev_ret;
+		return ret;
 	}
 
 	/*
@@ -3768,8 +3767,6 @@ static int cpsw_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 clean_runtime_disable_ret:
 	pm_runtime_disable(&pdev->dev);
-clean_ndev_ret:
-	free_netdev(priv->ndev);
 	return ret;
 }
 
@@ -3794,9 +3791,6 @@ static int cpsw_remove(struct platform_device *pdev)
 	cpsw_remove_dt(pdev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (cpsw->data.dual_emac)
-		free_netdev(cpsw->slaves[1].ndev);
-	free_netdev(ndev);
 	return 0;
 }
 
-- 
2.17.1

