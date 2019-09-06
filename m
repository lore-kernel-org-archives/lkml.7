Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71A9C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF9F20854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O12Uv9X9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404736AbfIFMdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:33:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43165 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404725AbfIFMdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:33:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id d15so4366140pfo.10;
        Fri, 06 Sep 2019 05:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XL1ecQdL6XPXwXmH0af6w6z5EAVN9fbcG5PWEOAOqeY=;
        b=O12Uv9X9eemdfbjlXdCH2RTvg+MPXjGz7vY/Gqhp9Vj6RUSWZ07sdHYmuQR8ZvgWFs
         VyKcVO1orqcRK9nyqvKzbZq5RGYpAxNtMgJbLa6CM1Ilx+S0oAEyvnSr3zJSaH+i96pu
         VOB4HBsJA+fXKbKhjPwRisv4UQFwFhd20dFfyEdwminLOg5nMmvQMsDOXDa7Wm7+dMf1
         Oz89BWwmy1YqxRSz034Wn8dVYdLSPFdh5djemm0EzoFNpsJ+rHMDQSejhkgCbKw7HZdj
         KpAeKb0mbfxTdUwKa0xjxkIy0ovq1u0rY+2gGwEgT6awyEb27GFDTn7F2Dq5IgBZZpBY
         L8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XL1ecQdL6XPXwXmH0af6w6z5EAVN9fbcG5PWEOAOqeY=;
        b=bbKcN+dSkPnCPyA2ihZ2y9aEUCQl7wdP/Fz+NcKM68OoamvPrFnjPj1xY73eaXVsMe
         koAV0bLbwMcqcEzry8V9fRAwAYl2Zs6SvodggLiIFJ+GY/fAX5bWlIe+cmeJ0WDx2ilf
         Miv+VCCJxgLfr8BXmeNcqqR48PqpaXwy8DCTh+/epnbKKdOnZCD1/ff/vu61VvAGCyNd
         cbyo3wvbwHj1JOFQ64JORt7EoGYp6qiejTjTnHWy9H2dppZwiVAgwFIiZ2DPGK3GsCQd
         LjGi+bxGdaQN8yDKJKjAc9QS79ArXSldxdIOSO/beImD8+kQyxWHkz2+atBethii/3TX
         CSoQ==
X-Gm-Message-State: APjAAAWIlWBppxTOvSg9Nawl8ysTLWF6WT4O4eJnOqc8F92UeByNCes6
        VvBPWbZSAakcOR5IpSqsDlw=
X-Google-Smtp-Source: APXvYqxYnVrJx8RQe8BwVimz0PHJn0+JCbOvLTf90TebAgJeKUBRjRR9eIXxqaR93YpHo+orEUkpSg==
X-Received: by 2002:a63:534d:: with SMTP id t13mr7774981pgl.313.1567773210032;
        Fri, 06 Sep 2019 05:33:30 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.203])
        by smtp.gmail.com with ESMTPSA id h70sm4752933pgc.36.2019.09.06.05.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 05:33:29 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3-next 3/3] arm64: dts: meson: odroid-c2: Add missing regulator linked to HDMI supply
Date:   Fri,  6 Sep 2019 12:32:59 +0000
Message-Id: <20190906123259.351-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190906123259.351-1-linux.amoon@gmail.com>
References: <20190906123259.351-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per schematics HDMI_P5V0 is supplied by P5V0 so add missing link.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes from previous
Patchv1
- As per Martin's suggestion added the HDMI_P5V0 fix regulator node.
Patchv2
- Added Matrin's and Neil's Reviewed-by.
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 5624ff034659..6ae9fafe4244 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -66,6 +66,15 @@
 		regulator-always-on;
 	};
 
+	hdmi_p5v0: regulator-hdmi_p5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "HDMI_P5V0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		/* AP2331SA-7 */
+		vin-supply = <&p5v0>;
+	};
+
 	tflash_vdd: regulator-tflash_vdd {
 		compatible = "regulator-fixed";
 
@@ -220,6 +229,7 @@
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	hdmi-supply = <&hdmi_p5v0>;
 };
 
 &hdmi_tx_tmds_port {
-- 
2.23.0

