Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC4EC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21261218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WrGfFosq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfDLMvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:51:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55972 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfDLMvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:51:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so11078770wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YRXN73rwWK7CxJS5YgF/viBNttH7xk5Xg8WuUiR1Q98=;
        b=WrGfFosqO0n7rEE40N73YryU8iFNP4iRBITt3YmVUm792V7uyVg3WjTshSr6oahWAG
         JSSPUV4hd9N5tdvVtJVayS4CtKk6bhb7iq7VQkrIXLH1o5acrcknPopFqyCjeL/HVYlH
         9B9RuK6K4tI0LcY3j5WEgQ0V5vo0folNfv8LgMIInHmcsZYV4ysTCMJvBdZRmu+fqqF2
         pIsIteOPGE77BfzmoNnUYuA3y3kraQYtyu6RtDL7041EWy4cwN0pjf4xwzpyhGDXrQGx
         zUeWJJ2Cs1R/UdZhGGWvblPPRlphv/AJJFWevRAS/0RgSUygrGMyLvTFdT+zqINFGKub
         dw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YRXN73rwWK7CxJS5YgF/viBNttH7xk5Xg8WuUiR1Q98=;
        b=sPVD/7hJ8Zyqivfqn21m2DOanHCXghD2oKMzb+Sq9rrZmD3XI97ZqUFoznb1AVW3ad
         7xeu9vxqXzjFs75I31qDdWsA16GFB4bDozt/6iiI1hpXxCR66Gz0TBTgDF8P7dOjrjTl
         V7PfgL9kOehQqAJOkaU34Wtou81F+JWhtnOILRlOkXbOCdxzszy4Egw6L+fzx5pRgVMQ
         FS7PSktzRyIlXcJXJMxOrMUDhq7WuZ4SbghMLCbYIGA4ahys6+faSZX5AuNiAlvmHBjW
         8NgdQZdiga3xDUHDrdUvqfXrHDIgYWMMZigyQ9fc08CbsVO2fKGnBtR+Hn2Gfnc1uv4t
         VACg==
X-Gm-Message-State: APjAAAX/jkVTpW4bpqB8jQBrj5Z3QVUzE/SqAYNooA7/WSscGlxPjqp4
        hANCo2MfFTQi9Ywqtj9E9TNqOA==
X-Google-Smtp-Source: APXvYqxZ+Ot91QIi1v9U3unqQLTOKOXCqVZi0nLR8Cl7uBCMgWcgWg44ZpyZRAlgKW0RWNYWd+lDxA==
X-Received: by 2002:a1c:1d97:: with SMTP id d145mr10608459wmd.136.1555073511533;
        Fri, 12 Apr 2019 05:51:51 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id b3sm42049702wrx.57.2019.04.12.05.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 05:51:50 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patchwork-bot+notify@kernel.org
Subject: [PATCH 3/7] arm64: dts: meson: g12a: add audio fifos
Date:   Fri, 12 Apr 2019 14:51:32 +0200
Message-Id: <20190412125136.28232-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412125136.28232-1-jbrunet@baylibre.com>
References: <20190412125136.28232-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the capture and playback audio fifos (DMA) of the g12a SoCs.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 73 +++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index b2acece1b66b..18f7d5af7dae 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/g12a-clkc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
 
 / {
@@ -240,6 +241,78 @@
 					resets = <&reset RESET_AUDIO>;
 				};
 
+				toddr_a: audio-controller@100 {
+					compatible = "amlogic,g12a-toddr",
+						     "amlogic,axg-toddr";
+					reg = <0x0 0x100 0x0 0x1c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "TODDR_A";
+					interrupts = <GIC_SPI 148 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_TODDR_A>;
+					resets = <&arb AXG_ARB_TODDR_A>;
+					status = "disabled";
+				};
+
+				toddr_b: audio-controller@140 {
+					compatible = "amlogic,g12a-toddr",
+						     "amlogic,axg-toddr";
+					reg = <0x0 0x140 0x0 0x1c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "TODDR_B";
+					interrupts = <GIC_SPI 149 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_TODDR_B>;
+					resets = <&arb AXG_ARB_TODDR_B>;
+					status = "disabled";
+				};
+
+				toddr_c: audio-controller@180 {
+					compatible = "amlogic,g12a-toddr",
+						     "amlogic,axg-toddr";
+					reg = <0x0 0x180 0x0 0x1c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "TODDR_C";
+					interrupts = <GIC_SPI 150 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_TODDR_C>;
+					resets = <&arb AXG_ARB_TODDR_C>;
+					status = "disabled";
+				};
+
+				frddr_a: audio-controller@1c0 {
+					compatible = "amlogic,g12a-frddr",
+						     "amlogic,axg-frddr";
+					reg = <0x0 0x1c0 0x0 0x1c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "FRDDR_A";
+					interrupts = <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
+					resets = <&arb AXG_ARB_FRDDR_A>;
+					status = "disabled";
+				};
+
+				frddr_b: audio-controller@200 {
+					compatible = "amlogic,g12a-frddr",
+						     "amlogic,axg-frddr";
+					reg = <0x0 0x200 0x0 0x1c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "FRDDR_B";
+					interrupts = <GIC_SPI 153 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_FRDDR_B>;
+					resets = <&arb AXG_ARB_FRDDR_B>;
+					status = "disabled";
+				};
+
+				frddr_c: audio-controller@240 {
+					compatible = "amlogic,g12a-frddr",
+						     "amlogic,axg-frddr";
+					reg = <0x0 0x240 0x0 0x1c>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "FRDDR_C";
+					interrupts = <GIC_SPI 154 IRQ_TYPE_EDGE_RISING>;
+					clocks = <&clkc_audio AUD_CLKID_FRDDR_C>;
+					resets = <&arb AXG_ARB_FRDDR_C>;
+					status = "disabled";
+				};
+
 				arb: reset-controller@280 {
 					status = "disabled";
 					compatible = "amlogic,meson-axg-audio-arb";
-- 
2.20.1

