Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A72FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7B82087E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="oLYE+U6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbfC0CeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:34:07 -0400
Received: from vps.xff.cz ([195.181.215.36]:55152 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732707AbfC0Cdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 22:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553654028; bh=wkW4pbocJoS4nnoajhIfit3K4302v+XeqpmoPTPOOQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLYE+U6Sf3SpGc5riCsPyws50QH/mk7RuImUPGTVzChTRscFN4kKOASn9zkpR8Gv7
         vdtM1g6HE3TGsPJs/QLJxySOdsXCBLfle6ID2EHdGjkORYj66z30PUy3TgSAHJk50U
         LN2YMqbnzEfDIgK5gE7g83IgSRgyF2v1E+wUiFPY=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        mark.rutland@arm.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Ziping Chen <techping.chan@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-input@vger.kernel.org, hdegoede@redhat.com
Subject: [PATCH RESEND v4 4/4] ARM: dts: sun8i: tbs-a711: Add support for volume keys input
Date:   Wed, 27 Mar 2019 03:33:39 +0100
Message-Id: <20190327023339.25975-5-megous@megous.com>
In-Reply-To: <20190327023339.25975-1-megous@megous.com>
References: <20190327023339.25975-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

TBS A711 tablet has volume up/down keys connected to r_lradc. Add
support for these keys.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 1e840ab5a541..6ecdc11b7059 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -46,6 +46,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "TBS A711 Tablet";
@@ -200,6 +201,25 @@
 	status = "okay";
 };
 
+&r_lradc {
+	vref-supply = <&reg_aldo2>;
+	status = "okay";
+
+	button@210 {
+		label = "Volume Up";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <210000>;
+	};
+
+	button@410 {
+		label = "Volume Down";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <410000>;
+	};
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.21.0

