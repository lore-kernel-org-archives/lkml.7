Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FCEC4740A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68880217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KWRSBJVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438242AbfIUPTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 11:19:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37997 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438147AbfIUPSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 11:18:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so4923380wmi.3;
        Sat, 21 Sep 2019 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FR91Xkho7A58iCTl5ApNx6Gn9blyxo7jlHkr4Z2ufbE=;
        b=KWRSBJVsDsKJOmZiT5h/pv4+GIz8T9Vn5Sg/QFlaN8AL6lpIc1VBJZRBiglIK0acUE
         I3dWlqeUmi5lESjDBd6eVVY/oe0QcxsXIiUsgm8iyKkH45U0jTjcZ+AW0SHByk0LJ7CB
         VWrOs6MKnx4J7EUGSv4VqEHMZddFyBeCYc3HwSrh80uTIV2QwkjsQ48C/iQdRtltTsUH
         zJhAfbRzf8oB2sLRFT/h10adWMx+BQ/HkJgch2fFN1QNfLxoXG6Rc+ITjehYR9n9IKgY
         ynAE5QCmoybHDI8BN1BJVEhTDhXRcNnOTzuOdg15ms4wnY8vWzupygv0snfKJA6MgOd/
         /+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FR91Xkho7A58iCTl5ApNx6Gn9blyxo7jlHkr4Z2ufbE=;
        b=NMJ5/RUZamFr+ehtmIfzFm6FdCAz2IBLAFpscxcPdIRSG4GAX0QpgqP7+y/07/TQn4
         WMyY3YhdhRsZf8mR5vSUqI+gNro1Crff5JQ2MrK/GCwmjOFnyHkj7cdslFA31xHigL2M
         XjzJu6nwlfdq+qftS1QoyWRoUbw0ZvBI2ON/eJ/B9KxdCkPCASm/qwwmjZ8nQLch9YEN
         3Tw4WEeoZMkCnvbCG2efZV98XdM7185hQDsgGG7WzndywQO05YqUTbm9ozFNWQRmaVqt
         5QcWedBt5IFAZKK5PFD+VbPRDD1BE4nt7FKwlbpTfSyFGj08clXBPfT/aDB2ppLfPTNu
         mP+A==
X-Gm-Message-State: APjAAAWh2RBKPc+Xv6cqlPQgy9I+tbVUSoLYSVucVfHM/wnM0to+Xudc
        zzsx/UEhh/7DTdh4IdOvhSo=
X-Google-Smtp-Source: APXvYqxVJaRV1NZ9p+a9UvRRJxgcRUElyATnSz2niSamFqTnFOLRoyRIYqzSD+uFEQH+1eVwneDFYg==
X-Received: by 2002:a1c:ba08:: with SMTP id k8mr7603515wmf.63.1569079133659;
        Sat, 21 Sep 2019 08:18:53 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133CE0B0028BAA8C744A6F562.dip0.t-ipconnect.de. [2003:f1:33ce:b00:28ba:a8c7:44a6:f562])
        by smtp.googlemail.com with ESMTPSA id c6sm6003120wrb.60.2019.09.21.08.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 08:18:53 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 5/6] ARM: dts: meson8: add the DDR clock controller
Date:   Sat, 21 Sep 2019 17:18:34 +0200
Message-Id: <20190921151835.770263-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190921151835.770263-1-martin.blumenstingl@googlemail.com>
References: <20190921151835.770263-1-martin.blumenstingl@googlemail.com>
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
index 4f59a4c8f036..257c1364864c 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -3,6 +3,7 @@
  * Copyright 2014 Carlo Caione <carlo@caione.org>
  */
 
+#include <dt-bindings/clock/meson8-ddr-clkc.h>
 #include <dt-bindings/clock/meson8b-clkc.h>
 #include <dt-bindings/gpio/meson8-gpio.h>
 #include <dt-bindings/reset/amlogic,meson8b-clkc-reset.h>
@@ -195,6 +196,14 @@
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
@@ -455,8 +464,8 @@
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
2.23.0

