Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87959C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1E524249
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Vtzf6YNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfLEPeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:34:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43865 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbfLEPeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:34:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so4103103wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 07:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cvIKYbv02jfkUFc5yq+y3wt+kyYSZpa4lPRFM3efvsQ=;
        b=Vtzf6YNqgoAaCepibQJqB+oRUraYuYM4z8tSKK59qmq5stMUvAdB+5q+XIdsKOABIl
         VpP08vBGgGPR8Y5f3xG1AMOHGvmMkWvU/Oca1xY6ANqlBPb8nVAqzxNEmOAcv+3QICm5
         T0VME75HypIlfAukkXmcATSTMQkKMZlFi4y652RFyDNg8fbpq6ZzJWp/9mQ1Epdo0iS3
         RPsYVfmjJiH+w4INMrHQRt1bgSz6bJlx4OQRxRdyhIPmSeH0g2k3bnxVlyeYoZC7KwdE
         ZVyzhB5UG+UTEHwz1loKwzmn0BA6e6oPkpKaEcfbyaeo2O9txuwXlZAvzkF/hqw13RVR
         6lYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cvIKYbv02jfkUFc5yq+y3wt+kyYSZpa4lPRFM3efvsQ=;
        b=JTraB2G7ekGJtRtpGnBPaGm9sDWx7QqJ3ws67t40xNRqa6je/cEQwik0l7Olu9t9kE
         wKoyzUW6O8ifuVZu5GloE3pqhBpVoGvCR9uYONx+FG1tTEGLltEU6sdwmrRHUCODNrr4
         Qrf/V55OgLhP0aeSrJLuZgoQAQvZWVprlvnikYPJ4fpt1ohMpnU4w7sRH8sfdvdCkIDF
         0eNuZWz5cYfPjRSrDzub7j2bdmbDrO0pakXPQAt/nkzpLqdXTOI4xRkstZfTYeDUkWWI
         Ssh+8P2P7DM2joE/vYpXHr2jLKad0pUlS/AiK7x6/o2HmrrY9Hkd8OvbI1TeKaOPMXCw
         KdgQ==
X-Gm-Message-State: APjAAAXjO5byrBK0W794TFXoq4Ui7gDjAJBDRkJ6zA9E1rMnegWU2VR+
        H7WSL1Oh3CI8U6NSsM28vjD0rw==
X-Google-Smtp-Source: APXvYqyHR+QR60eFIPYWpUC+I+EzJhKER/8/scWXEk6o2dHPHZQW02oXEkm5YTJXCK4A04iQ0bW1wA==
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr10388098wrw.391.1575560057417;
        Thu, 05 Dec 2019 07:34:17 -0800 (PST)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id u26sm191894wmj.9.2019.12.05.07.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 07:34:16 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     mjourdan@baylibre.com
Cc:     linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 4/4] arm64: dts: meson-g12-common: add video decoder node
Date:   Thu,  5 Dec 2019 16:34:08 +0100
Message-Id: <20191205153408.26500-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191205153408.26500-1-narmstrong@baylibre.com>
References: <20191205153408.26500-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Jourdan <mjourdan@baylibre.com>

Add the video decoder node for the Amlogic G12A and compatible SoC.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 3f39e020f74e..6fe7dead5a92 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2152,6 +2152,29 @@
 			};
 		};
 
+		vdec: video-decoder@ff620000 {
+			compatible = "amlogic,g12a-vdec";
+			reg = <0x0 0xff620000 0x0 0x10000>,
+			      <0x0 0xffd0e180 0x0 0xe4>;
+			reg-names = "dos", "esparser";
+			interrupts = <GIC_SPI 44 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "vdec", "esparser";
+
+			amlogic,ao-sysctrl = <&rti>;
+			amlogic,canvas = <&canvas>;
+
+			clocks = <&clkc CLKID_PARSER>,
+				 <&clkc CLKID_DOS>,
+				 <&clkc CLKID_VDEC_1>,
+				 <&clkc CLKID_VDEC_HEVC>,
+				 <&clkc CLKID_VDEC_HEVCF>;
+			clock-names = "dos_parser", "dos", "vdec_1",
+				      "vdec_hevc", "vdec_hevcf";
+			resets = <&reset RESET_PARSER>;
+			reset-names = "esparser";
+		};
+
 		vpu: vpu@ff900000 {
 			compatible = "amlogic,meson-g12a-vpu";
 			reg = <0x0 0xff900000 0x0 0x100000>,
-- 
2.22.0

