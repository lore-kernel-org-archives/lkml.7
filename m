Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33CDC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06DD21721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Luudy5lA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfDMQgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 12:36:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43518 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfDMQgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 12:36:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so11260953wrx.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 09:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9AocJvaLHJoa4iYjdAkrd1jMBEY1Q6G0BQqKP8Q3BgM=;
        b=Luudy5lA0Jr2vYj0t56JgKfgDY00UwatGRG1UI1cDJ7n7e8/X1uBfG6YcApvWFVo8V
         2ZwDGVUicsELiTeIADUWV4D4RilQT0Wv3oZs4yV1IikKqgYq3xjyG3ltNM1Tp4knqaIg
         XLZLpLLwhjwK1DjjR81w8qcAFYd/e88AfNu1ZgLDg55BnHP3oFBCu+VfsvAasSOr0djK
         wacAUzg5quJDb3+xJuoSNhYEA47Fj5WkeH4/+rso/yMsKqwFNgUShA60SnnVOfgTKmu2
         Aa/fDBjOREhr/G4zFfhnCCp/CBOlQChEwJuuHILUPMAi7qF/MjwUJ9CilFUo1AmY59jT
         tjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9AocJvaLHJoa4iYjdAkrd1jMBEY1Q6G0BQqKP8Q3BgM=;
        b=CDsqNImojAQuSbSQhPQwTysa3ZgHTV67nY5uI0h9hCnWOW12rr6yYBltIgYpHgjD4q
         aka6MsMJ2ybNICVnpCZjo/wghIwrCVOWOuNZdnBvRmSMymJbc2eXf6N8BDaNkNIuNqRL
         l+Y2EikUH2q6b4hKuV6BWeiKmiIjU3xdaeBTSFtytoAbpcp3zZQKosUEoO4TWCR+zhh3
         4z76t41zFEB7JGWlS5EywUYQ7oByuhtMjkGtVz55t1aJYFw31+vp3Tf0xO+g2o1mGr82
         6KsPzMTCqIuH7xUtUUs9pAgwslAF890El3GB+JkV8D3I9J4P1P7/piOiUiqjRdxj+aH5
         Gv2w==
X-Gm-Message-State: APjAAAXaGmbhUNS3P5cmk2X7mRO/adoUWWIWqIUOZWZquqRhxs6CK9Z0
        V9frDnAsMi/KgopYuysReFI=
X-Google-Smtp-Source: APXvYqxeR+dM/qboqMgoFunM3kgqRM3vJqoEnr7pd9afz0HJ9zGoF03qrolR2iMoYrFJi40vk2tIiQ==
X-Received: by 2002:a5d:5343:: with SMTP id t3mr38812600wrv.49.1555173398286;
        Sat, 13 Apr 2019 09:36:38 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD00714E418F6C82D049.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:714e:418f:6c82:d049])
        by smtp.googlemail.com with ESMTPSA id j3sm106200069wre.51.2019.04.13.09.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 09:36:37 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jianxin.pan@amlogic.com, ccaione@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/3] ARM: dts: meson8b: ec100: enable the RTC
Date:   Sat, 13 Apr 2019 18:34:22 +0200
Message-Id: <20190413163423.15149-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413163423.15149-1-martin.blumenstingl@googlemail.com>
References: <20190413163423.15149-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC is always enabled on this board since the battery is already
connected in the factory.
According to the schematics the VCC_RTC regulator (which is either
powered by the internal 3.3V or a battery) is connected to the 0.9V
RTC_VDD input of the SoCs.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-ec100.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index 3ca9638fad09..9bf4249cb60d 100644
--- a/arch/arm/boot/dts/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -88,6 +88,14 @@
 		};
 	};
 
+	rtc32k_xtal: rtc32k-xtal-clk {
+		/* X2 in the schematics */
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "RTC32K";
+		#clock-cells = <0>;
+	};
+
 	usb_vbus: regulator-usb-vbus {
 		/*
 		 * Silergy SY6288CCAC-GP 2A Power Distribution Switch.
@@ -347,6 +355,12 @@
 	clock-names = "clkin0";
 };
 
+&rtc {
+	status = "okay";
+	clocks = <&rtc32k_xtal>;
+	vdd-supply = <&vcc_rtc>;
+};
+
 /* exposed through the pin headers labeled "URDUG1" on the top of the PCB */
 &uart_AO {
 	status = "okay";
-- 
2.21.0

