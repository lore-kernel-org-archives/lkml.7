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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8415AC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57597205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHVWFv9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfLIVoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:44:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46692 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfLIVoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:44:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so17736163wrl.13;
        Mon, 09 Dec 2019 13:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MFlnOn0CAyQafh0Ou2lpY54Ga03K/6YVfFICBBVyXck=;
        b=SHVWFv9GB7WIK89zZ8hpc/0h0SHf1QojbofoNottxLVBs8cwaCi/uw0BKp23J35PDY
         7R90wutJrku9GEhuBB5gUHpfyRA57I6HTkqqrSaESuZCZIIqQ1JPiKCkPWG4cObLBgDW
         SKbkIRYgc77Te+ipRvnbFBtWeBJXv2q3nsb2FAc8iGKCob9SsEEBg4k4L4cWb6deHOVp
         MeSQ6q/to/YFccbZidm1zjF1o4pS+Mc1xFZ4yssfRw/353obbuA7yNNVoTyhdx5bpPua
         I72aZPDZ9fQOMidU8hW//qM7oLG1WhEU1VybG1wAbvu68ll7FP/WN2Mxmy0CC1+zCIZi
         v0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MFlnOn0CAyQafh0Ou2lpY54Ga03K/6YVfFICBBVyXck=;
        b=V+NuOutV+cIhXFIvU8pqRgYkHUsi4f7gVtNpDZIIC/iTkqaHZBmKO1Vp4uxRoqyS1E
         PaGZZpv6j2oPabVyd3gPsk5xxZ9OOt4Boqw2RnfBzYsXSJyxNKTZK8liBL4dvrG2Ha5f
         jnPHOFRUlqwI1LM0wCREsZ3hDoaDqfISnEdBqH8SkA1G+6nEF7G5WsyXezfFBkylUQal
         b6T9aaYU6cx5O+fRseyJSg+42BjssRinIENpKlLORhXBuL00ZKwT1ojkrdTwwJRV2qno
         MNGpjrOl9csAHmazKYkIiosWSsOV2ChBVbxeic6lCAQmM/ZqKMF5b93OImAlnj/G8Z3X
         kr3A==
X-Gm-Message-State: APjAAAXSHvFzO8Xa4lyfQSu6XqcIrUsoRqZQ/eW5tMUHgI0OeaKlyzHJ
        jAiYioEnpHoNNZsFq7x7ytfScZaLnu8=
X-Google-Smtp-Source: APXvYqwG1UKTr4UFaDyUJ1p9KM4xQ1K1UnSzKjQP2ac5ZI/H35M7ZyI+I3zbKunyojLEclL4RAqeIA==
X-Received: by 2002:adf:f586:: with SMTP id f6mr4279702wro.46.1575927855823;
        Mon, 09 Dec 2019 13:44:15 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id z6sm757714wmz.12.2019.12.09.13.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 13:44:15 -0800 (PST)
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
Subject: [PATCH v2 resend 11/13] phy: usb: bdc: Fix occasional failure with BDC on 7211
Date:   Mon,  9 Dec 2019 16:42:47 -0500
Message-Id: <20191209214249.41137-12-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209214249.41137-1-alcooperx@gmail.com>
References: <20191209214249.41137-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BDC "Read Transaction Size" needs to be changed from 1024
bytes to 256 bytes to prevent occasional transaction failures.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../phy/broadcom/phy-brcm-usb-init-synopsis.c | 18 +++++++++++++++
 drivers/phy/broadcom/phy-brcm-usb-init.h      |  1 +
 drivers/phy/broadcom/phy-brcm-usb.c           | 23 +++++++++++++++----
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init-synopsis.c b/drivers/phy/broadcom/phy-brcm-usb-init-synopsis.c
index fe3f653c64a7..c6504649d307 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init-synopsis.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init-synopsis.c
@@ -70,6 +70,11 @@
 #define USB_GMDIOCSR	0
 #define USB_GMDIOGEN	4
 
+/* Register definitions for the BDC EC block in 7211b0 */
+#define BDC_EC_AXIRDA			0x0c
+#define   BDC_EC_AXIRDA_RTS_MASK			0xf0000000
+#define   BDC_EC_AXIRDA_RTS_SHIFT			28
+
 
 static void usb_mdio_write_7211b0(struct brcm_usb_init_params *params,
 				  uint8_t addr, uint16_t data)
@@ -198,6 +203,7 @@ static void usb_init_common_7211b0(struct brcm_usb_init_params *params)
 {
 	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 	void __iomem *usb_phy = params->regs[BRCM_REGS_USB_PHY];
+	void __iomem *bdc_ec = params->regs[BRCM_REGS_BDC_EC];
 	int timeout_ms = PHY_LOCK_TIMEOUT_MS;
 	u32 reg;
 
@@ -230,6 +236,18 @@ static void usb_init_common_7211b0(struct brcm_usb_init_params *params)
 
 	usb_init_common(params);
 
+	/*
+	 * The BDC controller will get occasional failures with
+	 * the default "Read Transaction Size" of 6 (1024 bytes).
+	 * Set it to 4 (256 bytes).
+	 */
+	if ((params->mode != USB_CTLR_MODE_HOST) && bdc_ec) {
+		reg = brcm_usb_readl(bdc_ec + BDC_EC_AXIRDA);
+		reg &= ~BDC_EC_AXIRDA_RTS_MASK;
+		reg |= (0x4 << BDC_EC_AXIRDA_RTS_SHIFT);
+		brcm_usb_writel(reg, bdc_ec + BDC_EC_AXIRDA);
+	}
+
 	/*
 	 * Disable FSM, otherwise the PHY will auto suspend when no
 	 * device is connected and will be reset on resume.
diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.h b/drivers/phy/broadcom/phy-brcm-usb-init.h
index 66363b04d778..570bd9d8c9ec 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.h
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.h
@@ -19,6 +19,7 @@ enum brcmusb_reg_sel {
 	BRCM_REGS_XHCI_GBL,
 	BRCM_REGS_USB_PHY,
 	BRCM_REGS_USB_MDIO,
+	BRCM_REGS_BDC_EC,
 	BRCM_REGS_MAX
 };
 
diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index c82d7ec15334..cc5763ace3ad 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -36,6 +36,7 @@ struct value_to_name_map {
 struct match_chip_info {
 	void *init_func;
 	u8 required_regs[BRCM_REGS_MAX + 1];
+	u8 optional_reg;
 };
 
 static struct value_to_name_map brcm_dr_mode_to_name[] = {
@@ -71,7 +72,7 @@ struct brcm_usb_phy_data {
 };
 
 static s8 *node_reg_names[BRCM_REGS_MAX] = {
-	"crtl", "xhci_ec", "xhci_gbl", "usb_phy", "usb_mdio"
+	"crtl", "xhci_ec", "xhci_gbl", "usb_phy", "usb_mdio", "bdc_ec"
 };
 
 static irqreturn_t brcm_usb_phy_wake_isr(int irq, void *dev_id)
@@ -271,6 +272,7 @@ static struct match_chip_info chip_info_7211b0 = {
 		BRCM_REGS_USB_MDIO,
 		-1,
 	},
+	.optional_reg = BRCM_REGS_BDC_EC,
 };
 
 static struct match_chip_info chip_info_7445 = {
@@ -300,7 +302,8 @@ static const struct of_device_id brcm_usb_dt_ids[] = {
 
 static int brcm_usb_get_regs(struct platform_device *pdev,
 			     enum brcmusb_reg_sel regs,
-			     struct  brcm_usb_init_params *ini)
+			     struct  brcm_usb_init_params *ini,
+			     bool optional)
 {
 	struct resource *res;
 
@@ -317,7 +320,13 @@ static int brcm_usb_get_regs(struct platform_device *pdev,
 				return 0;
 		}
 		if (res == NULL) {
-			dev_err(&pdev->dev, "can't get %s base address\n",
+			if (optional) {
+				dev_dbg(&pdev->dev,
+					"Optional reg %s not found\n",
+					node_reg_names[regs]);
+				return 0;
+			}
+			dev_err(&pdev->dev, "can't get %s base addr\n",
 				node_reg_names[regs]);
 			return 1;
 		}
@@ -460,7 +469,13 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 			break;
 
 		err = brcm_usb_get_regs(pdev, info->required_regs[x],
-					&priv->ini);
+					&priv->ini, false);
+		if (err)
+			return -EINVAL;
+	}
+	if (info->optional_reg) {
+		err = brcm_usb_get_regs(pdev, info->optional_reg,
+					&priv->ini, true);
 		if (err)
 			return -EINVAL;
 	}
-- 
2.17.1

