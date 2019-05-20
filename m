Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266C0C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EEB206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MQp1WuNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfETToM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:44:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55842 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfETToK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:44:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id x64so533568wmb.5;
        Mon, 20 May 2019 12:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IYg36bJkUAGqrs6RcoppkW6uHqR+c6iAwwtmm+SF24A=;
        b=MQp1WuNCFJvfPVgPWAa/hBKKkjPR1lPrea/FUxe7vACI/kWv437nXBEHZv/6UJellY
         1Eq6OKYDbWKX/7jp048kyCjTrQrLssBZg/BTe1w5ggjePsCh/9ytffWIwyOlhmG/dnMZ
         fY1i41SLm3XVeJlCsN6TsWS0jbepJ7biSuwXvuBSOF/3BymHyafaXopDkQZ8cUd8TapM
         3Nb7RUS1hV/ArkTGVQ6MXocKAGALtMqWT+XJnyAIHoWoaM/B2i2NKU/A0h4kod5WHA5/
         1Z9RzW6jqYXUZJXG0s/s0Ah61TFsHeKjEEDsDxidKGeaFy2OighIX13Eufp+mAGOPa+G
         7xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IYg36bJkUAGqrs6RcoppkW6uHqR+c6iAwwtmm+SF24A=;
        b=WY3xcQtMsojiyngjwxRJHJJwyvL357OLo5iOTsCHbPxtCRruIpD8hSvso1IQfA7FiS
         rPrsFAWYwmpSiPTju0GaCAjcwPzTz/05SwX2RpFfcKc/2D72M4e4R1eREOJTRbJYDLzL
         PgRpjmzcg2K1zVjZ/ix3i1zymGM9hge/DZAf8OW4ukWHfQ0MX/wlxE6dCq8F9nDNh5Z/
         K1AtySEmSJdgfP0wu0X/g6/cDrdCF2kanV7pLwx8blvBsEGVIbZLSrYIXMxu08lwg70/
         cAEWTaZRcZTfAHjCFdDDlH7Uy2TCfIbLAkIGsN9JW5+BM0bmUtMkahMQFsHbItcQ8vpd
         u2fQ==
X-Gm-Message-State: APjAAAW6MWKO1Oxazh+k99Cw7OaJzvhI68SYnoLPZFvCJUJW8ThDZLg8
        weNycC8q2GiG/7o8EGR6R5M=
X-Google-Smtp-Source: APXvYqyFdBCG8cWHpaN2+KrG1gXeCei6iHoeMF6BgUJTXx01bW/MIbZDAKOJ2UzJT6V/bPMgmzethQ==
X-Received: by 2002:a1c:1f95:: with SMTP id f143mr627183wmf.16.1558381448175;
        Mon, 20 May 2019 12:44:08 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133EE71009C356FA1F0E19AF9.dip0.t-ipconnect.de. [2003:f1:33ee:7100:9c35:6fa1:f0e1:9af9])
        by smtp.googlemail.com with ESMTPSA id p8sm9135352wro.0.2019.05.20.12.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 12:44:07 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        mjourdan@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 4/5] ARM: dts: meson8m2: update the offset of the canvas module
Date:   Mon, 20 May 2019 21:43:52 +0200
Message-Id: <20190520194353.24445-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520194353.24445-1-martin.blumenstingl@googlemail.com>
References: <20190520194353.24445-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the Meson8m2 SoC the canvas module was moved from offset 0x20
(Meson8) to offset 0x48 (same as on Meson8b). The offsets inside the
canvas module are identical.

Correct the offset so the driver uses the correct registers.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8m2.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/meson8m2.dtsi b/arch/arm/boot/dts/meson8m2.dtsi
index bb87b251e16d..5bde7f502007 100644
--- a/arch/arm/boot/dts/meson8m2.dtsi
+++ b/arch/arm/boot/dts/meson8m2.dtsi
@@ -14,6 +14,16 @@
 	compatible = "amlogic,meson8m2-clkc", "amlogic,meson8-clkc";
 };
 
+&dmcbus {
+	/* the offset of the canvas registers has changed compared to Meson8 */
+	/delete-node/ video-lut@20;
+
+	canvas: video-lut@48 {
+		compatible = "amlogic,meson8m2-canvas", "amlogic,canvas";
+		reg = <0x48 0x14>;
+	};
+};
+
 &ethmac {
 	compatible = "amlogic,meson8m2-dwmac", "snps,dwmac";
 	reg = <0xc9410000 0x10000
-- 
2.21.0

