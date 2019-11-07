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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE79CC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8378721D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF/x+ahs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389490AbfKGOOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:14:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34910 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389413AbfKGOOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:14:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id p2so3238894wro.2;
        Thu, 07 Nov 2019 06:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OEEUPqR6ZmaXELpR8fTPNLPL8vVK/Y5WocC4nRZMSg0=;
        b=PF/x+ahslGcwz4+3/pXPHI3OljZewQieR+OmQ5QnBu4FL9PDfi5Ts6ZxGn0mMUN4PU
         YuFrpNJ7f2uzY9pfLVg0OEZW57+09f3jZdHyVEyv+2MGw6Z7amQMPZLBlPHJxttsSrmr
         kTUoTB3XwPCgHKNdh1BQsJ4sjlqI0MfllF2jq5dmZ2UoyP1L0Ryi5asPp2hfKVZgRZ/f
         PhsAugyIik4pHBT6wguQGdN1o3IRKAYw5qTwX+KjqoVGcfoDuTane9kKg9SOhekZP73V
         E8SpAJiys/hF6Rvq5gNti0slr5xfCDhlwXQCTfe5yBcN6NOyvIA7h3twLUq7WzTB+ywk
         2Gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OEEUPqR6ZmaXELpR8fTPNLPL8vVK/Y5WocC4nRZMSg0=;
        b=U2kY0IZiZfrJZ1BrQXQKQmb+EMDPVsmAv6hpaZQncVDen2LuAkDnMq0WWWwWDJnbOa
         IrihvhOWyw8Cxo3cxPh52sobJOwPle5+1zaCS3HirBte3aB7u9ZNQomqU+iw1UL9IY+1
         HaoRzT8U+ynlXEOPtJnC4+cD+5Wxve0+x+AKrsaXZX39KzFLoc9CnZbjd0pimIWc5GFk
         sDX5re6kp0pzuBKKn+DXCQrx7QIUvtKmL0XkfFRTlZO3n2nSnEJTkkDOY3ihcO8WFw7w
         X/1mMzKoDMB1jzjz/Ae8abw165xEp+qanjnw4kj84WIxpt/1Zm77jBBlT2+IZKx2GRgh
         /gzg==
X-Gm-Message-State: APjAAAXgued3jLYISU+m0jCezxWAMjIUXsiF3ZV5ptDh4NYLGPIjEPYf
        NmxhNafl9PlFU1TPEHD2OVY6OaAPfg8=
X-Google-Smtp-Source: APXvYqzVyIPOB8hfZJ6sxbs/sRJhJX3NiNTuvhtY5ovDYJCljQ2LK/8eEIk4LCPosK+XyKNYj4GuCA==
X-Received: by 2002:adf:fd91:: with SMTP id d17mr3045375wrr.214.1573136086761;
        Thu, 07 Nov 2019 06:14:46 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id b1sm2453888wrw.77.2019.11.07.06.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 06:14:46 -0800 (PST)
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
Subject: [PATCH 09/13] phy: usb: fix driver to defer on clk_get defer
Date:   Thu,  7 Nov 2019 09:13:35 -0500
Message-Id: <20191107141339.6079-10-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107141339.6079-1-alcooperx@gmail.com>
References: <20191107141339.6079-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle defer on clk_get because the new SCMI clock driver comes
up after this driver.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index b16b72a04eb4..9ae31fa184df 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -341,6 +341,8 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 
 	priv->usb_20_clk = of_clk_get_by_name(dn, "sw_usb");
 	if (IS_ERR(priv->usb_20_clk)) {
+		if (PTR_ERR(priv->usb_20_clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		dev_info(dev, "Clock not found in Device Tree\n");
 		priv->usb_20_clk = NULL;
 	}
@@ -371,6 +373,8 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 
 		priv->usb_30_clk = of_clk_get_by_name(dn, "sw_usb3");
 		if (IS_ERR(priv->usb_30_clk)) {
+			if (PTR_ERR(priv->usb_30_clk) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
 			dev_info(dev,
 				 "USB3.0 clock not found in Device Tree\n");
 			priv->usb_30_clk = NULL;
@@ -382,6 +386,8 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 
 	priv->suspend_clk = clk_get(dev, "usb0_freerun");
 	if (IS_ERR(priv->suspend_clk)) {
+		if (PTR_ERR(priv->suspend_clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		dev_err(dev, "Suspend Clock not found in Device Tree\n");
 		priv->suspend_clk = NULL;
 	}
-- 
2.17.1

