Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D1AC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1CE2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnB4rk7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfE2HS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:18:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41120 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfE2HSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:18:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id s24so536689plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 00:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aawXyaVUndOA3gmbFU8MOhKxpP5JaLgvaRjLb9Tuem4=;
        b=AnB4rk7IBerNEQACRXU0wbgqUN6GQKnv1TOiQZum+VHMJfGOrrRvF97L7rD85gqj2v
         W5UHKRF05pwBNpATd+bS/Kn1XLhyqoSEOGB8V+rPI2/Rkgnr6eBF6Ram0h/4ZhUtUY4t
         6kKdMApz/Nh8LJ/QIB/TB1IAhvn2vbNASSudj/a99k7s1NCYGEeN3vy2/HSIi5ur0tv7
         q/+Nniui6A5wFc7ngMSBZbnXO7Wc7amyLQDb0EPABOh7r75uaBxyozpmg2ST/+uE1Tv5
         fcw7y+UvfTd78eQ5kuYo4ydO3ikP2ec7tkgCfxb9YjtOoOecFrm9kofPM4+Hb3pfiOig
         pQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aawXyaVUndOA3gmbFU8MOhKxpP5JaLgvaRjLb9Tuem4=;
        b=ArMkoJ8oUta037PiIMicuckRM0v/GpOUDGrekCKZyZfbqqWL/W/ibdq8pRrT0/FWnF
         nyCpReDLXWhUrCbkPgeAAcQ1OrCSFoJbedrRlV5WpuhnJqrXyG84W9V73No0Eq7Q8rl0
         4/kTDJV9ppJtSx5TRimkWS9BzXHVgArvifNDi6ZSRBBPQ/Tez6Ic2FognR6LPppJR60u
         OYazzbLXphY9vIgqfoXAqbJJxF5ft5EIhS9zbFbNHLGhUw8bR7F9EP4UPJZz5aY5Aagv
         zZ+fCoP/38govWjI6nidhNxYq+DseH/UbdW2WhUOhXoDOu9sl3bn6y149uFTKYwMyPBk
         xAfQ==
X-Gm-Message-State: APjAAAUwjQLzbmvOl2gnbOlzz2C1u6dmiqHj7A2qFfQSC2tB5WSZ6f75
        umgY/twmL/F1jFo1IO49WTk=
X-Google-Smtp-Source: APXvYqy2YXmVQ9gCwMlsysZFTnip1mV+36qIwpdi6BdCr9jTimWUqP8ajah8NmxFN+wIrkNfzVNVcg==
X-Received: by 2002:a17:902:b495:: with SMTP id y21mr73769788plr.243.1559114333879;
        Wed, 29 May 2019 00:18:53 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id y16sm32038938pfo.133.2019.05.29.00.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 00:18:53 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: imx6: rdu2: Disable WP for USDHC2 and USDHC3
Date:   Wed, 29 May 2019 00:18:42 -0700
Message-Id: <20190529071843.24767-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529071843.24767-1-andrew.smirnov@gmail.com>
References: <20190529071843.24767-1-andrew.smirnov@gmail.com>
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
Reviewed-by: Chris Healy <cphealy@gmail.com>
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
index 07e21d1e5b4c..04d4d4d7e43c 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -658,7 +658,7 @@
 	pinctrl-0 = <&pinctrl_usdhc2>;
 	bus-width = <4>;
 	cd-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
+	disable-wp;
 	vmmc-supply = <&reg_3p3v_sd>;
 	vqmmc-supply = <&reg_3p3v>;
 	no-1-8-v;
@@ -671,7 +671,7 @@
 	pinctrl-0 = <&pinctrl_usdhc3>;
 	bus-width = <4>;
 	cd-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
+	disable-wp;
 	vmmc-supply = <&reg_3p3v_sd>;
 	vqmmc-supply = <&reg_3p3v>;
 	no-1-8-v;
@@ -1096,7 +1096,6 @@
 			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
 			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
 			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
-			MX6QDL_PAD_NANDF_D3__GPIO2_IO03		0x40010040
 			MX6QDL_PAD_NANDF_D2__GPIO2_IO02		0x40010040
 		>;
 	};
@@ -1109,7 +1108,6 @@
 			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
 			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
 			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
-			MX6QDL_PAD_NANDF_D1__GPIO2_IO01		0x40010040
 			MX6QDL_PAD_NANDF_D0__GPIO2_IO00		0x40010040
 
 		>;
-- 
2.21.0

