Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7DAC5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 17:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28C220665
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 17:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uM/mKdfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfF3RYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 13:24:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40891 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfF3RYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 13:24:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id a21so10637799ljh.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uUkBROZO3WakB4095Sqlp9gekMGTEEFtZPkRqC6risY=;
        b=uM/mKdfkiRjikWMeGLjOxOlcNobeB2PCrFWOmSy/QtV7Zsq52w/Gy5oRsJqd9UggZx
         Lyqbs6ExkSsMzUjJETRoZDJXY9pMe1ZkHXh/R1sIIz8bLDB25qSz6F4DaVH7AV5+sHfv
         1f0baQOqGfw+PBMOv5dADsX+o3W+3Q9pVXtJZxc0JuS1lbsjXcAFAZwrnrTpSlBFh9XV
         J2uFs9tD8k66Q4XIjckj4WN9swTcCRH6y+n3LDHz0PrNP039e8YF3jWW6Js07RE7n/UE
         FuQufsOTvvgpChK2FKg0yDTuMqfV83AS8PjQfDie2BCSoqab9kPy56ScG9/FrQEDHLmq
         SDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uUkBROZO3WakB4095Sqlp9gekMGTEEFtZPkRqC6risY=;
        b=qD/BacL/iZyF84nXZ8YS1UXw9WayOw0MYUMr4QQ0rrWNlJddDXalKnrOlDvKFgInf8
         H3FwZr/05oH/qdRAS+xRkdHxRCXLdFkr1ZbuuNDLPJa0vRKcYdiR62jLDIttO5W3MbQd
         WXDsDhggYSzicvMnkDGSdkH6olAwb3FdjEw5mvnX7TPjaXTn7Kbrll8Tpaq+JDqd9a8Y
         ftAwK07lO1aYLlAMCmpMBQpNftip1fTIDhiQ6POcfmLwKh2U3KAQoEB982EbtpzreGwK
         Zf5MVb2koly1Jv9ealQsfnQ8laVgc8Sz6RuoHuSsMjTuQ5NCKvdE5sST1D3FS3r9VwuR
         FrTw==
X-Gm-Message-State: APjAAAVOnuZ+jBGAjx798a10OlK3cw3M3/nILu7fRBw9+knp8MEmf+yr
        zqnLJfGelK8DPdUPMjIkbw0pqA==
X-Google-Smtp-Source: APXvYqwsL8R2TVbeV5aEhdmMQehA9L7CU1wJdpURGN5CoaeB4uTTKPZJDGH0IasikzP5ayeCPqfpow==
X-Received: by 2002:a2e:740a:: with SMTP id p10mr7897078ljc.19.1561915462387;
        Sun, 30 Jun 2019 10:24:22 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id c1sm2273795lfh.13.2019.06.30.10.24.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 10:24:21 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 net-next 4/6] net: ethernet: ti: davinci_cpdma: allow desc split while down
Date:   Sun, 30 Jun 2019 20:23:46 +0300
Message-Id: <20190630172348.5692-5-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190630172348.5692-1-ivan.khoronzhuk@linaro.org>
References: <20190630172348.5692-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's possible to set ring params while interfaces are down. When
interface gets up it uses number of descs to fill rx queue and on
later on changes to create rx pools. Usually, this resplit can happen
after phy is up, but it can be needed before this, so allow it to
happen while setting number of rx descs, when interfaces are down.
Also, if no dependency on intf state, move it to cpdma layer, where
it should be.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw_ethtool.c  |  9 ++++-----
 drivers/net/ethernet/ti/davinci_cpdma.c | 10 +++++++++-
 drivers/net/ethernet/ti/davinci_cpdma.h |  3 +--
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ethtool.c b/drivers/net/ethernet/ti/cpsw_ethtool.c
index 7c19eebbabcc..6ab0cec8560a 100644
--- a/drivers/net/ethernet/ti/cpsw_ethtool.c
+++ b/drivers/net/ethernet/ti/cpsw_ethtool.c
@@ -664,15 +664,14 @@ int cpsw_set_ringparam(struct net_device *ndev,
 
 	cpsw_suspend_data_pass(ndev);
 
-	cpdma_set_num_rx_descs(cpsw->dma, ering->rx_pending);
-
-	if (cpsw->usage_count)
-		cpdma_chan_split_pool(cpsw->dma);
+	ret = cpdma_set_num_rx_descs(cpsw->dma, ering->rx_pending);
+	if (ret)
+		goto err;
 
 	ret = cpsw_resume_data_pass(ndev);
 	if (!ret)
 		return 0;
-
+err:
 	dev_err(cpsw->dev, "cannot set ring params, closing device\n");
 	dev_close(ndev);
 	return ret;
diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index ea25b23c8058..7dc2c1ee6238 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -1427,8 +1427,16 @@ int cpdma_get_num_tx_descs(struct cpdma_ctlr *ctlr)
 	return ctlr->num_tx_desc;
 }
 
-void cpdma_set_num_rx_descs(struct cpdma_ctlr *ctlr, int num_rx_desc)
+int cpdma_set_num_rx_descs(struct cpdma_ctlr *ctlr, int num_rx_desc)
 {
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&ctlr->lock, flags);
 	ctlr->num_rx_desc = num_rx_desc;
 	ctlr->num_tx_desc = ctlr->pool->num_desc - ctlr->num_rx_desc;
+	ret = cpdma_chan_split_pool(ctlr);
+	spin_unlock_irqrestore(&ctlr->lock, flags);
+
+	return ret;
 }
diff --git a/drivers/net/ethernet/ti/davinci_cpdma.h b/drivers/net/ethernet/ti/davinci_cpdma.h
index aafa8889c789..df66b8c797ee 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.h
+++ b/drivers/net/ethernet/ti/davinci_cpdma.h
@@ -116,8 +116,7 @@ enum cpdma_control {
 int cpdma_control_get(struct cpdma_ctlr *ctlr, int control);
 int cpdma_control_set(struct cpdma_ctlr *ctlr, int control, int value);
 int cpdma_get_num_rx_descs(struct cpdma_ctlr *ctlr);
-void cpdma_set_num_rx_descs(struct cpdma_ctlr *ctlr, int num_rx_desc);
+int cpdma_set_num_rx_descs(struct cpdma_ctlr *ctlr, int num_rx_desc);
 int cpdma_get_num_tx_descs(struct cpdma_ctlr *ctlr);
-int cpdma_chan_split_pool(struct cpdma_ctlr *ctlr);
 
 #endif
-- 
2.17.1

