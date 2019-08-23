Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12227C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACF52166E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="b0KqI2bK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393536AbfHWJEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:04:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51945 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393471AbfHWJE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:04:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id k1so8219350wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 02:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7lS6otfNfKn2A4Z6EJ+EWGqquL/jDHyWtp6eWoI2sQ=;
        b=b0KqI2bKabxX/CLyMZVp4C9olw9IuKvdW4s2hW59kzepQ9tpvF7cIj3t7rlg5bdUoi
         SjrpZuX4aNecZpzG5WoarF2JwNbhgnTmhw6tOCTLPyj6a0MlCUri0PrZZbpzevTGI+2u
         jCP/dyGPZLHcwTzex2b+yWNzs+SYVzxIbYmN+1/gCEV4dWN/KFAkr/GkRmYPFEBq72qa
         +vptHtmHo11a57W5NNTxKHo7S3yWTEcABRlm9XfLO8ZpzjIQ3XrTcW9admytv+PYB37p
         wMOPBj4PfQGnFhzI+wRMlAt/VscakAVYsPEWyoClsGMbQUQG+zDSOFYHufNIYK/zcXeF
         adEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7lS6otfNfKn2A4Z6EJ+EWGqquL/jDHyWtp6eWoI2sQ=;
        b=PkBnuU4SITlCtQs3H77O4JuWb2v8baeRSNohRiHJ7S0HxsI77M6KLVSqP+JRJzauIc
         oR9ZxlD8zwMV5QyHzwQ3i6J1UrqhKxW5DD/e1YOFW9L5A0MKWlX32kHmJciccY1ffe+q
         2Q73J6uwrtwg/LcfcFeyrfx0xRmgA+XnlsQdIgol7wqeJ9jV0KuAHiUbr9dHS1g+1Wsw
         VNyeLcAqPDzAV6c2BU+yTKZad1tDdNgmyNaJtvf3NP9B/8cvYvBVUACcHJjw/eBh0/rp
         he0N63d+YIUISKp7kMsNdJ6E8uDv45LLla4e7yiVvhA0wDGV4sVxx9NKrA6MCc3UmS2d
         xRGQ==
X-Gm-Message-State: APjAAAWdBndEnwHLmJtmksB/puSrJASpoc5DLtUx0gJYud/aFfAbs7Hs
        m72sbbiiQm/OQXT8BRYsh24JCg==
X-Google-Smtp-Source: APXvYqzv+3OEYdyAmsOvtHfKnTXCIdOXKgggpEvAEYxC41wrsIacwiO8beWA5cQ7p8t4M1JJqXh2tw==
X-Received: by 2002:a1c:c1cd:: with SMTP id r196mr4049459wmf.127.1566551064134;
        Fri, 23 Aug 2019 02:04:24 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x26sm1625544wmj.42.2019.08.23.02.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 02:04:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, ulf.hansson@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] arm64: dts: meson-sm1-sei610: add HDMI display support
Date:   Fri, 23 Aug 2019 11:04:17 +0200
Message-Id: <20190823090418.17148-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823090418.17148-1-narmstrong@baylibre.com>
References: <20190823090418.17148-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the HDMI support nodes for the Amlogic SM1 Based SEI610 Board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-sm1-sei610.dts     | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 12dab0ba2f26..66bd3bfbaf91 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -51,6 +51,17 @@
 		};
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_tmds_out>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -177,6 +188,18 @@
 	phy-mode = "rmii";
 };
 
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
+	pinctrl-names = "default";
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
 &i2c3 {
 	status = "okay";
 	pinctrl-0 = <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
-- 
2.22.0

