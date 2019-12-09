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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A554C2D0C5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DAA205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgdntmBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfLIVoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:44:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38917 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfLIVoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:44:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so907098wmh.4;
        Mon, 09 Dec 2019 13:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=44lDiZC/HyWHizJUTFlT+jmrIvxAJf5o2GDXJq7Fi20=;
        b=NgdntmBjBBI7US/R8tQl9uYXTQr/3n2UwD+ASgV5d10EsibdIvI3Yo2xWBOK2JZGC0
         VSvP9nitBOAADTY5KKwBWnkcx3ADbR4uMJDh4F4aW7GGex5dFBNS3KfP/iynk4baKZF8
         0uTQhnNkTPhorbEUxDAhb0b6plLaUedcyWca5RDus++kDJKdE/RPxy853xrDmSad2SaT
         kIDEwVecCWDzrqPCgBy7eSzsdzibyEpVH/1MW65aVkTVSIe+DKudP5+capDKPT41agrT
         ssxkUpDdksUpHcO3tLySr3fx2bvLTNaKX+V6VKKf/Nb7ALYJ/B9svms03W2dQCELd5g4
         WFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=44lDiZC/HyWHizJUTFlT+jmrIvxAJf5o2GDXJq7Fi20=;
        b=nmjg0f5YSpF8kWT4PGoyWLiWSYzK2botz8bacZVXq0w3B0dJInktWBIJei/FWh3cRm
         OgMYPEtcLlf0TpauY5YRoUBYBHu+o7fXdyOfhnTfniuFO1X/sKLuyM24xo6mCqpU2sm2
         PGN7GZIf/laMIsDNUdFg9AaREUjp2rO8LXks9cMoQUGiRYnijDNorA7q0epA3xcZiKks
         zAF0c02Fx5WrL7+DqccOmzuLDQ1QafgOtIqZT1EehSTUEK1SctbrPU8PiSxL0wUuKqqB
         bVeSkOlBMxXbLz+5U0LYvzUuAGc3SxPDkF/0qMFoPLllWkN3+WjsOQJ+wKTLhedMnela
         SHag==
X-Gm-Message-State: APjAAAWCNzXZ1YChtN9do7Rxx5Qzx5/OLAr/3mUbiAdZijLMn7gjQumY
        XrVJzQtA2dqFg+UT2F57IUrtpyX6X7A=
X-Google-Smtp-Source: APXvYqy43EGY0bmWLyYnSp0se8lx2Ly4EXqffgmg01xOU1mzl0LzhGx9k8wzdlWFatOlTMcGtckElw==
X-Received: by 2002:a1c:a984:: with SMTP id s126mr1225626wme.146.1575927853828;
        Mon, 09 Dec 2019 13:44:13 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id z6sm757714wmz.12.2019.12.09.13.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 13:44:13 -0800 (PST)
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
Subject: [PATCH v2 resend 10/13] phy: usb: PHY's MDIO registers not accessible without device installed
Date:   Mon,  9 Dec 2019 16:42:46 -0500
Message-Id: <20191209214249.41137-11-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209214249.41137-1-alcooperx@gmail.com>
References: <20191209214249.41137-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is no device connected and FSM is enabled, the XHCI puts
the PHY into suspend mode.  When the PHY is put into suspend mode
the USB LDO powers down the PHY. This causes the MDIO to be
inaccessible and its registers reset to default. The fix is to
disable FSM.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb-init-synopsis.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init-synopsis.c b/drivers/phy/broadcom/phy-brcm-usb-init-synopsis.c
index bf138867efb1..fe3f653c64a7 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init-synopsis.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init-synopsis.c
@@ -56,6 +56,7 @@
 #define USB_PHY_PLL_LDO_CTL		0x08
 #define   USB_PHY_PLL_LDO_CTL_AFE_CORERDY_MASK		0x00000004
 #define USB_PHY_UTMI_CTL_1		0x04
+#define   USB_PHY_UTMI_CTL_1_POWER_UP_FSM_EN_MASK	0x00000800
 #define   USB_PHY_UTMI_CTL_1_PHY_MODE_MASK		0x0000000c
 #define   USB_PHY_UTMI_CTL_1_PHY_MODE_SHIFT		2
 #define USB_PHY_STATUS			0x20
@@ -229,6 +230,14 @@ static void usb_init_common_7211b0(struct brcm_usb_init_params *params)
 
 	usb_init_common(params);
 
+	/*
+	 * Disable FSM, otherwise the PHY will auto suspend when no
+	 * device is connected and will be reset on resume.
+	 */
+	reg = brcm_usb_readl(usb_phy + USB_PHY_UTMI_CTL_1);
+	reg &= ~USB_PHY_UTMI_CTL_1_POWER_UP_FSM_EN_MASK;
+	brcm_usb_writel(reg, usb_phy + USB_PHY_UTMI_CTL_1);
+
 	usb2_eye_fix_7211b0(params);
 }
 
-- 
2.17.1

