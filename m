Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8912FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497382087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="kBoHUS+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbfC0AZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:25:23 -0400
Received: from vps.xff.cz ([195.181.215.36]:53662 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732034AbfC0AZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553646307; bh=wkW4pbocJoS4nnoajhIfit3K4302v+XeqpmoPTPOOQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kBoHUS+EDsBYfceR4iTtz/GxwZ72nyfLEkftbqCuQdKI5PMiOo9nsFG5jaFJe1C1U
         G5dcvlGeamf+MB/5fLVZML9tQpKM/ToaO6nD9btvjBb6kdSIYt03NyGd+hBi7O5+zM
         hgDIdy+bf4F7xCFQ9jJallcX4WzEUOy310A5ZH6k=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        mark.rutland@arm.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Ziping Chen <techping.chan@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v4 4/4] ARM: dts: sun8i: tbs-a711: Add support for volume keys input
Date:   Wed, 27 Mar 2019 01:25:01 +0100
Message-Id: <20190327002501.4630-5-megous@megous.com>
In-Reply-To: <20190327002501.4630-1-megous@megous.com>
References: <20190327002501.4630-1-megous@megous.com>
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

