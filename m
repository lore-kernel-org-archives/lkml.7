Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D5FC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958B620874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733130AbfHZPjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:39:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37484 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733061AbfHZPiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:38:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so15806624wrt.4;
        Mon, 26 Aug 2019 08:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jGtaYskwXqtitTmb81lpaqplH9rL6ZrH9axl395rJFM=;
        b=IKBxbAxhFUs8aHdi9Ly9aj1Oj3bFYsyg5ZkyYh1xXQlaaax0373zzLdOhAOQdt9Of6
         NJHz744BYHI/GF95hx0uOi08ZQC6fP+rAil3d3O3mBp734yilW0/9+IV9GEXurwRm1pL
         ZvVCDfdlEHJODda3pRlav8GXunyABXzPe1TxmU/MB1YOsIDDKodGcffUTPAOCzLbQJ3T
         FO+60EQmOlrQDvzVc4w7wlrp/qEvw7tfxMpjaI8p14RgvLlqWGurNfZxiX7ZEHYipBDZ
         TW4K5lFFS6sLpHb3qvwE3d93zssadtuCUjpSSQdNsf0PHvw5xqnXSfngpt9cCDEPhKQ6
         PjoQ==
X-Gm-Message-State: APjAAAU29ysQfld+IXBkDkB5i9x1acEEq6l3bmy5An1VIcT24s0XfFks
        pLYmN0nDc9tO5a7e0L/YIxiTbSjJjOE=
X-Google-Smtp-Source: APXvYqydGIPpHOfkRz3VzlXBrDkyVledGjyMVRFPj6NY3pQu4YoRMHWAwMQbnBklpd5rb2iT/1qMAA==
X-Received: by 2002:adf:d08e:: with SMTP id y14mr22820025wrh.309.1566833928723;
        Mon, 26 Aug 2019 08:38:48 -0700 (PDT)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id z8sm11580798wru.13.2019.08.26.08.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:38:48 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/12] ARM: dts: imx7d: cl-som-imx7: add / enable watchdog
Date:   Mon, 26 Aug 2019 16:37:54 +0100
Message-Id: <20190826153800.35400-6-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190826153800.35400-1-git@andred.net>
References: <20190826153800.35400-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add / enable watchdog which is connected via
WDOG_B to the PMIC, due to i.MX7 Errata e10574

Signed-off-by: André Draszik <git@andred.net>
Cc: Ilya Ledvich <ilya@compulab.co.il>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 78046633d91b..ca3c5d95d6c3 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -207,6 +207,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
@@ -288,4 +294,10 @@
 			MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x4000007f
 		>;
 	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B	0x74
+		>;
+	};
 };
-- 
2.23.0.rc1

