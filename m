Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5BFC04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B78D2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfEPPwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:52:02 -0400
Received: from verein.lst.de ([213.95.11.211]:60417 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfEPPwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:52:01 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id E6EE568C65; Thu, 16 May 2019 17:51:39 +0200 (CEST)
From:   Torsten Duwe <duwe@lst.de>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: DTS: allwinner: a64: Enable audio on Teres-I
References: <20190516154943.239E668B05@newverein.lst.de>
Message-Id: <20190516155139.E6EE568C65@newverein.lst.de>
Date:   Thu, 16 May 2019 17:51:39 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harald Geyer <harald@ccbib.org>

The TERES-I has internal speakers (left, right), internal microphone
and a headset combo jack (headphones + mic), "CTIA" (android) pinout.

The headphone and mic detect lines of the A64 are connected properly,
but AFAIK currently unsupported by the driver.

Signed-off-by: Harald Geyer <harald@ccbib.org>
Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index f9eede0a8bd3..d57049fbdaca 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -70,6 +70,25 @@
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
+
+	speaker_amp: audio-amplifier {
+		compatible = "simple-audio-amplifier";
+		enable-gpios = <&r_pio 0 12 GPIO_ACTIVE_HIGH>; /* PL12 */
+		sound-name-prefix = "Speaker Amp";
+	};
+};
+
+&codec {
+	status = "okay";
+};
+
+&codec_analog {
+	cpvdd-supply = <&reg_eldo1>;
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
 };
 
 &ehci1 {
@@ -258,6 +286,29 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&sound {
+	simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
+	simple-audio-card,widgets = "Headphone", "Headphone Jack",
+				    "Microphone", "Headset Microphone",
+				    "Microphone", "Internal Microphone",
+				    "Speaker", "Internal Speaker";
+	simple-audio-card,routing =
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right",
+			"AIF1 Slot 0 Left ADC", "Left ADC",
+			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"Headphone Jack", "HP",
+			"Speaker Amp INL", "LINEOUT",
+			"Speaker Amp INR", "LINEOUT",
+			"Internal Speaker", "Speaker Amp OUTL",
+			"Internal Speaker", "Speaker Amp OUTR",
+			"Internal Microphone", "MBIAS",
+			"MIC1", "Internal Microphone",
+			"Headset Microphone", "HBIAS",
+			"MIC2", "Headset Microphone";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
