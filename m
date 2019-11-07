Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9543C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F60E21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6jSn3ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389542AbfKGOO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:14:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38245 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389491AbfKGOOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:14:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id z19so2604561wmk.3;
        Thu, 07 Nov 2019 06:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qrmqnLxj9ViNIz24qh8h+av4z6lprup9FZW6EXn4bM4=;
        b=L6jSn3ldErdD/bnstHkmzs3fUrPtIUHL+/MxvrWpyq/8Qw2ssBiyQnNLEIJawo63ZX
         GDxlKi35vsiYCcw93n5LX6lXhK/DTLyW/0PXAtD/AdeFht4XEIqWRYk5y3B9O5ztMtkk
         EB4lj25YQHGXpUYR66ywiW9ctPiVNKwtKZSGwdFqrDT4SIEvNZZS4WzpvPsaKlp/fjkk
         XMd0a3d6SMsPCkEuT9qiRWRaf5XBOUzYL94iIbMv8DbQU5FiHheo8nO6usJKSD5YjgWr
         TX9ECCDssAtFsAuqz0UElVpiLZfvZPdvL4Me5CwYAwWnol6dsaEsXy63D/86qQZvH6f/
         NEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qrmqnLxj9ViNIz24qh8h+av4z6lprup9FZW6EXn4bM4=;
        b=Fz+aKXv+IT5I3K5uR6TGHl9e4K9y8kT2Ah9s9i+dRhfzge02kKYnrljZ6fpQq8nvKc
         CJGYtQVrpy4B1sJcwgUYPyTxT7YdGRCTTSFujt+aW9cQV20LFAxMPPDcECWXW+to5efw
         LPAFK/NsgW2bHFGDTKFBgajR93srDvaTX/rqvhDa/UAy6rLExyYEPPx3XLFWfFZ0lyy8
         d1JMoeLlxgfTgyp4EcSG4y4yB98h1/vEjSFVsyP/lLgTsKq7O0PqjFAnxpFqdS9sw6i/
         zIkGOLIBVPgLJDw1cCEfSgDQR4bqiDGaN+udthiv9oXOsY7J8GifStfnxJZv+prbzUZM
         wSag==
X-Gm-Message-State: APjAAAV6fj6FuflC/V8ggZs8SEX7xbonXtgMgok0xpF4bJNY5T23qO1r
        FvDLeJGYI23rjeJtdrBkXvsB3E5qzfs=
X-Google-Smtp-Source: APXvYqx8eKjCmwHjI9gk2ZS8I9ZL7RbZRd9FNrq+t53DA1nQjqz2un8g//2InTi8rDXZsoT80mhksw==
X-Received: by 2002:a1c:9a4f:: with SMTP id c76mr3158475wme.103.1573136090710;
        Thu, 07 Nov 2019 06:14:50 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id b1sm2453888wrw.77.2019.11.07.06.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 06:14:50 -0800 (PST)
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
Subject: [PATCH 11/13] phy: usb: bdc: Fix occasional failure with BDC on 7211
Date:   Thu,  7 Nov 2019 09:13:37 -0500
Message-Id: <20191107141339.6079-12-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107141339.6079-1-alcooperx@gmail.com>
References: <20191107141339.6079-1-alcooperx@gmail.com>
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
index 9ae31fa184df..2a06965d20b8 100644
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
@@ -458,7 +467,13 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
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

