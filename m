Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A277AC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723D121927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fd6AiriF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbfISF3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 01:29:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43091 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388194AbfISF3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 01:29:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id u72so1178946pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 22:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SJDlhm907xyTeLn8eboZhigP+1jC9h49ln8vZf3zaoo=;
        b=fd6AiriFsm5ECQXieYjvYwo3dEkcVTY9IjOW3Fk0LLzlRQG0mt0IXNaSmaSqNOB/Uv
         emPEVfv7t9j4appHb5AVXYwS3SE8mm+9U/5UzlTs7yTymYOJps5Dw3ixojv80GKmX4GT
         XpUkPZWt8A20bfnt8gqyCQDBu45+Jr8aMc1fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SJDlhm907xyTeLn8eboZhigP+1jC9h49ln8vZf3zaoo=;
        b=aSrTej0w7/+V/VU1svyU63F2H8sCYXDVNCx980A6P2Aqps4yEXM3xem/Ix6ITlpU5Y
         wJwyPmk0k2e5PWekQy7LGN4MBZlo/OdUsdkCiJNdXK9vJyqxzUeSgPOvJIFGOlZWmW0q
         YEamjo3Q38G+S4SGeHTWx9IEqyoL3DDUQEI7nBApoEVmPHMb+xmXFE6jeZIj/RjVpZe5
         YwB4CtSarmc6IfVjL2zljKB0Y2aNbm6hF5hEPI1nelTkNRNQe+7ee6oM8Sf3ymkT44Md
         6aFjMlpsQ6CoaXCb8hyR5eXct4UzjJkCTiQ8PHYoDDzWVXtL9ZuByqs2uhiI5eV7i6LA
         N9MA==
X-Gm-Message-State: APjAAAVhEuBbIu2hiY55C6GVRwEZQmDgOIAhtBGaKK4FE/KtlKAJhdhs
        6fiXATzXXwRWOGYfqN8r+nA/Sg==
X-Google-Smtp-Source: APXvYqz8LkQoMxwMIj4ICP+GqPvIhHkETgBA+pziMgTii53NMnmCFKiBfOFnLxpeVQSb2I0N3iEmSQ==
X-Received: by 2002:a65:4782:: with SMTP id e2mr6861393pgs.402.1568870949591;
        Wed, 18 Sep 2019 22:29:09 -0700 (PDT)
Received: from localhost.localdomain ([49.206.200.127])
        by smtp.gmail.com with ESMTPSA id z20sm5051930pjn.12.2019.09.18.22.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 22:29:09 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Levin Du <djw@t-chip.com.cn>,
        Akash Gajjar <akash@openedev.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Da Xue <da@lessconfused.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 6/6] arm64: dts: rockchip: Fix roc-rk3399-pc regulator input rails
Date:   Thu, 19 Sep 2019 10:58:22 +0530
Message-Id: <20190919052822.10403-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190919052822.10403-1-jagan@amarulasolutions.com>
References: <20190919052822.10403-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few, know rk808 pmic regulators VCC[1-4], VCC[6-7], VCC[9-11],
VDD_LOG, VDD_GPU, VDD_CPU_B, VCC3V3_SYS are inputting with vcc_sys
which is 5V power rail from dc_12v.

So, replace the vin-supply of above mentioned regulators
with vcc_sys as per the PMIC-RK808-D page of roc-rk3399-pc
schematics.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../rk3399-libretech-roc-rk3399-pc.dts        | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-libretech-roc-rk3399-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-libretech-roc-rk3399-pc.dts
index 51242ea5447d..1eddb2e00809 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-libretech-roc-rk3399-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-libretech-roc-rk3399-pc.dts
@@ -85,7 +85,7 @@
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		vin-supply = <&dc_12v>;
+		vin-supply = <&vcc_sys>;
 	};
 
 	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
@@ -129,7 +129,7 @@
 		regulator-boot-on;
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1400000>;
-		vin-supply = <&vcc3v3_sys>;
+		vin-supply = <&vcc_sys>;
 	};
 };
 
@@ -202,16 +202,16 @@
 		rockchip,system-power-controller;
 		wakeup-source;
 
-		vcc1-supply = <&vcc3v3_sys>;
-		vcc2-supply = <&vcc3v3_sys>;
-		vcc3-supply = <&vcc3v3_sys>;
-		vcc4-supply = <&vcc3v3_sys>;
-		vcc6-supply = <&vcc3v3_sys>;
-		vcc7-supply = <&vcc3v3_sys>;
+		vcc1-supply = <&vcc_sys>;
+		vcc2-supply = <&vcc_sys>;
+		vcc3-supply = <&vcc_sys>;
+		vcc4-supply = <&vcc_sys>;
+		vcc6-supply = <&vcc_sys>;
+		vcc7-supply = <&vcc_sys>;
 		vcc8-supply = <&vcc3v3_sys>;
-		vcc9-supply = <&vcc3v3_sys>;
-		vcc10-supply = <&vcc3v3_sys>;
-		vcc11-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc_sys>;
+		vcc10-supply = <&vcc_sys>;
+		vcc11-supply = <&vcc_sys>;
 		vcc12-supply = <&vcc3v3_sys>;
 		vddio-supply = <&vcc1v8_pmu>;
 
@@ -385,7 +385,7 @@
 		regulator-ramp-delay = <1000>;
 		regulator-always-on;
 		regulator-boot-on;
-		vin-supply = <&vcc3v3_sys>;
+		vin-supply = <&vcc_sys>;
 
 		regulator-state-mem {
 			regulator-off-in-suspend;
@@ -404,7 +404,7 @@
 		regulator-ramp-delay = <1000>;
 		regulator-always-on;
 		regulator-boot-on;
-		vin-supply = <&vcc3v3_sys>;
+		vin-supply = <&vcc_sys>;
 
 		regulator-state-mem {
 			regulator-off-in-suspend;
-- 
2.18.0.321.gffc6fa0e3

