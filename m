Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BDEC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE4D20883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="r2OcgSMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfE0NWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:22:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43410 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfE0NWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:22:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id l17so8527473wrm.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0UO6p2NGpn6/x+RK1bJoMUDg+U4e7UPzCJT+tP40PaA=;
        b=r2OcgSMZb0v4j6KbwLI3lZude7y52PSXwphSwGgAIB9u+xVVV7O/ahSo2ZS/LMcwH4
         wqshUKB2VvyaIvZhSS1V6K9UjnbU/mlFMiBkGhIM8CIkv4bJvseyfm2UDDmt9hu2xBT6
         7mNhfmxgyl+059rx5X70BqJVEko6sOMPVDMUIj17uk3Mz9YHuInOrtmJOrdDUh5agYy3
         HWxtSiW4Dv1vzm/RcshsbWCqdV4AwrqZqlNL4O7MUcXGlbc8UecfNomF9mp+IvnpLTmx
         eKGYRgm+jZrmQ0ClplDsnJEqjxcxJ3Kyvw+9oxCoU9lggtjHlOnmPBVzAL0C5Y2ya6Ck
         C2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0UO6p2NGpn6/x+RK1bJoMUDg+U4e7UPzCJT+tP40PaA=;
        b=EwnGaKaPXJMvGCetHLoEy6qaR5+yqCt1IPFjoola3pmwPuxpKcAbmqh6y1Ubc8Y4YT
         kxRE6R2ITw0XkTyGyRx7UK48FgVgZyh3ae6Xj+cwb492Tbyh+HUGW8UGKaap5NXuwfI0
         knu9n7QlG3AVm9naTgWPQ9L3zAoEPNPISQDtpY7oDaODc44dXD37I5SQ8FwhzzFlTax4
         7boW8V7DJN8r00zthQaLLnWrDXTjKKJ6W+3tb8ULuDuKavARSQ7DkgCpvz5YCU4cgb/M
         bxnpgYjHxmfvTwB4cSwelSmxwm97tK+/DosGbpth2QhSUq+jSmwcH+zhU0ie1e4dZGSq
         tmEg==
X-Gm-Message-State: APjAAAWsRVvkiqRqYa6bobwrD7p03MI5fMQh71AlD3cwc8ukpaJC5wiN
        djpCVW+IJl5E6qgCQUmzjGjLXW6Jvh1W5g==
X-Google-Smtp-Source: APXvYqzCwOlwTFCDqqaeLiT8HaxVqritfgZVZbXUj48aOqAe46yNkgcCzFHUbw7WVsspKUXNijl9Ug==
X-Received: by 2002:adf:fe07:: with SMTP id n7mr134383wrr.7.1558963327475;
        Mon, 27 May 2019 06:22:07 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l12sm7019836wmj.22.2019.05.27.06.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:22:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com
Subject: [PATCH 06/10] arm64: dts: meson-gxbb-vega-s95: add HDMI nodes
Date:   Mon, 27 May 2019 15:21:56 +0200
Message-Id: <20190527132200.17377-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527132200.17377-1-narmstrong@baylibre.com>
References: <20190527132200.17377-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HDMI nodes to support graphics on Vega S95

Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 760730d4e87b..6738b2aac9a0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -73,6 +73,17 @@
 		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
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
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>,
@@ -108,6 +119,18 @@
 	};
 };
 
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
+	pinctrl-names = "default";
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
 &ir {
 	status = "okay";
 	pinctrl-0 = <&remote_input_ao_pins>;
-- 
2.21.0

