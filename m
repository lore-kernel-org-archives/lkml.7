Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DBEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF56020896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHbIPvaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfDAKlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:41:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53247 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfDAKk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:40:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id a184so9847124wma.2;
        Mon, 01 Apr 2019 03:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bUXqxWaP1QEJrooDO//E7+eG5MEjnbpAMHL7QOP4WX0=;
        b=SHbIPvaXzpVm3nlRN9UarxkKY9GWQoGj0T/Ozo171XaHbzZPpcsmgrz/XdeeEMPMGX
         +h+tqBT9mwkPWs+h7vmLmH1HNbFhQ3dCP4BRuY/tyiq96oKQioDcQcRXGJGQ6jEdGDHq
         OJp4jimerkHPtOOn5cnTK48Y91+GRMczTbGRoaGRaRJ9NeOoZnCpWVxsnWqp9BOFVniK
         h4lJLPcJKJb72EZIuj8GOM4uTZTRbw97PMlAhfX7oCjZC6liuFguEIYtDns4U56z8EDB
         2leqpD37kXV0yao7UQhaC7d0kbLTPSdVbVgXUbgDy9PGERiGqPC7eMbn2t5pMNAclMpy
         WCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUXqxWaP1QEJrooDO//E7+eG5MEjnbpAMHL7QOP4WX0=;
        b=fqHU7Da/dWU6LABKvUUn5uE71xzCVy34K1R/w63U1r/Vk5DZaByz11RHJhZ2deIt9U
         v62qRQfz29RsKUe4T8C1chbs+sW9quyGw5uPKRJcrVkUlzeIBFDGuuCtJZscT8RZuQCf
         Mp6GyDUUtyI2dyrGAf8vvYYbaKZNELWa/WT/mbh6M+w4AZ+KHDMvflSutMJLxHjqtvoF
         AbHtM+GiHFaPUV99Ah/UXBh0G4EYAVxESoZkNUPLjyMjvXy3jSa/87T1cPqiLKj0VCVq
         TIVueKgb9NeqDDex/bqLlEFYFpJrg3UKfZDA1i6F/eFM6D9QAS2pinF7braHzwKZIvT/
         LUTw==
X-Gm-Message-State: APjAAAXODoEbSA5K+JI5pHssBwVPkus3oFzN+fnHjt5vOlOqAWEZc28h
        rpuWPHGsW+2CeP4ykgqpfAs=
X-Google-Smtp-Source: APXvYqzF4ceVgyZGopY47+G2CF2QM/ESA6QLlkucKDEbeadyOiw3XBtbRFos3yHx2LeG5l7VkiljRg==
X-Received: by 2002:a1c:c707:: with SMTP id x7mr12021888wmf.149.1554115254978;
        Mon, 01 Apr 2019 03:40:54 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id e9sm16178025wrp.35.2019.04.01.03.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:40:54 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH v2 2/6] usb: host: xhci-tegra: Selectively program IPFS
Date:   Mon,  1 Apr 2019 12:40:46 +0200
Message-Id: <20190401104050.31355-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401104050.31355-1-thierry.reding@gmail.com>
References: <20190401104050.31355-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JC Kuo <jckuo@nvidia.com>

Starting with Tegra186, the XUSB controller no longer has the IPFS
wrapper. This commit adds a "has_ipfs" field to struct tegra_xusb_soc
that can be used to declare the existence of the IPFS wrapper.

For the existing chips (i.e. Tegra124 and Tegra210), the new field is
set to true. A future patch adding support for Tegra186 will set it to
false.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 43 +++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index efb0cad8710e..4d133bbabdda 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -161,6 +161,7 @@ struct tegra_xusb_soc {
 	} ports;
 
 	bool scale_ss_clock;
+	bool has_ipfs;
 };
 
 struct tegra_xusb {
@@ -637,16 +638,18 @@ static irqreturn_t tegra_xusb_mbox_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void tegra_xusb_ipfs_config(struct tegra_xusb *tegra,
-				   struct resource *regs)
+static void tegra_xusb_config(struct tegra_xusb *tegra,
+			      struct resource *regs)
 {
 	u32 value;
 
-	value = ipfs_readl(tegra, IPFS_XUSB_HOST_CONFIGURATION_0);
-	value |= IPFS_EN_FPCI;
-	ipfs_writel(tegra, value, IPFS_XUSB_HOST_CONFIGURATION_0);
+	if (tegra->soc->has_ipfs) {
+		value = ipfs_readl(tegra, IPFS_XUSB_HOST_CONFIGURATION_0);
+		value |= IPFS_EN_FPCI;
+		ipfs_writel(tegra, value, IPFS_XUSB_HOST_CONFIGURATION_0);
 
-	usleep_range(10, 20);
+		usleep_range(10, 20);
+	}
 
 	/* Program BAR0 space */
 	value = fpci_readl(tegra, XUSB_CFG_4);
@@ -661,13 +664,15 @@ static void tegra_xusb_ipfs_config(struct tegra_xusb *tegra,
 	value |= XUSB_IO_SPACE_EN | XUSB_MEM_SPACE_EN | XUSB_BUS_MASTER_EN;
 	fpci_writel(tegra, value, XUSB_CFG_1);
 
-	/* Enable interrupt assertion */
-	value = ipfs_readl(tegra, IPFS_XUSB_HOST_INTR_MASK_0);
-	value |= IPFS_IP_INT_MASK;
-	ipfs_writel(tegra, value, IPFS_XUSB_HOST_INTR_MASK_0);
+	if (tegra->soc->has_ipfs) {
+		/* Enable interrupt assertion */
+		value = ipfs_readl(tegra, IPFS_XUSB_HOST_INTR_MASK_0);
+		value |= IPFS_IP_INT_MASK;
+		ipfs_writel(tegra, value, IPFS_XUSB_HOST_INTR_MASK_0);
 
-	/* Set hysteresis */
-	ipfs_writel(tegra, 0x80, IPFS_XUSB_HOST_CLKGATE_HYSTERESIS_0);
+		/* Set hysteresis */
+		ipfs_writel(tegra, 0x80, IPFS_XUSB_HOST_CLKGATE_HYSTERESIS_0);
+	}
 }
 
 static int tegra_xusb_clk_enable(struct tegra_xusb *tegra)
@@ -1015,10 +1020,12 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	if (IS_ERR(tegra->fpci_base))
 		return PTR_ERR(tegra->fpci_base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	tegra->ipfs_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(tegra->ipfs_base))
-		return PTR_ERR(tegra->ipfs_base);
+	if (tegra->soc->has_ipfs) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+		tegra->ipfs_base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(tegra->ipfs_base))
+			return PTR_ERR(tegra->ipfs_base);
+	}
 
 	tegra->xhci_irq = platform_get_irq(pdev, 0);
 	if (tegra->xhci_irq < 0)
@@ -1208,7 +1215,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 		goto disable_rpm;
 	}
 
-	tegra_xusb_ipfs_config(tegra, regs);
+	tegra_xusb_config(tegra, regs);
 
 	err = tegra_xusb_load_firmware(tegra);
 	if (err < 0) {
@@ -1380,6 +1387,7 @@ static const struct tegra_xusb_soc tegra124_soc = {
 		.usb3 = { .offset = 0, .count = 2, },
 	},
 	.scale_ss_clock = true,
+	.has_ipfs = true,
 };
 MODULE_FIRMWARE("nvidia/tegra124/xusb.bin");
 
@@ -1411,6 +1419,7 @@ static const struct tegra_xusb_soc tegra210_soc = {
 		.usb3 = { .offset = 0, .count = 4, },
 	},
 	.scale_ss_clock = false,
+	.has_ipfs = true,
 };
 MODULE_FIRMWARE("nvidia/tegra210/xusb.bin");
 
-- 
2.21.0

