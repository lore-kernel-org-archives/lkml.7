Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEB7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA4C20840
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlqnX8lV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfCFOEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:04:24 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46893 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCFOEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:04:23 -0500
Received: by mail-yw1-f66.google.com with SMTP id n12so9978607ywn.13;
        Wed, 06 Mar 2019 06:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0h4/ZRuSltaePP2jL4/jUGCwjsf/sfoTJ3RQ5Ua+2lg=;
        b=JlqnX8lVBGsFQPMnsLYFXmTZExWN77To+PpE1KY3AzWbo92r+u3Mz/B/T2bfBfyzgC
         nBUI9uyoHuq9Ga8h/ryD5znWHSA+zO8UvnlVmolkpE0CPhH7/fMcU1dInPFP5WI1Soz4
         us3Q0lCiMyMt3l1lPN/u8bhhTnVej935/u7heWjAiVEpcjtdBYXAVh+gbyHlJmumVCPQ
         VYvWiZ36a4r5jTYrMyeSpiro/n8thaCiFZrykTvv4/AkBxt3kg0UyGUD8GrwrNrJoVF4
         Roz8Vw6q5WwLTvLyGxPllNipxeb98KD9vJzkDGlwBj3drY2Alz7nMYxrwcXoOfHBbFXI
         JvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0h4/ZRuSltaePP2jL4/jUGCwjsf/sfoTJ3RQ5Ua+2lg=;
        b=KJjWDE2uLUD28khAfcJPr8jS0wyi/4b+6OvOKd4caXZpJC5qhU15VqiHogeeB31MY0
         11C78Ft2bCjNAkITMufAQ0HRYnJjqc/cccDJqqebOzX3DoIGKX668kPMzooPqnFLDc63
         IwxL/yh/aNatO6xABPkdUxYp35BBEU8/HErxhZM6vvIrt3BGBjsWseqyA0lxz4MPGNZ8
         qsplG8YhinHSgbNqyMQIO0wD2IGVD/+SI1HAtmOG2+UYZuiYJh3K3iBsKSdhtUYjCCy0
         nQdJmp5pZaCbxTDAV1zZ0EguRoNH/03XRygVzT7Kf285TmB3kRHftKG/qq/oCGD4pAgC
         EQJg==
X-Gm-Message-State: APjAAAUozDemy9qdhRAFvtzFOp5A70ssHW2uDwKqwOzGoZS6ddCS8mAy
        W+EBOtpXDrVSr6TPzu4ivjI=
X-Google-Smtp-Source: APXvYqyRkEwzhPkludsy1G7cccKP4Q+kG3KEvGPTHWCFfYOq8xcrdhPSplC5kjzhCkr3SvnWHbbsbw==
X-Received: by 2002:a81:9bd0:: with SMTP id s199mr5242502ywg.446.1551881062349;
        Wed, 06 Mar 2019 06:04:22 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id r205sm859112ywb.70.2019.03.06.06.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 06:04:21 -0800 (PST)
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
Subject: [PATCH 1/3] ARM: dts: imx6q-logicpd: Shutdown LCD regulator during suspend
Date:   Wed,  6 Mar 2019 08:03:59 -0600
Message-Id: <20190306140402.17122-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LCD power sequencer is very finicky.  The backlight cannot
be driven until after the sequencer is done.  Until now, the
regulators were marked with 'regulator-always-on' to make sure
it came up before the backlight.  This patch allows the LCD
regulators to power down and prevent the backlight from being
used again until the sequencer is ready.  This reduces
standby power consumption by ~100mW.

Fixes: 1c207f911fe9 ("ARM: dts: imx: Add support for Logic
PD i.MX6QD EVM")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/imx6q-logicpd.dts b/arch/arm/boot/dts/imx6q-logicpd.dts
index 45eb0b7f75f8..d96ae54be338 100644
--- a/arch/arm/boot/dts/imx6q-logicpd.dts
+++ b/arch/arm/boot/dts/imx6q-logicpd.dts
@@ -21,6 +21,8 @@
 
 	panel-lvds0 {
 		compatible = "okaya,rs800480t-7x0gp";
+		power-supply = <&reg_lcd_reset>;
+		backlight = <&backlight>;
 
 		port {
 			panel_in_lvds0: endpoint {
@@ -38,7 +40,6 @@
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio4 17 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
-		regulator-always-on;
 		vin-supply = <&reg_3v3>;
 		startup-delay-us = <500000>;
 	};
@@ -52,7 +53,6 @@
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
-		regulator-always-on;
 		vin-supply = <&reg_lcd>;
 	};
 };
-- 
2.17.1

