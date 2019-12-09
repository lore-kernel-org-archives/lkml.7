Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8CDC00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36392073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQOeRUrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfLIQur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:50:47 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:46465 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIQuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:50:44 -0500
Received: by mail-pj1-f66.google.com with SMTP id z21so6122989pjq.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 08:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HxjIDEX+7ZVeJgru8LvvR5BufYtC0NpT+WMH9OusOnY=;
        b=BQOeRUrPJ++Kti92Xgwb5MxAYTIorWD7rvCPzQY/cR2v608QtRkHwD6Y+ywHt8d84x
         rgCXVDZbeKRx0VBOH89NFymh5/jMPAGwo6yJRQxw+kYaDqfnU/wT2j+LuKiYyuD4HB/1
         KSQoGWEsuVMK+dqIKyDqffC/Rso/XGEvNcqwMlDfTdvCLktfCZb8UBzYTJVfI6qVb0Jp
         IQSqlBsZKlecpPyAvmS8q1uUEXAXK8kboyXwHwtBCbmVLM1kjKCX6OiMqcPpfMia9Izz
         ymwh5Bs2RWRMS7QyWzPxprJh0cWCJmmJ0TV+/alpNwSmkb1l658CP6Obv3KyezE0t2ds
         qnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HxjIDEX+7ZVeJgru8LvvR5BufYtC0NpT+WMH9OusOnY=;
        b=GPqg9/24J9AO2GrwX21ar9l+cBDM6FuTTHCZynkkGoMt8BZGr6yECA7uj4hvFh8Ew3
         Cqwty81ojM0M9fkKcAFx779TvhUXL2efxg0lzzM/92xK4sYEHqtO0TLzgkhV9odyGGLc
         MnJzK6rk9eEZzyP6YbXUmrp52DKr6z0Beowemf8mZ4/GuU+JND9doL0DnS+DmMnq1P1U
         xdnxUYmjEWVSD9LhBTTqFnrU0ByF8A5m8tAWkygKQqAR3HBeFxVAmluG+RD6w0e3JwH2
         CtiOrAf446jC3+Vyic78qgNmJLnfauHNSqEECkQvM/w94L/DkRHkc8mwialMYI5Bobgj
         btrQ==
X-Gm-Message-State: APjAAAXj7iunlOYN1RNIt59ZExHOSDSlDpM3BojEfDIA+4mumtW1sMRk
        qfFrKZs1cCLrqilz/R+gMiQ=
X-Google-Smtp-Source: APXvYqw7fxQZCJAJm1NIbn6GoldxdOhS8euDIKP37TXk4AquUSLIi3jNWpIgYBiJKeIf9lakrhXYmw==
X-Received: by 2002:a17:90a:cc16:: with SMTP id b22mr33101464pju.65.1575910243781;
        Mon, 09 Dec 2019 08:50:43 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id c19sm18299294pfc.144.2019.12.09.08.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 08:50:42 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] ARM: dts: imx6: rdu2: Disable WP for USDHC2 and USDHC3
Date:   Mon,  9 Dec 2019 08:50:17 -0800
Message-Id: <20191209165018.21794-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191209165018.21794-1-andrew.smirnov@gmail.com>
References: <20191209165018.21794-1-andrew.smirnov@gmail.com>
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
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
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
index 7531f0595bd1..d062c86e0762 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -743,7 +743,7 @@
 	pinctrl-0 = <&pinctrl_usdhc2>;
 	bus-width = <4>;
 	cd-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
+	disable-wp;
 	vmmc-supply = <&reg_3p3v_sd>;
 	vqmmc-supply = <&reg_3p3v>;
 	no-1-8-v;
@@ -756,7 +756,7 @@
 	pinctrl-0 = <&pinctrl_usdhc3>;
 	bus-width = <4>;
 	cd-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
+	disable-wp;
 	vmmc-supply = <&reg_3p3v_sd>;
 	vqmmc-supply = <&reg_3p3v>;
 	no-1-8-v;
@@ -1180,7 +1180,6 @@
 			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
 			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
 			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
-			MX6QDL_PAD_NANDF_D3__GPIO2_IO03		0x40010040
 			MX6QDL_PAD_NANDF_D2__GPIO2_IO02		0x40010040
 		>;
 	};
@@ -1193,7 +1192,6 @@
 			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
 			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
 			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
-			MX6QDL_PAD_NANDF_D1__GPIO2_IO01		0x40010040
 			MX6QDL_PAD_NANDF_D0__GPIO2_IO00		0x40010040
 
 		>;
-- 
2.21.0

