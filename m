Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B43C32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AB22253D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzEwOlRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgACSTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:19:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44320 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgACSTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:19:39 -0500
Received: by mail-pg1-f194.google.com with SMTP id x7so23751448pgl.11;
        Fri, 03 Jan 2020 10:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RT3uMjCTNXctwL3ki3eO315EjLjo+qSfc5PPzuNqLtA=;
        b=FzEwOlRMFbNiAhqLfljSym93jTMUvS6k/dZXg/3L5CJaQ7moGCyNKhVKO0OCLqmXCa
         NwaRYzWB63wbqKSDgQmEe0dMyasgcs9aqAzXNkxyFtfyJYajfzUA0qtDxQaxZn88oLWC
         eLrKKiblk7vsDVeB9dm4H+ItRv7kzOWYSc13jF8uLuv+I/TjfYtVNTbDeqvuHpH4wLaI
         Q6706UTsTyWC4ixkLU3kV6thFd332tt0MS3gtWIT3bMDegkoiw4mYCsucyNQdtyRqooK
         UyVNN8fCYzEcHWJskkNSYvRG5RItugITX0NDErPPKcc/b81yrRcqixHEagD0NWtV0uu/
         nxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RT3uMjCTNXctwL3ki3eO315EjLjo+qSfc5PPzuNqLtA=;
        b=PFj11qRCsBRG0tJfXMwsg+Z5OT4/HzXQPwRlESc4vZBCnwKBvR4eoqYtmeam7d2U5J
         h6BPv9MwihC8CWgKa/oLOCEQYdIGuevYvLxmhzzD/t7V7VASXD59dgIwtOAu1z/fwNGH
         3rcFIJmuuVAqdp98V7hhlF9V3MlvpSWhiphSStkFwNYJmQNFGp0ZxU1yr0LuHdIWWtAG
         YDeiLsItstNvtd2Tu8rFhHHw9Owd7kHfRAi1GxgsDffWKaiwMGvvJLnn8QwylaCp2Jf3
         TiySjcd6VOP1W2/H9Sr8APBdge2r+fN54per/jEPzbv8N/TXjjX199QVa3Tj/sUP6Kjj
         Q5AQ==
X-Gm-Message-State: APjAAAUUEu2Ysc4vGzZMYWkoctH1+poewNuCSchfMtHJvgcZnhQTimAQ
        hQmHxwXkCm/m8N9IpYuc7rNzgYmj
X-Google-Smtp-Source: APXvYqwk5XDkvs1zJukGqobBsjnTy+tRHSX4K/8jH+V2gZBNBh0xSYIuGwEy1nH9zh4f/xv40Rz/gw==
X-Received: by 2002:aa7:8d8f:: with SMTP id i15mr66919232pfr.220.1578075578412;
        Fri, 03 Jan 2020 10:19:38 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j8sm41783602pfe.182.2020.01.03.10.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 10:19:38 -0800 (PST)
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
Subject: [PATCH v4 09/13] phy: usb: fix driver to defer on clk_get defer
Date:   Fri,  3 Jan 2020 13:18:07 -0500
Message-Id: <20200103181811.22939-10-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103181811.22939-1-alcooperx@gmail.com>
References: <20200103181811.22939-1-alcooperx@gmail.com>
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
index 5f7bfa09494d..c82d7ec15334 100644
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

