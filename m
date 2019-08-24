Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1DBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028F121670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRMv8aoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfHXA1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 20:27:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39856 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfHXA1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 20:27:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so6660694pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 17:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4aDP2sxBH+DTF0SIc0YSQecsbsINEtcbFoqwgL4lwgo=;
        b=kRMv8aoArR05QyuJAV0pHnmHwOy7NURhHQwyCrpJUp+MqOx9q+yo62ThQgTKpT2Kox
         G9wS1+W5Ov+jNi1jdSVwiaPszp9qAUlL8qA2cErpDOCXPyH06o0hUaARLQ32nGx8e1hq
         eVJ/pmQ8v2ARVAqe1b9rl4ijys+cQ3C5Lmo+SsjSnc7tO6JzzG7J5OzIAjBQYgoF5Ds6
         tjqEBDEg21fsHLQTNFTU/N5EsLiZQEqH0H2rBNhV1+C8JUT2V4+EkrOv49COMhegLyWs
         YaZ+vM+/fk4HR7//YKWTRjQim6RPo5a9WWD7V8hPjuoHPX2tf7jLqhOZ9pnkwbzC1iVi
         29fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4aDP2sxBH+DTF0SIc0YSQecsbsINEtcbFoqwgL4lwgo=;
        b=b5e0H28u4jfyy4mTbrdWI5lh8fQSn+rYqmK7TRfo1iefuqDkWEDRyHiDD/983Ushez
         wsg7dusumhEa5G1MIIQth7KVVC3Z1DY82jMVp2uqWSPTtNI+ckRl/xkvyCOaxy1pbmJP
         cvsqFErGYq5vZL4zyR/XDG7GlxsvRa5XltO8DfZvDRsIQxkjCXHpT4p9mqNtcQYDnDuQ
         y8NbkorZuI14bfWelJ+TLgmP+3hgRaxwF+tciAT/7lVO+kndPIkJDcaYUfPTUDbDAFpF
         l6rbZ1J0mA5hFFnYTnLx11P/Ac0NrJgWknHAJUWJPckUXSpQEPCPVsQcv6ACN+APb3KO
         RE+Q==
X-Gm-Message-State: APjAAAUmC6gqSuvMxoAhRk+NAxdTdtZXfQCjEUEBJdkERMb1+u8dwdcb
        0+oehenWIG03Ed5mLhq4yMk=
X-Google-Smtp-Source: APXvYqxHED+qBSwU9pUxCHsWXp/N6MoD+4BzaRj4J7K2JFacCcje8EPZATwu/yV8TrNs4dx8Zr8+mQ==
X-Received: by 2002:a65:448a:: with SMTP id l10mr6098897pgq.327.1566606473580;
        Fri, 23 Aug 2019 17:27:53 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id b13sm3471442pjz.10.2019.08.23.17.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 17:27:52 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: vf610-zii-scu4-aib: Use generic names for DT nodes
Date:   Fri, 23 Aug 2019 17:27:47 -0700
Message-Id: <20190824002747.14610-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devicetree specification recommends using generic node names.

Some ZII dts files already follow such recommendation, but some don't,
so use generic node names for consistency among the ZII dts files.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
index 45a978defbdc..6edd682dbd29 100644
--- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
+++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
@@ -417,7 +417,7 @@
 	pinctrl-0 = <&pinctrl_dspi1>;
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -430,7 +430,7 @@
 		};
 	};
 
-	spi-flash@1 {
+	flash@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -519,7 +519,7 @@
 		#gpio-cells = <2>;
 	};
 
-	lm75@48 {
+	temp-sensor@48 {
 		compatible = "national,lm75";
 		reg = <0x48>;
 	};
@@ -534,7 +534,7 @@
 		reg = <0x52>;
 	};
 
-	ds1682@6b {
+	elapsed-time-recorder@6b {
 		compatible = "dallas,ds1682";
 		reg = <0x6b>;
 	};
@@ -551,7 +551,7 @@
 		reg = <0x38>;
 	};
 
-	adt7411@4a {
+	adc@4a {
 		compatible = "adi,adt7411";
 		reg = <0x4a>;
 	};
@@ -563,7 +563,7 @@
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
-	gpio9: sx1503q@20 {
+	gpio9: io-expander@20 {
 		compatible = "semtech,sx1503q";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_sx1503_20>;
@@ -574,12 +574,12 @@
 		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
 	};
 
-	lm75@4e {
+	temp-sensor@4e {
 		compatible = "national,lm75";
 		reg = <0x4e>;
 	};
 
-	lm75@4f {
+	temp-sensor@4f {
 		compatible = "national,lm75";
 		reg = <0x4f>;
 	};
@@ -591,17 +591,17 @@
 		reg = <0x23>;
 	};
 
-	adt7411@4a {
+	adc@4a {
 		compatible = "adi,adt7411";
 		reg = <0x4a>;
 	};
 
-	at24c08@54 {
+	eeprom@54 {
 		compatible = "atmel,24c08";
 		reg = <0x54>;
 	};
 
-	tca9548@70 {
+	i2c-mux@70 {
 		compatible = "nxp,pca9548";
 		pinctrl-names = "default";
 		#address-cells = <1>;
@@ -639,7 +639,7 @@
 		};
 	};
 
-	tca9548@71 {
+	i2c-mux@71 {
 		compatible = "nxp,pca9548";
 		pinctrl-names = "default";
 		reg = <0x71>;
-- 
2.21.0

