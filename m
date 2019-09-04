Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A86C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBBB23400
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620341;
	bh=xpTxZ5R8eAcpX66aYu+28hbqAixej81lEhoB0dUZzuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QluALEzDalbSW3yrXuVOqffA/97NCFsHpgH/RR48uGPQi3li1bL6RCfCR0zL7vsuE
	 MpzxcLP08pa4/PTbYiXKd/DBVxojjO2Vz0mMQ0XEmRMT3HbmlKK2N1uiHcL8qxTzZ2
	 v/dSkv0pkhLI0a+pirceHaHu9EclSBotObfaX4EE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbfIDSFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:05:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389282AbfIDSFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:05:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 926862339E;
        Wed,  4 Sep 2019 18:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620337;
        bh=xpTxZ5R8eAcpX66aYu+28hbqAixej81lEhoB0dUZzuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SBxburqJv2LYJ91kCKtHSSppR96afD/fNZStWWaBjaC8Vj59qqZGhPrMiS5zGtLMY
         6UhdP8aFtjp0eJ2AKPq+4dm4uBm8T3u1r+ANfxkmjJRheDOXUydh+cApUtWqrrzCez
         aof2oEpyM+UTLRPL+2WYbBuaEnNOCTLWZpY1+fmo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 20/93] i2c: rcar: avoid race when unregistering slave client
Date:   Wed,  4 Sep 2019 19:53:22 +0200
Message-Id: <20190904175305.072864866@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7b814d852af6944657c2961039f404c4490771c0 ]

After we disabled interrupts, there might still be an active one
running. Sync before clearing the pointer to the slave device.

Fixes: de20d1857dd6 ("i2c: rcar: add slave support")
Reported-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-rcar.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 254e6219e5389..2c29f901d3090 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -139,6 +139,7 @@ struct rcar_i2c_priv {
 	enum dma_data_direction dma_direction;
 
 	struct reset_control *rstc;
+	int irq;
 };
 
 #define rcar_i2c_priv_to_dev(p)		((p)->adap.dev.parent)
@@ -859,9 +860,11 @@ static int rcar_unreg_slave(struct i2c_client *slave)
 
 	WARN_ON(!priv->slave);
 
+	/* disable irqs and ensure none is running before clearing ptr */
 	rcar_i2c_write(priv, ICSIER, 0);
 	rcar_i2c_write(priv, ICSCR, 0);
 
+	synchronize_irq(priv->irq);
 	priv->slave = NULL;
 
 	pm_runtime_put(rcar_i2c_priv_to_dev(priv));
@@ -916,7 +919,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	struct i2c_adapter *adap;
 	struct device *dev = &pdev->dev;
 	struct i2c_timings i2c_t;
-	int irq, ret;
+	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(struct rcar_i2c_priv), GFP_KERNEL);
 	if (!priv)
@@ -979,10 +982,10 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 		pm_runtime_put(dev);
 
 
-	irq = platform_get_irq(pdev, 0);
-	ret = devm_request_irq(dev, irq, rcar_i2c_irq, 0, dev_name(dev), priv);
+	priv->irq = platform_get_irq(pdev, 0);
+	ret = devm_request_irq(dev, priv->irq, rcar_i2c_irq, 0, dev_name(dev), priv);
 	if (ret < 0) {
-		dev_err(dev, "cannot get irq %d\n", irq);
+		dev_err(dev, "cannot get irq %d\n", priv->irq);
 		goto out_pm_disable;
 	}
 
-- 
2.20.1



