Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6F6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 00:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D163218D0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 00:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sruHEYzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfCQAXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 20:23:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40305 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbfCQAXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 20:23:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id u10so6752758wmj.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 17:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=+d/aJAagG5S/Fh0VkUlDOOeXW/rqhQF9KiGLzCYVJIs=;
        b=sruHEYzI/fbJQAorbTJsz4gx5SnUjaBlUquyi2XH0vg4ymb8M3aXdNvoIWToCxUjZo
         ph2EKY8v8/83cQghmgbHyu0RosLM+LrINDWDxjSNrmuBYEqLf/sig351dRPU3gjiDrI+
         ny4e1WudDTWJsSrGO938vcc6E5HI5JIkZa8Pt/nrp1B8G0s58qk7KHP3Q19BqmTvQSLw
         jBeopVS0hB7hY3OvE1gmksDwuOF4ddMmRd4SV7nLPiPGu20+AtNB6SCFJ5s3+6l7V6mN
         xJkBUblT4FELe5uB+Tk+qyFE29CQtUyzZaHHSUSZkmMuKFqsekcWvOjSgqeduhKtAJUm
         1+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition:user-agent;
        bh=+d/aJAagG5S/Fh0VkUlDOOeXW/rqhQF9KiGLzCYVJIs=;
        b=dFgw2/5ydHSUI5nBjmozfdwK6Ei0q96DUlFuCTjkjp3Xi03qBPFv9QjTh3McHqRV7c
         v1kY7pAfNnHXvZ5pl2BgVva2kez7bU+H8PdREzuAXGm1pbJO2cX+iqp51BHbQ0fwq1TX
         PTHa5sSN1ICrhu+Nyzg0sx9Zp9bCGSYX00twnIcZ62ZuPpacckKD3dGtAmnMlAk6DTfg
         MHuJ2GyZMIB+lwgEXEYtphhCujsl4OImZlyRnkvQEk8MjTtGHO6ndYX/Sm+Nr04lvoLJ
         7m+CXf8CRh5ZeBC+W20ew9mKkhNhA51XJc8KDzlu23bQLQTYvHpBeJh3OhmVTZul7jpn
         v/6g==
X-Gm-Message-State: APjAAAVdQE2360F9uZEd8DFJWUpi8dr2/qkjDNwTC6awSsCctBwLXD2U
        OhdLEIquUkGF8Xfm6I2gneI=
X-Google-Smtp-Source: APXvYqwE01ikxcZhRNPiQuT0tsg0nYwlCS5006pvWX/t70hcwRIBtCq36z8/3m9WA9jgDSKru+JLug==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr6689223wmc.69.1552782230916;
        Sat, 16 Mar 2019 17:23:50 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C98705F80045694D516271D164.dip0.t-ipconnect.de. [2003:c9:8705:f800:4569:4d51:6271:d164])
        by smtp.gmail.com with ESMTPSA id v10sm6610934wrn.26.2019.03.16.17.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 17:23:50 -0700 (PDT)
Date:   Sun, 17 Mar 2019 01:23:48 +0100
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, NeilBrown <neil@brown.name>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Subject: [PATCH] staging: mt7621-pci-phy: Add Spaces to Macro Definition
Message-ID: <20190317002345.GA6938@p200300EEEE2F.fritz.box>
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve Code readability by adding Spaces after #define

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
-- 
2.19.1

