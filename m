Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD9FC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEDC206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vh/0vicG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfDWNJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:09:32 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58106 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfDWNJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:09:30 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3ND9QuY066407;
        Tue, 23 Apr 2019 08:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556024966;
        bh=C7eS500OVaMb2VSktLxrUDNDB3N2S7eX6aau3ZJA4U0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Vh/0vicG+MShQ+guXN0VUf7U2bXsn99pyUP1cs1Du5BOMW4OP1agT3+nPSfnDOdNv
         tVzE37DanrqsicGD7f0fuSq24psF6vAbFk41e/gyixa3slV3EAubmV2RsWrYYpdtXT
         AlZAzvk2PcJ0giU29ABeCVPeBeZBFxx0zUeg5CA8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3ND9QVi096635
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Apr 2019 08:09:26 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 23
 Apr 2019 08:09:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 23 Apr 2019 08:09:25 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3ND9Pxm126123;
        Tue, 23 Apr 2019 08:09:25 -0500
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
Subject: [PATCH net-next 07/19] net: ethernet: ti: cpsw: use devm_alloc_etherdev_mqs()
Date:   Tue, 23 Apr 2019 16:08:58 +0300
Message-ID: <1556024950-20752-8-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_alloc_etherdev_mqs() and simplify code.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 17dd81f25f5e..e714b8f4739c 100644
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

