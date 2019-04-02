Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E61CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAA120857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvtU31Ws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfDBGbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:31:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42033 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfDBGbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:31:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id r15so5814969pfn.9;
        Mon, 01 Apr 2019 23:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ADfhP5zjUuDjSW2hB90EQKoYLSBhq+Id1FV/2cN0vlY=;
        b=TvtU31Wsh2zQ/3Nh5ZDWzgedo0YgcJM73Oap3izPnwHvdW/8iC4VOTHiyrJwtlIwwX
         cMxP8ilL+xbsKv7pDHkGWg4cO7AAicDftKinlUH5/9JCqWjTS55bbtf8f03zI54TBDSL
         QNSjdqkYARq+a+aC7YNeuLTgd7GXX6xg8isXClJo+9TAJcQuXBX+5RT37jzSuTiAX5dm
         4V3GZL+OtPanqMb9DARiEEgt0CBNGKy2xZQgsB5k/5s4EdBovly0TOmDHLCXPbVGK1UF
         2olKuS0Zf+IGrhYm29qKTFogkg4dD7QP7Fy7lcpKCSjkzklnwK+YLYO8dC5Ugf+eDEjL
         Magw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ADfhP5zjUuDjSW2hB90EQKoYLSBhq+Id1FV/2cN0vlY=;
        b=t32Yul+mNT0A9gdDjJ2yH5DUG2/0cgQ7z35F0IEe8/exwTOq+/WrvvTFnIPOorIL43
         JgXe6dp7i8h36t/hDskpBuoHqxnvpAdAZjMkceUDl9AxGIT3RpIQOiA+r4TamvBW8exJ
         w2m/HaYsc22qOCFhoUto0jqoGlU3cXeOkri5ENzSh0y+TM0Azl6hLgWDbgsEkfamZu2/
         csZptJsjUB/PYzz2ybyETpFf6tcEtI3C6JmBHzG4Yhm+GOiqShSEfuCL/U9DW3iBhNSK
         J1ENP8Nkmaea03/bw3VrEgvxeqs1BFW7HfCTKdsMjAyLk0NwpFYyobBIUWEzQ9O/+Sz3
         bvRw==
X-Gm-Message-State: APjAAAUGx4O9IoZEcxU7t3ZZlr33uVpEWMEuAY1ACIqTfUNx5GZ6iCYG
        30kq59VRhCk/Oi0WQjhE4bo=
X-Google-Smtp-Source: APXvYqzbMDztJcOdNTyqzRYMbCs9hmjnd9YghZAZYSsUUdk+HZF7IfKegX2wxDi3hfqMSXoW+n9tRw==
X-Received: by 2002:a62:ac02:: with SMTP id v2mr26546282pfe.163.1554186692246;
        Mon, 01 Apr 2019 23:31:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 23:31:31 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org, david@lechnology.com,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        thierry.reding@gmail.com, esben@haabendal.dk,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patrick.havelange@essensium.com, Rob Herring <robh@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 08/18] dt-bindings: counter: Document stm32 quadrature encoder
Date:   Tue,  2 Apr 2019 15:30:43 +0900
Message-Id: <fb7d2eb37a1bb0eb2a0e0b0ff89f25f965f293c9.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

Add bindings for STM32 Timer quadrature encoder.
It is a sub-node of STM32 Timer which implement the
quadratic encoder part of the hardware.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../bindings/counter/stm32-timer-cnt.txt      | 31 +++++++++++++++++++
 .../devicetree/bindings/mfd/stm32-timers.txt  |  7 +++++
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt

diff --git a/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
new file mode 100644
index 000000000000..c52fcdd4bf6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
@@ -0,0 +1,31 @@
+STMicroelectronics STM32 Timer quadrature encoder
+
+STM32 Timer provides quadrature encoder to detect
+angular position and direction of rotary elements,
+from IN1 and IN2 input signals.
+
+Must be a sub-node of an STM32 Timer device tree node.
+See ../mfd/stm32-timers.txt for details about the parent node.
+
+Required properties:
+- compatible:		Must be "st,stm32-timer-counter".
+- pinctrl-names: 	Set to "default".
+- pinctrl-0: 		List of phandles pointing to pin configuration nodes,
+			to set CH1/CH2 pins in mode of operation for STM32
+			Timer input on external pin.
+
+Example:
+	timers@40010000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "st,stm32-timers";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "int";
+
+		counter {
+			compatible = "st,stm32-timer-counter";
+			pinctrl-names = "default";
+			pinctrl-0 = <&tim1_in_pins>;
+		};
+	};
diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
index 0e900b52e895..15c3b87f51d9 100644
--- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
+++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
@@ -28,6 +28,7 @@ Optional parameters:
 Optional subnodes:
 - pwm:			See ../pwm/pwm-stm32.txt
 - timer:		See ../iio/timer/stm32-timer-trigger.txt
+- counter:		See ../counter/stm32-timer-cnt.txt
 
 Example:
 	timers@40010000 {
@@ -48,6 +49,12 @@ Example:
 			compatible = "st,stm32-timer-trigger";
 			reg = <0>;
 		};
+
+		counter {
+			compatible = "st,stm32-timer-counter";
+			pinctrl-names = "default";
+			pinctrl-0 = <&tim1_in_pins>;
+		};
 	};
 
 Example with all dmas:
-- 
2.21.0

