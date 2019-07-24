Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34091C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050D720840
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="vBfFUiqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387781AbfGXR2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:28:18 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52056 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfGXR2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1563988665; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uzIRBKbB7UU2QNs9lNEqqrq3se/+CB7MiPHQYfklzC8=;
        b=vBfFUiqaUOJAoAv6zMOJv+FLPitr8wCJi+GcqrB341SCXYgHJ3lJR8xaUn8F3J/PYavDfC
        tySQI3rwuKbvsBcfd3ThujnMl0PTdJPo4eL+pIhPIdJcQ3OjCuBP8ovg6zA6KFKh8oABMq
        gCB+ugQsu2DAZZpNvSKY/ZOsQZP31i0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v15 11/13] MIPS: CI20: Reduce system timer and clocksource to 3 MHz
Date:   Wed, 24 Jul 2019 13:16:13 -0400
Message-Id: <20190724171615.20774-12-paul@crapouillou.net>
In-Reply-To: <20190724171615.20774-1-paul@crapouillou.net>
References: <20190724171615.20774-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default clock (48 MHz) is too fast for the system timer.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
    v5: New patch
    
    v6: Set also the rate for the clocksource channel's clock
    
    v7: No change
    
    v8: No change
    
    v9: Don't configure clock timer1, as the OS Timer is used as
    	clocksource on this SoC
    
    v10: Revert back to v8 bahaviour. Let the user choose what
    	 clocksource should be used.
    
    v11-v15: No change

 arch/mips/boot/dts/ingenic/ci20.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 4f7b1fa31cf5..2e9952311ecd 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -2,6 +2,7 @@
 /dts-v1/;
 
 #include "jz4780.dtsi"
+#include <dt-bindings/clock/ingenic,tcu.h>
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -238,3 +239,9 @@
 		bias-disable;
 	};
 };
+
+&tcu {
+	/* 3 MHz for the system timer and clocksource */
+	assigned-clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>;
+	assigned-clock-rates = <3000000>, <3000000>;
+};
-- 
2.21.0.593.g511ec345e18

