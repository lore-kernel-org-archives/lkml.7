Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4188DC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBF62072B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZutM+W0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfKOSnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:43:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39739 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfKOSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:43:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id l7so12048550wrp.6;
        Fri, 15 Nov 2019 10:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n5G8vs80VS3sA4MhM4cgPCr2IxsX3rpduYhIhTGIkuI=;
        b=ZutM+W0ogPUSZhV90V1adFu/zwBzRsYtRS1uAYlG4aef/VnkwGi2d9gVcYL64IM5ll
         m2i0Z+rY50kkNny175k25dNuaVBnetIp0+m8QhytKMEuwA3cBODcKz8wOsTCUDQGzGg1
         zNASyVhOUr7HnLrm5Ytn9eVGogET5az9wq5YG9yBY7nDksALNmrVThs9RkaXneV8XeS2
         +9ZysXdX8tFqAA8T3BvGaw3LfMR0fxgcUgKOHEOTg+PPiiFzgwDwLbokI6bQc33FOFwU
         /kR6778Nn+1XcGfYe+lu/3wv8BXPH9Q0A7M/zz9Kyb3LF98Bp33cB2W4AfX8WmZIewAI
         yqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n5G8vs80VS3sA4MhM4cgPCr2IxsX3rpduYhIhTGIkuI=;
        b=nxyuw0OwX43PanKVnt0GTunqsfhAC7WcfYGYmLwF/JHx9oIiFtxSiOwxHyylzoO7vq
         hHBTbf1TVDYgQWVo7i7qcoc6nLpapz8yWFo5oF9lVBd7VYSjp3Doh8nBQ44Riyy//LAy
         4heXNJf6tra4ICzzVc757MNt3+Aqs+xxAvniFPqssCOrERKKUiwLQpOt0s8yfr5ABbZ9
         Q+MlCR2yW78wK0DJloZpODTe/OTohyEQZavLgI++ISXRTjlrAiWW7ObUtkjxoIQyLaAI
         1T6+qa3o/n8cDsyhQ99YJRMmDKEJc4U2f23aYiMStMVlQAB/s0YvRrWS5eNFdUHf+jGi
         2F6A==
X-Gm-Message-State: APjAAAXR/gSUUky3Oi4keP2I+0wIVM12gz141D/a1jccbt1+aw7tJO3K
        OcMZwaqsBA7h+VyUDt5N2pN6X49YPuM=
X-Google-Smtp-Source: APXvYqxhxd3N9xQeLfTjyCbbyVKUcioEYABPKnqb31gT+D/B4XCLxBys89EN1Ei8Fg3lKybqS4gl8w==
X-Received: by 2002:a05:6000:1206:: with SMTP id e6mr16943372wrx.113.1573843416930;
        Fri, 15 Nov 2019 10:43:36 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id g138sm2620989wmg.11.2019.11.15.10.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 10:43:36 -0800 (PST)
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
Subject: [PATCH v2 03/13] phy: usb: Put USB phys into IDDQ on suspend to save power in S2 mode
Date:   Fri, 15 Nov 2019 13:42:13 -0500
Message-Id: <20191115184223.41504-4-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115184223.41504-1-alcooperx@gmail.com>
References: <20191115184223.41504-1-alcooperx@gmail.com>
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

