Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CEDC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE7D20815
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bSGwfDwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfE0NWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:22:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44270 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfE0NWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:22:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id w13so8561070wru.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5tls13Db7MluddscEzD/cF6XBKT+xo8zEqe2ab5FrI=;
        b=bSGwfDwAQNmN5af6mPI9aaBpl7ow9qoZBVLH4+zqLWruiKxLnW5XbtURKbDdTcnRQO
         6vnjdz8rtc5Z/BRk5ivxx7l/c0jj3RbtJPJTGGmKIi5tT1npBVYDSYze3aReFnj0SWDp
         so9B0iTixNrayDnNwS2qbh1fjLesU1G7I7cH+kVWL6zAnqkp7ouE6T+9RbCCrbAooG7d
         Q5+jYo+x4dGc1HMfqMQMyxGyz0fEZ6cxyzW44yUiqd/bUjucvtApDQstXj5Hd7ScmY03
         rdg2aTMEbG3A9OCaQ2K6SA+7/fo2JNpjnysCa8otZntQIsSV0ZYM7EfdXi70+NZnbQKU
         Fyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5tls13Db7MluddscEzD/cF6XBKT+xo8zEqe2ab5FrI=;
        b=SbrkGVtnVo0hSymUxUZ2G2svdjWGuDjiFXYJNnt+lNsLhcYI9QzN8EDobyavrYsNum
         Vri9fCIGnyVLNHC1rsM3W0WGklVA1rxNLJIfqzZp0cOQ97iY4o+CqFsle54gq8kWrjmj
         hDxWyEEiHQzpiQKBAc3S4t9/XCqq/mj5h5Izs8Zsa+6q78uenjjXsejJw66LRpDwHKwD
         cz8vDHVXso9lXbhXPnKnd8mSVBYH4Q9Mwgsw9RAJSS0CTevCGepYid/6D5aTAjr3Y3il
         j3xCW8NGZBIU4ty57CPfzci5gnU5acbUbxjwkirZvqS4vRQkWKC0xr6PUWSZ/IEgoQeU
         fgxA==
X-Gm-Message-State: APjAAAWr7zX6Ew3nqgP9X8y0U39G7Wrnlgl0bXf9k64bZnJNoqo4xaib
        f48OfqGDWzlj+HROZA007YDyLQ==
X-Google-Smtp-Source: APXvYqx4ak3U23GjVQ37/QuSEhrHTCPPogN0xcqSigoV1Oz/v7kkcfkYXBee31EHzam3stgt8gbEaA==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr21802706wrp.281.1558963323951;
        Mon, 27 May 2019 06:22:03 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l12sm7019836wmj.22.2019.05.27.06.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:22:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 02/10] arm64: dts: meson-gxm-khadas-vim2: fix Bluetooth support
Date:   Mon, 27 May 2019 15:21:52 +0200
Message-Id: <20190527132200.17377-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527132200.17377-1-narmstrong@baylibre.com>
References: <20190527132200.17377-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

- Remove serial1 alias
- Add support for uart_A rts/cts
- Add bluetooth uart_A subnode qith shutdown gpio

Fixes: b8b74dda3908 ("ARM64: dts: meson-gxm: Add support for Khadas VIM2")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 25079501f2bb..ff4f0780824d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -18,7 +18,6 @@
 
 	aliases {
 		serial0 = &uart_AO;
-		serial1 = &uart_A;
 		serial2 = &uart_AO_B;
 	};
 
@@ -403,8 +402,14 @@
 /* This one is connected to the Bluetooth module */
 &uart_A {
 	status = "okay";
-	pinctrl-0 = <&uart_a_pins>;
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
 	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 /* This is brought out on the Linux_RX (18) and Linux_TX (19) pins: */
-- 
2.21.0

