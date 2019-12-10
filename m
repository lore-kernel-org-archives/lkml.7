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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5AEC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91D42073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iryaSD52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfLJUJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:09:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38309 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfLJUJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:09:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so21561368wrh.5;
        Tue, 10 Dec 2019 12:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u/LjPuF3/fCHoU0gjJ+jhVHgMQTJmMf2Obyi4CIeoxM=;
        b=iryaSD524QzJLWrvBJeXCxs6EkdwiQqRjSmDFZXGuvbUw21wuS9yN10e3SW/37q6P9
         eWloyjbs5DoLPeR572uw1d5acE+ae35FV6018cV2NlXlw32USWCaLtnN4pKcTeW6sezR
         9c0omx2nBvsPnID3HTeIIPHzm8NU8i19qB4jC5esPPhsXMR6uKeU/TXsxRd4nXuqtaLg
         x8OaoJ0FzU9e/+nuyJEYyZr9mu6tcmOsUNDsG/BDRA5w+VnFsNU/yBR8xLJuoKwFG5C0
         X1MZeD8ui/GUMoCJ0JAzIdVIRSQXXzsHxzmXktm//gmUE93sthMSiLczVC9lH1B2b3IY
         6sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u/LjPuF3/fCHoU0gjJ+jhVHgMQTJmMf2Obyi4CIeoxM=;
        b=cdmupNeKLgstIJMy76UENIGly6L4hCC06eKlh854Jb5ZbYi/1miCgIsE3A3CN3eaUO
         RMMZnk9GN+qjbg4TDvbyI7zmUu+sFRGOqpW0n+C6SAoBojGca4ROxhONv5n0dutAmyGR
         NIpnN3gUE+qFZCTDOhtdPIkYotr1Ets40j4QnrFxzHaT9JKuRt/jH2tzxfHUfYJ965qf
         hte7eMZRXnTTMO8Y8VU2WIRUilJfWcKLNrTCsbcOb4BHIfueCqhB5l6Re8DN0WQuny3z
         4maD0NuDnCyAK9NZMDs6ZjGv2uk/o0VFNM8C9HJZbIKJ5rBM90IDM//9y5S778kifK1u
         qwRA==
X-Gm-Message-State: APjAAAX8UM8ai9imYkfQvoupYYSkHT2mEkNlLT0kLRnWbjAlmlf+XDJM
        jormGI/jYBqYNEXo+E1LHdU=
X-Google-Smtp-Source: APXvYqz1HahWkU6kOI2OPxbyEF894A8hHjOhrlhREULuOqq0LKqnnSaxBzfWtlfLB1Lx0VXZjwD33g==
X-Received: by 2002:adf:ee92:: with SMTP id b18mr5465886wro.281.1576008559977;
        Tue, 10 Dec 2019 12:09:19 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w19sm4113643wmc.22.2019.12.10.12.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:09:19 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     kishon@ti.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 2/2] phy: brcm-sata: Implement 7216 initialization sequence
Date:   Tue, 10 Dec 2019 12:08:52 -0800
Message-Id: <20191210200852.24945-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210200852.24945-1-f.fainelli@gmail.com>
References: <20191210200852.24945-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7216 is a 16nm process chip with a slightly different version of the PHY
SerdDeS/AFE that requires a specific tuning sequence. Key on the
compatible string to perform that initialization.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-sata.c | 120 +++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
index 50ac75bbb0c9..4710cfcc3037 100644
--- a/drivers/phy/broadcom/phy-brcm-sata.c
+++ b/drivers/phy/broadcom/phy-brcm-sata.c
@@ -33,6 +33,7 @@
 #define SATA_PHY_CTRL_REG_28NM_SPACE_SIZE		0x8
 
 enum brcm_sata_phy_version {
+	BRCM_SATA_PHY_STB_16NM,
 	BRCM_SATA_PHY_STB_28NM,
 	BRCM_SATA_PHY_STB_40NM,
 	BRCM_SATA_PHY_IPROC_NS2,
@@ -104,10 +105,13 @@ enum sata_phy_regs {
 	PLL1_ACTRL5				= 0x85,
 	PLL1_ACTRL6				= 0x86,
 	PLL1_ACTRL7				= 0x87,
+	PLL1_ACTRL8				= 0x88,
 
 	TX_REG_BANK				= 0x070,
 	TX_ACTRL0				= 0x80,
 	TX_ACTRL0_TXPOL_FLIP			= BIT(6),
+	TX_ACTRL5				= 0x85,
+	TX_ACTRL5_SSC_EN			= BIT(11),
 
 	AEQRX_REG_BANK_0			= 0xd0,
 	AEQ_CONTROL1				= 0x81,
@@ -116,6 +120,7 @@ enum sata_phy_regs {
 	AEQ_FRC_EQ				= 0x83,
 	AEQ_FRC_EQ_FORCE			= BIT(0),
 	AEQ_FRC_EQ_FORCE_VAL			= BIT(1),
+	AEQ_RFZ_FRC_VAL				= BIT(8),
 	AEQRX_REG_BANK_1			= 0xe0,
 	AEQRX_SLCAL0_CTRL0			= 0x82,
 	AEQRX_SLCAL1_CTRL0			= 0x86,
@@ -152,7 +157,28 @@ enum sata_phy_regs {
 	TXPMD_TX_FREQ_CTRL_CONTROL3_FMAX_MASK	= 0x3ff,
 
 	RXPMD_REG_BANK				= 0x1c0,
+	RXPMD_RX_CDR_CONTROL1			= 0x81,
+	RXPMD_RX_PPM_VAL_MASK			= 0x1ff,
+	RXPMD_RXPMD_EN_FRC			= BIT(12),
+	RXPMD_RXPMD_EN_FRC_VAL			= BIT(13),
+	RXPMD_RX_CDR_CDR_PROP_BW		= 0x82,
+	RXPMD_G_CDR_PROP_BW_MASK		= 0x7,
+	RXPMD_G1_CDR_PROP_BW_SHIFT		= 0,
+	RXPMD_G2_CDR_PROP_BW_SHIFT		= 3,
+	RXPMD_G3_CDR_PROB_BW_SHIFT		= 6,
+	RXPMD_RX_CDR_CDR_ACQ_INTEG_BW		= 0x83,
+	RXPMD_G_CDR_ACQ_INT_BW_MASK		= 0x7,
+	RXPMD_G1_CDR_ACQ_INT_BW_SHIFT		= 0,
+	RXPMD_G2_CDR_ACQ_INT_BW_SHIFT		= 3,
+	RXPMD_G3_CDR_ACQ_INT_BW_SHIFT		= 6,
+	RXPMD_RX_CDR_CDR_LOCK_INTEG_BW		= 0x84,
+	RXPMD_G_CDR_LOCK_INT_BW_MASK		= 0x7,
+	RXPMD_G1_CDR_LOCK_INT_BW_SHIFT		= 0,
+	RXPMD_G2_CDR_LOCK_INT_BW_SHIFT		= 3,
+	RXPMD_G3_CDR_LOCK_INT_BW_SHIFT		= 6,
 	RXPMD_RX_FREQ_MON_CONTROL1		= 0x87,
+	RXPMD_MON_CORRECT_EN			= BIT(8),
+	RXPMD_MON_MARGIN_VAL_MASK		= 0xff,
 };
 
 enum sata_phy_ctrl_regs {
@@ -166,6 +192,7 @@ static inline void __iomem *brcm_sata_pcb_base(struct brcm_sata_port *port)
 	u32 size = 0;
 
 	switch (priv->version) {
+	case BRCM_SATA_PHY_STB_16NM:
 	case BRCM_SATA_PHY_STB_28NM:
 	case BRCM_SATA_PHY_IPROC_NS2:
 	case BRCM_SATA_PHY_DSL_28NM:
@@ -287,6 +314,94 @@ static int brcm_stb_sata_init(struct brcm_sata_port *port)
 	return brcm_stb_sata_rxaeq_init(port);
 }
 
+static int brcm_stb_sata_16nm_ssc_init(struct brcm_sata_port *port)
+{
+	void __iomem *base = brcm_sata_pcb_base(port);
+	u32 tmp, value;
+
+	/* Reduce CP tail current to 1/16th of its default value */
+	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL6, 0, 0x141);
+
+	/* Turn off CP tail current boost */
+	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL8, 0, 0xc006);
+
+	/* Set a specific AEQ equalizer value */
+	tmp = AEQ_FRC_EQ_FORCE_VAL | AEQ_FRC_EQ_FORCE;
+	brcm_sata_phy_wr(base, AEQRX_REG_BANK_0, AEQ_FRC_EQ,
+			 ~(tmp | AEQ_RFZ_FRC_VAL |
+			   AEQ_FRC_EQ_VAL_MASK << AEQ_FRC_EQ_VAL_SHIFT),
+			 tmp | 32 << AEQ_FRC_EQ_VAL_SHIFT);
+
+	/* Set RX PPM val center frequency */
+	if (port->ssc_en)
+		value = 0x52;
+	else
+		value = 0;
+	brcm_sata_phy_wr(base, RXPMD_REG_BANK, RXPMD_RX_CDR_CONTROL1,
+			 ~RXPMD_RX_PPM_VAL_MASK, value);
+
+	/* Set proportional loop bandwith Gen1/2/3 */
+	tmp = RXPMD_G_CDR_PROP_BW_MASK << RXPMD_G1_CDR_PROP_BW_SHIFT |
+	      RXPMD_G_CDR_PROP_BW_MASK << RXPMD_G2_CDR_PROP_BW_SHIFT |
+	      RXPMD_G_CDR_PROP_BW_MASK << RXPMD_G3_CDR_PROB_BW_SHIFT;
+	if (port->ssc_en)
+		value = 2 << RXPMD_G1_CDR_PROP_BW_SHIFT |
+			2 << RXPMD_G2_CDR_PROP_BW_SHIFT |
+			2 << RXPMD_G3_CDR_PROB_BW_SHIFT;
+	else
+		value = 1 << RXPMD_G1_CDR_PROP_BW_SHIFT |
+			1 << RXPMD_G2_CDR_PROP_BW_SHIFT |
+			1 << RXPMD_G3_CDR_PROB_BW_SHIFT;
+	brcm_sata_phy_wr(base, RXPMD_REG_BANK, RXPMD_RX_CDR_CDR_PROP_BW, ~tmp,
+			 value);
+
+	/* Set CDR integral loop acquisition bandwidth for Gen1/2/3 */
+	tmp = RXPMD_G_CDR_ACQ_INT_BW_MASK << RXPMD_G1_CDR_ACQ_INT_BW_SHIFT |
+	      RXPMD_G_CDR_ACQ_INT_BW_MASK << RXPMD_G2_CDR_ACQ_INT_BW_SHIFT |
+	      RXPMD_G_CDR_ACQ_INT_BW_MASK << RXPMD_G3_CDR_ACQ_INT_BW_SHIFT;
+	if (port->ssc_en)
+		value = 1 << RXPMD_G1_CDR_ACQ_INT_BW_SHIFT |
+			1 << RXPMD_G2_CDR_ACQ_INT_BW_SHIFT |
+			1 << RXPMD_G3_CDR_ACQ_INT_BW_SHIFT;
+	else
+		value = 0;
+	brcm_sata_phy_wr(base, RXPMD_REG_BANK, RXPMD_RX_CDR_CDR_ACQ_INTEG_BW,
+			 ~tmp, value);
+
+	/* Set CDR integral loop locking bandwidth to 1 for Gen 1/2/3 */
+	tmp = RXPMD_G_CDR_LOCK_INT_BW_MASK << RXPMD_G1_CDR_LOCK_INT_BW_SHIFT |
+	      RXPMD_G_CDR_LOCK_INT_BW_MASK << RXPMD_G2_CDR_LOCK_INT_BW_SHIFT |
+	      RXPMD_G_CDR_LOCK_INT_BW_MASK << RXPMD_G3_CDR_LOCK_INT_BW_SHIFT;
+	if (port->ssc_en)
+		value = 1 << RXPMD_G1_CDR_LOCK_INT_BW_SHIFT |
+			1 << RXPMD_G2_CDR_LOCK_INT_BW_SHIFT |
+			1 << RXPMD_G3_CDR_LOCK_INT_BW_SHIFT;
+	else
+		value = 0;
+	brcm_sata_phy_wr(base, RXPMD_REG_BANK, RXPMD_RX_CDR_CDR_LOCK_INTEG_BW,
+			 ~tmp, value);
+
+	/* Set no guard band and clamp CDR */
+	tmp = RXPMD_MON_CORRECT_EN | RXPMD_MON_MARGIN_VAL_MASK;
+	if (port->ssc_en)
+		value = 0x51;
+	else
+		value = 0;
+	brcm_sata_phy_wr(base, RXPMD_REG_BANK, RXPMD_RX_FREQ_MON_CONTROL1,
+			 ~tmp, RXPMD_MON_CORRECT_EN | value);
+
+	/* Turn on/off SSC */
+	brcm_sata_phy_wr(base, TX_REG_BANK, TX_ACTRL5, ~TX_ACTRL5_SSC_EN,
+			 port->ssc_en ? TX_ACTRL5_SSC_EN : 0);
+
+	return 0;
+}
+
+static int brcm_stb_sata_16nm_init(struct brcm_sata_port *port)
+{
+	return brcm_stb_sata_16nm_ssc_init(port);
+}
+
 /* NS2 SATA PLL1 defaults were characterized by H/W group */
 #define NS2_PLL1_ACTRL2_MAGIC	0x1df8
 #define NS2_PLL1_ACTRL3_MAGIC	0x2b00
@@ -544,6 +659,9 @@ static int brcm_sata_phy_init(struct phy *phy)
 	struct brcm_sata_port *port = phy_get_drvdata(phy);
 
 	switch (port->phy_priv->version) {
+	case BRCM_SATA_PHY_STB_16NM:
+		rc = brcm_stb_sata_16nm_init(port);
+		break;
 	case BRCM_SATA_PHY_STB_28NM:
 	case BRCM_SATA_PHY_STB_40NM:
 		rc = brcm_stb_sata_init(port);
@@ -601,6 +719,8 @@ static const struct phy_ops phy_ops = {
 };
 
 static const struct of_device_id brcm_sata_phy_of_match[] = {
+	{ .compatible	= "brcm,bcm7216-sata-phy",
+	  .data = (void *)BRCM_SATA_PHY_STB_16NM },
 	{ .compatible	= "brcm,bcm7445-sata-phy",
 	  .data = (void *)BRCM_SATA_PHY_STB_28NM },
 	{ .compatible	= "brcm,bcm7425-sata-phy",
-- 
2.17.1

