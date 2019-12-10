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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672D5C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D267208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu1LtkIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfLJNX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:23:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56026 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727625AbfLJNXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:23:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so3184811wmj.5;
        Tue, 10 Dec 2019 05:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wS4OYwLXLEvBtINm/7GwVk3W/9nI5ZzRdQ3AYe/w/RE=;
        b=Fu1LtkIuLARFdm/9GgPl/lueamweLUNxWP1y6mMVz45hVC7qqPlEZNGJENvQI3hgUP
         gVVvQLdtiSYFmn+EIWNTzIYdAS0846tqC2Gp8XZxL8+bQ79PRc/Yn6wVCahElwQD7eSy
         5Ic7EfUj41zeS+NnaEZW30qn87Rj44EfvoSQmGrJxy7LIhMN1wcAb9QgYdLH+ZcbJimR
         Xf4+WhbQI5+zRTEfS2Ls4NSKePRpC0MowYlMBRrXv7j/cMv1Y+8Ukfg1FgwzcTwNjQku
         14rLfeu7NpZ0PBMZGxK6q5/JKeMuXVbqme5XLgYPoO2sAPQG5zk3SXno9UXRT0e6Gklp
         QUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wS4OYwLXLEvBtINm/7GwVk3W/9nI5ZzRdQ3AYe/w/RE=;
        b=JSgZuEzceSHlwgCYyF9jEnRwQOPXVZ6qRVGEnyRE7AWoudiGACsaeR2BIXKRT7VJE3
         uEXyVsWc4tj5yy8tHtasZoLP8tFQYr9+JEXpleuaQq6MecquAn1jhkXmRt5e/FXJL9/u
         ZIVuHWb8uCW1vvN0KDnytDEuEa1TiqPNYQo4s2lj8An73M3Juz5/HJwqPsEbFJp48jgb
         fQ2Vox+EcRhebawQjMEkLZ2ibQFaDQVC9WylxAmAjhDmgS+eGzwjKQviWp7V6PcqPN0b
         s9hOo9F+LNbLcjti46BXyMtqdBIEgrL6BSGpJc20+xggX3MMqHIEz4vo55SpHuFgW5PG
         +N0A==
X-Gm-Message-State: APjAAAVYmd9MpjoOJdXU4XieGy3p3RhWWJKsRd2Ujhs+xPzgUKaJ8Qr7
        qpOdlxkE/KGvENIW5JMXt1hrIY5MJGw=
X-Google-Smtp-Source: APXvYqxmm6xjOoklsCQq4CtTblMfdkOZjUUBsUhviFDYr3aP4pYyN3txPMaHU+23EZ0ModoCGwMeWg==
X-Received: by 2002:a1c:c3c4:: with SMTP id t187mr5109555wmf.4.1575984232534;
        Tue, 10 Dec 2019 05:23:52 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id s82sm3101680wms.28.2019.12.10.05.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 05:23:52 -0800 (PST)
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
Subject: [PATCH v3 12/13] phy: usb: USB driver is crashing during S3 resume on 7216
Date:   Tue, 10 Dec 2019 08:21:31 -0500
Message-Id: <20191210132132.41509-13-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210132132.41509-1-alcooperx@gmail.com>
References: <20191210132132.41509-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a result of the USB 2.0 clocks not being disabled/enabled
during suspend/resume on XHCI only systems.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index cc5763ace3ad..1ab44f54244b 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -543,7 +543,7 @@ static int brcm_usb_phy_suspend(struct device *dev)
 		brcm_usb_wake_enable(&priv->ini, true);
 		if (priv->phys[BRCM_USB_PHY_3_0].inited)
 			clk_disable_unprepare(priv->usb_30_clk);
-		if (priv->phys[BRCM_USB_PHY_2_0].inited)
+		if (priv->phys[BRCM_USB_PHY_2_0].inited || !priv->has_eohci)
 			clk_disable_unprepare(priv->usb_20_clk);
 		if (priv->wake_irq >= 0)
 			enable_irq_wake(priv->wake_irq);
-- 
2.17.1

