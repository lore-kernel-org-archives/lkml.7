Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE54BC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D1120644
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJnoEnp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbfIBI6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:58:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42767 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730723AbfIBI6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:58:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id w22so220824pfi.9;
        Mon, 02 Sep 2019 01:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EBJJZiLTlyHQcUFWi8qoZ9At1kM31HK9hl2nVQuOJ2c=;
        b=uJnoEnp6UQq3q56OIGpn91LI+Lb7z64K3bEgJtC4UYLUnlk7INET6LAaeNoMQNAsen
         kaAEkT+dGNSwp0bmZ464/QnZdZlMkGn4W4xD5jD4+5zAcXLPmlgxQLAZ41AiC1CJKRiA
         Vj2xDVutt1MDC030JngWtY5ecl8OBqvBqc+8rJmaF2Ff0oVsxtSC9xN1C4uqZ6vaR/E/
         iWSoqG+f1nfNogt/Hx3LHX2VoE7sK50HWlL2v6xHHSUZAtHY2nY47F7YJenKnIUjj+dg
         g+BXoSofgoFXpindXrh1KbtIsqqAN9Wm7f2DelYdedxuLjW3hqpqsuF18OLRfsvb1/6m
         so+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EBJJZiLTlyHQcUFWi8qoZ9At1kM31HK9hl2nVQuOJ2c=;
        b=it4d0SNyz8gNj+pH5bP6jbJFnQeLDzehZN4JSmIC4FWJs0T0ppdmfTWBhNNh78uRVg
         OOpM0Xzw9djk3CkzQTLXUAVlyWm/CZza2B66GzZAqCrJXyDgD8bRi1M+n1znd9hgWCbc
         2D5A0/8GU+hgv0UDPJDaGXVuHmqfxUPc65+DAcsShV9dKJF/BcGr7XigiLhrp9JlmzY7
         BdXM+2EyDRI5uHet5cSZJ9RoO98hhTsmt/VaZh+jRok0cQWx7yWWx1QX+9kf1uVdwIh/
         wpl8PIWJ26QobHTY+5qKTrxSyybFjH5rK9SsMoxZEvCJDUTEeMs3luTjHt/++FN5nEF4
         LWew==
X-Gm-Message-State: APjAAAVAFn+2rSTgcj+ZZpt6JZ+8ar+qarog2wpE/wnwh+sCReFdOjUG
        NhiYnboMBsk9KtsD6sK88hE=
X-Google-Smtp-Source: APXvYqxDkvnzZTNNAe1ds51ArcA57zi+5grJfD4+nj5NMlFU6xjf5LaMuCod1wpZnEAE2Gdpk5Qqng==
X-Received: by 2002:a65:6454:: with SMTP id s20mr24238401pgv.15.1567414717995;
        Mon, 02 Sep 2019 01:58:37 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.203])
        by smtp.gmail.com with ESMTPSA id y6sm6313117pfp.82.2019.09.02.01.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 01:58:37 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2-next 1/3] arm64: dts: meson: odroid-c2: Add missing regulator linked to P5V0 regulator
Date:   Mon,  2 Sep 2019 08:58:19 +0000
Message-Id: <20190902085821.1263-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190902085821.1263-1-linux.amoon@gmail.com>
References: <20190902085821.1263-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per schematics VDDIO_AO18, VDDIO_AO3V3/VDD3V3 DDR3_1V5/DDR_VDDC:
fixed regulator output which is supplied by P5V0.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes from previous.
- drop the rename and linking vcc3v3 regulator node.
- fix the typo spelling.
---
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 3e51f0835c8d..b763b76820ba 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -111,6 +111,36 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	vddio_ao1v8: regulator-vddio-ao1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		/* U17 RT9179GB */
+		vin-supply = <&p5v0>;
+	};
+
+	vddio_ao3v3: regulator-vddio-ao3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		/* U11 MP2161GJ-C499 */
+		vin-supply = <&p5v0>;
+	};
+
+	vddc_ddr: regulator-vddc-ddr {
+		compatible = "regulator-fixed";
+		regulator-name = "DDR3_1V5";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+		/* U15 MP2161GJ-C499 */
+		vin-supply = <&p5v0>;
+	};
+
 	emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
-- 
2.23.0

