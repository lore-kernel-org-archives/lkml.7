Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C5CC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7362220859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Up8nzLbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfE0NAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:00:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54691 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0NAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:00:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id i3so16070209wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umSEve02562WR4TA1J+Sf1DhtYFqJtcfnl3qYv1eGOI=;
        b=Up8nzLbUmXELSCH+VzXuSkFa+DzjgiGlsLg16q0M42ls5tjlEogTcpQJ0KU6O2IPO0
         fgRJNaYNs4uuluTd6TgYds56i/4Y7XTrId1pjpUYFQgi2NzGOb4jSTU7cE3KTiDEqPVr
         qvNAJs/0XeRhdpcOZ5ugCeOPcpyKBHAWzo7Bh5G2wM5zlDScwsoYaAjGngnTzFz1C/5U
         X8n3ZX6oWzoKaR7B9RxCDbvlA2ezT4iYVeixebZ0zzIk1u0Roxzn4Ln0db23GI/ow5Hs
         Mh8Z9CMnUjK8p6TeawS3Oj5tMMBfavAtZTLZgI1OL/WnnILZquKrcA9tJA/bFz7/cbOR
         RMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umSEve02562WR4TA1J+Sf1DhtYFqJtcfnl3qYv1eGOI=;
        b=fbW7mG4kHyWOqmK6CB+ypymLjUIKDfif0HwZpkeANt+r7/TQW6y3+L1zyixMUV32sX
         Imv72v4fE7vY1/AwS/+WXT4WED52CaXVZ7DJ9hgKaKR7t81wIDJ1Vem45KsSuSRP/Bnj
         bYyyKmv6x0IXCgpLDVrgRfBcMWiR9VrQxf9MaeintJ+ZfIVV4KAQUvbiPLBBg4UAUIm3
         CAa1ofktQ4wC0XGVdeI3a1EGM81TlWC0gBZAVk+LkvhOwZNc+3WHtfJMAS6N4KeUgOSq
         8GD/rcD1LU0T0dlWAdBGUgS7iWbDZDkXaoPtk1cNwy6n8xK1mnIXB85NGx8vzG9u7iZ6
         EAWg==
X-Gm-Message-State: APjAAAV6dFd8/iTIsDhZ60SEAqaKbW23r17qaTnFDCDiMpym0DrmPTb3
        dztZOT5WGa+agvTrlGOSCMrhRJkcOoOTPA==
X-Google-Smtp-Source: APXvYqzpB4SvzQ6WmxC6WmcUac7SWjVTlYu5Vu5qEcUudrnHnifoGhX1hZdTQT0DJ8CDNxdatjD2RA==
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr5987241wma.93.1558962046462;
        Mon, 27 May 2019 06:00:46 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x187sm10864335wmb.33.2019.05.27.06.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:00:45 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] arm64: dts: meson-g12a-x96-max: Add Gigabit Ethernet Support
Date:   Mon, 27 May 2019 15:00:43 +0200
Message-Id: <20190527130043.3384-1-narmstrong@baylibre.com>
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
Changes since v1:
- Fixed eth_rmii_pins into eth_pins


 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 5cdc263b03e6..706753ddfa7d 100644
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
+	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
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

