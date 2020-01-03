Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234CBC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F112F2253D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7fPgsM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgACSTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:19:31 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40105 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbgACST2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:19:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so23749151pgt.7;
        Fri, 03 Jan 2020 10:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H4+FLclhdhCw74jAzeAwHm0BVOBLEFDsMtURbkkNBZU=;
        b=b7fPgsM5mGk6z83c9LDyzId6ez04NMpL7DEQSyIYFibdR8sd2Nzz8y+Te0H8CTeU/x
         iIQ93+fzPhDaXpUfkIFlJIp41Q5ziTuok9fC6iKeeFcJcDp8y4PYLo2n7aqaCLv65QHW
         E+XccHokjIAdeS7NFMtosBhbiMbcBjFIgGAhcCkZF+Za+qwzMzt4VyAZ8FWIYa1A0v1J
         OJA0xDmuvxojgCcuSzlrgvjS77AJwoDzrpnViq0evwa4kjljuUNMIPxuJXo0PXPn5Xpl
         ZFQL3/5qBICsJcUkbK3WXaE0JvCyJja2yA3SQtNbsgUSXbd67LKOLJK9jtB/vnXQrNHW
         avBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H4+FLclhdhCw74jAzeAwHm0BVOBLEFDsMtURbkkNBZU=;
        b=UE3VdBrrxACVc9XaM5AuOLOWBFyeYFLEJpOMY2SbW3nQySFzm5l5WjIP9A3PeZ3wOH
         1si6WIaOFwWPvBE55yzWkwK7XjlbKDTEzsCusaP3R+M6clQfEqvwMVVE4Iknka0yi9AJ
         pW/1CyLc7w5sMP+ggg6NXWYRGq+wrA5TQryhlvUs896Ln4kn8dGsllXw85Dz/dOCnuvv
         E/ibi3zs6IPTSKL7j9FEzwRJHvi/fchez6YYa0KKK7VbFbfQbOP8M9uViqlDH1mCeS3R
         Gzhuikyxl3IYTfjqo1+9cePAjqnLKz/WwW5ziAExPimobjG5H4sGwQni8WoTCNVX996n
         B1Ng==
X-Gm-Message-State: APjAAAXlpcz6VITNxrqcLyALxrOXCBPZ+Ja7/q/mugVEbE0N9v6w/Rq+
        qljxjF8rZyYginGIju/pnoZgluYzPbc=
X-Google-Smtp-Source: APXvYqyd9ZHb8lCT1ZWjePB2OcU+bgS2tg+bAz2UTydf83b69xa442arcEs1Sf5vavhuFPSKav2a+g==
X-Received: by 2002:a62:158c:: with SMTP id 134mr94582731pfv.81.1578075567622;
        Fri, 03 Jan 2020 10:19:27 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j8sm41783602pfe.182.2020.01.03.10.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 10:19:27 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Srinath Mannam <srinath.mannam@broadcom.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v4 03/13] phy: usb: Put USB phys into IDDQ on suspend to save power in S2 mode
Date:   Fri,  3 Jan 2020 13:18:01 -0500
Message-Id: <20200103181811.22939-4-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103181811.22939-1-alcooperx@gmail.com>
References: <20200103181811.22939-1-alcooperx@gmail.com>
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
index bd473d12ab28..ac7f7995c11f 100644
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

