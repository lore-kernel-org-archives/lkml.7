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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D125C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35E321882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt6s7B+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbfKGOOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:14:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33669 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389440AbfKGOOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:14:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id w30so3267081wra.0;
        Thu, 07 Nov 2019 06:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=44lDiZC/HyWHizJUTFlT+jmrIvxAJf5o2GDXJq7Fi20=;
        b=dt6s7B+3L7faldxtLN8sdJQXFvpAsXkV/6ry7E6zqBccZhB1+a5d8vQQqzVLke2AEq
         TkYHtFivAYYZ7pjwH17Ohi8T4dbpe6ovYNZQtg2NvLMuBzRg5FplWSEFROMG66u3nLer
         +JFXwEPbcqO1M75UrINLVF57DZm27fcNkj90MYWE7GMzk/gkSwunJuf6j1zPX3lS5Ajx
         7A8YYwtVfeDi4ggJpyE80bIBAyHVtDhWEaMuvFonNNCPvBp+PdzgMoCFHSBOxD+qqV3Q
         moTbenVbsXp+WQPa+jwTYE/0HtDWMRjGLjQIT6ntL7QYHLmiroMXiqpzFTQJ2mt0HSnh
         nrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=44lDiZC/HyWHizJUTFlT+jmrIvxAJf5o2GDXJq7Fi20=;
        b=tp6WNIKCpuTGdIYkcQjEMtlpjg3mtrY9benBoBnSk8CwqATEBrgLIFjvDXzhEbxgKh
         3wD+3NdoJyamaBZU9eE2V6Pa8D+rDy52tmYKYC6xph3jmPU1kf6KoK3BTFqqp7YpIfv9
         m3VdoEqEMJBD4GZeE6M2YV++cm9pPcvfRlloLKxXQyqxar8i2u9dHfglPhtunlivn7tC
         /nz2psB5V4bYYZ3A2pplNARrr1k9fBlAfYBm9aiq4CvKEsmQ8jS26sLzNdA1Qj1MwJUc
         Yu3H9IkvbGK1LqZy6bP81u0nHw7Ru5c6Xes0xt7BvsurfqOI51EL5FXzpIWzo+yoXg6G
         hVZQ==
X-Gm-Message-State: APjAAAVdJ94H5NLZIkaNyhkZuMuohSODyttUV1HzPfNLC2Bb/xZ9I4rh
        Zbmj4wbMkcgkOTbJRvJGoEfyCuCG8lw=
X-Google-Smtp-Source: APXvYqxAJAvZOWtRDoSOZlYra1V2iZ+H2tnGhHLQCy8LALFXp7QN0F3x0hKfAPUThi0tjSepKOrfLQ==
X-Received: by 2002:adf:e449:: with SMTP id t9mr3242971wrm.196.1573136088683;
        Thu, 07 Nov 2019 06:14:48 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id b1sm2453888wrw.77.2019.11.07.06.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 06:14:48 -0800 (PST)
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
Subject: [PATCH 10/13] phy: usb: PHY's MDIO registers not accessible without device installed
Date:   Thu,  7 Nov 2019 09:13:36 -0500
Message-Id: <20191107141339.6079-11-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107141339.6079-1-alcooperx@gmail.com>
References: <20191107141339.6079-1-alcooperx@gmail.com>
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

