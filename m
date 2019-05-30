Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0D5C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FFA250D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189325;
	bh=5lqbSiFsCzajkB4FyK61e1Rl1EHlse2aMLHD0Ua8Zf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u7dWKkuTOCqj8QHXjTtoGqAOVnO08W7kNTvRmg2/uZ3Rc+b2xW9brqwzpJaF8wupE
	 Ot/s0WY6GHBKmX+MwUL+iAkhfEcjjoTGM3vwR1Vc3ub8WxxHsFVG9LC9NMwHMEtNxm
	 nGIKAg/dKPBa/Hre53x5d7q9TNSpCUeIuxm5bHbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfE3EIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:08:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731069AbfE3DRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:17:18 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BEB2246A2;
        Thu, 30 May 2019 03:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186237;
        bh=5lqbSiFsCzajkB4FyK61e1Rl1EHlse2aMLHD0Ua8Zf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X19UE1MITgMojc+wdzxN4OPmLva/R23ieQsO85X0b3hHcPiDjEwNRE4yUnYu7TXyj
         dubWyi/JWeHE5SpuZvXe6ZiyloY5kqMkDQz6rH5VU8zYmnuZZCmnsdTrJwVApiPkxo
         GXEukqXdobnS7xIu/WSxYc5MlP7s9Tdbvd6kbpbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 147/276] phy: sun4i-usb: Make sure to disable PHY0 passby for peripheral mode
Date:   Wed, 29 May 2019 20:05:05 -0700
Message-Id: <20190530030534.820598616@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e6f32efb1b128344a2c7df9875bc1a1abaa1d395 ]

On platforms where the MUSB and HCI controllers share PHY0, PHY passby
is required when using the HCI controller with the PHY, but it must be
disabled when the MUSB controller is used instead.

Without this, PHY0 passby is always enabled, which results in broken
peripheral mode on such platforms (e.g. H3/H5).

Fixes: ba4bdc9e1dc0 ("PHY: sunxi: Add driver for sunxi usb phy")

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 15c8fc2abf01f..1f8809bab002c 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -550,6 +550,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 	struct sun4i_usb_phy_data *data =
 		container_of(work, struct sun4i_usb_phy_data, detect.work);
 	struct phy *phy0 = data->phys[0].phy;
+	struct sun4i_usb_phy *phy = phy_get_drvdata(phy0);
 	bool force_session_end, id_notify = false, vbus_notify = false;
 	int id_det, vbus_det;
 
@@ -606,6 +607,9 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
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



