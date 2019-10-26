Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F96ECA9EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5572721655
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PcCgI+5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfJZLDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 07:03:34 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:38957 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfJZLDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 07:03:33 -0400
Received: by mail-pf1-f172.google.com with SMTP id v4so3441776pff.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y6Dgg0LHIAz3laO+y1ntUkl0I7eVRTHEz+QlpqCcJzM=;
        b=PcCgI+5Uk4+2QOtva7LrdqGw/ak4nk7qSeEMr723khYMa6gWpChw9Y1C3ZnkguEkqM
         c30XftThaNU0RSa1jFu71B1uf6OaYSYBcB1+3aDnHBRABZtmHFGr68aYpUFS3ksTD4yu
         ToYrqU935IGFVtWTsMtW3qnaOo5aYDgFcXgyuDIqA26QagZ/4qh3TR5nl9KDeCqjB79u
         2bZX41wlop6pBV3KM3JWxgPBzwmXbEOPrqIAo1GYRO8WMe/Q5SzURqTHazHRiF8o/m8X
         01ZsUl2qF4PCODOGd+L8C1enhAuY+jK1mYfmxzlSXzE7VpgOEss89Y7jkI+Sl7AEiEZc
         miag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y6Dgg0LHIAz3laO+y1ntUkl0I7eVRTHEz+QlpqCcJzM=;
        b=fHfSr6SrPNs2HbpCnjEHDGOFLdEIk9UBhWW5r1vhRE/oebvDVKBg8Y8KWvq02junre
         4n2f+wxr6OZjta2w4RLpGYV6noh6xQjIWt60GPlwLmBCHXev9Akz3Yumn+qnEqDVHRTM
         gDCVDhAegOWh+gjlMPKqW5dXjYkwnnqThawC/4bm79FRIuqMZkNmtJSLATLFaJufPyGr
         oDPUSV0dC0hx49SBfvsqK8XKzATggVbWtGN5EWRnVOSmJzkIukykMO8/fnokbb/AWj5W
         HgeQ4W5OCCww7L28/rg6eWJ7TRrqHM8Hi0TYtosfbd3Qpvyl43TIEHLtsKC3E/E81Xyy
         woSA==
X-Gm-Message-State: APjAAAX0gVEpBFi5LoaQGYEiGfJbvJlNPQ0ogC2XNPExbwOqK+icXcA1
        u/pCjTgw11uej+JzSTsF5mCW
X-Google-Smtp-Source: APXvYqzowpzR04MTwmL3N8OyfcVyg17NzEjCzBIUt7ybdLxmxuCT8V1POkDgpr/m0PBBlzk8wfKDgQ==
X-Received: by 2002:a17:90a:a384:: with SMTP id x4mr1395313pjp.116.1572087812466;
        Sat, 26 Oct 2019 04:03:32 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6214:69c4:49ad:ba3c:6f9:2d8a])
        by smtp.gmail.com with ESMTPSA id x129sm5543379pfx.14.2019.10.26.04.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 04:03:31 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 4/7] arm64: dts: bitmain: Add clock controller support for BM1880 SoC
Date:   Sat, 26 Oct 2019 16:32:50 +0530
Message-Id: <20191026110253.18426-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191026110253.18426-1-manivannan.sadhasivam@linaro.org>
References: <20191026110253.18426-1-manivannan.sadhasivam@linaro.org>
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

