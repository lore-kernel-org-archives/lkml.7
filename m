Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80858C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5308B2339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Qf+7k8hC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfHULlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:41:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54536 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbfHULl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 07:41:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so1755733wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 04:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKHSL2TvLdzeYTHakHcSzedmEttI2anacBGRuNcRBkU=;
        b=Qf+7k8hCbmdx30F6mqFUQm8AMdjK23pNz+MRa8MhFvVDygJXD7EaWUmdHhejqp8wct
         4+pLHdp5iw5KDRMZwuqkVAswEUWxofGDQzuGgpsquF+50kJQ1cGsy52QwHTJrbmPdLgB
         p6J6bIFj/E7cb4atsDOaHFqdfsF+MOBeAdZ1hdD/zl0/zSSvwRSCAgtZolAGbs49PaFV
         ewpZL/DUiR1uYLS6dG93Af1jwyqjqhWH15xmIcm7oTjVNZ5Z+14qsF6DjqQkOFawvPzm
         dwBN03rjf2OfX3Ur5nNvzjj3DcyWYil3SnIIk/2iOenEBrtl7I82aOMwHPr0LX+2AW+J
         J9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKHSL2TvLdzeYTHakHcSzedmEttI2anacBGRuNcRBkU=;
        b=tNeCZ25rkd8BiU1MTNV+9R0hr9RyPyFMopOEsSk7YQM8ocriZnF8qVPJlakqujrLZJ
         QwyapBSmSmfjYbeyB1Zok7F9TUwdKiar9/JqfGhKEvAU0bCGRho3S3XbL1P+PUk9L+YO
         n++m7mHBZkwVbMooSx4qi+oebYa1zj1VwvoLccHOe0NXpUM1luSxII+V7AtQ5vs7A+5r
         ws1haQwUo4E3ou1rfZNOXR2DompMU/wztD42xTOODU6QNroAD7B+zdFrQ42k782YPDJ5
         yugABYJ+8AtDbw71U1Wyl+0S5hDLnpKVleOalcmLUTOTOuJg4S9weDHmvjm1d1yNWAfg
         GLzQ==
X-Gm-Message-State: APjAAAWk2OgGkvmgWA7rq9S/k+HvqKdT2OJF5RJT8wMXNCYbcIP+/dMn
        kj8ZVRPBbS9CHbic4wFAS/ujkHCuziXWHQ==
X-Google-Smtp-Source: APXvYqw4lJ4s62v8F8QFkE+24Nhj1T9LxC4dbp+rc3mOe7dCfo5AauJ9VNbYhuGEd5Xg9fgwIPl5Cw==
X-Received: by 2002:a1c:ca09:: with SMTP id a9mr5490244wmg.43.1566387687833;
        Wed, 21 Aug 2019 04:41:27 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g12sm24049686wrv.9.2019.08.21.04.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 04:41:27 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, ulf.hansson@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: meson-sm1-sei610: add USB support
Date:   Wed, 21 Aug 2019 13:41:21 +0200
Message-Id: <20190821114121.10430-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821114121.10430-1-narmstrong@baylibre.com>
References: <20190821114121.10430-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the USB properties for the Amlogic SM1 Based SEI610 Board in order to
support the USB DRD Type-C port and the USB3 Type A port.

The USB DRD Type-C controller uses the ID signal to toggle the USB role
between the DWC3 Host controller and the DWC2 Device controller.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 66bd3bfbaf91..36ac2e4b970d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -321,3 +321,8 @@
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
 };
+
+&usb {
+	status = "okay";
+	dr_mode = "otg";
+};
-- 
2.22.0

