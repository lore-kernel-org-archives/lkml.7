Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BDAC5ED45
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FC5246C0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfLMPuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:50:15 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44807 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbfLMPuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 10:50:11 -0500
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id BA0A960010;
        Fri, 13 Dec 2019 15:50:08 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, sd@queasysnail.net, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        allan.nielsen@microchip.com, camelia.groza@nxp.com,
        Simon.Edelhaus@aquantia.com, Igor.Russkikh@aquantia.com,
        jakub.kicinski@netronome.com
Subject: [PATCH net-next v3 04/15] net: phy: add MACsec ops in phy_device
Date:   Fri, 13 Dec 2019 16:48:33 +0100
Message-Id: <20191213154844.635389-5-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191213154844.635389-1-antoine.tenart@bootlin.com>
References: <20191213154844.635389-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a reference to MACsec ops in the phy_device, to allow
PHYs to support offloading MACsec operations. The phydev lock will be
held while calling those helpers.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 include/linux/phy.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index f4116947a7d7..11b92da25681 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -328,6 +328,7 @@ struct phy_c45_device_ids {
 };
 
 struct macsec_context;
+struct macsec_ops;
 
 /* phy_device: An instance of a PHY
  *
@@ -351,6 +352,7 @@ struct macsec_context;
  * attached_dev: The attached enet driver's device instance ptr
  * adjust_link: Callback for the enet controller to respond to
  * changes in the link state.
+ * macsec_ops: MACsec offloading ops.
  *
  * speed, duplex, pause, supported, advertising, lp_advertising,
  * and autoneg are used like in mii_if_info
@@ -449,6 +451,11 @@ struct phy_device {
 
 	void (*phy_link_change)(struct phy_device *, bool up, bool do_carrier);
 	void (*adjust_link)(struct net_device *dev);
+
+#if IS_ENABLED(CONFIG_MACSEC)
+	/* MACsec management functions */
+	const struct macsec_ops *macsec_ops;
+#endif
 };
 #define to_phy_device(d) container_of(to_mdio_device(d), \
 				      struct phy_device, mdio)
-- 
2.23.0

