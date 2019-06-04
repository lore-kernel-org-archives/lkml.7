Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57198C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3077C24A99
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iNBvPjb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfFDOr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:47:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40735 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfFDOrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:47:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so11301433wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bLDsai7BCDJ9/WAFUmOmDJ4D/4W6/bXgG+qdhNwcZhk=;
        b=iNBvPjb5Qy21/12AvtkoRo4IHAm41Wg4Vk0nBhVKAQXzW/FfWktrlAJB1cx60YTjZN
         pYT8vqd6X/6JxxL9Q2aDSrZhJTO8FGCMZjYSJ5YlrT0gcbOLrUoxbTCpOJhoo0WVj4uS
         qaihsQHl5/DKak5ZC4VFsTKtIgy1bcly73SbJxXYkhpOuPjvu72uV4TFbFhLE4u3db1x
         XBPLS2/aV/kZr/v/fqELn48ZEdCAlNPLQJ879P7p7ggyomOArRwgIWvmJZa1MtjT8tc2
         kZ2WrTjGxBjbXU7Ioqw6JIRq/dfUL+mD1M9xuYkST96HZDAcr4mgLkbPuWKE5Xr5iIM5
         KumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bLDsai7BCDJ9/WAFUmOmDJ4D/4W6/bXgG+qdhNwcZhk=;
        b=rDBPqtfYfaqM0siVnKXf9Bg30vxbPRMqq2TBwLNRRGeQlfmE2YnF2bkBUKj4tRNDmj
         yLyaxnDCqvm5Qj8Xb51j4Wzwfv1ENb5559UI1iXnyrfym5E5TihiLK91905pX9k23DcY
         CsmWkb/9bGQHWVZKyFrxeMwlC8lfYQBEQcpAw9G7fIA2KAzCcmUD/WkFRl+wnmzdrJOx
         V/LdVbIHDBh6IJTzz6m9xzabnKlPs2rnrZLor8ptt8d7JJuo9WIMZHdLN07mQ7gqcTWw
         MbXnZJgDlmbH/m2igv0Ft+J9EgqpwBeWVEBU+IMIWzCHD7CbFKpsxxJNi/ZPtXfBmoMI
         3ZgA==
X-Gm-Message-State: APjAAAWPyNJ1KYjNu1fEoKM7fKrRZrcDN0bvIakGQkc7rScOVytkT/RQ
        4m9kOoGRqhGz6GMO7/HBbQN5wFtSY6kPnA==
X-Google-Smtp-Source: APXvYqw4x2gWBkZ94JwAp/u/xenQcH6trywYc6ypCThQKgduCn+6apBhkSU1BFXr5dezDKoFoQcCDw==
X-Received: by 2002:a5d:62c9:: with SMTP id o9mr19704199wrv.186.1559659638823;
        Tue, 04 Jun 2019 07:47:18 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v184sm3649639wme.10.2019.06.04.07.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:47:18 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     jic23@kernel.org, khilman@baylibre.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: meson: g12a: add temperature sensor node
Date:   Tue,  4 Jun 2019 16:47:13 +0200
Message-Id: <20190604144714.2009-3-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604144714.2009-1-glaroque@baylibre.com>
References: <20190604144714.2009-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two temperature sensor
the first near CPU and GPU, second near DDR

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 22 +++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 840dab606110..37f17087bdb1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -1360,6 +1360,28 @@
 				};
 			};
 
+			cpu_temp: temperature-sensor@34800 {
+				compatible = "amlogic,meson-g12a-cpu-tsensor",
+					     "amlogic,meson-g12a-tsensor";
+				reg = <0x0 0x34800 0x0 0x50>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				status = "okay";
+				#io-channel-cells = <1>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
+			ddr_temp: temperature-sensor@34c00 {
+				compatible = "amlogic,meson-g12a-ddr-tsensor",
+					     "amlogic,meson-g12a-tsensor";
+				reg = <0x0 0x34c00 0x0 0x50>;
+				interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				status = "okay";
+				#io-channel-cells = <1>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
 			usb2_phy0: phy@36000 {
 				compatible = "amlogic,g12a-usb2-phy";
 				reg = <0x0 0x36000 0x0 0x2000>;
-- 
2.17.1

