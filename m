Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E81BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D6020673
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8Oc3pFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfH0MPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:15:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43944 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729970AbfH0MPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:15:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so14009061pfn.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=A5EmULFtDl5i5Z5Rzq6bwCLJMqdhrquKs6z6Oe0kR7k=;
        b=w8Oc3pFTLBEG/TCudB+3yJrs26KIoXt8+oquaINe8ipfHBdCvRtTU91u9i6DY4GYt+
         8eY3a1EtCU596QzEwlekxoIyrRWYiGX+xds3Hdr9pFDWU5xYL+aRQ08Ox/2lVe3GcK4w
         1rDJcbz0JF660l/Fbj9uk8WqP9yLlXMLcVXKb7SEOeCcTG+e8Ir95+L31hFrP28xZB3z
         6+u2oLuZyYU5JrbaCo9d7gx5EcjVMVCrdaYMyCostqbCap80ct7DaJP+sKFELi4OW4tt
         raFuviw9pDZdduFFpSy3BOhU0FdEL3hGDFbsxG8GOsZiAaShDUm8nIrcxWOOPD9+vauJ
         whHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=A5EmULFtDl5i5Z5Rzq6bwCLJMqdhrquKs6z6Oe0kR7k=;
        b=LcG5eYpd9sitAOyTMoX0nF8UjA7Aaq8o/+cLxs+54Lgazhzu8oLpWOPwFm1KUY9lnF
         GPQ5R9k7fmoggmakR6Iq2os5I05Ev29CQtTB/8Z+ELzhq2eDZSvfj3+fAmUBbTCS/NrW
         TQp3osOhYMyz9gyHxZRlhsJWcyCUFghCByOiw1iEY9w7n1onfh3pGqTM7Ry2eqIinsCJ
         rXTBazKGLXOb9P7VoF7+UJDgjnqh1cShMCF+nNMuh3XlyLw5KZTEP/eQEqFtg/+GcQY7
         vtos0XLj1bOjp+MZW5Ki7dk/QrQuS7r/jYPz2QQt8t5KNGlgAikt0R2a4hnZG35lXVaD
         q9dw==
X-Gm-Message-State: APjAAAXCsdgD8o9ublkwAGqeKX3IvRTYWOpPbe5DY7fCPP6ZxJObqG+D
        rMvaGNF3FTkSfPzIKmkZZWZ7OblTCyDWhQ==
X-Google-Smtp-Source: APXvYqzv4AuLKMaw1mkPE5w73Uh2fp1sJoQ5QLxaSyFcMnMWCK68xN0Gcw7rMKK8p7MKqYEXVR5/3Q==
X-Received: by 2002:a63:c009:: with SMTP id h9mr20902459pgg.166.1566908108909;
        Tue, 27 Aug 2019 05:15:08 -0700 (PDT)
Received: from localhost ([49.248.54.193])
        by smtp.gmail.com with ESMTPSA id d3sm3159687pjz.31.2019.08.27.05.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 05:15:08 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        sboyd@kernel.org, masneyb@onstation.org, marc.w.gonzalez@free.fr,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 11/15] arm64: dts: qcs404: thermal: Add interrupt support
Date:   Tue, 27 Aug 2019 17:44:07 +0530
Message-Id: <74b10329041835ea1b019817729fe2d87f83e65b.1566907161.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register upper-lower interrupt for the tsens controller.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 42 +++++++++++++++-------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 3d0789775009c..065a60d50a07f 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -280,6 +280,8 @@
 			nvmem-cells = <&tsens_caldata>;
 			nvmem-cell-names = "calib";
 			#qcom,sensors = <10>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -1071,8 +1073,8 @@
 
 	thermal-zones {
 		aoss-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 0>;
 
@@ -1086,8 +1088,8 @@
 		};
 
 		q6-hvx-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 1>;
 
@@ -1101,8 +1103,8 @@
 		};
 
 		lpass-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 2>;
 
@@ -1116,8 +1118,8 @@
 		};
 
 		wlan-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 3>;
 
@@ -1131,8 +1133,8 @@
 		};
 
 		cluster-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 4>;
 
@@ -1165,8 +1167,8 @@
 		};
 
 		cpu0-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 5>;
 
@@ -1199,8 +1201,8 @@
 		};
 
 		cpu1-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 6>;
 
@@ -1233,8 +1235,8 @@
 		};
 
 		cpu2-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 7>;
 
@@ -1267,8 +1269,8 @@
 		};
 
 		cpu3-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 8>;
 
@@ -1301,8 +1303,8 @@
 		};
 
 		gpu-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&tsens 9>;
 
-- 
2.17.1

