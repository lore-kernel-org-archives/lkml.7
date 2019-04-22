Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4F7C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E174C21905
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962385;
	bh=SYXSczzpGuOW/A27+PQSyngiYCRFC1ygmSahEGORUXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uIDF0A1j2HS/Wdg3zdi3XZODuiDOfwlNLSbKIYUTnBO07skGiajVwzVjAt6YD9BMQ
	 F3E8/SlfFJz0+2p+EL/E4e+mLODKVUq2L7/9qcF0/V1CrZSs8QGqstwFwwiuTZqU2x
	 sPkXxzJ3LnyIXkYafrHBNHpKJ3VqIHKJJcQi/H18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfDVTqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729957AbfDVTqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:46:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2D7421901;
        Mon, 22 Apr 2019 19:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962377;
        bh=SYXSczzpGuOW/A27+PQSyngiYCRFC1ygmSahEGORUXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2uy+HWHcZnPuu/WvlIbtTpA06uRvb1F9y/H9j4oalmTbaIMGFS48eH54AOKjzRoZj
         XFozU9d2PQhEtztfgZbfMEDhfMWMQfvVEBYhJ1r44MSnxVPMn/bwVHtk5ZghDr73Iy
         CIXIfpbDwnjTFndsjrxEeLZFkGs/SI0a1dpF4wiQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>, Frank Pavlic <f.pavlic@kunbus.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Tristram Ha <Tristram.Ha@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 29/68] net: ks8851: Delay requesting IRQ until opened
Date:   Mon, 22 Apr 2019 15:44:37 -0400
Message-Id: <20190422194516.11634-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit d268f31552794abf5b6aa5af31021643411f25f5 ]

The ks8851 driver currently requests the IRQ before registering the
net_device.  Because the net_device name is used as IRQ name and is
still "eth%d" when the IRQ is requested, it's impossibe to tell IRQs
apart if multiple ks8851 chips are present.  Most other drivers delay
requesting the IRQ until the net_device is opened.  Do the same.

The driver doesn't enable interrupts on the chip before opening the
net_device and disables them when closing it, so there doesn't seem to
be a need to request the IRQ already on probe.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Frank Pavlic <f.pavlic@kunbus.de>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Tristram Ha <Tristram.Ha@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/micrel/ks8851.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851.c b/drivers/net/ethernet/micrel/ks8851.c
index 1633fa5c709c..c9faec4c5b25 100644
--- a/drivers/net/ethernet/micrel/ks8851.c
+++ b/drivers/net/ethernet/micrel/ks8851.c
@@ -785,6 +785,15 @@ static void ks8851_tx_work(struct work_struct *work)
 static int ks8851_net_open(struct net_device *dev)
 {
 	struct ks8851_net *ks = netdev_priv(dev);
+	int ret;
+
+	ret = request_threaded_irq(dev->irq, NULL, ks8851_irq,
+				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+				   dev->name, ks);
+	if (ret < 0) {
+		netdev_err(dev, "failed to get irq\n");
+		return ret;
+	}
 
 	/* lock the card, even if we may not actually be doing anything
 	 * else at the moment */
@@ -899,6 +908,8 @@ static int ks8851_net_stop(struct net_device *dev)
 		dev_kfree_skb(txb);
 	}
 
+	free_irq(dev->irq, ks);
+
 	return 0;
 }
 
@@ -1529,14 +1540,6 @@ static int ks8851_probe(struct spi_device *spi)
 	ks8851_read_selftest(ks);
 	ks8851_init_mac(ks);
 
-	ret = request_threaded_irq(spi->irq, NULL, ks8851_irq,
-				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-				   ndev->name, ks);
-	if (ret < 0) {
-		dev_err(&spi->dev, "failed to get irq\n");
-		goto err_irq;
-	}
-
 	ret = register_netdev(ndev);
 	if (ret) {
 		dev_err(&spi->dev, "failed to register network device\n");
@@ -1549,11 +1552,7 @@ static int ks8851_probe(struct spi_device *spi)
 
 	return 0;
 
-
 err_netdev:
-	free_irq(ndev->irq, ks);
-
-err_irq:
 err_id:
 	if (gpio_is_valid(gpio))
 		gpio_set_value(gpio, 0);
@@ -1574,7 +1573,6 @@ static int ks8851_remove(struct spi_device *spi)
 		dev_info(&spi->dev, "remove\n");
 
 	unregister_netdev(priv->netdev);
-	free_irq(spi->irq, priv);
 	if (gpio_is_valid(priv->gpio))
 		gpio_set_value(priv->gpio, 0);
 	regulator_disable(priv->vdd_reg);
-- 
2.19.1

