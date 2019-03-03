Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AC0C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5676C20863
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ek0SDME8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfCCUHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:07:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35600 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfCCUG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:06:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id e17so1486381pgd.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 12:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nj6iC/SZT6BJVehE1IgS4x6izL4XIS21HdsDOD+Q8Qs=;
        b=Ek0SDME8nuBD9Edi9oiBH9XWAlQ3p2UIZ2lUTWWfJkDKlKxb+Oc8rBiTXd7Knp3rgR
         qq5Px+hDkY9EVz9LDq3vNbd1cmObGNIGKQzfxOgmSCHOQuiRPTm9osO3lhKNDV3DAFNi
         am871z1L77+34+tdEjAKyb1exd6f/fom2GD/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nj6iC/SZT6BJVehE1IgS4x6izL4XIS21HdsDOD+Q8Qs=;
        b=kjwr8fgOAkpNOUcnnixurRuMo3TAhwa5ftP6q1twAPyU0uu5/d6lDg2ZGx+WpbszWh
         6VfdxK+d4hkGSK2c/P+kUd6R9KqbVypoDTabWLStsNA5vmguum7VWTjpupDQPydrLm56
         YvVMRiCDRtkcHMeoRRdvWjFptpRrD1G285E7ssi1AMMMqkMERKm8S7xOS4AeVc/7mCqR
         wgpJnEpAQmymq7/68fV+PMWdu+OYitzeVUFmRVSWXt0uEcKGWJyxZJxHICl2rsqERQV1
         8umaSXyT3JEM9oGrEchzQc9ljtBULaBZLdN8Lk/d6d9QjFB+RNeP8goWLplZ3tNyYvvD
         x5Dw==
X-Gm-Message-State: APjAAAXvB3ZDgbpqIloRvT2PamcO5npd1wGxnDXNVKvubCoWMHbKrrHf
        E8aunaqkmKkCRU4gctPFfP5j+Q==
X-Google-Smtp-Source: APXvYqx/5hiUaybEbL76AxSL/kw+B44fKb3CWngGGwumcixEOMCshHel8RcUkHbHv6rCZt/v1B6s9Q==
X-Received: by 2002:a63:4a11:: with SMTP id x17mr15222919pga.376.1551643618915;
        Sun, 03 Mar 2019 12:06:58 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id j14sm5654021pfn.77.2019.03.03.12.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 12:06:58 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com, devicetree@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 3/4] dt-bindings: display: Add Novatek NT35596 panel documentation
Date:   Mon,  4 Mar 2019 01:36:17 +0530
Message-Id: <20190303200618.17581-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190303200618.17581-1-jagan@amarulasolutions.com>
References: <20190303200618.17581-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Novatek NT35596 is a single-chip IC solution for small or medium-sized
LTPS TFT LCD panels. NT35596 provides  several system interfaces like
MIPI/SPI/I2C.

Microtech MTF050FHDI-03 is 1080x1920, 4-lane MIPI DSI LCD panel which
has inbuilt NT35596 IC chip.

NT35596 support several regulators on the chip, among those ony 4 regulators
like VCI, VDDI/DVDD, AVDD, AVEE are used during power-on sequence. Since
MTF050FHDI-03 panel do support 3-regulator based power-on sequence, this
patch document only needful regulators and rest can be add while supporting
new panels on the similar chip IC.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../display/panel/novatek,nt35596.txt         | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt35596.txt

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35596.txt b/Documentation/devicetree/bindings/display/panel/novatek,nt35596.txt
new file mode 100644
index 000000000000..d336cd41e177
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35596.txt
@@ -0,0 +1,32 @@
+Novatek NT35596 based LCD panels
+
+Novatek NT35596 is a single-chip IC solution for small or medium-sized
+LTPS TFT LCD panels. NT35596 provides  several system interfaces like
+MIPI/SPI/I2C.
+
+Microtech MTF050FHDI-03 is 1080x1920, 4-lane MIPI DSI LCD panel which
+has inbuilt NT35596 IC chip.
+
+Required properties:
+- compatible: must be "novatek,nt35596" and one of
+  * "microtech,mtf050fhdi-03"
+- reset-gpios: a GPIO phandle for the reset pin
+
+Required properties for microtech,mtf050fhdi-03:
+- reg: DSI virtual channel used by that screen
+- dvdd-supply: I/O system regulator
+- avdd-supply: analog regulator for MIPI circuit
+- avee-supply: analog regulator for MIPI circuit
+
+Optional properties:
+- backlight: phandle for the backlight control.
+
+panel@0 {
+	compatible = "microtech,mtf050fhdi-03", "novatek,nt35596";
+	reg = <0>;
+	dvdd-supply = <&reg_dldo2>;	/* VCC-MIPI */
+	avdd-supply = <&reg_dc1sw>;	/* AVDD_5V0 */
+	avee-supply = <&reg_dc1sw>;	/* AVEE_5V */
+	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+	backlight = <&backlight>;
+};
-- 
2.18.0.321.gffc6fa0e3

