Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345DBC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F47204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0HhR+VL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfGALnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:43:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46700 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfGALnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:43:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so13435175wrw.13;
        Mon, 01 Jul 2019 04:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nlvG1Oeh5iwoJZL6P2V9jRC59SO8k9eeIkjL+7+wPvc=;
        b=s0HhR+VLDw0dHjeetEwFglZJmc1xYcHfCtDrDK3KNoPfzUfX1FWIsxf3yQttWDnZNN
         p0oHKHeX/yWz+Vt3BAgmcobll1C8FR2/KM/7ZahFvSYuOrfHWYX4DDdRGAALCy6u+7ia
         HNvJZ2f84EqFvx7Ce79wgRdshOfzdgNitK9jTlgfBk5Lna6noSDXAU0KzoaKxtzdQvaB
         S1feTT+R94cOeMRE7FdvWRWrFGnXxTX++XE5lbr4KOFLKo/clzRQNKR/u0whJOgt95k/
         M6J7q63gDfzZkbMJgnOOGDIR1I17BWu2JD6mxgkZkt3F1EhBBYq7QoNCfkdRaxgwXXAJ
         aycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nlvG1Oeh5iwoJZL6P2V9jRC59SO8k9eeIkjL+7+wPvc=;
        b=sZMcRLo91kFICdxpyQ++41hN2QSUeNmMQjAf0Wwp6xSKNusSKZqs+Nfcuu0awQWRZC
         fqer4Kb9y42xNyURiwoiYn/B4D3qkMXjZOUKTWOpNLd0g/N94TKe4ki4TXESvM66Jx0S
         EtT4dOzBpBxNg2AH1Kn6eI3v1drEDuioU5BNh0yDeK8Tp0CjIHmhxn11StCGTfsdG5FB
         Zl2QkzPzFEuqAbbMV0mJ7glCia9Qy3uYVBi2EvK1ucJeHrO27Mp7zHhFU51R9g+IEXQL
         D2wtDuZ9XOyW/7RGzGhk3rWt0sD5r4jnA4sNlVga4vCP/W0c1nvtrXmmrapj1mPyyLK8
         snqw==
X-Gm-Message-State: APjAAAVUKSgRq9hzQu0LUiDS/1vwNbngfNH6TrcClh2zRIAN6yTCR7Uh
        ewOCCB8aHToUBnXKlkUoB98=
X-Google-Smtp-Source: APXvYqwgWj7Up6pniwW0+De8qQVkXxoEUkKa5hEySdPeb/hW2f4XHuyK4Lp2zaK9yIUjEIpR3Auxww==
X-Received: by 2002:a5d:5448:: with SMTP id w8mr18684638wrv.180.1561981391406;
        Mon, 01 Jul 2019 04:43:11 -0700 (PDT)
Received: from localhost ([193.47.161.132])
        by smtp.gmail.com with ESMTPSA id j189sm12191140wmb.48.2019.07.01.04.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jul 2019 04:43:10 -0700 (PDT)
From:   Oliver Graute <oliver.graute@gmail.com>
X-Google-Original-From: Oliver Graute <oliver.graute@kococonnector.com>
To:     aisheng.dong@nxp.com
Cc:     sboyd@kernel.org, mturquette@baylibre.com,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Sriram Dash <sriram.dash@nxp.com>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 1/2] arm64: add gpio4 and gpio5 to basic DTS for i.MX8MQ
Date:   Mon,  1 Jul 2019 13:42:45 +0200
Message-Id: <20190701114253.1538-2-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701114253.1538-1-oliver.graute@kococonnector.com>
References: <20190701114253.1538-1-oliver.graute@kococonnector.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add gpio4 to imx8qm.dtsi
add gpio5 to imx8qm.dtsi

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 526cbbddc202..fe4c584625cf 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -121,6 +121,25 @@
 		interrupt-parent = <&gic>;
 	};
 
+	gpio4: gpio@5d0c0000 {
+		compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+		reg = <0x0 0x5d0c0000 0x0 0x10000>;
+		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+};
+	gpio5: gpio@5d0d0000 {
+		compatible = "fsl,imx8qm-gpio", "fsl,imx35-gpio";
+		reg = <0x0 0x5d0d0000 0x0 0x10000>;
+		interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+		 gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1

