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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFE8C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DBC20740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUJy6L0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfKOSn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:43:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36446 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfKOSnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:43:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id c22so11494820wmd.1;
        Fri, 15 Nov 2019 10:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=44lDiZC/HyWHizJUTFlT+jmrIvxAJf5o2GDXJq7Fi20=;
        b=AUJy6L0FiPANesawRIslnabTIItR6XMOS4WHYQ3D6pc8miNDb/Z5X11gNI1eTl9q5q
         n3GmIiY8X9Nr7Lk5icpkz585MPqmz9RqdiCLJ+JJBHr9Yfk9/vSAAugoXB1FA5L7dSqi
         2AO3pQaBc65xkk/eh4X21dXAGMs0Nls620cHZyeBymyKKUUjHI/E+zU/NFppB9oTvxt3
         5jyhjIxeYtTiYjsC6NiptPWC8kjJRQBCIg2oiqPBsr8M0YOQlhj3CjhgSHI4ZWL4tWyK
         /EPJEkyZQSoNIel0I+TSbq8m8cRC/Q1U3lboURLdfxOxeVrtMYWNI5m420a24NxJGUS1
         G9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=44lDiZC/HyWHizJUTFlT+jmrIvxAJf5o2GDXJq7Fi20=;
        b=h71VNfmb3RJDlZuBvdLgAc/BwfsJwsLdjuMxpFCW8KzTkFbTg2kALOEmJPpFrC5eSu
         vMo65Q/zkNW6a4fach4RxfJfueRThKEQEZ4zvnz+yHSn2FJDETL9v9oBPYPIopXaQ7la
         TTHZurokIKY/oDpotH3uS3JfwIk7txdRa7Z05DwuXVCj17pgtDwuoicwDFAcIXjhvQMw
         svcNdRmDkE+6w1gtoC76X5bEr8pfCI3iobBR/yUfSgAjxdnj3LYPVbtZP7w0np99nm+C
         jGHQ69dNE86LlkHtok5ND22NPw99lFomSSsTVB6ZCUAsSz/6+mODMMwvHIICzA0hr6hk
         ytbg==
X-Gm-Message-State: APjAAAU9r2k9/WMs/rZVvcYGqUPJS6rjOntzShvasmACB32+0tUUIitK
        qx/pG0Az8srP7HwFXZqEN3IhrNQBw9Y=
X-Google-Smtp-Source: APXvYqwsBuwArKC2zsEagHcuDz0VELwiJxoMPPhcSFoPYDNRSb2qkuibjkIOivEmh4xMhP4E639SOg==
X-Received: by 2002:a05:600c:2041:: with SMTP id p1mr15806760wmg.11.1573843431625;
        Fri, 15 Nov 2019 10:43:51 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id g138sm2620989wmg.11.2019.11.15.10.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 10:43:51 -0800 (PST)
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
Subject: [PATCH v2 10/13] phy: usb: PHY's MDIO registers not accessible without device installed
Date:   Fri, 15 Nov 2019 13:42:20 -0500
Message-Id: <20191115184223.41504-11-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115184223.41504-1-alcooperx@gmail.com>
References: <20191115184223.41504-1-alcooperx@gmail.com>
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

