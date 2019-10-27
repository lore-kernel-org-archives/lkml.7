Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAC4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CDB214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DJKRsi+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfJ0QXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 12:23:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46882 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfJ0QXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 12:23:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so7342780wrw.13;
        Sun, 27 Oct 2019 09:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FR91Xkho7A58iCTl5ApNx6Gn9blyxo7jlHkr4Z2ufbE=;
        b=DJKRsi+4xUNfRqEYSANnCE2BCk4qocBMxIHxvNaFwMv+6reNOJ1yDYZzxawhOVKc+u
         uTJs8mvzJAJRnXdV3PBCK7J+OLejIm0UExJaXQogyWv2+BgWDBWfXTg3kZpu0Jmdk7lG
         /TyFplsRJQ2IpcuqsNqJKTxyHc9uJ2l/2CiD1tpl4bJ5csKhETxra1ZBvxjQGJGCtawL
         yOxoKoQ/Qczup8O23yRK//AG/vdy4hLOGN68aA6tPyya/7qZ+H27V1gYV5prUio4nJDb
         IQWqqg+8jrprGeXqbfvnrir+EWjX38frqDR51u3xD1yBKGVj/PN1HyM3z5ncT5s0Ameu
         /Thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FR91Xkho7A58iCTl5ApNx6Gn9blyxo7jlHkr4Z2ufbE=;
        b=hbwJ+zhCBWfzHfTFCFqeZCWau3+GTI4AlMdHlQpr4SfofLM170L51LxQsaTS2dODRQ
         hD/lC7EcESXCJuO01CC5FzgQitUjpRBsmDH8HzUxoTA6sXASJLSs71Z8z6V3xd7ByuXr
         j/gO2t9rr1lNO1iMyl3DozO1mDyDVqzlhGTwPesA/2PyloEgCX/UrCQHd8lrCBzFzocX
         Xi/VHuYPijIgR0+HNbtyLf3EbU1ahzAUD7KtNZqwb3UD0Eb4TWm8s64k2Y3qTHrIPWCY
         fuPlCpZmLP/Gwn6S4pvdUyJ5wetxkBk+ydQXks8V1inGIiMnnxfZ3ts9+jzWYOdZVOGH
         TW+A==
X-Gm-Message-State: APjAAAW4k76Du7kxP0oINBUTcIq/8zypjg1atTSA+4GQiV/9aSZybbKW
        qhjZh/bZBKcE4nF2zunCAYE=
X-Google-Smtp-Source: APXvYqwYcUCsvwTfCVC8G8QhpTTpc/gHzJpzRKp5RQnLVauGHvqBTZj2iIoo9YjsXmaCQ/Mnq8Vf2g==
X-Received: by 2002:a5d:640e:: with SMTP id z14mr11475473wru.311.1572193425067;
        Sun, 27 Oct 2019 09:23:45 -0700 (PDT)
Received: from localhost.localdomain (p200300F133D01300428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33d0:1300:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id 1sm8243299wrr.16.2019.10.27.09.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 09:23:44 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 4/5] ARM: dts: meson8: add the DDR clock controller
Date:   Sun, 27 Oct 2019 17:23:27 +0100
Message-Id: <20191027162328.1177402-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027162328.1177402-1-martin.blumenstingl@googlemail.com>
References: <20191027162328.1177402-1-martin.blumenstingl@googlemail.com>
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

