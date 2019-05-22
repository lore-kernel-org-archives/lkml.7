Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE15FC16A69
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAB32173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVXyOm2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfEVHMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 03:12:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36217 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfEVHMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 03:12:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id d21so622424plr.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 00:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8bTu6X7CFTpKQj2hlqQMei3Kew6tYJUCMubi9x8LbI=;
        b=GVXyOm2sFRF5KWitsBFnioMb6BvG6y2aTrmjTV6OwCKD0BIk3qaNl7/7JlUAX62yba
         JgsIEW1CTiT8GchF8yPlm2tZqzPRn8KOP5RdFITahy9j6C9kw/mLlxbjcHRIB5kXxhH8
         Jx4hCmyZv+fxLO5wvBoOiyruJp9TI52XM3bTXw8O6J0Fkn8C4Sdc8LPclW1s9U2zEQ5s
         05KmfBnwQDGbrsE7GTvfYqmYYHJ0mlX0QyPErXuj7kyg87Wizxwt1GospRgLxwzR/uGg
         ltNwpyZaZUm/dmptBQp7HZdQpRwmePRd2+81ta8sJyXoeWOjvgjmWH9hFtpg1jUfkTLK
         t/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8bTu6X7CFTpKQj2hlqQMei3Kew6tYJUCMubi9x8LbI=;
        b=dN/Lsb075P+F9py87vhDlYwJdMs8o3ri4Ag8yrS22Q03iRECtZQj8FHV2x7LEnPI16
         KzyHEeERr+JXV9KywhiAi+ptQbEbzb+aHiBeSzmIEuNGZaLy6mli0Cw+JKqhiLiaJIo+
         LsOpM8t4wGN9oQz5urMqK2Md1fmzMX877pVO6QDJKhslHr8O++GoBJTcck9+J2XzV5KA
         oo6nzRr6mSn20QHr4GCRSDIGBdhhtDAjXIKjYTRSPRaVOyF7ExjusoaA2DjSiZeAmyOK
         Wj/UaahKucuHGzxwsAC4Gw/BKrd+ImarNytigb8MYjsFNyNaRXX3ORSZaBnvzPYM9tR3
         bq1w==
X-Gm-Message-State: APjAAAX+xGgEMcv5aO6e55zR9YNYM8cLV4G2Geld/+PStXT8M+tVUVH8
        000IgTkSAsd2aZDY+2WIMU4=
X-Google-Smtp-Source: APXvYqyl/Iw28Z/U3/w5+sDvBf83DFgGZzoQgrqzc8FoY5Bm5jBg7e6viK0u4Kh1ncSODy3ng1nlfw==
X-Received: by 2002:a17:902:7592:: with SMTP id j18mr28945645pll.213.1558509174106;
        Wed, 22 May 2019 00:12:54 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id n127sm22750178pga.57.2019.05.22.00.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 00:12:53 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: imx6: rdu2: Disable WP for USDHC2 and USDHC3
Date:   Wed, 22 May 2019 00:12:26 -0700
Message-Id: <20190522071227.31488-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522071227.31488-1-andrew.smirnov@gmail.com>
References: <20190522071227.31488-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RDU2 production units come with resistor connecting WP pin to
correpsonding GPIO DNPed for both SD card slots. Drop any WP related
configuration and mark both slots with "disable-wp".

Reported-by: Chris Healy <cphealy@gmail.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 977d923e35df..5484e4b87975 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -625,7 +625,7 @@
 	pinctrl-0 = <&pinctrl_usdhc2>;
 	bus-width = <4>;
 	cd-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
+	disable-wp;
 	vmmc-supply = <&reg_3p3v_sd>;
 	vqmmc-supply = <&reg_3p3v>;
 	no-1-8-v;
@@ -638,7 +638,7 @@
 	pinctrl-0 = <&pinctrl_usdhc3>;
 	bus-width = <4>;
 	cd-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
+	disable-wp;
 	vmmc-supply = <&reg_3p3v_sd>;
 	vqmmc-supply = <&reg_3p3v>;
 	no-1-8-v;
@@ -1054,7 +1054,6 @@
 			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
 			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
 			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
-			MX6QDL_PAD_NANDF_D3__GPIO2_IO03		0x40010040
 			MX6QDL_PAD_NANDF_D2__GPIO2_IO02		0x40010040
 		>;
 	};
@@ -1067,7 +1066,6 @@
 			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
 			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
 			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
-			MX6QDL_PAD_NANDF_D1__GPIO2_IO01		0x40010040
 			MX6QDL_PAD_NANDF_D0__GPIO2_IO00		0x40010040
 
 		>;
-- 
2.21.0

