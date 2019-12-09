Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93D3C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A839A2465A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWe12ucl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfLIVoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:44:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56240 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfLIVoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:44:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so951420wmj.5;
        Mon, 09 Dec 2019 13:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n5G8vs80VS3sA4MhM4cgPCr2IxsX3rpduYhIhTGIkuI=;
        b=cWe12uclXhwcu3izBnCofTph9kxBd/6LXwa4QBGTN4n4LSo+2knEV3Wry8p7QgPiXu
         lYp0dhqziRpTdkloONIna+3gEoD04zY8TaL37bUlhZtzie6mxJ1KSumGwITx2829S/GS
         EtRL0ZDYDmMU1uGox/1zfr/qcx0h7jYve6Z03mrZ1FAXxdHt0HOQEjyIGx8gTE2F6Kyz
         59CeHgZRyjZw5qZfNr48P/rXFC2Fd6bEh+bzmA75kOqbZkFfMoy3gPiGx+9sG1sZtrmM
         FRGISjnDDxoUVdFxx19gkfkSAYOG0X7ki/ShXt2N9dEhIphEB4bYVyg46gx3DvOSeWC5
         zHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n5G8vs80VS3sA4MhM4cgPCr2IxsX3rpduYhIhTGIkuI=;
        b=Xgb58rtZHNz3almt1nuLGSz8hfXKTda+kL9bD53HqdJWOboYZPao/S8gAG4WX9XoSY
         +JUmE72mrvwFevmJAnKZYA6VRJsSSYb4bRUurwUIFcYW2HcTauAunzsU9tU7brRxc8yd
         YD+My2YX2z4vKERXXHsB9wunMrVgtFzD7uXR3gSm3IPq2A4kokYqEJV46sG5/XF8/9rZ
         8UkhSxH4tH4Ac6fKOYa2vJCQ1rjmnQuy8v/6XZxiH0e8Mo+PCJviF6DCFUOjf6OKdNe3
         /hjpxonLKZVdP9W0ok2xE1JoNTEOfauco+AK5udWhlTyQYarA4qi6GCf1A1o4KNQi6G5
         li4w==
X-Gm-Message-State: APjAAAWqT98sHuvu/qKWJewL5eHVadVjPxdwsiv3ypvl9hThV6ZB0b3b
        rzOSVFUWPHYhecVv4DuzmtMmVwlz9ig=
X-Google-Smtp-Source: APXvYqz6nvbRQHUcQkd94oo1jyFxUVi3z7EmmJAivKLNh6IbCPG0rRcXL5ZxnEPtnXrT+u25NW5NrQ==
X-Received: by 2002:a05:600c:1007:: with SMTP id c7mr1267751wmc.158.1575927839077;
        Mon, 09 Dec 2019 13:43:59 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id z6sm757714wmz.12.2019.12.09.13.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 13:43:58 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 resend 03/13] phy: usb: Put USB phys into IDDQ on suspend to save power in S2 mode
Date:   Mon,  9 Dec 2019 16:42:39 -0500
Message-Id: <20191209214249.41137-4-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209214249.41137-1-alcooperx@gmail.com>
References: <20191209214249.41137-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the Phy driver will put the USB phys into the max
power saving mode (IDDQ) when there is no corresponding XHCI, EHCI
or OHCI client (through rmmod, unbind or if the driver is not
builtin). This change will also put the Phys into IDDQ mode
on suspend so that S2 will get the additional power savings.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb-init.c |  2 --
 drivers/phy/broadcom/phy-brcm-usb.c      | 11 +++++++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadcom/phy-brcm-usb-init.c
index 56d9b314a8d0..0e6b921072be 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -1002,8 +1002,6 @@ void brcm_usb_uninit_common(struct brcm_usb_init_params *params)
 
 void brcm_usb_uninit_eohci(struct brcm_usb_init_params *params)
 {
-	if (USB_CTRL_MASK_FAMILY(params, USB_PM, USB20_HC_RESETB))
-		USB_CTRL_UNSET_FAMILY(params, USB_PM, USB20_HC_RESETB);
 }
 
 void brcm_usb_uninit_xhci(struct brcm_usb_init_params *params)
diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 217e3702ef4e..634afc803778 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -381,8 +381,15 @@ static int brcm_usb_phy_suspend(struct device *dev)
 	struct brcm_usb_phy_data *priv = dev_get_drvdata(dev);
 
 	if (priv->init_count) {
-		clk_disable_unprepare(priv->usb_20_clk);
-		clk_disable_unprepare(priv->usb_30_clk);
+		if (priv->phys[BRCM_USB_PHY_3_0].inited)
+			brcm_usb_uninit_xhci(&priv->ini);
+		if (priv->phys[BRCM_USB_PHY_2_0].inited)
+			brcm_usb_uninit_eohci(&priv->ini);
+		brcm_usb_uninit_common(&priv->ini);
+		if (priv->phys[BRCM_USB_PHY_3_0].inited)
+			clk_disable_unprepare(priv->usb_30_clk);
+		if (priv->phys[BRCM_USB_PHY_2_0].inited)
+			clk_disable_unprepare(priv->usb_20_clk);
 	}
 	return 0;
 }
-- 
2.17.1

