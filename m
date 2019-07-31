Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C23C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD73208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="konqN/tS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfGaMOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:14:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34873 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfGaMOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:14:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so69435847wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3CCOCjh2x1iQPGlZN3jIo89XnZKXDURAKwx788VT6WA=;
        b=konqN/tSWn5MnRNaHXWCAuACoPQk79+SeUDGVfuNUSYGAy6R13WPzZcwC/9viSy9ZC
         uiBR0TN5rc3akffhBkgRd7o78J2XiETILJxUH1Ctr4biflUhUKSphigwbyX08uSaQAKN
         SpV+/OeKHwEm119YhMP4Wrlmn6ueB2rRj0/JZ04ZBuuu7X92DNKTlFqO/o4/Y2F8MKJ/
         u5u1P/QG/2a8RNDnEBPFP9wLkR+hhRpLdM2IRvrQ1JhifwRh7xz4wt+ByVgkKH+VwDFL
         O6SdN9yX46kRY0aZ3UCVxKwh1pe+TDeIVmJ2/qQfDPfT35db9g4qTrHr4OKmx+4Owqn7
         wi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3CCOCjh2x1iQPGlZN3jIo89XnZKXDURAKwx788VT6WA=;
        b=oRiD8s+nuYUM9wtCtonIq1OI1BZlic5J9m500e4AwCKte0L2QALodWzTt79P0BVb7U
         4tdpmoNtCTI5w2FoNvAqlvtiY2bzj0XHIX/72Rxe5SqB35v+EDTdDm5KtAuYAFl9RwZE
         tS82rL1bfrxlv3lehSVfLvt0iLeyfWcVBpBTKmvaUPmL2pSad12OoEgSubk5lNax50Lw
         XiAp5rxNa0xLxsLI0XhuWtpWZ6LpcXAcETxqCdZhCnuKxyu8Gu4z10QlbL5OaXg5liJ3
         KTlRWtT4XWTtiDniA+6VhDSJpCvvC71Pr8KLA7Lt7LWxumK2Gi4ZXgEeRYtPsgQPVmjU
         1jcQ==
X-Gm-Message-State: APjAAAWYrOdfj0tJ1JsqDzBaXflrzyPOsuFhN3WhZzZLyT620ZSCQHBf
        sIqhtQUscuuGCbiuO7CY7T2+PQ==
X-Google-Smtp-Source: APXvYqwrOzBQ/vplwh9sXRThCJ+igArUJU9XiT1VUFIdwNGAU5J1RHqwjHxq4gdna2QH4jynKhdhPw==
X-Received: by 2002:adf:f812:: with SMTP id s18mr5128298wrp.32.1564575256188;
        Wed, 31 Jul 2019 05:14:16 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a64sm3613713wmf.1.2019.07.31.05.14.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:14:15 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/6] arm64: dts: amlogic: g12: add temperature sensor
Date:   Wed, 31 Jul 2019 14:14:06 +0200
Message-Id: <20190731121409.17285-4-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731121409.17285-1-glaroque@baylibre.com>
References: <20190731121409.17285-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpu and ddr temperature sensors for G12 Socs

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 06e186ca41e3..e10aba5c9270 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1353,6 +1353,28 @@
 				};
 			};
 
+			cpu_temp: temperature-sensor@34800 {
+				compatible = "amlogic,g12-cpu-thermal",
+					     "amlogic,g12-thermal";
+				reg = <0x0 0x34800 0x0 0x50>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				status = "okay";
+				#thermal-sensor-cells = <1>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
+			ddr_temp: temperature-sensor@34c00 {
+				compatible = "amlogic,g12-ddr-thermal",
+					     "amlogic,g12-thermal";
+				reg = <0x0 0x34c00 0x0 0x50>;
+				interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				status = "okay";
+				#thermal-sensor-cells = <1>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
 			usb2_phy0: phy@36000 {
 				compatible = "amlogic,g12a-usb2-phy";
 				reg = <0x0 0x36000 0x0 0x2000>;
-- 
2.17.1

