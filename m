Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CDEC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC31D2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552898743;
	bh=oE2VmK1dMwj4JPqbgny69BjkrG8/fAdvi0FJW8YH9hQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=UUjHXRXn+EnzLxzQkd+8J6n+C9FKosz1n/atGQO7s37oP5qtpNvfL0Bs+sKlWFsHB
	 OxKEmvzWG7YgUD2zqqKzlyy9VZyiJtFVXMB2KvJ9CsiZ1Sr9hzEv9IgX0hv4r5FhWl
	 Z+mG+Ey/yBVb3Jnh3NbwNheKYaQ0JfT+wXq6nngc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfCRIpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:45:41 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:41002 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbfCRIpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:45:38 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id 38A945FD14; Mon, 18 Mar 2019 16:45:36 +0800 (CST)
Date:   Mon, 18 Mar 2019 16:45:36 +0800
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [BUG] USB (EHCI/OHCI) broken on Allwinner SoCs
Message-ID: <20190318084536.GA27150@wens.csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

USB EHCI/OHCI hosts are broken on Allwinner SoCs on v5.1-rc1. I believe
this is partially triggered by commit b97a31348379 ("usb: core: comply
to PHY framework"), and partially due to how the Allwinner USB PHY
driver handles phy_set_mode for non-OTG PHYs. Note this is not from a
bisect.

The following changes fix this.

Hunk 1 makes our PHY driver accept PHY_MODE_USB_HOST for the non-OTG
PHYs as a no-op.

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
---

Hunk 2 makes the USB core call phy_set_mode with PHY_MODE_USB_HOST
instead of PHY_MODE_USB_HOST_SS. Not sure why PHY_MODE_USB_HOST_SS was
used here, but I believe only a small set of hardware actually support
SuperSpeed, so it might be better to use the more encompasing
PHY_MODE_USB_HOST. That or the core code would have to check which speed
class the port is for and pass in the appropriate mode. The Allwinner
PHYs do not support SuperSpeed.

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 3189181bb628..7f25e384144d 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2740,7 +2740,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 			return retval;
 
 		retval = usb_phy_roothub_set_mode(hcd->phy_roothub,
-						  PHY_MODE_USB_HOST_SS);
+						  PHY_MODE_USB_HOST);
 		if (retval)
 			goto err_usb_phy_roothub_power_on;
 
---

If the two changes make sense I'll send them out as actual patches.
