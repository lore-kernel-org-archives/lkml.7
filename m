Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D87CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A4620882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EgzjKJzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfJUO3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:29:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51383 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbfJUO3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:29:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id q70so6406102wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CWYTqEyFtCOGakjlsNfRufixkNsbXr5lNP4UMlm1PG8=;
        b=EgzjKJzHoYUGkXcnmYBxTE0wwlWMADawhLiOwzthjwpM1Ze4VnIiYHorWAQ6NbSDEM
         YW5c06uFVcHIChoHfLaQ0SvlFkLJNSFsKf5ebIIMyU9OLXdxHxZOI6dkPVRPeLGwVupX
         xMTyteIssTql0hNdb1y+de+JQmn1KIYoYLGGMsLRK5v7HRAU74z8sEAwbxxfmCDNYw8S
         m3qy0Sru9ygMm26ot8A1Rg5rpJ5hxzPN1/6P7hhc3jThrHYdrBEObRxtUoQXz/vR4toB
         IVPI+OmAxFpbKzHQBN0xMmrXQWDzYT9FA3MEafy8kENyEIGnvFVr7i2TuGi1tsbmbguR
         Zeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CWYTqEyFtCOGakjlsNfRufixkNsbXr5lNP4UMlm1PG8=;
        b=MhRa89M6y24a/1RbIBrsjldDHdl9IiX3fwJ5yOLhN3OsC4aJg1xPCKX+lir2IHkpt4
         lKlY6LiKaYT0ltckx2QEunYMg44YzbfP9Uk5GhjI7yqtSWfzyWsVKwx0XkpDnfPLAvUg
         LDVXy62JjzSTGvqruOPUgQ0Sd7LNyti9qSz+86Vg4+Ng1HhnTRhsXZtlkco77ot8IHim
         7RJHZ7eWvux4bo9VpyouTwmAPzfu2Ckwu/FKJ0qadFmwtHulMzX2d9XD/fW4xq/qDo+E
         JBBwif4dYGN99+0dQwb0CEme2yuPvqtXqTczO0q+5d24qKtWKbSsbyXpKg/PSRnfH34E
         tw7g==
X-Gm-Message-State: APjAAAVl4f0TLtS+CDkyp5UEQE/EyXrec6etttojlSwwtoQpdy1WjtX2
        KjhW3FKfRNI6GXbDTIobjs8svw==
X-Google-Smtp-Source: APXvYqx1AEQ9qTWronewXaRO1McG5B1AqN27qxt7hs3CmBfk/ag/v361jhGFZEtnnnnr2xXiMMDQkA==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr19213259wmh.40.1571668151654;
        Mon, 21 Oct 2019 07:29:11 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d11sm17304463wrf.80.2019.10.21.07.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 07:29:11 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 5/5] arm64: dts: meson-gx: fix i2c compatible
Date:   Mon, 21 Oct 2019 16:29:04 +0200
Message-Id: <20191021142904.12401-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191021142904.12401-1-narmstrong@baylibre.com>
References: <20191021142904.12401-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-gxbb-nanopi-k2.dt.yaml: i2c@8500: compatible: Additional items are not allowed ('amlogic,meson-gxbb-i2c' was unexpected)
meson-gxbb-nanopi-k2.dt.yaml: i2c@8500: compatible:0: 'amlogic,meson-gx-i2c' is not one of ['amlogic,meson6-i2c', 'amlogic,meson-gxbb-i2c', 'amlogic,meson-axg-i2c']
meson-gxbb-nanopi-k2.dt.yaml: i2c@8500: compatible: ['amlogic,meson-gx-i2c', 'amlogic,meson-gxbb-i2c'] is too long

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 042132bf5b76..10d5c97cba4f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -240,7 +240,7 @@
 			};
 
 			i2c_A: i2c@8500 {
-				compatible = "amlogic,meson-gx-i2c", "amlogic,meson-gxbb-i2c";
+				compatible = "amlogic,meson-gxbb-i2c";
 				reg = <0x0 0x08500 0x0 0x20>;
 				interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>;
 				#address-cells = <1>;
@@ -290,7 +290,7 @@
 			};
 
 			i2c_B: i2c@87c0 {
-				compatible = "amlogic,meson-gx-i2c", "amlogic,meson-gxbb-i2c";
+				compatible = "amlogic,meson-gxbb-i2c";
 				reg = <0x0 0x087c0 0x0 0x20>;
 				interrupts = <GIC_SPI 214 IRQ_TYPE_EDGE_RISING>;
 				#address-cells = <1>;
@@ -299,7 +299,7 @@
 			};
 
 			i2c_C: i2c@87e0 {
-				compatible = "amlogic,meson-gx-i2c", "amlogic,meson-gxbb-i2c";
+				compatible = "amlogic,meson-gxbb-i2c";
 				reg = <0x0 0x087e0 0x0 0x20>;
 				interrupts = <GIC_SPI 215 IRQ_TYPE_EDGE_RISING>;
 				#address-cells = <1>;
@@ -415,7 +415,7 @@
 			};
 
 			i2c_AO: i2c@500 {
-				compatible = "amlogic,meson-gx-i2c", "amlogic,meson-gxbb-i2c";
+				compatible = "amlogic,meson-gxbb-i2c";
 				reg = <0x0 0x500 0x0 0x20>;
 				interrupts = <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>;
 				#address-cells = <1>;
-- 
2.22.0

