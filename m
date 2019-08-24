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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1071AC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 18:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0B82146E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 18:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta+h6P6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfHXSuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 14:50:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33659 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfHXSuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 14:50:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id go14so7612120plb.0;
        Sat, 24 Aug 2019 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KG3wU0cDOLtAU+yc37BRhIg5M3JzRBY8MVvSn1NtlyE=;
        b=Ta+h6P6PVcFDwVsgbSLDnX7gW1kemD4czlwwbc9mlHYkvo3nUiUfIZBGt3zo3guLa2
         +lv7tOVxu5RWaoChp/DBlEUeL6kBIk4KP14FEyD81Rw7dkDatNKh1Nx8aPrIRW+055uE
         mzL7uMMNrUTDfre2uT4D5ewQRUlzt9CT0EzQTwMZKa+3YCyxwEL6zctSftTDqdf+DRv0
         +XcRw2nk+xjeyD+uLyjgRyJvj919MO0EQqIiDCN32Cd4LjINgcLXvn5HHX3PpXb/tey5
         uU5c8DHLDDoaRu1PXKgKITwBUejIhQFdLX1OoUhgVCKeEfJClSCPmhqS4uPSD2KF0CzQ
         1VWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KG3wU0cDOLtAU+yc37BRhIg5M3JzRBY8MVvSn1NtlyE=;
        b=VZT7XWfcZRvkSbJywkMVyHepQ2fLiervLvmNuSSaTg8rI/WSOd8JfnPVJ2DwYMIFvc
         tL+dkG1saVACMckZe2oZ9oWC549uWqsNZhRukkVr1V8SJHfGoOxl8EiHI+Ms39HgP3xj
         XcWMmVlvvXdXplJFGsxXqCudZHhLLNXK6d8m8xG2FV3CV7lWAS31kAfpK6ObxP2mur9b
         rsprOoRndnR6ExkrBng9H/pB+jB5jxUDo5r+LIk8saTeP54ZlrkK7T1uAXZQDIryN5xz
         sObmn86V1m2bOaSCUKHfvv8hAJ6DAET4/hMyvNdMULSCLgoWHRuWP3lxxPcqXDdvCjoJ
         PUwA==
X-Gm-Message-State: APjAAAVjW0awsgiISab0LkuhIBfjRUOhIEZqqWgaJAKgBhgdv9hEmB1d
        tHAPhPqjr8IbhVXaCCLV7eI=
X-Google-Smtp-Source: APXvYqyMAOX4IlwwT6RsKneClv2NtasaHom5hyOCs/mi2fe6yXE26vU3ERE59ELNNeC8HH/dakqjPw==
X-Received: by 2002:a17:902:e30f:: with SMTP id cg15mr11298012plb.46.1566672599386;
        Sat, 24 Aug 2019 11:49:59 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.111])
        by smtp.gmail.com with ESMTPSA id t8sm5519292pji.24.2019.08.24.11.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 11:49:59 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv4 2/3] arm64: dts: meson: odroid-c2: Add missing linking regulator to usb bus
Date:   Sat, 24 Aug 2019 18:49:11 +0000
Message-Id: <20190824184912.795-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190824184912.795-1-linux.amoon@gmail.com>
References: <20190824184912.795-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing linking regulator node to usb bus for power usb devices.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes from previous patch
[1] https://lore.kernel.org/patchwork/patch/1031243/
split the changes and add the comments to power source
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 41d5fa370eb3..f3dcabf97c63 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -36,8 +36,15 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 
+		/*
+		 * signal name from schematics: PWREN
+		 */
 		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		/*
+		 * signal name from sehematics: USB_POWER
+		 */
+		vin-supply = <&p5v0>;
 	};
 
 	leds {
-- 
2.23.0

