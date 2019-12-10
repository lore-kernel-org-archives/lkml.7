Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4E0C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AD3214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRroJBzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfLJNXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:23:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50990 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfLJNXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:23:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so3217605wmg.0;
        Tue, 10 Dec 2019 05:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=44lDiZC/HyWHizJUTFlT+jmrIvxAJf5o2GDXJq7Fi20=;
        b=kRroJBzAKKKmAwcsbcJbG1rZ0JkCkHxhTkdOKioiUAMuPjh/HBjgLoQWuWYrK6j5Q9
         sVPTcPcH5rbznIta+7bl4SP2LqWratl0CzfeG2r/Gq2bKo8byY4rm4TchnEoMQqGgxUg
         FdzoCuBxAv+hASweuy3TmPPl/qWYWAM7bLr7T+3I0NqqWnjJ3p/I5igo8fApZCabLsFf
         OpaZcxNRFEqhOf1d17RDE6Ed8UIy+w48SjWowAfLE8/j8Ttf4Tnat6Szuep7aiFJK1HH
         DEuveC8cEhqAvhSS/VzcOCbov+Q/PlbAl8cfUytepmzh6yywgzzvU00SMl39Qod71vGO
         lQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=44lDiZC/HyWHizJUTFlT+jmrIvxAJf5o2GDXJq7Fi20=;
        b=DNMlGK4VSn1uPTepjYfmtMaiTiqr95xg4nljlEdbiZHM3wU3LCsQA/L6HfLugplAq/
         oY51fqQndv31NZy92LKGS/u+U8bDZ1g/TfVGETHaNMmKdVfg2duGL+gCY5w5nLCxxrS0
         TkIjgMQXEjBSv/RcXnA48Nplo+qQAaYxHyeuefpUHZDH+ced62AIUq/rxZMcu+TAZpjX
         NasLNqt2k3jm/e7IBrbL5QwvABOcL/VSOHFgMOfq3tmBgTKJiPsC0FcJ5qqhKUZX8ojw
         3ZObYCZtjcRcHTPBogEzeatNFCDnfKDMGFdEbWLGQBZJKPH2Eewon6DWGgGEqW7uxBSZ
         /Djg==
X-Gm-Message-State: APjAAAW8Uef9oky2aepZukEKCCnKroJhfdR0YEV4F6W74LVR3+yXjPax
        ZvpfFvEnYPlGzHviKYEcX2SPM3/IMGw=
X-Google-Smtp-Source: APXvYqyyhMv4dbY67TEy7fz96u1SdwGMd0d3PmwQHFiJc/qOd/h/a645zpLfwEz3nMOQpl3YdRBMGA==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr4937677wmj.168.1575984228426;
        Tue, 10 Dec 2019 05:23:48 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id s82sm3101680wms.28.2019.12.10.05.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 05:23:47 -0800 (PST)
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
Subject: [PATCH v3 10/13] phy: usb: PHY's MDIO registers not accessible without device installed
Date:   Tue, 10 Dec 2019 08:21:29 -0500
Message-Id: <20191210132132.41509-11-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210132132.41509-1-alcooperx@gmail.com>
References: <20191210132132.41509-1-alcooperx@gmail.com>
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

