Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A07C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40E0214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aAt655SR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbfHFNFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:05:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37733 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731759AbfHFNFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:05:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so62762697wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 06:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uqH4UC1eSv85wYUtuk1mdjTGck9SIfF7lj/7yQH/8cg=;
        b=aAt655SRq+X0Jny0WrUuo7sHjdd6G8a1GtrHRFYhXO1URHEr3byWv8/KWMOj8q9TjQ
         040nKWawlrr5JZ83gyaGdkT+k1Mod+TK9X1aG9bdRz2rdifNlah3zVCF0zUmssP6DQAi
         u3gIb/HUhMGroGl90/ytrizOn8PNZgHtXNNLH4BpNhVvNKEckWXSXJP70eDShNK7qgyd
         50ytA6pXiVCBbSku2+T3undY7EiTNu9bOpKmrDi6UT7/QwWz3kFlsPMYFtqH5oCuGoja
         w7UBBPo0rnAaaKloFS59gpptairrYwWMTvFTstw4Idmcu9lwAcX3CdPgsDkSbBH7H2dZ
         h8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uqH4UC1eSv85wYUtuk1mdjTGck9SIfF7lj/7yQH/8cg=;
        b=QoPUMTJBnE2VLUvRMQLdIlU/1phFRzfuMWbMMzCmeeAggQkFr9cP8DD/XtUUGkkAGL
         hboLmlK90Pz2Uh7VxBZHdWOX4C0+nK4MJgMy/RH/31txemf/SPPoLggjFXnQ03UYLuta
         thY1F2oLAFsp7i6h5sGDiO20JcvpeLmrketP5qJ8/i29mRh/EPXFzgOzgAW+hhYm0/EI
         rdEqWzOUNx/dtxQaZ1OAJT8nKqnHdUxWwOHtVjj+IQRW/n+XFobNixgoS46bL2jtoZ91
         XcyDki8F2uaq+fpytQcjhw/BZOp/UJ7IIOf4ffpMElH9yduIV2i4AeZwZdRZpga2oP++
         PVUw==
X-Gm-Message-State: APjAAAVE+PZv0LG3vY53Nc25rDyR8skjKf8IHJLx7TFRWeWHjwJMvRmB
        xK76/M4wQRzpa9s3fz0YylCeRfiowFs=
X-Google-Smtp-Source: APXvYqzvKl6XDaK+k++qOddjwyFWqDlehJlRskJnMO8xAi2r7ugXjIzQcQOHtKclpqWFZJmrdGoijA==
X-Received: by 2002:adf:e708:: with SMTP id c8mr4973678wrm.25.1565096713800;
        Tue, 06 Aug 2019 06:05:13 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j33sm201888738wre.42.2019.08.06.06.05.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 06:05:13 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/6] arm64: dts: amlogic: g12: add temperature sensor
Date:   Tue,  6 Aug 2019 15:05:03 +0200
Message-Id: <20190806130506.8753-4-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806130506.8753-1-glaroque@baylibre.com>
References: <20190806130506.8753-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpu and ddr temperature sensors for G12 Socs

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 06e186ca41e3..a06298538614 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1353,6 +1353,26 @@
 				};
 			};
 
+			cpu_temp: temperature-sensor@34800 {
+				compatible = "amlogic,g12-cpu-thermal",
+					     "amlogic,g12-thermal";
+				reg = <0x0 0x34800 0x0 0x50>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				#thermal-sensor-cells = <0>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
+			ddr_temp: temperature-sensor@34c00 {
+				compatible = "amlogic,g12-ddr-thermal",
+					     "amlogic,g12-thermal";
+				reg = <0x0 0x34c00 0x0 0x50>;
+				interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				#thermal-sensor-cells = <0>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
 			usb2_phy0: phy@36000 {
 				compatible = "amlogic,g12a-usb2-phy";
 				reg = <0x0 0x36000 0x0 0x2000>;
-- 
2.17.1

