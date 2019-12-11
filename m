Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABFFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2147A21556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYVSQx64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfLKOFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:05:00 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:43228 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfLKOE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:04:58 -0500
Received: by mail-pj1-f66.google.com with SMTP id g4so8973815pjs.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 06:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UuYwx4FSzyLc9U1xa0BZGom1pgq8tugsRTYhO5cDG3M=;
        b=PYVSQx64S9qCKQW5/VoLb1Dfu5FCANe/WwCYgMrLw68aBbp1xG/lcwq7mn5cQHYTsI
         MDAPb6c9L1Yz82iophl6y5FwYZEeoko/Dcw4tAxaC0D0tegsbw512X92+8iauX9yg6PV
         t/d1EK920x08nLMdgl6I6pmxJNQKV0mmNqUay1Du8fdV4Ul8RkT+VVWXoH8O9b8fyDHJ
         jX2AjHFDB4KWcLfQSQXiKXC/SV1mWvpNqAdmSqwf1Mo51UoN96SKiUFhWG2ZE3vyDJBT
         psDGGXUVxVYFO7VRRuDb1kB/Czx9bjjaF6sNyOGk7nc+vDsXqUJt6GIsnvjhJKZLoADC
         xsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UuYwx4FSzyLc9U1xa0BZGom1pgq8tugsRTYhO5cDG3M=;
        b=gxIVsbBycOEDhXWX4ovZO8mFojoNRhUiYDXUu8rEomh+yNdhDG/Kqi+VCLleN+AKlt
         ZR4N4cBSC+Dh7n2O+16QCKnPtFsCnWfpzzhOtBUqNgaLA/tCitg5ANW41A2el64gZvZZ
         lMQcjiRAeTd0xSVm3EbXvAH024WuExyKqpqgOkZgj6bW0gCUW0nHoIPbz8cNvFK69zEZ
         MkL8E2VrcAShUAo5NkDs9nsilVIcTuHV6A0nuAOKJzXtlrEla9ixmkZm+8xg5Y605yEJ
         VHCuy3Eg8U9oGFu4+ff00D5+bdCMW8BXvRT60x0YQJphO/8GHzgAn1i6iThZRD4Arlyt
         08yA==
X-Gm-Message-State: APjAAAVlxAkAlw1wI+8lWw86dJVmE+6PUeU/USH7X/+GASSDNgyiu5lJ
        5MtpPQu/exkIgqYygOj1m4E=
X-Google-Smtp-Source: APXvYqyOYK6C8UMov6vErx0/6/xfChBgejaGNR6iloblC4SH/KvL/ZwlKkh475bl99B63WdJu+zxIA==
X-Received: by 2002:a17:902:8216:: with SMTP id x22mr3374184pln.334.1576073097671;
        Wed, 11 Dec 2019 06:04:57 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id o12sm3489656pfg.152.2019.12.11.06.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 06:04:56 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: dts: vf610-zii-scu4-aib: Use generic names for DT nodes
Date:   Wed, 11 Dec 2019 06:04:43 -0800
Message-Id: <20191211140444.7076-1-andrew.smirnov@gmail.com>
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

Changes since [v1]:

    - Rebased on top of 12/05 linux-next

    - Added "ARM: dts: vf610-zii-scu4-aib: Add node for switch
      watchdog" to this series, which was previously accidental and
      implicit prerequisite for this patch

[v1] lore.kernel.org/lkml/20190824002747.14610-1-andrew.smirnov@gmail.com

 arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
index d7caf618f980..a02c7ea3b92d 100644
--- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
+++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
@@ -407,7 +407,7 @@
 	pinctrl-0 = <&pinctrl_dspi1>;
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -420,7 +420,7 @@
 		};
 	};
 
-	spi-flash@1 {
+	flash@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -509,7 +509,7 @@
 		#gpio-cells = <2>;
 	};
 
-	lm75@48 {
+	temp-sensor@48 {
 		compatible = "national,lm75";
 		reg = <0x48>;
 	};
@@ -524,7 +524,7 @@
 		reg = <0x52>;
 	};
 
-	ds1682@6b {
+	elapsed-time-recorder@6b {
 		compatible = "dallas,ds1682";
 		reg = <0x6b>;
 	};
@@ -536,7 +536,7 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	adt7411@4a {
+	adc@4a {
 		compatible = "adi,adt7411";
 		reg = <0x4a>;
 	};
@@ -548,7 +548,7 @@
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
-	gpio9: sx1503q@20 {
+	gpio9: io-expander@20 {
 		compatible = "semtech,sx1503q";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_sx1503_20>;
@@ -559,12 +559,12 @@
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
@@ -576,17 +576,17 @@
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
@@ -625,7 +625,7 @@
 		};
 	};
 
-	tca9548@71 {
+	i2c-mux@71 {
 		compatible = "nxp,pca9548";
 		pinctrl-names = "default";
 		reg = <0x71>;
-- 
2.21.0

