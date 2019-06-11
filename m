Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F185AC31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CEF20874
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PobiPbYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407825AbfFKV7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:59:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43858 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407763AbfFKV7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:59:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id j29so10455002lfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Zzu+iigGnljTNLpw4PV21/NpwXZqBVj44MZDZpMBu9k=;
        b=PobiPbYcny3WgIyxrQehAN1nsvHHczEh4rKLhjhpRUHi5oP2JXevAQTzCNmyXPtkOJ
         uAD+t9JOexPIFCh64sfCV9FtaD6iUetrcyogT28F7NvlRqrI6n2zAqm4dtu+VlvIBR3a
         gyZvO2JwZbHansH5cVDh6Z6jYRq3yM/oVxR9BYZ8JrW69pUHdF4W/B5Ql4r1Gr80X/AJ
         IdOD3Ocdd6FDE87CL1PtMIcDU97zcS2vEGZ1mLJkzAjczvHpU3Cy7iQUTaPL38rNU5Pa
         aLUFeipC7MS8JcjaqgSjwUMQmDg5p17vONbyE1a+ivXjuxvCaaxKfcTEQFHNk9jrBrVZ
         Km5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Zzu+iigGnljTNLpw4PV21/NpwXZqBVj44MZDZpMBu9k=;
        b=n/AWVBey6Xi0tCRKqRK41ytz4WxfMzk+YKDE0mx4KrvaaC07ybQyY/HyCaXi+S9Y66
         HTE2ILJWmtwHE3LlxSW/PmAs8nLX+xBG0VTo24PW4M/cNwXo3N2zAhgFuWhEjtyuguJ2
         7BoDPGlsSqqwb3dNbwpCZVtz3+67BqouKxqdaUve9mCrJkIDAmVopaf5oVHhmRMnHHOf
         Zh2MiNDf7LrQuM6KzGvz44tRM9dxOrLEipifVJO5EWOLH+irrFcdB0StN3u1RXLga0fI
         gDhF2DLGrIYGRH2Pb3fmlS/PhYsvSBg28HuTCFngew5RPY2BFyXEw7zOHIsyIVKIc/sd
         wKDQ==
X-Gm-Message-State: APjAAAXQqw7hDuW8BoHlvpTt3/oj4HhDSe1/QzLaLznjNAQi3mRKak55
        iKkzjcbJngw/NJCQ8ub9hFjzvw==
X-Google-Smtp-Source: APXvYqxROsgLEagJ8cL2DRxT+ztHYQ7QT2V+4OlXJGcsDDWEq6cv4mqxmOimauuTlNjm9dvfY5hkxQ==
X-Received: by 2002:ac2:4466:: with SMTP id y6mr11979289lfl.0.1560290382773;
        Tue, 11 Jun 2019 14:59:42 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id u10sm3339653lfu.18.2019.06.11.14.59.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 14:59:42 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] net: ethernet: ti: cpsw_ethtool: simplify slave loops
Date:   Wed, 12 Jun 2019 00:59:40 +0300
Message-Id: <20190611215940.32359-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only for consistency reasons, do it like in main cpsw.c module
and use ndev reference but not by means of slave.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on net-next/master

 drivers/net/ethernet/ti/cpsw_ethtool.c | 40 ++++++++++++++------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ethtool.c b/drivers/net/ethernet/ti/cpsw_ethtool.c
index 6d1c9ebae7cc..86697b32194d 100644
--- a/drivers/net/ethernet/ti/cpsw_ethtool.c
+++ b/drivers/net/ethernet/ti/cpsw_ethtool.c
@@ -458,7 +458,6 @@ int cpsw_nway_reset(struct net_device *ndev)
 static void cpsw_suspend_data_pass(struct net_device *ndev)
 {
 	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
-	struct cpsw_slave *slave;
 	int i;
 
 	/* Disable NAPI scheduling */
@@ -467,12 +466,13 @@ static void cpsw_suspend_data_pass(struct net_device *ndev)
 	/* Stop all transmit queues for every network device.
 	 * Disable re-using rx descriptors with dormant_on.
 	 */
-	for (i = cpsw->data.slaves, slave = cpsw->slaves; i; i--, slave++) {
-		if (!(slave->ndev && netif_running(slave->ndev)))
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		ndev = cpsw->slaves[i].ndev;
+		if (!(ndev && netif_running(ndev)))
 			continue;
 
-		netif_tx_stop_all_queues(slave->ndev);
-		netif_dormant_on(slave->ndev);
+		netif_tx_stop_all_queues(ndev);
+		netif_dormant_on(ndev);
 	}
 
 	/* Handle rest of tx packets and stop cpdma channels */
@@ -483,13 +483,14 @@ static int cpsw_resume_data_pass(struct net_device *ndev)
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
 	struct cpsw_common *cpsw = priv->cpsw;
-	struct cpsw_slave *slave;
 	int i, ret;
 
 	/* Allow rx packets handling */
-	for (i = cpsw->data.slaves, slave = cpsw->slaves; i; i--, slave++)
-		if (slave->ndev && netif_running(slave->ndev))
-			netif_dormant_off(slave->ndev);
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		ndev = cpsw->slaves[i].ndev;
+		if (ndev && netif_running(ndev))
+			netif_dormant_off(ndev);
+	}
 
 	/* After this receive is started */
 	if (cpsw->usage_count) {
@@ -502,9 +503,11 @@ static int cpsw_resume_data_pass(struct net_device *ndev)
 	}
 
 	/* Resume transmit for every affected interface */
-	for (i = cpsw->data.slaves, slave = cpsw->slaves; i; i--, slave++)
-		if (slave->ndev && netif_running(slave->ndev))
-			netif_tx_start_all_queues(slave->ndev);
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		ndev = cpsw->slaves[i].ndev;
+		if (ndev && netif_running(ndev))
+			netif_tx_start_all_queues(ndev);
+	}
 
 	return 0;
 }
@@ -587,7 +590,7 @@ int cpsw_set_channels_common(struct net_device *ndev,
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
 	struct cpsw_common *cpsw = priv->cpsw;
-	struct cpsw_slave *slave;
+	struct net_device *sl_ndev;
 	int i, ret;
 
 	ret = cpsw_check_ch_settings(cpsw, chs);
@@ -604,20 +607,19 @@ int cpsw_set_channels_common(struct net_device *ndev,
 	if (ret)
 		goto err;
 
-	for (i = cpsw->data.slaves, slave = cpsw->slaves; i; i--, slave++) {
-		if (!(slave->ndev && netif_running(slave->ndev)))
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		sl_ndev = cpsw->slaves[i].ndev;
+		if (!(sl_ndev && netif_running(sl_ndev)))
 			continue;
 
 		/* Inform stack about new count of queues */
-		ret = netif_set_real_num_tx_queues(slave->ndev,
-						   cpsw->tx_ch_num);
+		ret = netif_set_real_num_tx_queues(sl_ndev, cpsw->tx_ch_num);
 		if (ret) {
 			dev_err(priv->dev, "cannot set real number of tx queues\n");
 			goto err;
 		}
 
-		ret = netif_set_real_num_rx_queues(slave->ndev,
-						   cpsw->rx_ch_num);
+		ret = netif_set_real_num_rx_queues(sl_ndev, cpsw->rx_ch_num);
 		if (ret) {
 			dev_err(priv->dev, "cannot set real number of rx queues\n");
 			goto err;
-- 
2.17.1

