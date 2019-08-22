Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C37BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757AE23406
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TOXDCBl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392796AbfHVRef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:34:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46731 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404374AbfHVRZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so3826784plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 10:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y6Dgg0LHIAz3laO+y1ntUkl0I7eVRTHEz+QlpqCcJzM=;
        b=TOXDCBl6f8xlElGz/1VgT87+cdII1cmN5ZgoolaAd7oEb3dKLp1S1aL8eIAK602wRA
         rFV3kajNzuMqA4UEKTCS3p+weiq9BteIBukmbisFxA48gsaY84KdHTxbIl+R7uti/zmz
         vKmYinXsuEL5HmhH7cQg7SvGd3IMVzS+tidp1iSw7IeQ5I3BILh31uDv6xkYym/ZUF22
         I+N3iNN6gjUqxDsC7MVj180HA/sXR/waBKbKAC6Ujfjt91vw4asNcnDuH9yG8hcd+pla
         GAc0mCLgB3uLH3bVSL7ZcOSv9zFfBCOpTcrSc+K2XP/54ZTAa50tjiJvklrL9DieJktS
         oDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y6Dgg0LHIAz3laO+y1ntUkl0I7eVRTHEz+QlpqCcJzM=;
        b=FXPpJ+FG/zBUDwvPya3KJAFWMx8R4gnpHjFhdkAV70BzRuEF53f63OTF7/bQEcLt72
         lgueAvz8YB57e+UbOAOecGpfCRsbRyhnTXNTj8YrdKgt1e9ODX3RPNKPBUalwWOEUYOr
         ceVUVlstdxEHr0WuKatCQIHZXc2xhMlN9V1vghtCS6JWCicIyZJxB+CMYhkO2uCsyqjf
         IwqstXYZvI3eHibp2cgzAH2V3sq9BUuBFCcFMBI4iNYURbQbu2nFlmE5eC/+u8RTLbf/
         +IXaZe306+fKTWwjwf/oX0N62USfI3+R0eGYG0MhUQdoXOl2Tqtl3vONhrX6DjjVpq5X
         Ctlg==
X-Gm-Message-State: APjAAAXASOoTgNNevjlp0VQmIlbUP91yQ1Ma6sPCqpfj1+HBeC+RNQlB
        ClG++QP/la6nITZjGblqNazzjKz/Ug==
X-Google-Smtp-Source: APXvYqyQha/e6kS2nojAOGpDDw4shsyn1hRc1sxUaHNJWwVW+IOzYG5yHHeYZaNx46NEZ2lrt6i+Eg==
X-Received: by 2002:a17:902:ab8f:: with SMTP id f15mr41150750plr.301.1566494717986;
        Thu, 22 Aug 2019 10:25:17 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:71cc:5738:24ad:193e:4b59:8a76])
        by smtp.gmail.com with ESMTPSA id r12sm31705798pgb.73.2019.08.22.10.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 10:25:17 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 5/8] arm64: dts: bitmain: Add clock controller support for BM1880 SoC
Date:   Thu, 22 Aug 2019 22:54:23 +0530
Message-Id: <20190822172426.25879-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822172426.25879-1-manivannan.sadhasivam@linaro.org>
References: <20190822172426.25879-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock controller support for Bitmain BM1880 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/bitmain/bm1880.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/bitmain/bm1880.dtsi b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
index d65453f99a99..8471662413da 100644
--- a/arch/arm64/boot/dts/bitmain/bm1880.dtsi
+++ b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
@@ -4,6 +4,7 @@
  * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
  */
 
+#include <dt-bindings/clock/bm1880-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/bitmain,bm1880-reset.h>
 
@@ -66,6 +67,12 @@
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 
+	osc: osc {
+		compatible = "fixed-clock";
+		clock-frequency = <25000000>;
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -94,6 +101,15 @@
 				reg = <0x400 0x120>;
 			};
 
+			clk: clock-controller@e8 {
+				compatible = "bitmain,bm1880-clk";
+				reg = <0xe8 0x0c>, <0x800 0xb0>;
+				reg-names = "pll", "sys";
+				clocks = <&osc>;
+				clock-names = "osc";
+				#clock-cells = <1>;
+			};
+
 			rst: reset-controller@c00 {
 				compatible = "bitmain,bm1880-reset";
 				reg = <0xc00 0x8>;
-- 
2.17.1

