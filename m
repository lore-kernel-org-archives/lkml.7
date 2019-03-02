Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060E6C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C934920838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="AFFSjFni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfCBXhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 18:37:11 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:36348 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfCBXhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 18:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551569826; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QXVem2TpVdYtsiNNPXp2mDxTvUig9TlLtbDdC9zzZmE=;
        b=AFFSjFniRIdHXTr/huYhATFf/DMWvKITK4K4Mj3haJmuksIAur794g8f9EATpWaZxkuc7S
        QcNYWondm1Ge++ruUNoqWdvUsTPuuAfCaNkhp0ErnJcPoz9tqeJy/oW2wKo+31QFMmrg1+
        +2QPDlQam/3zqyAtkP6qkmD9k8gToSo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v10 25/27] MIPS: GCW0: Reduce system timer and clocksource to 750 kHz
Date:   Sat,  2 Mar 2019 20:34:11 -0300
Message-Id: <20190302233413.14813-26-paul@crapouillou.net>
In-Reply-To: <20190302233413.14813-1-paul@crapouillou.net>
References: <20190302233413.14813-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default clock (12 MHz) is too fast for the system timer.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
         v8: New patch
    
         v9: Don't configure clock timer1, as the OS Timer is used as
             clocksource on this SoC
    
         v10: Revert back to v8 bahaviour. Let the user choose what
              clocksource should be used.

 arch/mips/boot/dts/ingenic/gcw0.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/gcw0.dts b/arch/mips/boot/dts/ingenic/gcw0.dts
index 35f0291e8d38..2f26b8a498e9 100644
--- a/arch/mips/boot/dts/ingenic/gcw0.dts
+++ b/arch/mips/boot/dts/ingenic/gcw0.dts
@@ -60,3 +60,9 @@
 	/* The WiFi module is connected to the UHC. */
 	status = "okay";
 };
+
+&tcu {
+	/* 750 kHz for the system timer and clocksource */
+	assigned-clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>;
+	assigned-clock-rates = <750000>, <750000>;
+};
-- 
2.11.0

