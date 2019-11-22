Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F62FC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E3C20714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWB0qAhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfKVKaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:30:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36585 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfKVKaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:30:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id k13so3180488pgh.3;
        Fri, 22 Nov 2019 02:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KZF4nCg+mr6Tu7VsbFdxmJAwi8ka4CeGB3j0/tQUh5Q=;
        b=fWB0qAhi80fT+Q/RQ4rWbGdN28X7xewAfOZCug4QaKIQuw3pBgWLvWdanya5EjKNsY
         uA0MY2/5Ao72E5fmBT0xrPh2z2ouGbMatpGmufUyjoPziIAbW06cymmArvFfcFugSzEY
         pCJSJXdezGTB1OqJIa3HgOYNZhrTLQRf0r4LobJn4Y/Z7hNCgl/+F4TzTK5euJxHLtuJ
         jcPAcLm0gy5stx3QrMpA50j8kHh//UbZVdkJ7duKZH3Nj+/CD38YUmJ6CQ5ugSDaz5aF
         SxeZ5g5SqpDasHHoTL0m887lrtqeSayGmJhke7iH+Et8bZZ5Way9/fR6ai9FmN4JhYhW
         ytZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KZF4nCg+mr6Tu7VsbFdxmJAwi8ka4CeGB3j0/tQUh5Q=;
        b=UgUn9kuDLqzlvY8P4ufaZmYeljm0RDu0Q5jYg9tsy914qILpgIFNlNYkIOBKtn5BzC
         SDSstQ+Fm1+uXZPeYvJbsCxQxjPE57EpbVBqCtPpOREynS+VsItY3CNz2mGQSdpkKnD7
         SiRJv2nOP8ej6kazJzhdOn9Kxm2YU4qJpUqh0fmQ7qKd2xlE2gaH4iAJbg4BI+DfzAqc
         JUpkEmBi95TUvE0cKTTTIaTCJX3o/rwFa2o2G00IF7dzt2N7JtA3fYKVnhbbwdPGZGyY
         eWuSbS860tDzSFGlldWWtjvI7I/ZApt4VSGksloaj1ua5Ws3dFi5jW3209ard9xPDONw
         nISQ==
X-Gm-Message-State: APjAAAVtLgnb89ku7pP8dEiIMEHcXJ3B51c+sSZvDtnMedb6cyWqSugP
        Oiw5lW6x9OXds5PLdPdv2Lo=
X-Google-Smtp-Source: APXvYqycOpmM/n3thMeej5yGENE2TyzgFM6MbEvwtSCL1aM0q8MUKsgmF/CiLfo61cTKps1pxWyPDA==
X-Received: by 2002:aa7:9639:: with SMTP id r25mr16489748pfg.17.1574418628685;
        Fri, 22 Nov 2019 02:30:28 -0800 (PST)
Received: from cnn ([2402:3a80:46d:ffdd:5d90:34b2:635a:ec78])
        by smtp.gmail.com with ESMTPSA id f59sm2247416pje.0.2019.11.22.02.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 02:30:28 -0800 (PST)
Date:   Fri, 22 Nov 2019 16:00:22 +0530
From:   Manikandan <manikandan.hcl.ers.epl@gmail.com>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     joel@jms.id.au, vijaykhemka@fb.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: Re: [PATCH v2] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Message-ID: <20191122103022.GA15913@cnn>
References: <20191118123707.GA5560@cnn>
 <b2f503f0-0f13-46bc-a1be-c82a42b85797@www.fastmail.com>
 <D34D3A2F-9CD5-4924-8407-F6EB0A4C66B5@fb.com>
 <20191121074843.GA10607@cnn>
 <0fce7468-bb35-4d47-8d5d-abc228e99085@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fce7468-bb35-4d47-8d5d-abc228e99085@www.fastmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From 9a17872b5faf2c00ab0b572bac0072e44a3d8b91 Mon Sep 17 00:00:00 2001
From: manikandan-e <manikandan.hcl.ers.epl@gmail.com>
Date: Thu, 21 Nov 2019 11:57:07 +0530
Subject: [PATCH] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC

The Yosemite V2 is a facebook multi-node server
platform that host four OCP server. The BMC
in the Yosemite V2 platorm based on AST2500 SoC.

This patch adds linux device tree entry related to
Yosemite V2 specific devices connected to BMC SoC.

Signed-off-by: manikandan-e <manikandan.hcl.ers.epl@gmail.com>
---
 .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    | 152 +++++++++++++++++++++
 1 file changed, 152 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
new file mode 100644
index 0000000..5f9a2e1
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2018 Facebook Inc.
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Facebook Yosemitev2 BMC";
+	compatible = "facebook,yosemitev2-bmc", "aspeed,ast2500";
+	aliases {
+		serial0 = &uart1;
+		serial4 = &uart5;
+	};
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200 earlyprintk";
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	iio-hwmon {
+		// VOLATAGE SENSOR
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0> , <&adc 1> , <&adc 2> ,  <&adc 3> ,
+		<&adc 4> , <&adc 5> , <&adc 6> ,  <&adc 7> ,
+		<&adc 8> , <&adc 9> , <&adc 10>, <&adc 11> ,
+		<&adc 12> , <&adc 13> , <&adc 14> , <&adc 15> ;
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+	};
+};
+
+&uart5 {
+	// BMC Console
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	use-ncsi;
+};
+
+&adc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default
+		&pinctrl_adc1_default
+		&pinctrl_adc2_default
+		&pinctrl_adc3_default
+		&pinctrl_adc4_default
+		&pinctrl_adc5_default
+		&pinctrl_adc6_default
+		&pinctrl_adc7_default
+		&pinctrl_adc8_default
+		&pinctrl_adc9_default
+		&pinctrl_adc10_default
+		&pinctrl_adc11_default
+		&pinctrl_adc12_default
+		&pinctrl_adc13_default
+		&pinctrl_adc14_default
+		&pinctrl_adc15_default>;
+};
+
+&i2c8 {
+	status = "okay";
+	//FRU EEPROM
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+};
+
+&i2c9 {
+	status = "okay";
+	tmp421@4e {
+	//INLET TEMP
+		compatible = "ti,tmp421";
+		reg = <0x4e>;
+	};
+	//OUTLET TEMP
+	tmp421@4f {
+		compatible = "ti,tmp421";
+		reg = <0x4f>;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+	//HSC
+	adm1278@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c11 {
+	status = "okay";
+	//MEZZ_TEMP_SENSOR
+	tmp421@1f {
+		compatible = "ti,tmp421";
+		reg = <0x1f>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+	//MEZZ_FRU
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+};
+
+&pwm_tacho {
+	status = "okay";
+	//FSC
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
+	fan@0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+	};
+	fan@1 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
+	};
+};
-- 
2.7.4


On Fri, Nov 22, 2019 at 09:16:39AM +1030, Andrew Jeffery wrote:
> 
> 
> On Thu, 21 Nov 2019, at 18:18, Manikandan wrote:
> > 
> > Hi Andrew/Vijay,
> > 
> > Thanks for the review .
> > 
> > The following changes done in dts and tested in Facebook Yosemite V2 
> > BMC platform,
> >   1. LPC feature removed as not supported .
> >   2. VUART feature removed as not supported.
> >   3. Host UART feature removed as not in the current scope.
> >   4. ADC pinctrl details added in dts.
> 
> Can you please re-send the patch as a v2 and inline to the mail rather than
> as an attachment?
> 
> Cheers,
> 
> Andrew
