Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2615ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95D021721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/sXWPA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfJGNR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:17:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39698 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfJGNRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:17:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so8652316pff.6;
        Mon, 07 Oct 2019 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6es+bj4m6D0NRp6eJ86Bzn7NLYhzt0+WYGFkXdeisCE=;
        b=M/sXWPA02M0QcDjEUHDoxDu/iJZ10d3QoTkc7NCVa8WvgNxbztWLtxFmCgQTtuInB3
         7yBbsaq9qcQp5mHn0qtxLuIV0PZe9APox09UgEmLMvvr5MjsqI3BTrU89KLdHFizbG/m
         Hv3ZqhAsy2rNL6lFYqlxg7aSi1/1WrJwHD86+yakYzvRXlaeHnlifdP8QAATZTaRiUxb
         H3VavPsftKhLu0yTh0HfAcbaqrT4wsI8R+Jh/YPIqsEcHRkuEsXfsuxI7OkQo4nEcWbC
         K5+H9RMIoYgRpVOiuzTGPXzY06kDmXZPBrGbnXdDto9IKXd/zcZf1d1B/y1xLy+LGfaa
         BbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6es+bj4m6D0NRp6eJ86Bzn7NLYhzt0+WYGFkXdeisCE=;
        b=IiTVJYxTgyNqnai+Pf23m/x22T53scLDMtDPVAUn+48RNo8jt1Xa+rastoYhE4Tnmt
         zSJeg9kR1Ns3DCqwHZU4oxIzvlJlpGsDgif7M4TjBggR3ghELQvIk5PVJ1Bon+ck9vCF
         NPw4qDxWykNcfWB6+twvQGO4CwvH8c9EoeDC4Y5dsTjm+0P49zjUT8RDBXvuOS0Iryul
         EFr9WQbAqxDMJvQuDmT/QujExlK5cRigV7uRbCsSiqB3oKxU2sTpp7FrP+ndi8mjTJaN
         lWz7hCDnB7EcTKqDiBRNVLDNQLRfQBiwWas4n+qjmiRCExoHG1eUDg4vbhq8RdWtQbOa
         moiw==
X-Gm-Message-State: APjAAAUy9osvXarQrp9k8FUKGhWND8dTifooV0xYxCBdQNvNYJDqgjYn
        tDaq0ekCrpFapQV90ksZTG0=
X-Google-Smtp-Source: APXvYqxmONDIX7T3YMFHU+SSe8JVCjsCt1EGkyQpLu08tdDcSrutmezf6irBwCbhMuxrdQ3HkMuugg==
X-Received: by 2002:a63:9742:: with SMTP id d2mr29579186pgo.356.1570454244493;
        Mon, 07 Oct 2019 06:17:24 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.138])
        by smtp.gmail.com with ESMTPSA id r186sm16938650pfr.40.2019.10.07.06.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 06:17:24 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 4/5] arm64: dts: meson: Add missing regulator linked to VCCV5 regulator to VDDIO_C/TF_IO
Date:   Mon,  7 Oct 2019 13:16:48 +0000
Message-Id: <20191007131649.1768-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007131649.1768-1-linux.amoon@gmail.com>
References: <20191007131649.1768-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per schematics add missing VCCV5 power supply to VDDIO_C/TF_IO
regulator. Also add TF_3V3N_1V8_EN signal name to gpio pin.

Fixes: c35f6dc5c377 (arm64: dts: meson: Add minimal support for Odroid-N2)
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 6bd23a1e7e1d..5daf176452f7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -66,11 +66,14 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
 
+		/* TF_3V3N_1V8_EN */
 		gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
 		gpios-states = <0>;
 
 		states = <3300000 0>,
 			 <1800000 1>;
+		/* U16 RT9179GB */
+		vin-supply = <&vcc_5v>;
 	};
 
 	flash_1v8: regulator-flash_1v8 {
-- 
2.23.0

