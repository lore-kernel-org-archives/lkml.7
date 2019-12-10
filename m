Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158D1C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2F9208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3WH5Xqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfLJNYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:24:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40287 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfLJNXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:23:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so3157895wmi.5;
        Tue, 10 Dec 2019 05:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H4+FLclhdhCw74jAzeAwHm0BVOBLEFDsMtURbkkNBZU=;
        b=T3WH5XqfLetiRgJBy6bGiL857tumh3t0aFWaqjQBigz1b4hiy5q6+MPfBTdlR2deaY
         3vEUap4VQO8vWsJ8/pt3CaMMxqt2jo/i5LrozOqJ3Acd9OzRxCl5XcrSloYesxdWqUHb
         Y8rES7Z6Gc82Nj2abcYYHPeCMB9X7ogpZ/9h0p7dt4VdWenICy0mLuuRdYxCR+3END9Y
         jjFaPcUjznVi0d2RmnmLssCIQ6PuwaOV6lg0Pipkg+lGRK0+mJo4ddwIj+TkHaxMeUIz
         IWgrjmQIvjHVUYj2sQB2kbwlLLHRW8kscQlNVbbNjYHfq9goJ/8XIIkBDQpEpNCNitil
         Zn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H4+FLclhdhCw74jAzeAwHm0BVOBLEFDsMtURbkkNBZU=;
        b=jyD++X1trwTHBnpPxKD0XwSarCot0kKhrJT8pP8pH6tYqq6x32sTWeLYc+fRnKilOo
         HqKc8Ws8ibstUynsLvE+EGj12VSTaN2YcYL6vakIHsI6TBZz6wB3e3EagkFeA98Ad0Wz
         57SqMaiw2vvMXmjxzaJPVPOvn8ZHS4u8HkpJ386PIE71z6yvftAW3BSq2ZIfPGzQlDTg
         h199u6F6eYUfYk0BbStsAalqkn4nmzf0v86lCQn5UvjA+pqUHOv1oRsvyxtLpY/C2qSS
         FnX6b8VpqvwwwFXKNsUn6psT7uSpkxv/OgNkqTlokqfJ3x78ft77brA4jd08x3FIAfow
         3n3w==
X-Gm-Message-State: APjAAAV5nuNORj1yhAVxaYHBEatCnn/U5tdz+9ufhzRqLF07dlByF3b5
        9NW8RMljtD4+9d4QUImA3lqw8bduVVY=
X-Google-Smtp-Source: APXvYqwRKREd+dTcyz/cmUO5OP+/NQ+62nTATaIIK9TjFJFfl/x1evrju2D3rlM1KG1gHPjAkpeR7w==
X-Received: by 2002:a7b:c750:: with SMTP id w16mr5536056wmk.46.1575984213983;
        Tue, 10 Dec 2019 05:23:33 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id s82sm3101680wms.28.2019.12.10.05.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 05:23:33 -0800 (PST)
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
Subject: [PATCH v3 03/13] phy: usb: Put USB phys into IDDQ on suspend to save power in S2 mode
Date:   Tue, 10 Dec 2019 08:21:22 -0500
Message-Id: <20191210132132.41509-4-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210132132.41509-1-alcooperx@gmail.com>
References: <20191210132132.41509-1-alcooperx@gmail.com>
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

