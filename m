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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F630C4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634B9208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jbSHNaXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438224AbfIUPTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 11:19:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33621 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438182AbfIUPS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 11:18:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so11623708wme.0;
        Sat, 21 Sep 2019 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ryY1C6V/Fnndw45BEkZbgWqU1CO6K4z5Y17d3HMNBz4=;
        b=jbSHNaXEeYn6hTwnob4r0cFK1tawMR7cK74NLvuSDg9K1Q+i9UN9MDMzyPNum1rg3u
         3+Zlha3bTktCHxytNPYwWn53kVqaCHTgDo1L0cjl3wRSBAjIgHQkbY/BPedgCdfd+m9m
         JA6TQEeNuoNw7bN0LVMoBnGgKOo5DmAPmrUPyP62jHCdLV+yumcWomD7WbfFLICNTIMl
         wOB/n0k8in4sKU/Ftefui+uGHNdWEvAMHFdPXAUmYacmj0L6jE0PslD3GpFqk++rcNG6
         8ykti5lqNIIgp4jx0YLk0usYFU/nzwdGlTbqK72AnwmeBGV/FbdcGgiN58hjVeP3yfjM
         XSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ryY1C6V/Fnndw45BEkZbgWqU1CO6K4z5Y17d3HMNBz4=;
        b=o2dAXi0lZ2SbqSq9U5qnP3uRVuFwPHMmjHL43wzVfpNrnGe4NIqZod1FY6FH/v/kPh
         /zzGpxwokbe+boXQfzIfr099Y+sHvQ6HjzF9Bc/kZgVPbPaeYdT/5cv2nloQ8w5s5h/p
         +9Ql+PGAcbaHpuCW+rFandoZO470g7phaUbMvHm8nMW2nqYNPEV/2C19woyG1wAcv7gO
         gt+7TVkAb8HX3u8r/us72MgdwE/FA/NhWD95aajOfA6IdOPdDb4PDpfGNbab1tFSxCtb
         OR3F7BMqw4P5zr2slwZTeQ8aelUzG/96GpHvVFtwHzpKl3ty0+nNnPLfCywZulQQIbdl
         CmLw==
X-Gm-Message-State: APjAAAUuXXZkQCzNIstXrQf2Gnl3wEBQWqmmELW8iyiX9Sp9VCmi9bLE
        Auznc1RkMZ/vgfQMn49DkZM=
X-Google-Smtp-Source: APXvYqzBWlO/a1o7buEzHL4fJp72XmAnFcohUCZlv806SiF/cVfQ3RUOZrNiEOVvXdyUtLEN+b6d2A==
X-Received: by 2002:a05:600c:217:: with SMTP id 23mr7868145wmi.76.1569079134900;
        Sat, 21 Sep 2019 08:18:54 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133CE0B0028BAA8C744A6F562.dip0.t-ipconnect.de. [2003:f1:33ce:b00:28ba:a8c7:44a6:f562])
        by smtp.googlemail.com with ESMTPSA id c6sm6003120wrb.60.2019.09.21.08.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 08:18:54 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 6/6] ARM: dts: meson8b: add the DDR clock controller
Date:   Sat, 21 Sep 2019 17:18:35 +0200
Message-Id: <20190921151835.770263-7-martin.blumenstingl@googlemail.com>
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
 arch/arm/boot/dts/meson8b.dtsi | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 1934666ff60f..8ac8bdfaf58f 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -4,6 +4,7 @@
  * Author: Carlo Caione <carlo@endlessm.com>
  */
 
+#include <dt-bindings/clock/meson8-ddr-clkc.h>
 #include <dt-bindings/clock/meson8b-clkc.h>
 #include <dt-bindings/gpio/meson8b-gpio.h>
 #include <dt-bindings/reset/amlogic,meson8b-reset.h>
@@ -172,6 +173,14 @@
 		#size-cells = <1>;
 		ranges = <0x0 0xc8000000 0x8000>;
 
+		ddr_clkc: clock-controller@400 {
+			compatible = "amlogic,meson8b-ddr-clkc";
+			reg = <0x400 0x20>;
+			clocks = <&xtal>;
+			clock-names = "xtal";
+			#clock-cells = <1>;
+		};
+
 		dmcbus: bus@6000 {
 			compatible = "simple-bus";
 			reg = <0x6000 0x400>;
@@ -434,8 +443,8 @@
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

