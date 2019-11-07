Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C88C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEFA21D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSXTmXuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389319AbfKGOOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:14:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35547 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389032AbfKGOOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:14:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id 8so2623446wmo.0;
        Thu, 07 Nov 2019 06:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n5G8vs80VS3sA4MhM4cgPCr2IxsX3rpduYhIhTGIkuI=;
        b=hSXTmXuHLBpu0zD9e0xuixf1ulbCGQgSBils56wZxFuyFWeSclmE0yfm9xX7fcVfCN
         sQ36TeuKN6hjIL32f3xyqSNt1KItt7V9JbKno91ivs1ZCTzVmPzCmEbUdfpe7vM0PVSE
         +XsbCyTu/7FmCNL/1c/CfiZ3+9sxOI+pw3XrzafsLR+jpMntev0YfHxiaKtn63poWRp+
         uHDGIWcBKA7ywWhXwLkb2IZDc+QL3SO8F4cABQkyztWiBQ/pjHoU4YM2oKE22goz655i
         2PWuZ1kPi0v0JqEhnlxmHMbfmbg+PnrzpATP7DbudA8kgZKzipJESKGIsyFx1lKAlNjo
         rTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n5G8vs80VS3sA4MhM4cgPCr2IxsX3rpduYhIhTGIkuI=;
        b=DJjg0/QTI6wIbTMhj/YaFtuhU8nB8fmLVJ8zDGcghldb3lhd/Rw4OmAOAvRq9R0Zzj
         3fHfeF0XbHDLlroHVbvfLi1qbXU+toV50m1gLSdjneAG6j4pW5KPTCMPOrl2DzKyt9vQ
         0Ohmt2CvP+fpNB55X/ikLFc01F6ySHLqjsSeDxxicJrRuCemFYH64GPS+pegIL13jQcH
         v+0nybb9Ayapkm8rQwIOtldyFT2ho9clpgId+Jiuk8eM8qxOOkHWCQVPy/v7f7a6bTLi
         L7bLSPQ/qm6pGJsSIebzNmvYokDFcxjrvNE+iHEt4YYO8ECCZ5wUSPmybZyTFs+Drbip
         dZnw==
X-Gm-Message-State: APjAAAUNg1pwPRXz3Yq7YWJxvE+K95dCXm4fCbuocjvxWFAiB/05Z+AX
        FzBqD4Fr/4LrxwcF7/VIblyGEJiwqSw=
X-Google-Smtp-Source: APXvYqzwZkg2at7weMm3Xi5poNNvKbkzcGIacFWSIDTP2hLy32lCioKV70ZSpYSIOo4umHUp5HZ4xg==
X-Received: by 2002:a1c:44b:: with SMTP id 72mr3041762wme.72.1573136074144;
        Thu, 07 Nov 2019 06:14:34 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id b1sm2453888wrw.77.2019.11.07.06.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 06:14:33 -0800 (PST)
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
Subject: [PATCH 03/13] phy: usb: Put USB phys into IDDQ on suspend to save power in S2 mode
Date:   Thu,  7 Nov 2019 09:13:29 -0500
Message-Id: <20191107141339.6079-4-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107141339.6079-1-alcooperx@gmail.com>
References: <20191107141339.6079-1-alcooperx@gmail.com>
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

