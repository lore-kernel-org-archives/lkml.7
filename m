Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6894C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8297A218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553244683;
	bh=rldEdrr5rCUngUjDLMHQBj1zn9ZZLEGs+jkZJmgEgzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Edg5lMZuMrgwPaLTrDiAN35pcVd6/MTEfNGWSApQbcGsUdanfjcj0D7wuPdO31Gj0
	 ns2eF+CyDfyUq58xRRizRUFy3ysbsnmM9TiK2A9Fxfw1MMTBRqzeYIW6EEGN7UR5t9
	 K0esqx5+4b+jMAV3nBjoNftGERQgWf1WChlqyUIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfCVIvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:51:21 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:41770 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfCVIvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:51:18 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id CD03B5FD69; Fri, 22 Mar 2019 16:51:15 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usb: core: Try generic PHY_MODE_USB_HOST if usb_phy_roothub_set_mode fails
Date:   Fri, 22 Mar 2019 16:51:08 +0800
Message-Id: <20190322085108.18693-3-wens@kernel.org>
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

Some PHYs do not support PHY_MODE_USB_HOST_SS, i.e. USB 3.0 or higher.
Fall back and try the more generic PHY_MODE_USB_HOST if it fails.

Fixes: b97a31348379 ("usb: core: comply to PHY framework")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/usb/core/hcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 3189181bb628..975d7c1288e3 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2741,6 +2741,9 @@ int usb_add_hcd(struct usb_hcd *hcd,
 
 		retval = usb_phy_roothub_set_mode(hcd->phy_roothub,
 						  PHY_MODE_USB_HOST_SS);
+		if (retval)
+			retval = usb_phy_roothub_set_mode(hcd->phy_roothub,
+							  PHY_MODE_USB_HOST);
 		if (retval)
 			goto err_usb_phy_roothub_power_on;
 
-- 
2.20.1

