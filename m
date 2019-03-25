Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8180DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B44520645
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfCYUsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:48:16 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:59668 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbfCYUsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:48:15 -0400
Received: from localhost.localdomain (85-76-115-194-nat.elisa-mobile.fi [85.76.115.194])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id DF814B000B;
        Mon, 25 Mar 2019 22:48:09 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] staging: octeon-ethernet: fix incorrect PHY mode
Date:   Mon, 25 Mar 2019 22:48:01 +0200
Message-Id: <20190325204801.7013-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When connecting PHY, we set the mode to PHY_INTERFACE_MODE_GMII which is
not always correct. Specifically on boards where RGMII_RXID is needed
networking now longer works with at803x after commit 6d4cd041f0af
("net: phy: at803x: disable delay only for RGMII mode").

Fix by passing the correct mode. Tested on EdgeRouter Lite
(RGMII_RXID, at803x PHY) and D-Link DSR-500N (RGMII, broadcom PHY).

Fixes: 6d4cd041f0af ("net: phy: at803x: disable delay only for RGMII mode")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/staging/octeon/ethernet-mdio.c   |  2 +-
 drivers/staging/octeon/ethernet.c        | 40 +++++++++++++++++++++---
 drivers/staging/octeon/octeon-ethernet.h |  4 ++-
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
index d6248eecf123..2aee64fdaec5 100644
--- a/drivers/staging/octeon/ethernet-mdio.c
+++ b/drivers/staging/octeon/ethernet-mdio.c
@@ -163,7 +163,7 @@ int cvm_oct_phy_setup_device(struct net_device *dev)
 		goto no_phy;
 
 	phydev = of_phy_connect(dev, phy_node, cvm_oct_adjust_link, 0,
-				PHY_INTERFACE_MODE_GMII);
+				priv->phy_mode);
 	of_node_put(phy_node);
 
 	if (!phydev)
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index ce61c5670ef6..986db76705cc 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -653,14 +653,37 @@ static struct device_node *cvm_oct_node_for_port(struct device_node *pip,
 	return np;
 }
 
-static void cvm_set_rgmii_delay(struct device_node *np, int iface, int port)
+static void cvm_set_rgmii_delay(struct octeon_ethernet *priv, int iface,
+				int port)
 {
+	struct device_node *np = priv->of_node;
 	u32 delay_value;
+	bool rx_delay;
+	bool tx_delay;
 
-	if (!of_property_read_u32(np, "rx-delay", &delay_value))
+	/* By default, both RX/TX delay is enabled in
+	 * __cvmx_helper_rgmii_enable().
+	 */
+	rx_delay = true;
+	tx_delay = true;
+
+	if (!of_property_read_u32(np, "rx-delay", &delay_value)) {
 		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(port, iface), delay_value);
-	if (!of_property_read_u32(np, "tx-delay", &delay_value))
+		rx_delay = delay_value > 0;
+	}
+	if (!of_property_read_u32(np, "tx-delay", &delay_value)) {
 		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(port, iface), delay_value);
+		tx_delay = delay_value > 0;
+	}
+
+	if (!rx_delay && !tx_delay)
+		priv->phy_mode = PHY_INTERFACE_MODE_RGMII_ID;
+	else if (!rx_delay)
+		priv->phy_mode = PHY_INTERFACE_MODE_RGMII_RXID;
+	else if (!tx_delay)
+		priv->phy_mode = PHY_INTERFACE_MODE_RGMII_TXID;
+	else
+		priv->phy_mode = PHY_INTERFACE_MODE_RGMII;
 }
 
 static int cvm_oct_probe(struct platform_device *pdev)
@@ -825,6 +848,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
 			priv->port = port;
 			priv->queue = cvmx_pko_get_base_queue(priv->port);
 			priv->fau = fau - cvmx_pko_get_num_queues(port) * 4;
+			priv->phy_mode = PHY_INTERFACE_MODE_NA;
 			for (qos = 0; qos < 16; qos++)
 				skb_queue_head_init(&priv->tx_free_list[qos]);
 			for (qos = 0; qos < cvmx_pko_get_num_queues(port);
@@ -856,6 +880,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
 				break;
 
 			case CVMX_HELPER_INTERFACE_MODE_SGMII:
+				priv->phy_mode = PHY_INTERFACE_MODE_SGMII;
 				dev->netdev_ops = &cvm_oct_sgmii_netdev_ops;
 				strcpy(dev->name, "eth%d");
 				break;
@@ -865,11 +890,16 @@ static int cvm_oct_probe(struct platform_device *pdev)
 				strcpy(dev->name, "spi%d");
 				break;
 
-			case CVMX_HELPER_INTERFACE_MODE_RGMII:
 			case CVMX_HELPER_INTERFACE_MODE_GMII:
+				priv->phy_mode = PHY_INTERFACE_MODE_GMII;
+				dev->netdev_ops = &cvm_oct_rgmii_netdev_ops;
+				strcpy(dev->name, "eth%d");
+				break;
+
+			case CVMX_HELPER_INTERFACE_MODE_RGMII:
 				dev->netdev_ops = &cvm_oct_rgmii_netdev_ops;
 				strcpy(dev->name, "eth%d");
-				cvm_set_rgmii_delay(priv->of_node, interface,
+				cvm_set_rgmii_delay(priv, interface,
 						    port_index);
 				break;
 			}
diff --git a/drivers/staging/octeon/octeon-ethernet.h b/drivers/staging/octeon/octeon-ethernet.h
index 4a07e7f43d12..be570d33685a 100644
--- a/drivers/staging/octeon/octeon-ethernet.h
+++ b/drivers/staging/octeon/octeon-ethernet.h
@@ -12,7 +12,7 @@
 #define OCTEON_ETHERNET_H
 
 #include <linux/of.h>
-
+#include <linux/phy.h>
 #include <asm/octeon/cvmx-helper-board.h>
 
 /**
@@ -33,6 +33,8 @@ struct octeon_ethernet {
 	 * cvmx_helper_interface_mode_t
 	 */
 	int imode;
+	/* PHY mode */
+	phy_interface_t phy_mode;
 	/* List of outstanding tx buffers per queue */
 	struct sk_buff_head tx_free_list[16];
 	unsigned int last_speed;
-- 
2.17.0

