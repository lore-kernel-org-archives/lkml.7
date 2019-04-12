Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A542EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CF82186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wKIzkJkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfDLMv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:51:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44043 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfDLMvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:51:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so11771563wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pD/ha1o6xuuVhzSZWIPaFNtC4/6La9+pE80liTrfGdE=;
        b=wKIzkJkJ1lUE+QbaeCtOMd1B8P8cFTBCdaIFNAXADJ+vHY3yVSwLaa4P+9ANa6hZ1W
         nwgZJnhZxPBXqBoUt7QgV6HeNNiNMdsHP3EDrxMj/PVqOpkdmYuKzpK1FYybttWQwLMX
         Yym2l14aXy7blpoLTzcdpiw9IowoFnPKmQkr/ICIipVRtRxC9QablDJr7rJqGsuVFnks
         bzuDNOPDFJ+TmKgy5MFoBF+uzUbiVCbO2KKov9ZDuRoXWpArUr4sBk4PoKXvgfSbF3ws
         m7MZl6FF1WVf6t3ur/pPsaozmHw+wmTWXox0jwMIYPfkEbw/Hubs1FZ3r+W5CaRMSH4O
         YZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pD/ha1o6xuuVhzSZWIPaFNtC4/6La9+pE80liTrfGdE=;
        b=fQpyYcNkGhyG3pLhg4eDl79acNUPiThJjbOTA4/CGoD0b5aXAUnOOSzjbCy2cEk6Qj
         FVmIFQ2rDa5ODNl7PKyfJIWSlFP/HMmv7fqpOGw2F0bn4TSFjlrXhMt++U55FP19n03z
         HvVoBqoLP7zW8OsWSbMu9UyiRX0J2BYrScpKLHpp6pYXnFBxaW++f5xzHrLqmBzckyQZ
         WhMHAXw8MUIYy34LKwdmoPou1XBYuu6ex7dfc07VxNt4WAeXHedL/BgecKw9sA9a1Qj/
         IUEbywmMmVXaSFdHf13hMHvj8GpLDMOcO98jORWLHx6NfgCF5sMBhASY5zCqaAFWa8P+
         PVZg==
X-Gm-Message-State: APjAAAWgPyZYxh3lKDwpphEczj5IXTwoqnopA+cZgZ7bljv/SOoxvZ7v
        WRPoDlCU/J/CUH8gWTcROCWuSw==
X-Google-Smtp-Source: APXvYqz8A36P9ZWbN4122tC3oJ0vZQQEooXHFzHbMajUhOclVDtOFX2+hq6RxAvjq57thiJ3WD3ipw==
X-Received: by 2002:adf:e9c1:: with SMTP id l1mr26023039wrn.270.1555073508457;
        Fri, 12 Apr 2019 05:51:48 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id b3sm42049702wrx.57.2019.04.12.05.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 05:51:47 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patchwork-bot+notify@kernel.org
Subject: [PATCH 1/7] arm64: dts: meson: g12a: add audio clock controller
Date:   Fri, 12 Apr 2019 14:51:30 +0200
Message-Id: <20190412125136.28232-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412125136.28232-1-jbrunet@baylibre.com>
References: <20190412125136.28232-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the controller dedicated to audio clocks found on the g12a SoC.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index d6ca0bbd8f74..1ab2a77b01eb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/clock/g12a-clkc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
 
 / {
 	compatible = "amlogic,g12a";
@@ -202,6 +203,42 @@
 					};
 				};
 			};
+
+			audio: bus@42000 {
+				compatible = "simple-bus";
+				reg = <0x0 0x42000 0x0 0x2000>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges = <0x0 0x0 0x0 0x42000 0x0 0x2000>;
+
+				clkc_audio: clock-controller@0 {
+					status = "disabled";
+					compatible = "amlogic,g12a-audio-clkc";
+					reg = <0x0 0x0 0x0 0xb4>;
+					#clock-cells = <1>;
+
+					clocks = <&clkc CLKID_AUDIO>,
+						 <&clkc CLKID_MPLL0>,
+						 <&clkc CLKID_MPLL1>,
+						 <&clkc CLKID_MPLL2>,
+						 <&clkc CLKID_MPLL3>,
+						 <&clkc CLKID_HIFI_PLL>,
+						 <&clkc CLKID_FCLK_DIV3>,
+						 <&clkc CLKID_FCLK_DIV4>,
+						 <&clkc CLKID_GP0_PLL>;
+					clock-names = "pclk",
+						      "mst_in0",
+						      "mst_in1",
+						      "mst_in2",
+						      "mst_in3",
+						      "mst_in4",
+						      "mst_in5",
+						      "mst_in6",
+						      "mst_in7";
+
+					resets = <&reset RESET_AUDIO>;
+				};
+			};
 		};
 
 		aobus: bus@ff800000 {
-- 
2.20.1

