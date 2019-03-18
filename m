Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5454CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133D22133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnXEn7U8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfCRS64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:58:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53528 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfCRS64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:58:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id e74so14134301wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 11:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=8Vs9SnGE5lXkHgcMHiWF2IZO6U3rU+rpYz5WSEKAHIs=;
        b=OnXEn7U8h6fR4JC9Y9ddjBmezd+RWijbI2WMZw+xgwsgW/bLvt68c6UsK5PUzyHOHx
         aRK8xqKk+K4m6CFjLq0Fdp+0sVsuj0tJy7udjclosHEmKNQMrnd8R9e3ieS+IAjZgfar
         2i+01pgwd9YjL4f4G2/g6Zw/koXLovgmD7hj9jqNbdNiri7y23D/l4XdIMFg00iRYlO6
         h+tscWkyGq2wywvY1DrvXY2BXj94/26cYzyvrqBbKUwyja9H85HNclNPe9EU+MKxniB9
         LUwZWCWSbF6V2/zhSKjCyEnb2ZH0NYZuJRuIelB7VcWrgr27O2GaLDEWRELD461WWTgl
         wyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=8Vs9SnGE5lXkHgcMHiWF2IZO6U3rU+rpYz5WSEKAHIs=;
        b=VRciCdjd2PVJGsJoNBiLBgw7V7lILSXOXfRQlDzEM6r2cbdEoY5R9tysyRGE5GIHej
         b5UOCDxuO63c2ITKYxD6c4snwTppnAdOB0p6XMJpO1AkqmvxgPngkxLCwQU398WtZklT
         ZprFk1c9VNe8EcKWAZEh4iCsCYtMWwhMPdIc1714FPzvD6aWwiiCZx2ALjFcMzUysn3N
         VdVIMwsKnnlk9E6iyIZ9GUHFZno7NrPKU0sroVDcKgWH4mt+D688RODl+QVyKTiegy8s
         EBwMesVNnWDVKFe4GMPFNn9/pxH0YspKNPMHbpkYzf+OfXUfh+HwZx0QejtIS/WTSPWE
         Cddg==
X-Gm-Message-State: APjAAAVxMFwFiL7K6EPybn6QhDKE2MX+2gBU1gsepSPWNZ8xmsCXTWHw
        JLNJwvN07NhDCx6G+8PYv2OhzH4SXX0=
X-Google-Smtp-Source: APXvYqxUFjgVqOWE0sMu9TdtCmURSe4LpsTW+DdPwc1z6mws/Pabldkx15HWhzp3Cv8IKNqaeN9HjQ==
X-Received: by 2002:a1c:7dcc:: with SMTP id y195mr277417wmc.13.1552935533637;
        Mon, 18 Mar 2019 11:58:53 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C987214D00406AF0BED3444E70.dip0.t-ipconnect.de. [2003:c9:8721:4d00:406a:f0be:d344:4e70])
        by smtp.gmail.com with ESMTPSA id w10sm13344749wrn.32.2019.03.18.11.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 11:58:52 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joe Perches <joe@perches.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Subject: [PATCH v2] staging: mt7621-pci-phy: Add Spaces to Macro Definition
Date:   Mon, 18 Mar 2019 19:58:43 +0100
Message-Id: <20190318185852.29741-1-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Improve Code readability by adding Tabs and Spaces after #define

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 .../staging/mt7621-pci-phy/pci-mt7621-phy.c   | 126 +++++++++---------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c b/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c
index d3ca2f019112..98c06308143c 100644
--- a/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c
+++ b/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c
@@ -14,69 +14,69 @@
 #include <mt7621.h>
 #include <ralink_regs.h>
 
-#define RALINK_CLKCFG1			0x30
-#define CHIP_REV_MT7621_E2		0x0101
-
-#define PCIE_PORT_CLK_EN(x)		BIT(24 + (x))
-
-#define RG_PE1_PIPE_REG			0x02c
-#define RG_PE1_PIPE_RST			BIT(12)
-#define RG_PE1_PIPE_CMD_FRC		BIT(4)
-
-#define RG_P0_TO_P1_WIDTH		0x100
-#define RG_PE1_H_LCDDS_REG		0x49c
-#define RG_PE1_H_LCDDS_PCW		GENMASK(30, 0)
-#define RG_PE1_H_LCDDS_PCW_VAL(x)	((0x7fffffff & (x)) << 0)
-
-#define RG_PE1_FRC_H_XTAL_REG		0x400
-#define RG_PE1_FRC_H_XTAL_TYPE          BIT(8)
-#define RG_PE1_H_XTAL_TYPE              GENMASK(10, 9)
-#define RG_PE1_H_XTAL_TYPE_VAL(x)       ((0x3 & (x)) << 9)
-
-#define RG_PE1_FRC_PHY_REG		0x000
-#define RG_PE1_FRC_PHY_EN               BIT(4)
-#define RG_PE1_PHY_EN                   BIT(5)
-
-#define RG_PE1_H_PLL_REG		0x490
-#define RG_PE1_H_PLL_BC			GENMASK(23, 22)
-#define RG_PE1_H_PLL_BC_VAL(x)		((0x3 & (x)) << 22)
-#define RG_PE1_H_PLL_BP			GENMASK(21, 18)
-#define RG_PE1_H_PLL_BP_VAL(x)		((0xf & (x)) << 18)
-#define RG_PE1_H_PLL_IR			GENMASK(15, 12)
-#define RG_PE1_H_PLL_IR_VAL(x)		((0xf & (x)) << 12)
-#define RG_PE1_H_PLL_IC			GENMASK(11, 8)
-#define RG_PE1_H_PLL_IC_VAL(x)		((0xf & (x)) << 8)
-#define RG_PE1_H_PLL_PREDIV             GENMASK(7, 6)
-#define RG_PE1_H_PLL_PREDIV_VAL(x)      ((0x3 & (x)) << 6)
-#define RG_PE1_PLL_DIVEN		GENMASK(3, 1)
-#define RG_PE1_PLL_DIVEN_VAL(x)		((0x7 & (x)) << 1)
-
-#define RG_PE1_H_PLL_FBKSEL_REG		0x4bc
-#define RG_PE1_H_PLL_FBKSEL             GENMASK(5, 4)
-#define RG_PE1_H_PLL_FBKSEL_VAL(x)      ((0x3 & (x)) << 4)
-
-#define	RG_PE1_H_LCDDS_SSC_PRD_REG	0x4a4
-#define RG_PE1_H_LCDDS_SSC_PRD          GENMASK(15, 0)
-#define RG_PE1_H_LCDDS_SSC_PRD_VAL(x)   ((0xffff & (x)) << 0)
-
-#define RG_PE1_H_LCDDS_SSC_DELTA_REG	0x4a8
-#define RG_PE1_H_LCDDS_SSC_DELTA        GENMASK(11, 0)
-#define RG_PE1_H_LCDDS_SSC_DELTA_VAL(x) ((0xfff & (x)) << 0)
-#define RG_PE1_H_LCDDS_SSC_DELTA1       GENMASK(27, 16)
-#define RG_PE1_H_LCDDS_SSC_DELTA1_VAL(x) ((0xff & (x)) << 16)
-
-#define RG_PE1_LCDDS_CLK_PH_INV_REG	0x4a0
-#define RG_PE1_LCDDS_CLK_PH_INV		BIT(5)
-
-#define RG_PE1_H_PLL_BR_REG		0x4ac
-#define RG_PE1_H_PLL_BR			GENMASK(18, 16)
-#define RG_PE1_H_PLL_BR_VAL(x)		((0x7 & (x)) << 16)
-
-#define	RG_PE1_MSTCKDIV_REG		0x414
-#define RG_PE1_MSTCKDIV			GENMASK(7, 6)
-#define RG_PE1_MSTCKDIV_VAL(x)		((0x3 & (x)) << 6)
-
-#define RG_PE1_FRC_MSTCKDIV		BIT(5)
+#define RALINK_CLKCFG1				0x30
+#define CHIP_REV_MT7621_E2			0x0101
+
+#define PCIE_PORT_CLK_EN(x)			BIT(24 + (x))
+
+#define RG_PE1_PIPE_REG				0x02c
+#define RG_PE1_PIPE_RST				BIT(12)
+#define RG_PE1_PIPE_CMD_FRC			BIT(4)
+
+#define RG_P0_TO_P1_WIDTH			0x100
+#define RG_PE1_H_LCDDS_REG			0x49c
+#define RG_PE1_H_LCDDS_PCW			GENMASK(30, 0)
+#define RG_PE1_H_LCDDS_PCW_VAL(x)		((0x7fffffff & (x)) << 0)
+
+#define RG_PE1_FRC_H_XTAL_REG			0x400
+#define RG_PE1_FRC_H_XTAL_TYPE			BIT(8)
+#define RG_PE1_H_XTAL_TYPE			GENMASK(10, 9)
+#define RG_PE1_H_XTAL_TYPE_VAL(x)		((0x3 & (x)) << 9)
+
+#define RG_PE1_FRC_PHY_REG			0x000
+#define RG_PE1_FRC_PHY_EN			BIT(4)
+#define RG_PE1_PHY_EN				BIT(5)
+
+#define RG_PE1_H_PLL_REG			0x490
+#define RG_PE1_H_PLL_BC				GENMASK(23, 22)
+#define RG_PE1_H_PLL_BC_VAL(x)			((0x3 & (x)) << 22)
+#define RG_PE1_H_PLL_BP				GENMASK(21, 18)
+#define RG_PE1_H_PLL_BP_VAL(x)			((0xf & (x)) << 18)
+#define RG_PE1_H_PLL_IR				GENMASK(15, 12)
+#define RG_PE1_H_PLL_IR_VAL(x)			((0xf & (x)) << 12)
+#define RG_PE1_H_PLL_IC				GENMASK(11, 8)
+#define RG_PE1_H_PLL_IC_VAL(x)			((0xf & (x)) << 8)
+#define RG_PE1_H_PLL_PREDIV			GENMASK(7, 6)
+#define RG_PE1_H_PLL_PREDIV_VAL(x)		((0x3 & (x)) << 6)
+#define RG_PE1_PLL_DIVEN			GENMASK(3, 1)
+#define RG_PE1_PLL_DIVEN_VAL(x)			((0x7 & (x)) << 1)
+
+#define RG_PE1_H_PLL_FBKSEL_REG			0x4bc
+#define RG_PE1_H_PLL_FBKSEL			GENMASK(5, 4)
+#define RG_PE1_H_PLL_FBKSEL_VAL(x)		((0x3 & (x)) << 4)
+
+#define	RG_PE1_H_LCDDS_SSC_PRD_REG		0x4a4
+#define RG_PE1_H_LCDDS_SSC_PRD			GENMASK(15, 0)
+#define RG_PE1_H_LCDDS_SSC_PRD_VAL(x)		((0xffff & (x)) << 0)
+
+#define RG_PE1_H_LCDDS_SSC_DELTA_REG		0x4a8
+#define RG_PE1_H_LCDDS_SSC_DELTA		GENMASK(11, 0)
+#define RG_PE1_H_LCDDS_SSC_DELTA_VAL(x)		((0xfff & (x)) << 0)
+#define RG_PE1_H_LCDDS_SSC_DELTA1		GENMASK(27, 16)
+#define RG_PE1_H_LCDDS_SSC_DELTA1_VAL(x)	((0xff & (x)) << 16)
+
+#define RG_PE1_LCDDS_CLK_PH_INV_REG		0x4a0
+#define RG_PE1_LCDDS_CLK_PH_INV			BIT(5)
+
+#define RG_PE1_H_PLL_BR_REG			0x4ac
+#define RG_PE1_H_PLL_BR				GENMASK(18, 16)
+#define RG_PE1_H_PLL_BR_VAL(x)			((0x7 & (x)) << 16)
+
+#define	RG_PE1_MSTCKDIV_REG			0x414
+#define RG_PE1_MSTCKDIV				GENMASK(7, 6)
+#define RG_PE1_MSTCKDIV_VAL(x)			((0x3 & (x)) << 6)
+
+#define RG_PE1_FRC_MSTCKDIV			BIT(5)
 
 /**
  * struct mt7621_pci_phy_instance - Mt7621 Pcie PHY device
-- 2.19.1
