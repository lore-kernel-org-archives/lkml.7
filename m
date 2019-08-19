Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92424C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6400820651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Xh0II7dN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfHSP50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:57:26 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:26890 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfHSP50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:57:26 -0400
Received: from grover.flets-west.jp (softbank126125143222.bbtec.net [126.125.143.222]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x7JFu5LM008800;
        Tue, 20 Aug 2019 00:56:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x7JFu5LM008800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566230165;
        bh=4GK43BeKnZv5WyQmgfpb1RfuIr9VmwksRI1v6Lo8THA=;
        h=From:To:Cc:Subject:Date:From;
        b=Xh0II7dN9ng2FE6abhAYGvXbe2CwYqlCE054fL0AeQ2SLcgkjj+zDnPUC3ID4Nuv/
         cpCjIQUzgImo547Tj9TxCySIaXDAUIcoaWA12Zu8Yg2/tFIP+SkoYD74KhRz3MTf8d
         +XkA4f1QHfPHnbP6cH6IE09aYXLsP/xyLSRpnFgJulQ0agIPz043z+Jy3afwB/j46M
         xZcL4JZ1Dby9JysSD1xo9yoZvb80EQ4F7GQtJs5sj5ytrKr2K5lHD29mZv3DT3PBNN
         zGLeb0iB5kZC1i/fyzihUCu9R7JOr79qK53Me8uxIOlaKnSWhAJysY7RjB0NExavs7
         gAxVJmWBXP1Qg==
X-Nifty-SrcIP: [126.125.143.222]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] ARM: s3c64xx: squash samsung_usb_phy.h into setup-usb-phy.c
Date:   Tue, 20 Aug 2019 00:56:02 +0900
Message-Id: <20190819155602.20843-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is only used by arch/arm/mach-s3c64xx/setup-usb-phy.c

$ git grep samsung_usb_phy_type
include/linux/usb/samsung_usb_phy.h:enum samsung_usb_phy_type {
$ git grep USB_PHY_TYPE_DEVICE
arch/arm/mach-s3c64xx/setup-usb-phy.c:  if (type == USB_PHY_TYPE_DEVICE)
arch/arm/mach-s3c64xx/setup-usb-phy.c:  if (type == USB_PHY_TYPE_DEVICE)
include/linux/usb/samsung_usb_phy.h:    USB_PHY_TYPE_DEVICE,
$ git grep USB_PHY_TYPE_HOST
include/linux/usb/samsung_usb_phy.h:    USB_PHY_TYPE_HOST,

Actually, 'enum samsung_usb_phy_type' is unused; the 'type' parameter
has 'int' type. Anyway, there is no need to declare this enum in the
globally visible header. Squash the header.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-s3c64xx/setup-usb-phy.c        |  5 +++++
 arch/arm/plat-samsung/include/plat/usb-phy.h |  2 --
 include/linux/usb/samsung_usb_phy.h          | 17 -----------------
 3 files changed, 5 insertions(+), 19 deletions(-)
 delete mode 100644 include/linux/usb/samsung_usb_phy.h

diff --git a/arch/arm/mach-s3c64xx/setup-usb-phy.c b/arch/arm/mach-s3c64xx/setup-usb-phy.c
index 46a9e955607f..6aaaa1d8e8b9 100644
--- a/arch/arm/mach-s3c64xx/setup-usb-phy.c
+++ b/arch/arm/mach-s3c64xx/setup-usb-phy.c
@@ -15,6 +15,11 @@
 #include "regs-sys.h"
 #include "regs-usb-hsotg-phy.h"
 
+enum samsung_usb_phy_type {
+	USB_PHY_TYPE_DEVICE,
+	USB_PHY_TYPE_HOST,
+};
+
 static int s3c_usb_otgphy_init(struct platform_device *pdev)
 {
 	struct clk *xusbxti;
diff --git a/arch/arm/plat-samsung/include/plat/usb-phy.h b/arch/arm/plat-samsung/include/plat/usb-phy.h
index 6d0c788beb9d..94da89ecbd3b 100644
--- a/arch/arm/plat-samsung/include/plat/usb-phy.h
+++ b/arch/arm/plat-samsung/include/plat/usb-phy.h
@@ -7,8 +7,6 @@
 #ifndef __PLAT_SAMSUNG_USB_PHY_H
 #define __PLAT_SAMSUNG_USB_PHY_H __FILE__
 
-#include <linux/usb/samsung_usb_phy.h>
-
 extern int s5p_usb_phy_init(struct platform_device *pdev, int type);
 extern int s5p_usb_phy_exit(struct platform_device *pdev, int type);
 
diff --git a/include/linux/usb/samsung_usb_phy.h b/include/linux/usb/samsung_usb_phy.h
deleted file mode 100644
index dc0071741695..000000000000
--- a/include/linux/usb/samsung_usb_phy.h
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2012 Samsung Electronics Co.Ltd
- *		http://www.samsung.com/
- *
- * Defines phy types for samsung usb phy controllers - HOST or DEIVCE.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-enum samsung_usb_phy_type {
-	USB_PHY_TYPE_DEVICE,
-	USB_PHY_TYPE_HOST,
-};
-- 
2.17.1

