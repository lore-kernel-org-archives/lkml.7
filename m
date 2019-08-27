Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0F5C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52E5217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892617;
	bh=S8JjfVYWj8GNl81S43xPKJ2MQsUpVoI1He3XTJrV6DI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XI2iVMKw1XX9WTVjL7kYfG1ruEbhYMmo604Z3ac5BAjecuGJl9o4dF1Pu4sBNQdzo
	 Nh9W77lLHkCq1LFFWd+/TbZGftwcT9EpRIrJ7WFgYDPBPePry0a4Fu8A20pJgKP8jW
	 TmkEeokffzVWZ/ebJw1oopj1ejrGGjiZu5RLyei8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbfH0H44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730146AbfH0H4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:56:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA415206BA;
        Tue, 27 Aug 2019 07:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892610;
        bh=S8JjfVYWj8GNl81S43xPKJ2MQsUpVoI1He3XTJrV6DI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tEZ4ndF8cPYe1hb8nuQyXLgAIoZ8Q/VxNCKtoKCB0XoZkNPDdAsnikTxgpIaGHjgD
         IVIqHClf8GOFYqhxurnQbxXApH9DbPCry6vhFzLwxqvEEIC2WBkfoWmU1l+K+u9Esz
         FkChSfigxN4JBMPVmLkW7457UYMXjh18v/sSOCEI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Weitao Hou <houweitaoo@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 12/98] can: mcp251x: add error check when wq alloc failed
Date:   Tue, 27 Aug 2019 09:49:51 +0200
Message-Id: <20190827072718.993836992@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 375f755899b8fc21196197e02aab26257df26e85 ]

add error check when workqueue alloc failed, and remove redundant code
to make it clear.

Fixes: e0000163e30e ("can: Driver for the Microchip MCP251x SPI CAN controllers")
Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Tested-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/spi/mcp251x.c | 49 ++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index da64e71a62ee2..fccb6bf21fada 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -678,17 +678,6 @@ static int mcp251x_power_enable(struct regulator *reg, int enable)
 		return regulator_disable(reg);
 }
 
-static void mcp251x_open_clean(struct net_device *net)
-{
-	struct mcp251x_priv *priv = netdev_priv(net);
-	struct spi_device *spi = priv->spi;
-
-	free_irq(spi->irq, priv);
-	mcp251x_hw_sleep(spi);
-	mcp251x_power_enable(priv->transceiver, 0);
-	close_candev(net);
-}
-
 static int mcp251x_stop(struct net_device *net)
 {
 	struct mcp251x_priv *priv = netdev_priv(net);
@@ -954,37 +943,43 @@ static int mcp251x_open(struct net_device *net)
 				   flags | IRQF_ONESHOT, DEVICE_NAME, priv);
 	if (ret) {
 		dev_err(&spi->dev, "failed to acquire irq %d\n", spi->irq);
-		mcp251x_power_enable(priv->transceiver, 0);
-		close_candev(net);
-		goto open_unlock;
+		goto out_close;
 	}
 
 	priv->wq = alloc_workqueue("mcp251x_wq", WQ_FREEZABLE | WQ_MEM_RECLAIM,
 				   0);
+	if (!priv->wq) {
+		ret = -ENOMEM;
+		goto out_clean;
+	}
 	INIT_WORK(&priv->tx_work, mcp251x_tx_work_handler);
 	INIT_WORK(&priv->restart_work, mcp251x_restart_work_handler);
 
 	ret = mcp251x_hw_reset(spi);
-	if (ret) {
-		mcp251x_open_clean(net);
-		goto open_unlock;
-	}
+	if (ret)
+		goto out_free_wq;
 	ret = mcp251x_setup(net, spi);
-	if (ret) {
-		mcp251x_open_clean(net);
-		goto open_unlock;
-	}
+	if (ret)
+		goto out_free_wq;
 	ret = mcp251x_set_normal_mode(spi);
-	if (ret) {
-		mcp251x_open_clean(net);
-		goto open_unlock;
-	}
+	if (ret)
+		goto out_free_wq;
 
 	can_led_event(net, CAN_LED_EVENT_OPEN);
 
 	netif_wake_queue(net);
+	mutex_unlock(&priv->mcp_lock);
 
-open_unlock:
+	return 0;
+
+out_free_wq:
+	destroy_workqueue(priv->wq);
+out_clean:
+	free_irq(spi->irq, priv);
+	mcp251x_hw_sleep(spi);
+out_close:
+	mcp251x_power_enable(priv->transceiver, 0);
+	close_candev(net);
 	mutex_unlock(&priv->mcp_lock);
 	return ret;
 }
-- 
2.20.1



