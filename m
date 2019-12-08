Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7066DC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 18:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35698206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 18:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DjcQP7b2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLHSFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 13:05:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39380 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfLHSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 13:05:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so13451373wrt.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 10:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UuP9LhRtgkK8koesUiLux4flnpKR/nS/46pWP1bbRQo=;
        b=DjcQP7b2GrL9Y8doqAnmZen1LtRo/zLBC1HSPEYSk45emHJ+l/CcOF1N1rZ0x69LE5
         5pUjYqbdjixV6s7xBJFTymPx/cpB7o8w2ZOK/Xqhq+Xis2+H+x6f8gboyA1cGUWizrdg
         OfO+6IxkHRsV7ut1LzxU67zJhph+4MZDY4tJHjiClgNH+AFuU5LsH1Gqs3W7RvQO5+r7
         LpkfjwfqnkxffPgmzDG4oRgf4/5mFsHvohvSj5eXsMbzM5eDCVhzMCvUD4ZAapaUEqW/
         8UAfaLVY/lvEwQ9xx19uBmvslYY2oZ1GgLiTeh6nI5TMaNwAp8h0G6y4lHFgub8LlG4e
         l3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UuP9LhRtgkK8koesUiLux4flnpKR/nS/46pWP1bbRQo=;
        b=TZWnb7Da4goQRQTV04xVI9q7nZG+SUjOvI0OIgRAwQF6qR3DH9eRJV4eCWXbFUp4td
         S/SK5f3K+QxgzwzMuRlzvBvM8sjOkEwPlpkum97duXfj21brE2M3utsgybwjgh0PV9oa
         NdrtiSwA9ypZ6IQpAxxfaFcIfMMAblol4QAMOyanOXC3i6auZ3zielbon0mgKMDBH107
         VfIUZpcj2UzJ8hb8VV00D8aSVmuuM6Q1cBlV4/TEi5C1LLQ4aUKMBiVXOHrPqJzLM+mB
         ABrGR1O5pmAW+vSjDBUO4FScPUO+TPA66ye9/rJBsffZn3RIDyJjg8voG1I3lOrFjeIn
         ltJQ==
X-Gm-Message-State: APjAAAVFzGhFyjQI7P5ArNrZZib26tdvnlvzp3vdXTl5pFDmvkA/p4gd
        2AirDzLSybIMYYJ+DWogmyU=
X-Google-Smtp-Source: APXvYqz8FE+HKKyDmebCrGclBYajOMpFDHdh0F2mObT75i8X0038zJYEHXA76soGKk0k6BHGl4WkiQ==
X-Received: by 2002:adf:b605:: with SMTP id f5mr25821137wre.383.1575828343648;
        Sun, 08 Dec 2019 10:05:43 -0800 (PST)
Received: from localhost.localdomain (p200300F1371AD700428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371a:d700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id a64sm11797687wmc.18.2019.12.08.10.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 10:05:43 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        jbrunet@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/3] ARM: dts: meson8: add the DDR clock controller
Date:   Sun,  8 Dec 2019 19:05:24 +0100
Message-Id: <20191208180525.1076152-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191208180525.1076152-1-martin.blumenstingl@googlemail.com>
References: <20191208180525.1076152-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DDR clock controller and pass it's DDR_CLKID_DDR_PLL to the main
(HHI) clock controller as "ddr_clk". The "ddr_clk" is used as one of the
inputs for the audio clock muxes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index add6d7991fdf..b35d7444c1f4 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -3,6 +3,7 @@
  * Copyright 2014 Carlo Caione <carlo@caione.org>
  */
 
+#include <dt-bindings/clock/meson8-ddr-clkc.h>
 #include <dt-bindings/clock/meson8b-clkc.h>
 #include <dt-bindings/gpio/meson8-gpio.h>
 #include <dt-bindings/reset/amlogic,meson8b-clkc-reset.h>
@@ -195,6 +196,14 @@ mmcbus: bus@c8000000 {
 		#size-cells = <1>;
 		ranges = <0x0 0xc8000000 0x8000>;
 
+		ddr_clkc: clock-controller@400 {
+			compatible = "amlogic,meson8-ddr-clkc";
+			reg = <0x400 0x20>;
+			clocks = <&xtal>;
+			clock-names = "xtal";
+			#clock-cells = <1>;
+		};
+
 		dmcbus: bus@6000 {
 			compatible = "simple-bus";
 			reg = <0x6000 0x400>;
@@ -455,8 +464,8 @@ &gpio_intc {
 &hhi {
 	clkc: clock-controller {
 		compatible = "amlogic,meson8-clkc";
-		clocks = <&xtal>;
-		clock-names = "xtal";
+		clocks = <&xtal>, <&ddr_clkc DDR_CLKID_DDR_PLL>;
+		clock-names = "xtal", "ddr_pll";
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};
-- 
2.24.0

