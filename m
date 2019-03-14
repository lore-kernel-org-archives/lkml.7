Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F18C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3782C2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfCNNGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:06:02 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:39033 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfCNNGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:06:02 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost.localdomain (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B18D7C0002;
        Thu, 14 Mar 2019 13:05:50 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jagan Teki <jagan@openedev.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] phy: sun4i-usb: Make sure to disable PHY0 passby for peripheral mode
Date:   Thu, 14 Mar 2019 14:05:18 +0100
Message-Id: <20190314130518.2892-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On platforms where the MUSB and HCI controllers share PHY0, PHY passby
is required when using the HCI controller with the PHY, but it must be
disabled when the MUSB controller is used instead.

Without this, PHY0 passby is always enabled, which results in broken
peripheral mode on such platforms (e.g. H3/H5).

Fixes: ba4bdc9e1dc0 ("PHY: sunxi: Add driver for sunxi usb phy")

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 5163097b43df..7b23920e0068 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -551,6 +551,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 	struct sun4i_usb_phy_data *data =
 		container_of(work, struct sun4i_usb_phy_data, detect.work);
 	struct phy *phy0 = data->phys[0].phy;
+	struct sun4i_usb_phy *phy = phy_get_drvdata(phy0);
 	bool force_session_end, id_notify = false, vbus_notify = false;
 	int id_det, vbus_det;
 
@@ -607,6 +608,9 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 			mutex_unlock(&phy0->mutex);
 		}
 
+		/* Enable PHY0 passby for host mode only. */
+		sun4i_usb_phy_passby(phy, !id_det);
+
 		/* Re-route PHY0 if necessary */
 		if (data->cfg->phy0_dual_route)
 			sun4i_usb_phy0_reroute(data, id_det);
-- 
2.20.1

