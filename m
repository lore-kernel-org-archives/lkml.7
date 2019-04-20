Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9470AC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7DA20854
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnoVPVlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfDTOwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 10:52:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39703 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 10:52:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id e92so2059938plb.6;
        Sat, 20 Apr 2019 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fjXElioTNn0znvD/3UdTPYP7pGyhNbHIV3hkEzwuuh0=;
        b=tnoVPVlIyTP1zGHUr73pwXlcx8gr/sw5n+kFlXv6c2j1TRi3e8CHyQLkUXycOmBBYi
         MhJZMtmlDX1xx1A+pbw+hIG8JIUePXNRP5HyT1VkOOENKWrABtGz4h4fYFZJmR//+07H
         G+m8E4A97dTM26vOaja4Ok8aCA+GHADjG0dy202aQaxPxnIbE9CYC7w9WeFmBkbH/XAm
         exYmScfjCQDicNslyNNlUMdJlbumyeQqK0CXwY4a0v4h1uBJly2GQ1fZMrHvCOHEDj56
         IW9kvG10uM5iTb2mTbk3hsnINYxmAu2mSYL7ONcblwWAyv+qtxbkVgkwsWQM/DWUJcWu
         Rpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fjXElioTNn0znvD/3UdTPYP7pGyhNbHIV3hkEzwuuh0=;
        b=cYktPJMkDEUZ3cm9TnoNIrFTJQSR4GD8ozAmXKDz/g3/0F24eynRnCBCBzCm6p4rWe
         1+N7mxalikYdNVIWawAThnrdnpO/L5LW3aRjPgIYV8ozwpJ1eVt6uLaLXOLJifnOf1Kk
         vK4MU+C9hXRUV54HGUHfI9pJ3risTs0lYhE3y9JSfcHPrp4NQVTmnB+4VFTSkm7cDeIn
         83bLlH/DtzlDKHVim7bmEsIQJwRL3X8F/Q9AD01rgFBHOsxMiyt+hlv7PODt1n/HSgVF
         l+Qp+aIt1rgbAM5viwx9UzUGEU7VTRGkDBGrNNOcdJmNYJc7v9DjhFHwFbrHMAWnisVx
         49lw==
X-Gm-Message-State: APjAAAWDVc/F9Ugn5v7z/+lSIYvLyuczk0dqkEuT9MT8MYUkesrxHF8J
        epGhJ5fo4YLZdl/1Qn0to68=
X-Google-Smtp-Source: APXvYqzsxwMELY6Y3wLX6tVwCzs8xE71b2492HqFRkko9rEVK4cRUKtWdaj7Z4HGdHuXpBo+ScCDyQ==
X-Received: by 2002:a17:902:5609:: with SMTP id h9mr80552pli.35.1555771964256;
        Sat, 20 Apr 2019 07:52:44 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id y10sm11536852pfm.27.2019.04.20.07.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 07:52:43 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] arm64: dts: allwinner: h6: Enable HDMI output on orangepi 3
Date:   Sat, 20 Apr 2019 10:52:40 -0400
Message-Id: <20190420145240.27400-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Orangepi 3 has HDMI type A connector.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
rebase:
sunxi/dt64-for-5.2 arm64: dts: allwinner: a64-amarula-relic: Add OV5640
camera node
---
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 17d496990108..6ed3a1ee297d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -21,6 +21,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -50,6 +61,10 @@
 	cpu-supply = <&reg_dcdca>;
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -58,6 +73,16 @@
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
-- 
2.17.0

