Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E49C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FC9218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553244679;
	bh=NUI8BFU8CCxq90FOVsS7QGcknBL90XYA/lgpKKNMJ6g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=pNlpjimCMhXBJxf++DzOsbCXj1xgfwJFYb0YC0r22NAM1iHHfSNPoHiIqoX4gKv7O
	 +nTE2Qbbr6jhsTWXUQa01bNFiWtWaDgHnE6qwvHFpT/D82rxCp7/59o0ZzQaYno2do
	 7MEb6LWhIrevDrs5wS8LkjH1GG2WoBxzCb1tHwM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfCVIvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:51:18 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:41762 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfCVIvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:51:17 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id BB9A75FCDD; Fri, 22 Mar 2019 16:51:15 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ARM: sunxi: Fix USB host init fail on v5.1-rc1
Date:   Fri, 22 Mar 2019 16:51:06 +0800
Message-Id: <20190322085108.18693-1-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

As previously reported [1], USB EHCI/OHCI hosts are broken on Allwinner
SoCs on v5.1-rc1. This is partially triggered by commit b97a31348379
("usb: core: comply to PHY framework"), and partially due to how the
Allwinner USB PHY driver handles phy_set_mode for non-OTG PHYs.

This series fixes this in both places.

Patch 1 makes phy-sun4i-usb accept PHY_MODE_USB_HOST for non-OTG PHYs.

Patch 2 makes the usb core fall back to setting the mode
PHY_MODE_USB_HOST if set_mode with PHY_MODE_USB_HOST_SS fails. If that
fails then the failure path is the same as before. This should make it
so existing USB 3.0 drivers are affected.

The patches don't have any dependencies on each other, and could go in
through separate branches. However this affects usability of USB input
devices and Ethernet dongles, I'd rather they go in sooner than later.

Regards
ChenYu


[1] https://lkml.org/lkml/2019/3/18/74

Chen-Yu Tsai (2):
  phy: sun4i-usb: Support set_mode to USB_HOST for non-OTG PHYs
  usb: core: Try generic PHY_MODE_USB_HOST if usb_phy_roothub_set_mode
    fails

 drivers/phy/allwinner/phy-sun4i-usb.c | 5 ++++-
 drivers/usb/core/hcd.c                | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.20.1

