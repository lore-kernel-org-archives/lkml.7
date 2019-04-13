Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BF8C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78072214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dnjEcHLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfDMQgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 12:36:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39680 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfDMQgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 12:36:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so15923763wrn.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 09:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8LOVyhXJLZoTsXDBrD5GMoCBgvmfqnSxKbuKGLv7HJk=;
        b=dnjEcHLAoRyk+cvtQyouH/4TVcKGJ8E71XHOjrXLYiHWei1GzaUXi+eo1Hy/TNux+x
         szPCYHD5Da5Apk+LHOq+P1t1b2P7eS/7wqrjZwXPya3/CwZCBO9rs4JniuVfuWdYzhPn
         tzgh79b1WZ5Hw7vyWJg3clwnIPvHbo8noekifIwRmP78sRiF9Qo06rUgjhmjGVGby9Me
         I7CgyPoFseQPI3+6hhnYzVV71rOUp1xzv2amJrp7N8HygNaxj1Xk3XmE+YzTmJ8cMw6N
         vPYgNo+EuIBNMA922ybWE4aFEZIwu9tvv3/BhAyAlqBDoNf92n5naH2jLfvhgSDKIlSG
         vLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8LOVyhXJLZoTsXDBrD5GMoCBgvmfqnSxKbuKGLv7HJk=;
        b=PHT8+0YZKPccXTasYfg2v5F11janlc6pPeERAyC+pmtCB8PopDIatilQsTe3or75Ms
         gzYPTZdlve8U9T7KEJIIUocKHboTSMqeSaPirWTs9GpMjodGIs702rLjxBmL3A6UmSUh
         7xM03BX6E7snwBjq9NnLWplC/7ZkHL3dl/bK/1gvMEW4TyLnk1OsVnv8hx10XDustMno
         QmJPYTATK0HU3zTBhK+WoaegyLTn2Q7z/xLmSnTpmaXIajrSnp13XkFt53bRNZXws9L8
         MluothNuAIGLUC/9x8f8TyI5YlgF+Svpq+U5rE5GBNn2pqTcY0g0sJ2bPESsoXzijB/0
         vMWw==
X-Gm-Message-State: APjAAAWdA/DMKl55Aa7474Npqjv5WeHEFyuqrPxmoV4H0JqEt0gFkS+S
        BNophlRiT84wvRoVRB+xSgo=
X-Google-Smtp-Source: APXvYqxVB9hGCkjzanqpxnDdsmMzAp/LEGX/vRQZqbEOxT2DQoMCx84xCb0MHfJBPu09b5PULten3g==
X-Received: by 2002:a5d:4a43:: with SMTP id v3mr19357168wrs.126.1555173397082;
        Sat, 13 Apr 2019 09:36:37 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD00714E418F6C82D049.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:714e:418f:6c82:d049])
        by smtp.googlemail.com with ESMTPSA id j3sm106200069wre.51.2019.04.13.09.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 09:36:36 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jianxin.pan@amlogic.com, ccaione@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] ARM: dts: meson: add support for the RTC
Date:   Sat, 13 Apr 2019 18:34:21 +0200
Message-Id: <20190413163423.15149-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413163423.15149-1-martin.blumenstingl@googlemail.com>
References: <20190413163423.15149-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 32-bit Meson SoCs have an RTC block in the AO (always on) area. The
RTC requires an external 32.768 kHz oscillator to work properly. Whether
or not this crystal exists depends on the board, so it has to be added
for each board.dts (instead of adding it somewhere in a generic .dtsi).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi   | 9 +++++++++
 arch/arm/boot/dts/meson8.dtsi  | 5 +++++
 arch/arm/boot/dts/meson8b.dtsi | 5 +++++
 3 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 6f54a8897574..8841783aceec 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -252,6 +252,15 @@
 				#size-cells = <0>;
 				status = "disabled";
 			};
+
+			rtc: rtc@740 {
+				compatible = "amlogic,meson6-rtc";
+				reg = <0x740 0x14>;
+				interrupts = <GIC_SPI 72 IRQ_TYPE_EDGE_RISING>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				status = "disabled";
+			};
 		};
 
 		usb0: usb@c9040000 {
diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index d2ec4af82cc5..7ef442462ea4 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -541,6 +541,11 @@
 	compatible = "amlogic,meson8-pwm", "amlogic,meson8b-pwm";
 };
 
+&rtc {
+	compatible = "amlogic,meson8-rtc";
+	resets = <&reset RESET_RTC>;
+};
+
 &saradc {
 	compatible = "amlogic,meson8-saradc", "amlogic,meson-saradc";
 	clocks = <&clkc CLKID_XTAL>,
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index df42e48f1cc1..800cd65fc50a 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -510,6 +510,11 @@
 	compatible = "amlogic,meson8b-pwm";
 };
 
+&rtc {
+	compatible = "amlogic,meson8b-rtc";
+	resets = <&reset RESET_RTC>;
+};
+
 &saradc {
 	compatible = "amlogic,meson8b-saradc", "amlogic,meson-saradc";
 	clocks = <&clkc CLKID_XTAL>,
-- 
2.21.0

