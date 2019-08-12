Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8967C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7925320663
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVb+eaXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfHLKv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:51:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36423 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfHLKvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:51:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so11349623wme.1;
        Mon, 12 Aug 2019 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s6rx1dKUlrkp8lxrOtRYzLFSZ1b6ZE6siahQ5YOjH0s=;
        b=CVb+eaXo2L4uM0satNH8rv4hAuHEe9s6gMleWULDR7+PiRZ+/xA/4RBmoJJFHmzMSJ
         oaEos42X9x4zneikNH10lWnMVDiOhygtJCpv3ey0JialcqOxLxSNRdFf5e2ycFL8PYtR
         BmXfvwSCFQJMaEm9MpqXVlpC/c/8LxGs4XVArzE1TKKyCi8FUIuL+Ejo2ghmj2bJmSum
         p32NozAwLYo0UFS1xvirot+T+ZkwyZ9b6VV1A2eB9On6byX3Nim95OdqSxfcfkrfv9Ud
         CiuLnj5H6b9TBwIGZSgkkjbp3irr2e3sAyWwPkELtm46aATsDsetsXT2JEQl6+vN/F1d
         9lAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s6rx1dKUlrkp8lxrOtRYzLFSZ1b6ZE6siahQ5YOjH0s=;
        b=eohooJwu5djQNkebZlwlxBEDiKtTkIsAeRP03nEKGSmQfDPWPJESztRSRJFesixc0V
         Uxi7lGZ+IekeGWxtna5+LeCwFWU9Qd6/ewdBJCZhpx6o95d8P7ChOvJlPxp8ytVP2XWx
         vPbK2zNMWp+TvoUb/WPpHQlJnmzDEs79V1w3506w5tPYrGXsWRjCAbNvWJua13WedyWY
         Kkd23VjVd9VTiJumyxobmmCsylGqzmKAzZL9OasMMJL6ODz5ebS8+5/4mC29taFFcUgA
         selSlA1ymaCaGBEmxgUz5RftT66S2x88i/fzyeBltnFKjBD/WeHXeWxcF2KjLYGE89rF
         Y6qQ==
X-Gm-Message-State: APjAAAUfl5XKBhtPjFmYnHJPWlnCxddS+VJxyAZZAnbduNAMqHu+6Ykz
        z5ILDijGC+2CWZTVNVy/RQa45WIOp9wXQQ==
X-Google-Smtp-Source: APXvYqwcypxhte6LRn2hiX6Q6xCU9wrTY4rbDlru9jV6IK9HQW07ieLBEkKsRKPv2UH3pSAPKrFZzQ==
X-Received: by 2002:a05:600c:144:: with SMTP id w4mr13375394wmm.94.1565607082842;
        Mon, 12 Aug 2019 03:51:22 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id z8sm22797916wru.13.2019.08.12.03.51.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 03:51:22 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v6 2/2] arm64: dts: allwinner: h6: Enable SPDIF for Beelink GS1
Date:   Mon, 12 Aug 2019 12:51:15 +0200
Message-Id: <20190812105115.26676-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812105115.26676-1-peron.clem@gmail.com>
References: <20190812105115.26676-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beelink GS1 board has a SPDIF out connector, so enable it in
the device-tree and add a simple SPDIF soundcard.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 0dc33c90dd60..4bd14f085070 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -51,6 +51,24 @@
 		regulator-max-microvolt = <5000000>;
 		regulator-always-on;
 	};
+
+	sound-spdif {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sun50i-h6-spdif";
+
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_out>;
+		};
+	};
+
+	spdif_out: spdif-out {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+	};
 };
 
 &de {
@@ -243,6 +261,10 @@
 	vcc-pm-supply = <&reg_aldo1>;
 };
 
+&spdif {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.20.1

