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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F49FC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7600A2464E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rr2oD3VV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgACSTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:19:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39678 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgACSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:19:41 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so16368013plp.6;
        Fri, 03 Jan 2020 10:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hObdGfhJZd0SmP8SodLo/G+SfyA3edd8eSiGk2vdy/s=;
        b=rr2oD3VVAcuSjaCyH+1w105sIq0VCXM5GrVe2oYbdEhaZj21pxjsHxinGTzvYpGtz3
         yBAcQlOLvUdcc4PVExO2HHJsjd43SxfEO5JHcWckCmnzVpOUDM0pCU3QH4eEbozNI1wA
         RJ+5wD00KMQATPlxf+tD51y4foy+E1kjAFbW5LohNoJdwNF2ssEudpeXuwf3HJWFCxcF
         4Axn7q9ewa8/fyUiK08HQpwM2rptVr/c16gjPlwjj7UyzFVzuc2T/ADD2GTGG4HFrBnN
         bZF2CFLt0MDLul1CPAedBFA8pNOIwgd2Box/OWh+B6FEdhZKtuMZrgrRzJMYZnGIgapF
         wTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hObdGfhJZd0SmP8SodLo/G+SfyA3edd8eSiGk2vdy/s=;
        b=QyG/JUi5IOKAFsBRSAAz5n+iAvYoBgm1wyequ6/JNaF05dw9kPk1CtpJInBRcpDv+D
         Q8kyYuoicj6xuYnivC5RERQQ5LbGFLrxvSC6DUQuArCsA6JU2rzd1KWkrKZZt8DHIZyI
         dFZTWjJptSYwxI2WyoKhwgMYOwgimUHGphzGfdIKotQhZGhHvzgzr+m9hL+N/SOacJgp
         Hgnd1gckffSLXOXe4jJhTeZhOkMi6x10LVErH0zPn7u+q0/q6X9em0XDeIrPT3YYYI4O
         RjbFLmzbDu+GLZksGIpLiJ37caNrLls9hQZAg55PYkJJUmNz7zHw73+DTZCFXT3c+Q6c
         co0A==
X-Gm-Message-State: APjAAAVudzzpV7lQg3F2AdpcjeMAmrWJASb6uURYrvm1nZxMkTwB/i7S
        /9WMt0MqkUgOMM0WWbnwEl/xa4tQ
X-Google-Smtp-Source: APXvYqyxVbyVdmuEyNYCeZvfxH9A1WjQiJHvKs5vzKLwH12ImzSu2kcR/dCMUQBUYJlzV89Xo4lVCA==
X-Received: by 2002:a17:902:aa48:: with SMTP id c8mr92033758plr.243.1578075580077;
        Fri, 03 Jan 2020 10:19:40 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j8sm41783602pfe.182.2020.01.03.10.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 10:19:39 -0800 (PST)
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
Subject: [PATCH v4 10/13] phy: usb: PHY's MDIO registers not accessible without device installed
Date:   Fri,  3 Jan 2020 13:18:08 -0500
Message-Id: <20200103181811.22939-11-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103181811.22939-1-alcooperx@gmail.com>
References: <20200103181811.22939-1-alcooperx@gmail.com>
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
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
index ee49cbdb55bb..ce4226ac552e 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
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

