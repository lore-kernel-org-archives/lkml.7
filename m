Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C23C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16942083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901241;
	bh=6otDJS9XmGr1r62fW0HJClqei9JFcEuaUCHKRk/N95k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P+uGYlzQ5EvSfwvsvA1rC8E/FUFrhIpWqUuOf8JDuyeWLpFzhwk/IinsE/6OKpesK
	 j2MN2Li61UcsD43NQebZjmp7Z2wJ/2DJfhzLrXe6zbyIo8+UdjDdFSlFedudUS7OX0
	 6h8f8mZKJZJOlkR/4f6qwH4JNHiT7RnIiYFAWIJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfCRJ1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:27:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbfCRJ1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:27:18 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5E3E2083D;
        Mon, 18 Mar 2019 09:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901237;
        bh=6otDJS9XmGr1r62fW0HJClqei9JFcEuaUCHKRk/N95k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ufdhXcKhpxFXiLiSvftqhE9NNVpvYATFxHz47SrSJolUTzbZO5mMawftXZ4Js5InX
         /e9sd/RkpcO/P3E+aIJkdW95wD1p+VK04oaXGwP01vO6OmuMlvzpa1SUYPDQ+IydOS
         GlfpmguaHH8OmuCFXu0qWDQ6J8g5xHRJs9TdkqKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 27/43] net: dsa: mv88e6xxx: Set correct interface mode for CPU/DSA ports
Date:   Mon, 18 Mar 2019 10:24:19 +0100
Message-Id: <20190318083716.673336135@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083715.877441740@linuxfoundation.org>
References: <20190318083715.877441740@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit 7cbbee050c959f41b512599bafd99685f419ce26 ]

By default, the switch driver is expected to configure CPU and DSA
ports to their maximum speed. For the 6341 and 6390 families, the
ports interface mode has to be configured as well. The 6390X range
support 10G ports using XAUI, while the 6341 and 6390 supports
2500BaseX, as their maximum speed.

Fixes: 787799a9d555 ("net: dsa: mv88e6xxx: Default ports 9/10 6390X CMODE to 1000BaseX")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |   11 +++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h |    3 +++
 drivers/net/dsa/mv88e6xxx/port.c |   24 ++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/port.h |    4 ++++
 4 files changed, 42 insertions(+)

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -559,6 +559,9 @@ static int mv88e6xxx_port_setup_mac(stru
 			goto restore_link;
 	}
 
+	if (speed == SPEED_MAX && chip->info->ops->port_max_speed_mode)
+		mode = chip->info->ops->port_max_speed_mode(port);
+
 	if (chip->info->ops->port_set_pause) {
 		err = chip->info->ops->port_set_pause(chip, port, pause);
 		if (err)
@@ -3042,6 +3045,7 @@ static const struct mv88e6xxx_ops mv88e6
 	.port_set_duplex = mv88e6xxx_port_set_duplex,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed = mv88e6341_port_set_speed,
+	.port_max_speed_mode = mv88e6341_port_max_speed_mode,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_egress_floods = mv88e6352_port_set_egress_floods,
@@ -3360,6 +3364,7 @@ static const struct mv88e6xxx_ops mv88e6
 	.port_set_duplex = mv88e6xxx_port_set_duplex,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed = mv88e6390_port_set_speed,
+	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_egress_floods = mv88e6352_port_set_egress_floods,
@@ -3404,6 +3409,7 @@ static const struct mv88e6xxx_ops mv88e6
 	.port_set_duplex = mv88e6xxx_port_set_duplex,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed = mv88e6390x_port_set_speed,
+	.port_max_speed_mode = mv88e6390x_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_egress_floods = mv88e6352_port_set_egress_floods,
@@ -3448,6 +3454,7 @@ static const struct mv88e6xxx_ops mv88e6
 	.port_set_duplex = mv88e6xxx_port_set_duplex,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed = mv88e6390_port_set_speed,
+	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_egress_floods = mv88e6352_port_set_egress_floods,
@@ -3541,6 +3548,7 @@ static const struct mv88e6xxx_ops mv88e6
 	.port_set_duplex = mv88e6xxx_port_set_duplex,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed = mv88e6390_port_set_speed,
+	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_egress_floods = mv88e6352_port_set_egress_floods,
@@ -3672,6 +3680,7 @@ static const struct mv88e6xxx_ops mv88e6
 	.port_set_duplex = mv88e6xxx_port_set_duplex,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed = mv88e6341_port_set_speed,
+	.port_max_speed_mode = mv88e6341_port_max_speed_mode,
 	.port_tag_remap = mv88e6095_port_tag_remap,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_egress_floods = mv88e6352_port_set_egress_floods,
@@ -3847,6 +3856,7 @@ static const struct mv88e6xxx_ops mv88e6
 	.port_set_duplex = mv88e6xxx_port_set_duplex,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed = mv88e6390_port_set_speed,
+	.port_max_speed_mode = mv88e6390_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_egress_floods = mv88e6352_port_set_egress_floods,
@@ -3895,6 +3905,7 @@ static const struct mv88e6xxx_ops mv88e6
 	.port_set_duplex = mv88e6xxx_port_set_duplex,
 	.port_set_rgmii_delay = mv88e6390_port_set_rgmii_delay,
 	.port_set_speed = mv88e6390x_port_set_speed,
+	.port_max_speed_mode = mv88e6390x_port_max_speed_mode,
 	.port_tag_remap = mv88e6390_port_tag_remap,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_egress_floods = mv88e6352_port_set_egress_floods,
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -377,6 +377,9 @@ struct mv88e6xxx_ops {
 	 */
 	int (*port_set_speed)(struct mv88e6xxx_chip *chip, int port, int speed);
 
+	/* What interface mode should be used for maximum speed? */
+	phy_interface_t (*port_max_speed_mode)(int port);
+
 	int (*port_tag_remap)(struct mv88e6xxx_chip *chip, int port);
 
 	int (*port_set_frame_mode)(struct mv88e6xxx_chip *chip, int port,
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -312,6 +312,14 @@ int mv88e6341_port_set_speed(struct mv88
 	return mv88e6xxx_port_set_speed(chip, port, speed, !port, true);
 }
 
+phy_interface_t mv88e6341_port_max_speed_mode(int port)
+{
+	if (port == 5)
+		return PHY_INTERFACE_MODE_2500BASEX;
+
+	return PHY_INTERFACE_MODE_NA;
+}
+
 /* Support 10, 100, 200, 1000 Mbps (e.g. 88E6352 family) */
 int mv88e6352_port_set_speed(struct mv88e6xxx_chip *chip, int port, int speed)
 {
@@ -345,6 +353,14 @@ int mv88e6390_port_set_speed(struct mv88
 	return mv88e6xxx_port_set_speed(chip, port, speed, true, true);
 }
 
+phy_interface_t mv88e6390_port_max_speed_mode(int port)
+{
+	if (port == 9 || port == 10)
+		return PHY_INTERFACE_MODE_2500BASEX;
+
+	return PHY_INTERFACE_MODE_NA;
+}
+
 /* Support 10, 100, 200, 1000, 2500, 10000 Mbps (e.g. 88E6190X) */
 int mv88e6390x_port_set_speed(struct mv88e6xxx_chip *chip, int port, int speed)
 {
@@ -360,6 +376,14 @@ int mv88e6390x_port_set_speed(struct mv8
 	return mv88e6xxx_port_set_speed(chip, port, speed, true, true);
 }
 
+phy_interface_t mv88e6390x_port_max_speed_mode(int port)
+{
+	if (port == 9 || port == 10)
+		return PHY_INTERFACE_MODE_XAUI;
+
+	return PHY_INTERFACE_MODE_NA;
+}
+
 int mv88e6390x_port_set_cmode(struct mv88e6xxx_chip *chip, int port,
 			      phy_interface_t mode)
 {
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -285,6 +285,10 @@ int mv88e6352_port_set_speed(struct mv88
 int mv88e6390_port_set_speed(struct mv88e6xxx_chip *chip, int port, int speed);
 int mv88e6390x_port_set_speed(struct mv88e6xxx_chip *chip, int port, int speed);
 
+phy_interface_t mv88e6341_port_max_speed_mode(int port);
+phy_interface_t mv88e6390_port_max_speed_mode(int port);
+phy_interface_t mv88e6390x_port_max_speed_mode(int port);
+
 int mv88e6xxx_port_set_state(struct mv88e6xxx_chip *chip, int port, u8 state);
 
 int mv88e6xxx_port_set_vlan_map(struct mv88e6xxx_chip *chip, int port, u16 map);


