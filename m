Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54F7C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26E5218FE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962611;
	bh=VCvzpzNHA8Mxkeqe0+GeYcWhHnGDbbwbY+uaYXjWx8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2e5IfAwvVzazB/qSAHEMcbF332Wpd3WEdk/zsHK21HNerQqZdecWBj834G7DyATay
	 G+mOZKt5Gj55sSKoOteh0jp5RW0eR4rsX58QIupZqLl/EiwWJet2v6fop/zMoJTPLS
	 G7naxaEMg/dnBDNn2MO5W9e+JJBjEBAEGIG84iE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfDVTuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731000AbfDVTuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:50:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EDEE20643;
        Mon, 22 Apr 2019 19:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962604;
        bh=VCvzpzNHA8Mxkeqe0+GeYcWhHnGDbbwbY+uaYXjWx8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vFwRS+kgfxQIwiVyFRnYOWoWDhXcYBfaQmanc+IONgRLXYDpAsHFnFhA6X+XCdJBa
         tUh1RMBkvaxS1F+9+E5jKwDuVNHXq9jyhrijCA3maW+RAwXNIkAW0afSyDBv18WHhf
         E4IxWIyTEoqGlnPqt/20/o8/wtpiTMVP1Cl0dzT0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>, Frank Pavlic <f.pavlic@kunbus.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Tristram Ha <Tristram.Ha@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 10/21] net: ks8851: Delay requesting IRQ until opened
Date:   Mon, 22 Apr 2019 15:49:30 -0400
Message-Id: <20190422194941.13433-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194941.13433-1-sashal@kernel.org>
References: <20190422194941.13433-1-sashal@kernel.org>
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
index a8c5641ff955..ff6cab4f6343 100644
--- a/drivers/net/ethernet/micrel/ks8851.c
+++ b/drivers/net/ethernet/micrel/ks8851.c
@@ -797,6 +797,15 @@ static void ks8851_tx_work(struct work_struct *work)
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
@@ -911,6 +920,8 @@ static int ks8851_net_stop(struct net_device *dev)
 		dev_kfree_skb(txb);
 	}
 
+	free_irq(dev->irq, ks);
+
 	return 0;
 }
 
@@ -1542,14 +1553,6 @@ static int ks8851_probe(struct spi_device *spi)
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
@@ -1562,11 +1565,7 @@ static int ks8851_probe(struct spi_device *spi)
 
 	return 0;
 
-
 err_netdev:
-	free_irq(ndev->irq, ks);
-
-err_irq:
 err_id:
 	if (gpio_is_valid(gpio))
 		gpio_set_value(gpio, 0);
@@ -1587,7 +1586,6 @@ static int ks8851_remove(struct spi_device *spi)
 		dev_info(&spi->dev, "remove\n");
 
 	unregister_netdev(priv->netdev);
-	free_irq(spi->irq, priv);
 	if (gpio_is_valid(priv->gpio))
 		gpio_set_value(priv->gpio, 0);
 	regulator_disable(priv->vdd_reg);
-- 
2.19.1

