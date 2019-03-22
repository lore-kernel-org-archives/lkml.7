Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EEFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111B7218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553244687;
	bh=tuivY8FVXe+dDskDzGEI/mSiKa6zdBLHLrYDQLGYPtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s9/4AuL6nPIMZkQJQoq0VyFdPEPqDHXS4kfE6f9abhiy7TNb6eoy6m1UdtQmF5biw
	 yZs5bqgaGBCHOcmt19Gh5FodAg9BJsdf03I69U+CfZecuAA3IPuui7g2PygbviMtTa
	 e5GhJeBtx1VcQN+jsSVAEBhuQAC+j/MUKjFHZmQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfCVIvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:51:19 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:41772 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727538AbfCVIvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:51:18 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id C59C25F899; Fri, 22 Mar 2019 16:51:15 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] phy: sun4i-usb: Support set_mode to USB_HOST for non-OTG PHYs
Date:   Fri, 22 Mar 2019 16:51:07 +0800
Message-Id: <20190322085108.18693-2-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322085108.18693-1-wens@kernel.org>
References: <20190322085108.18693-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

While only the first PHY supports mode switching, the remaining PHYs
work in USB host mode. They should support set_mode with mode=USB_HOST
instead of failing. This is especially needed now that the USB core does
set_mode for all USB ports, which was added in commit b97a31348379 ("usb:
core: comply to PHY framework").

Make set_mode with mode=USB_HOST a no-op instead of failing for the
non-OTG USB PHYs.

Fixes: 6ba43c291961 ("phy-sun4i-usb: Add support for phy_set_mode")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 5163097b43df..4bbd9ede38c8 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -485,8 +485,11 @@ static int sun4i_usb_phy_set_mode(struct phy *_phy,
 	struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
 	int new_mode;
 
-	if (phy->index != 0)
+	if (phy->index != 0) {
+		if (mode == PHY_MODE_USB_HOST)
+			return 0;
 		return -EINVAL;
+	}
 
 	switch (mode) {
 	case PHY_MODE_USB_HOST:
-- 
2.20.1

