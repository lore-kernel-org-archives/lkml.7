Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5194FC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0D421479
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PwGzKxwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfDZRNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:13:00 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47730 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfDZRM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:12:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3QHCrlW072438;
        Fri, 26 Apr 2019 12:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556298773;
        bh=hCuf3Uiz/AsLm5/G1pS3m+C5sg9iKfKUfjlQJUQubwI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PwGzKxwVYOSpqW+HaM8ypeGIRpvwvtLfo9q2IX7i5IMGXmcE+CjSc7MMHoL9z/a3D
         IH9xq+g4bkRXKiNWohwLLLKDrAJNxd/6G1GUX5G3mJo8DfVwds16kybpEDZxBQAE8q
         6ycjwkb+qDXSueeXb/3nqIjsjbF5ouObkreTY7sg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3QHCri5029611
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Apr 2019 12:12:53 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 26
 Apr 2019 12:12:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 26 Apr 2019 12:12:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3QHCpZh117788;
        Fri, 26 Apr 2019 12:12:52 -0500
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
Subject: [PATCH net-next v2 04/20] net: ethernet: ti: cpsw: update cpsw_split_res() to accept cpsw_common
Date:   Fri, 26 Apr 2019 20:12:26 +0300
Message-ID: <1556298762-8632-5-git-send-email-grygorii.strashko@ti.com>
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

Update cpsw_split_res() to accept struct cpsw_common instead of
struct net_device to simplify code.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 1c04c16e279b..13a339c64892 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -963,11 +963,9 @@ static void cpsw_rx_handler(void *token, int len, int status)
 		dev_kfree_skb_any(new_skb);
 }
 
-static void cpsw_split_res(struct net_device *ndev)
+static void cpsw_split_res(struct cpsw_common *cpsw)
 {
-	struct cpsw_priv *priv = netdev_priv(ndev);
 	u32 consumed_rate = 0, bigest_rate = 0;
-	struct cpsw_common *cpsw = priv->cpsw;
 	struct cpsw_vector *txv = cpsw->txv;
 	int i, ch_weight, rlim_ch_num = 0;
 	int budget, bigest_rate_ch = 0;
@@ -1341,7 +1339,7 @@ static void cpsw_adjust_link(struct net_device *ndev)
 
 	if (link) {
 		if (cpsw_need_resplit(cpsw))
-			cpsw_split_res(ndev);
+			cpsw_split_res(cpsw);
 
 		netif_carrier_on(ndev);
 		if (netif_running(ndev))
@@ -2107,7 +2105,7 @@ static int cpsw_ndo_stop(struct net_device *ndev)
 	for_each_slave(priv, cpsw_slave_stop, cpsw);
 
 	if (cpsw_need_resplit(cpsw))
-		cpsw_split_res(ndev);
+		cpsw_split_res(cpsw);
 
 	cpsw->usage_count--;
 	pm_runtime_put_sync(cpsw->dev);
@@ -2594,7 +2592,7 @@ static int cpsw_ndo_set_tx_maxrate(struct net_device *ndev, int queue, u32 rate)
 		netdev_get_tx_queue(slave->ndev, queue)->tx_maxrate = rate;
 	}
 
-	cpsw_split_res(ndev);
+	cpsw_split_res(cpsw);
 	return ret;
 }
 
@@ -3063,7 +3061,7 @@ static int cpsw_set_channels(struct net_device *ndev,
 	}
 
 	if (cpsw->usage_count)
-		cpsw_split_res(ndev);
+		cpsw_split_res(cpsw);
 
 	ret = cpsw_resume_data_pass(ndev);
 	if (!ret)
@@ -3698,7 +3696,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	netif_tx_napi_add(ndev, &cpsw->napi_tx,
 			  cpsw->quirk_irq ? cpsw_tx_poll : cpsw_tx_mq_poll,
 			  CPSW_POLL_WEIGHT);
-	cpsw_split_res(ndev);
+	cpsw_split_res(cpsw);
 
 	/* register the network device */
 	SET_NETDEV_DEV(ndev, &pdev->dev);
-- 
2.17.1

