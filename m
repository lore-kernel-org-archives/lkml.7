Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D63C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 18:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1336E206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 18:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueVeoJxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfHXSt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 14:49:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40899 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfHXSt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 14:49:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id h3so7618142pls.7;
        Sat, 24 Aug 2019 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mWM5LytVm+qVRCAst8MByyiY2Qa5JPuN6rsR3ZQ70z8=;
        b=ueVeoJxLluToFx+7NSL/79KFr3FgDymk0Q3IbzlNc+RpUCVdkfYubfuw6llg0MT83V
         RHgYVMjGtjLKwPLF61/YYc9Vamj9ZHFRtdUo1R167dxlVQEzi/NmTBb21scWlroo54nQ
         20pTzu1ghzF8CEsSaxA7nT5KeVzB/td+GaCu8w9N/gYCutyTid0mHqavLhEVZneea+rj
         JcOH9hMGAmiucsSC3yXuhy6M96YV9hDz7evYiEfc8txKzC7iBrMNFDwUvCdW8R8kudaY
         9bIZTWwLbpD0meiOnN64iZxIGMznrvrI9DZZyZ2P6xjpAc7JzbmhzPAwsq0nwUJzuxxv
         18Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mWM5LytVm+qVRCAst8MByyiY2Qa5JPuN6rsR3ZQ70z8=;
        b=NF7ULXFx4LISfPl1baI7ojDNVE5kQQECnBT9slOg0nUNUjZ2hk6GwPXIb2TzTD+4yk
         hRXMZqNi3zXph6HkfAkYXUqa7SMuaCtz0Em1Qn1Q2o76Z9QH8VBBwwQmNwPYtrAb6RAe
         8ebfebPd2+Ko69XV2HjKR7MTW/w02d8BG1m0/I2BBF8EaFAXbiHw7X/2jnos4rliyh/E
         4AGvWwStdNaZDuEtVXpFtZfnPgXJFo17MRZeQl+KnlZAkKRf/nblHJFXTTkJdmBzF/xH
         E8r6A2B+ZwZ4KcUTAz9KPs/Wf9ukrlgZc6deXKidNPyyVsw5UC8jhWEN0JaGYs5A6vNj
         7anw==
X-Gm-Message-State: APjAAAU1AxW24BaReJLXPLDekdmvNpLZoZERt79TQHFMsfewfdhYaV9Z
        5EHSx57zS0k/SVysKs0DArM=
X-Google-Smtp-Source: APXvYqxcnSVgRSIlKHxAzb4Ia7pYMTMytnfEb5MOPyrQskplVfhLXfLS9fKipFL2C/aKSs2M2GNqjw==
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr11346603pla.197.1566672596225;
        Sat, 24 Aug 2019 11:49:56 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.111])
        by smtp.gmail.com with ESMTPSA id t8sm5519292pji.24.2019.08.24.11.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 11:49:55 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv4 1/3] arm64: dts: meson: odroid-c2: p5v0 is the main 5V power input
Date:   Sat, 24 Aug 2019 18:49:10 +0000
Message-Id: <20190824184912.795-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190824184912.795-1-linux.amoon@gmail.com>
References: <20190824184912.795-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the schematic Monolithic Power Systems MP2161GJ-C499
supply a fixed output voltage of 5.0V. This supplies linked
to VDD_EE, HDMI_P5V0, USB_POWER, VCCK, VDDIO_AO1V8, DDR_VDDC
according to the schematics.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes from my previous attempt below
[1] https://lore.kernel.org/patchwork/patch/1031243/

New patch and fix the commit message.
Added regulator-always-on since this is core input regulator.
Split the linking on regulator and usb node in separate patch.

Later more patchs will follow linking more core regulator as per
shematics.
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 9972b1515da6..41d5fa370eb3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -50,6 +50,15 @@
 		};
 	};
 
+	p5v0: regulator-p5v0 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "P5V0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
 	tflash_vdd: regulator-tflash_vdd {
 		/*
 		 * signal name from schematics: TFLASH_VDD_EN
-- 
2.23.0

