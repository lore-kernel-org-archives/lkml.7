Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132E6ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E629A21A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfIKGYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 02:24:08 -0400
Received: from mxout017.mail.hostpoint.ch ([217.26.49.177]:59915 "EHLO
        mxout017.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbfIKGYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 02:24:08 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i7w2r-000P9p-GC; Wed, 11 Sep 2019 08:24:01 +0200
Received: from [83.150.61.156] (helo=volery)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i7w2r-0005Mp-An; Wed, 11 Sep 2019 08:24:01 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Date:   Wed, 11 Sep 2019 08:23:59 +0200
From:   Sandro Volery <sandro@volery.com>
To:     gregkh@linuxfoundation.org, davem@davemloft.net,
        aaro.koskinen@iki.fi, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: octeon: Avoid several usecases of strcpy
Message-ID: <20190911062359.GA14886@volery>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strcpy was used multiple times in strcpy to write into dev->name.
I replaced them with strscpy.

Signed-off-by: Sandro Volery <sandro@volery.com>
---
 drivers/staging/octeon/ethernet.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 8889494adf1f..cf8e9a23ebf9 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -784,7 +784,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
 			priv->imode = CVMX_HELPER_INTERFACE_MODE_DISABLED;
 			priv->port = CVMX_PIP_NUM_INPUT_PORTS;
 			priv->queue = -1;
-			strcpy(dev->name, "pow%d");
+			strscpy(dev->name, "pow%d", sizeof(dev->name));
 			for (qos = 0; qos < 16; qos++)
 				skb_queue_head_init(&priv->tx_free_list[qos]);
 			dev->min_mtu = VLAN_ETH_ZLEN - mtu_overhead;
@@ -856,39 +856,39 @@ static int cvm_oct_probe(struct platform_device *pdev)
 
 			case CVMX_HELPER_INTERFACE_MODE_NPI:
 				dev->netdev_ops = &cvm_oct_npi_netdev_ops;
-				strcpy(dev->name, "npi%d");
+				strscpy(dev->name, "npi%d", sizeof(dev->name));
 				break;
 
 			case CVMX_HELPER_INTERFACE_MODE_XAUI:
 				dev->netdev_ops = &cvm_oct_xaui_netdev_ops;
-				strcpy(dev->name, "xaui%d");
+				strscpy(dev->name, "xaui%d", sizeof(dev->name));
 				break;
 
 			case CVMX_HELPER_INTERFACE_MODE_LOOP:
 				dev->netdev_ops = &cvm_oct_npi_netdev_ops;
-				strcpy(dev->name, "loop%d");
+				strscpy(dev->name, "loop%d", sizeof(dev->name));
 				break;
 
 			case CVMX_HELPER_INTERFACE_MODE_SGMII:
 				priv->phy_mode = PHY_INTERFACE_MODE_SGMII;
 				dev->netdev_ops = &cvm_oct_sgmii_netdev_ops;
-				strcpy(dev->name, "eth%d");
+				strscpy(dev->name, "eth%d", sizeof(dev->name));
 				break;
 
 			case CVMX_HELPER_INTERFACE_MODE_SPI:
 				dev->netdev_ops = &cvm_oct_spi_netdev_ops;
-				strcpy(dev->name, "spi%d");
+				strscpy(dev->name, "spi%d", sizeof(dev->name));
 				break;
 
 			case CVMX_HELPER_INTERFACE_MODE_GMII:
 				priv->phy_mode = PHY_INTERFACE_MODE_GMII;
 				dev->netdev_ops = &cvm_oct_rgmii_netdev_ops;
-				strcpy(dev->name, "eth%d");
+				strscpy(dev->name, "eth%d", sizeof(dev->name));
 				break;
 
 			case CVMX_HELPER_INTERFACE_MODE_RGMII:
 				dev->netdev_ops = &cvm_oct_rgmii_netdev_ops;
-				strcpy(dev->name, "eth%d");
+				strscpy(dev->name, "eth%d", sizeof(dev->name));
 				cvm_set_rgmii_delay(priv, interface,
 						    port_index);
 				break;
-- 
2.23.0

