Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF275C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 03:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7970208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 03:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xsc1FqfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfEMD7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 23:59:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45015 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfEMD7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 23:59:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id d3so5740396plj.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 20:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F9QBOZtjHD3cvSHL8seit1ng6gf/KXanf0uSnR0dfOI=;
        b=Xsc1FqfBOwy8bGWszVKy9eKAwN5fabSOCsyoyESVpaOJllyh8NWqBLwEigRo5L6Gtn
         wnb/SLFTaPG3x0thYFka1ag/hw90I2iQSYo1tCuJb0mYPJNTIYFSg5syIRtkVDnh0+Ks
         hv4eR4HqATvnVpOU7qQDzFp08ohYrnZgo+qG0ePDL/DHYcKUBRYk3SXaW+QN1woNIJwP
         EXajKe5rRQyjIAHLrHRsi/XrFzAZoUdydcKzsAmBD92wZUZHl8ZXTuymRneC32JNt1Fy
         5mSmrZ/GgTiyehLHkwbi1YgJeNTUe+5fhjZYdGLnyQFK+czO+4hqdpQKehFWymF2giup
         215Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F9QBOZtjHD3cvSHL8seit1ng6gf/KXanf0uSnR0dfOI=;
        b=D1vqn1N8QXwckajCgXSjdCrTedUZkdJMTz7JoFjvjB1pEkPx6v4Opula9aQQaVASe8
         70q0evxWLbxPb/8qvHPAtSvCDwjlEzDiQlIIY2a039qGUVppSRilaL2TUQsDStpEepCy
         /CVNnyJhDp1NlJyWIDGhiIFj3syAU1KXUOFS+R67lxuagMB3/DBCn2SQAyok+UMswWdV
         Ljzo0vvneedT4xesMluIMwEepLJAV3HGVDqlNku8C+vR/JFA4Z8POYMz1mZlhQxt1zZD
         TN6iUi5TTsg+FCIoDZ/b8GYpZMhAtMJJHj931gyLZsUl1K1Ufn+s5tFbtlnwxxFL65UF
         gWgA==
X-Gm-Message-State: APjAAAV0DvaIu9Ojvt4B7ZQH4USIm5ACo2hOC5CEa+SwHIN140YqvH1T
        nkR+AhdQdHOoYnHTgzosMXU=
X-Google-Smtp-Source: APXvYqyNX8YPKfwxKwTXESwWJea0905IwBlPHwMrvpJrp5+E3xFtZK2791xVKS08UbaHHZOStnse3g==
X-Received: by 2002:a17:902:a405:: with SMTP id p5mr23101195plq.51.1557719963804;
        Sun, 12 May 2019 20:59:23 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i17sm16042496pfo.103.2019.05.12.20.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 20:59:23 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: vf610-zii-dev: Add QSPI node
Date:   Sun, 12 May 2019 20:59:09 -0700
Message-Id: <20190513035909.30460-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190513035909.30460-1-andrew.smirnov@gmail.com>
References: <20190513035909.30460-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both rev C and rev B of the board come with two QSPI-NOR chips
attached to the SoC. Add DT code describing all of this.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-dev.dtsi | 48 ++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/vf610-zii-dev.dtsi
index 5246c75e848c..f63a470f78ce 100644
--- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
+++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
@@ -177,6 +177,36 @@
 	status = "okay";
 };
 
+&qspi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi0>;
+	status = "okay";
+
+	/*
+	 * Attached MT25QL02 can go up to 90Mhz in DTR and 166 in SDR
+	 * modes, so we limit spi-max-frequency to 90Mhz
+	 */
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <90000000>;
+		spi-rx-bus-width = <4>;
+		reg = <0>;
+		m25p,fast-read;
+	};
+
+	flash@2 {
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <90000000>;
+		spi-rx-bus-width = <4>;
+		reg = <2>;
+		m25p,fast-read;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart0>;
@@ -360,12 +390,18 @@
 
 	pinctrl_qspi0: qspi0grp {
 		fsl,pins = <
-			VF610_PAD_PTD7__QSPI0_B_QSCK	0x31c3
-			VF610_PAD_PTD8__QSPI0_B_CS0	0x31ff
-			VF610_PAD_PTD9__QSPI0_B_DATA3	0x31c3
-			VF610_PAD_PTD10__QSPI0_B_DATA2	0x31c3
-			VF610_PAD_PTD11__QSPI0_B_DATA1	0x31c3
-			VF610_PAD_PTD12__QSPI0_B_DATA0	0x31c3
+			VF610_PAD_PTD0__QSPI0_A_QSCK	0x38c2
+			VF610_PAD_PTD1__QSPI0_A_CS0	0x38c2
+			VF610_PAD_PTD2__QSPI0_A_DATA3	0x38c3
+			VF610_PAD_PTD3__QSPI0_A_DATA2	0x38c3
+			VF610_PAD_PTD4__QSPI0_A_DATA1	0x38c3
+			VF610_PAD_PTD5__QSPI0_A_DATA0	0x38c3
+			VF610_PAD_PTD7__QSPI0_B_QSCK	0x38c2
+			VF610_PAD_PTD8__QSPI0_B_CS0	0x38c2
+			VF610_PAD_PTD9__QSPI0_B_DATA3	0x38c3
+			VF610_PAD_PTD10__QSPI0_B_DATA2	0x38c3
+			VF610_PAD_PTD11__QSPI0_B_DATA1	0x38c3
+			VF610_PAD_PTD12__QSPI0_B_DATA0	0x38c3
 		>;
 	};
 
-- 
2.21.0

