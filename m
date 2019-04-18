Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EAFC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1B52183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="h0cyWpdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388988AbfDRM1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:27:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39466 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388375AbfDRM12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:27:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so2679403wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yaNaoCP8pznZw7TWRPuJzQR6dBbJDMZ7bf+8pYaycCk=;
        b=h0cyWpdfjXxV8o+0QGI1FlzKHsaxQknwUXk/WWbneAyFQps4Pba5SIW3NSGPWWsnFL
         43t62Hrj7vX2kkjEvMPdQzQzVuK8vaXFquY10j9xlxnSvwUFe5GcjSIgNQIaN8V2H3Or
         PBUBDrFB4LhLjJFzpimxMICN05ySGkVd8on/MU9DF2dgvCmGaRS+gBn/iU2E1li/g9pU
         q517mhg0TJ4KNmzZBiOtK7hnomX4EqtkPN14ddYyShTOdtzpocBQkcZDfRoavw3WaSQk
         AQJ8rdHfZAV9GXpqkdxvceT1obOmnnSJujhYpPDYKb/3QxY8SF6Vb+PhYu86FrCTqnrO
         asCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yaNaoCP8pznZw7TWRPuJzQR6dBbJDMZ7bf+8pYaycCk=;
        b=AEmFT8MTnGBbYwcHk57yesEhIFlb7SnwII0TAx2RAswtUSWcpvtwqP9cs2nVEW1Hx0
         mrC2Q+3O5t35uhwD8YJb06s8WGx1/U2WSmEKos4p2IQ2LR5EXSQkkGNI3rPSFqgbvIBP
         ppf2I0G57WiGAxw88zt7HhoJzqQrGzLuFaAm72yvA1k/hOWVXCE8fdycPhTlrYbudAGX
         Kdc9nlE7rPFx1Kv5JInP/CtiI4hR0lW215AM8ddVCWMBdYiMSYuNrFdzGkk4F21TQrWM
         ySdnYFcfzJVZZCAU1J4rCJ0rsRPhMDldHDT2Ve1OYeZyQwKA0VG6DyMNsruNF3iAyaLQ
         qUDw==
X-Gm-Message-State: APjAAAUkVinqx1HTn65DJap9tAW1BVRYnyciPipF6PMbGw6bJ0nMcRmc
        EPqM2SSmyMJXLXZ8w/Ge7LaYEg==
X-Google-Smtp-Source: APXvYqzXo52LNbrT7WhG1D3rHAqhwljMhATMhsgkdlDTHXLjnfTqq8nO4kPHYeDdHP5ItwfliWQUvQ==
X-Received: by 2002:a1c:7e0e:: with SMTP id z14mr2817731wmc.95.1555590446600;
        Thu, 18 Apr 2019 05:27:26 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z14sm1510110wro.81.2019.04.18.05.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 05:27:25 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patchwork-bot+notify@kernel.org
Subject: [PATCH 2/6] arm64: dts: meson: libretech-cc: switch eMMC to 1.8v
Date:   Thu, 18 Apr 2019 14:27:10 +0200
Message-Id: <20190418122714.30805-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418122714.30805-1-jbrunet@baylibre.com>
References: <20190418122714.30805-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While some 3.3v eMMC 4.0 are available from libretech, Only the 1.8v 5.0
modules are recommended and supported for the aml-s905x-cc.

the 1.8v is provided by LDOs on the eMMC card, from vcc 3.3v

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index d4d5e3e5439d..b0f22cdb586c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -115,11 +115,13 @@
 		regulator-max-microvolt = <1800000>;
 	};
 
+	/* This is provided by LDOs on the eMMC daugther card */
 	vddio_boot: regulator-vddio_boot {
 		compatible = "regulator-fixed";
 		regulator-name = "VDDIO_BOOT";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
 	};
 };
 
@@ -253,8 +255,9 @@
 
 	bus-width = <8>;
 	cap-mmc-highspeed;
-	mmc-ddr-3_3v;
-	max-frequency = <50000000>;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	max-frequency = <200000000>;
 	disable-wp;
 
 	mmc-pwrseq = <&emmc_pwrseq>;
-- 
2.20.1

