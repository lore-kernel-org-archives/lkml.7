Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9CDC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C6D214B2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ7oQT4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfLECTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:19:48 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46892 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfLECTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:19:46 -0500
Received: by mail-yb1-f194.google.com with SMTP id v15so850563ybp.13;
        Wed, 04 Dec 2019 18:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yd2Q7YPR11r5oinbUH01VXPynULLPCtlISudYlOMZyU=;
        b=dZ7oQT4U2H+qzIRBhZmeTPi8Mt3dIMzOm7Hp5/V3r8x/h/EIO00FBZMSX3PlqoQSrv
         Ua9Xjpp1MH/3vnT9HJSleKk0nsEdNYw2lowXV421mkLCgS39iX5Jzm22PS7aaHUprt/i
         X6H+kHwAhaTA8H7ejrzXE2wLJsx8aP5vQtGEUbPBjBYwgdogL9oPNCFncN9gm80hAq3X
         iHn8wiooFWAwTk8zF2gWozDTciPwZFgRBM5KS1I7eZo015WAKeazOlT8dqNq+qSFplj7
         R13YpWnX6+BkhEdMFf/dgNMiwI5hD+QRrL2o2GqR2Hw5QuNk1eUIKtDuLC5ZmAAGTrDC
         qIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yd2Q7YPR11r5oinbUH01VXPynULLPCtlISudYlOMZyU=;
        b=COpLX36f/7h/ButBDPN/PgrcNQrq7n0VdVA21BEv9DW0e/6Zp9uCl4IxbR1Kiks2qK
         ODjbYE4GCKwruLc5W5iZQD5edIVxyZQ2xX7cD3NMLPYEojX3IcmtMWaBZgz5UOkHMikj
         DKnA4OYnsZjKEi1hoURLTZBnR6PuqRJUX3t7VaU17711F2IoOF4ncp2erKVGijPkbKGm
         /aAkTq25ipEKKP8/bLouHZt3p1QlRY4REIN5gLx+Jb6i5c8yEI27BTb3OY5TiqcDgXA/
         Ei2e40+Slp1HroWPgbdXBNPngJHMD7oLQ+txuBJmPwSquFIgC5a+SLolA1BV4bIMSnze
         GbVw==
X-Gm-Message-State: APjAAAXlyNEci4eP2wvupFDOh8YK6y8d3Zpc+mwnKlUwEmic+JI1a61L
        Ya15YlaPHF7W2/EVCDzCgiA=
X-Google-Smtp-Source: APXvYqyVdj3RzhMGiTatSwC3Khz8b2JenHZUs6hXCp8QeiH6aGTz3/PIkHDqKJsFHIjOWWrugZ0pgw==
X-Received: by 2002:a25:d143:: with SMTP id i64mr4691585ybg.415.1575512384839;
        Wed, 04 Dec 2019 18:19:44 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id l6sm4188449ywa.39.2019.12.04.18.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 18:19:44 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] soc: imx: gpcv2: Update imx8m-power.h to include iMX8M Mini
Date:   Wed,  4 Dec 2019 20:19:18 -0600
Message-Id: <20191205021924.25188-3-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205021924.25188-1-aford173@gmail.com>
References: <20191205021924.25188-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for i.MX8M Mini support in the GPC driver, the
include file used by both the device tree and the source needs to
have the appropriate references for it.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 include/dt-bindings/power/imx8m-power.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/dt-bindings/power/imx8m-power.h b/include/dt-bindings/power/imx8m-power.h
index 8a513bd9166e..0054bba744b8 100644
--- a/include/dt-bindings/power/imx8m-power.h
+++ b/include/dt-bindings/power/imx8m-power.h
@@ -18,4 +18,18 @@
 #define IMX8M_POWER_DOMAIN_MIPI_CSI2	9
 #define IMX8M_POWER_DOMAIN_PCIE2	10
 
+#define IMX8MM_POWER_DOMAIN_MIPI	0
+#define IMX8MM_POWER_DOMAIN_PCIE	1
+#define IMX8MM_POWER_DOMAIN_USB_OTG1	2
+#define IMX8MM_POWER_DOMAIN_USB_OTG2	3
+#define IMX8MM_POWER_DOMAIN_DDR1	4
+#define IMX8MM_POWER_DOMAIN_GPU2D	5
+#define IMX8MM_POWER_DOMAIN_GPU	6
+#define IMX8MM_POWER_DOMAIN_VPU	7
+#define IMX8MM_POWER_DOMAIN_GPU3D	8
+#define IMX8MM_POWER_DOMAIN_DISP	9
+#define IMX8MM_POWER_VPU_G1		10
+#define IMX8MM_POWER_VPU_G2		11
+#define IMX8MM_POWER_VPU_H1		12
+
 #endif
-- 
2.20.1

