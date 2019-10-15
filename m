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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AE9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EAB20640
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrOKiVhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbfJOP1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:27:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38959 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJOP1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:27:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17so9753574plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 08:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iOSSt4ZhUqn3ehxuv6bc7loSFHikhOWJ0dAyz4sll8g=;
        b=UrOKiVhNAQeoJvHpoi0Qbb7juPxHCpk6MK7GPbyRY7CM8W2h1E6U6K0AHft/5i1si4
         1c3xu1P6ckiPJtwjd7g1f1BjQYmCTqvFyixDZwQXvYslLtHW2SYJtebHe6Yl3C7ovWI9
         N6Z/SPO6iIIqHzwzQoVJA4Y01H6sEj5zMNwjO9vrGbzeryT6zdXeS2JS+FGIygwxX/yq
         izR23UE0ZHSzG57+w7OSVOpxj2nH9cmLTJswxv19PCWDvJv7Adm4ROD6qZLjnlfxaQFb
         kxDO3TeqkZzm5Q/u+zCmcyWjKv/Vd+m4ZYLa5Ph27LOb8IayU/jGoneh/c8kb28OdEEQ
         lwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iOSSt4ZhUqn3ehxuv6bc7loSFHikhOWJ0dAyz4sll8g=;
        b=GJVIVT4Qlkyx1PLbaou+dB8lwQytycVtFlbtitNEj30eOda6ouVqseyjJ7Z37hWTkj
         IS08zKYLer2nnKth7IzPSjVk2MQ4+qcGp0FDBCkbL2YibKM/3VzebD0gW8ZFMicA7MhK
         uLo1KmmsN5zWcKVEo45YpkWygJsOyfBx9w0H+g3JsBeXMhCJ2cSe+n6WkSW1qytSQc46
         GU+oA6Sx/kptElRqgz0KNi42476PfMFRv3cPGd3meJYmqKEdLUCOGpkbTZK7CDoF5pny
         713pV1X8ILAAvk4RCUUnVXuw2W7Wzzd5Sz7FPkO5LYolCrSe69kSXOBLbV4YyNgQUvmH
         6tZQ==
X-Gm-Message-State: APjAAAXVAsF5Y0NLRg0JnlBAsPXhOjjYBWW7Vjm1k1kVZops2oqyOJe5
        O3xiGDO2KNfd39pi94fwvLs=
X-Google-Smtp-Source: APXvYqxQECFXLF9zIPAzcU/sO8NG6/rUwytKyF12X2GxxvG6X2ZqfA2seJgRQAk7NJUp9UI+6jx+TA==
X-Received: by 2002:a17:902:b611:: with SMTP id b17mr35969820pls.23.1571153241170;
        Tue, 15 Oct 2019 08:27:21 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id w11sm21158957pgl.82.2019.10.15.08.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 08:27:20 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: dts: zii-ultra: Fix regulator-vsd-3v3's vin-supply
Date:   Tue, 15 Oct 2019 08:26:51 -0700
Message-Id: <20191015152654.26726-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulator-vsd-3v3 is supplied via GEN_3V3 rail which is an output of
an "always on" load switch supplied by 3V3_MAIN. GEN_3V3 is also used
as vin-supply by a number of peripherals, so adding it also allows us
to follow the schematic more closely.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
index 087b5b6ebe89..5d7a8f09f1ab 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
@@ -68,11 +68,20 @@
 		regulator-always-on;
 	};
 
+	reg_gen_3p3: regulator-gen-3p3 {
+		compatible = "regulator-fixed";
+		vin-supply = <&reg_3p3_main>;
+		regulator-name = "GEN_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	reg_usdhc2_vmmc: regulator-vsd-3v3 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_reg_usdhc2>;
 		compatible = "regulator-fixed";
-		vin-supply = <&reg_3p3_main>;
+		vin-supply = <&reg_gen_3p3>;
 		regulator-name = "3V3_SD";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-- 
2.21.0

