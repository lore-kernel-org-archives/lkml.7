Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF025ECE596
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B695F2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS5v+aCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbfJOP10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:27:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37832 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387482AbfJOP1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:27:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so12718592pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 08:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3STC62uX1LOFWn2/FmxkJuEB5bdiiyaCnOBZryIGQaY=;
        b=IS5v+aCvGsRk59ZFIRRyaOwbReneKHG1yZP1HIsbfySuDdJzYuaycAtnOW3Ut3NhOo
         HeyllnaQGFHUcNlxNy3bEFfyrPw1WY9vEyAS/treqiRAIAy7vy4/ncxSm6YYEpikCR/z
         at9JRXUCombNSkBeKfNYWrmIPN4oZE805oweUprVfQ83xLIhlEXjghyKyHZ9YgVEBTRi
         8HHgk1ve3VEPx4Y8c7W6uEkFoNRdGLpCeTzLESoULdBy0Ndfk+cdeXxvfm8Qbyr/7ew4
         n3sjvLMygBuHu6yUAOueFtseAXnAGB6fgkASI6bAxm1mJpmfyfyujnaAi5ctm31kSS0i
         Ycgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3STC62uX1LOFWn2/FmxkJuEB5bdiiyaCnOBZryIGQaY=;
        b=FchsNzFIwn9dzX2q2+LpFCh2eBcGUES5W/vowW+EAs2D4UDVW6gVzXMdyUJOm18w0d
         YUo8hbOUq2g/GuY+BQJkwwOVVsP77hJqY2EuXHmIt32tLNsihuyouMclZTR9cfvoQbJF
         jPd5gNTK1Dng+vONt3i2KlmHA0w80bTfWocgkAKC9Ipe83e4AtWuI5Fcj+eDK5gVa8EY
         TSni15n35rB5uOWNR0rj9oxESwKk970UMLAYNsBYCv4HQjUb4mi2kwS5NSn4rbZq+qLn
         Sd+zSLrABcZfqCnaFK8YXlu9iTRXaEzTi76G7egw+/qk/BZ+4OlGOvUTGcQLgl1ssUM9
         JD+w==
X-Gm-Message-State: APjAAAULgkH0kZlMREXu4XKqJn5cr8Y96XPtMO/FR7gHNI0J5YDh7JRR
        fh12+2D53DDu6lwziEjrORE=
X-Google-Smtp-Source: APXvYqzBLhQZidCNp2+fuvAICwYLOr5FvcIHI1/8XBIqLSmL5cmk/+85uIsm9eI1OJKkhxm0j/KVfw==
X-Received: by 2002:a17:90a:bc06:: with SMTP id w6mr42632084pjr.138.1571153244400;
        Tue, 15 Oct 2019 08:27:24 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id w11sm21158957pgl.82.2019.10.15.08.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 08:27:23 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: zii-ultra: Add node for accelerometer
Date:   Tue, 15 Oct 2019 08:26:53 -0700
Message-Id: <20191015152654.26726-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191015152654.26726-1-andrew.smirnov@gmail.com>
References: <20191015152654.26726-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C node for accelerometer present on both Zest and RMB3 boards.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
Cc: linux-kernel@vger.kernel.org
---
 .../boot/dts/freescale/imx8mq-zii-ultra.dtsi   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
index 21eb52341ba8..8395c5a73ba6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
@@ -262,6 +262,18 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
+	accel@1c {
+		compatible = "fsl,mma8451";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_accel>;
+		reg = <0x1c>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "INT2";
+		vdd-supply = <&reg_gen_3p3>;
+		vddio-supply = <&reg_gen_3p3>;
+	};
+
 	ucs1002: charger@32 {
 		compatible = "microchip,ucs1002";
 		pinctrl-names = "default";
@@ -522,6 +534,12 @@
 };
 
 &iomuxc {
+	pinctrl_accel: accelgrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SAI5_RXC_GPIO3_IO20		0x41
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC			0x3
-- 
2.21.0

