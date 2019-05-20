Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C667C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E6721707
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Dimz5KWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389736AbfETNnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:43:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53638 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389581AbfETNnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:43:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id 198so13368259wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LAW0NHRYcYNyBkm24e03bjOrNz4ZAqZ8Xq4Q0IzbpVY=;
        b=Dimz5KWshfT69RCp2fuwxLNaVZXc2u41WD6Q5lY9y05Bgc54W+AqzaA7ODdKk0l4dz
         typeW6SRq/is0uH3q00ctV7CeWBNkd1prpRwgkrciXTPqslNPoYc0JU/+L0skeoBt+05
         hC4ltD3lfhM9mqT72B7jeOL4/Qr13jjmAgxMBCZwrzlpDMT2yjiIzRzzJU3s2qbtBKF0
         rOJjLWqmMmTzSBgz2fUfnhzqMHqN12+Z20YmnSJDFVX6taETDRnevZYfRCIHvUxlsqtV
         U9PF6gmK6r3U1DcPI1ai1iOz0fN6g1DbpWD5RrEFcusFowi6wZ0HtAIWsO3tzFjFdpOQ
         D8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LAW0NHRYcYNyBkm24e03bjOrNz4ZAqZ8Xq4Q0IzbpVY=;
        b=CbCXe9Z3FQG9Cfp1BV69shEOR6CxTvVdACAOcZeH3xlNx0qHOMXp+rn+E2pPPWjt38
         jH0eBnBmcjKVvnWaXxTomKPbRIe6ZzA6AoZR5W/M++33RqErE3w8TqPrZEptqSfej7zh
         NHD1IqVkBAdDwYTspXlwlARV6ntflDrfgh7lOe84pEBdtiuHAv1gb6pXg730JnNUNCVI
         kNAmIePR7/fclVB4L+8cRpV3tyyyK/eaxWutclPjG1Qu/nxkJlVzS8HJV/lbwS1W7t6G
         Mv1bk8/T6DUjMWYjyzXvQMy9uZJhvUa9wVXDxmsjs3tRTmmAKYUF41tWyjvm/GNIx94n
         q8sA==
X-Gm-Message-State: APjAAAWPXFze2HEW+k17k4rEywyBPPlXdryLySegG0kV7GjvDsmmjVTE
        pBv8u0aLt0SD7BBXw6KQWbdTLhtHsnojwA==
X-Google-Smtp-Source: APXvYqzS3opLw29csk5N34wBxalNj+6DyubSRQpudJlizqmfm3+OfR94bvvBmUKOjbos5rzB9etkwg==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr22595141wmg.64.1558359820032;
        Mon, 20 May 2019 06:43:40 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o8sm15309598wrx.50.2019.05.20.06.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 06:43:39 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: meson-g12a-x96-max: Add Gigabit Ethernet Support
Date:   Mon, 20 May 2019 15:43:36 +0200
Message-Id: <20190520134336.24737-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the network interface of the X96 Mac using an external
Realtek RTL8211F gigabit PHY, needing the same broken-eee properties
as the previous Amlogic SoC generations.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 5cdc263b03e6..5ca79109c250 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -15,6 +15,7 @@
 
 	aliases {
 		serial0 = &uart_AO;
+		ethernet0 = &ethmac;
 	};
 	chosen {
 		stdout-path = "serial0:115200n8";
@@ -150,6 +151,27 @@
 	pinctrl-names = "default";
 };
 
+&ext_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211F (0x001cc916) */
+		reg = <0>;
+		max-speed = <1000>;
+		eee-broken-1000t;
+	};
+};
+
+&ethmac {
+	pinctrl-0 = <&eth_rmii_pins>, <&eth_rgmii_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&external_phy>;
+	amlogic,tx-delay-ns = <2>;
+	snps,reset-gpio = <&gpio GPIOZ_14 0>;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-active-low;
+};
+
 &uart_A {
 	status = "okay";
 	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
-- 
2.21.0

