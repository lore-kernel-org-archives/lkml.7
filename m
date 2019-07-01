Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7BBC46478
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D556221530
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VFZrfRQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfGAKrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:47:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56239 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbfGAKrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:47:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so15330272wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 03:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MHTJ257kdPP2T0j92u2xSaWnQO7aRf9hGbv+c9l6pxM=;
        b=VFZrfRQ1F0iwy+14EMyBHVHHM3dPYVsVYIq1rXoHN6fFnW+W8hmKNQ7soUw1ak0be7
         4691jHA+qEJU4qfw4xoKufSACls4wAxo2FRRQVWIWBM7kb4Wj0WVCiEeYShwaxUqsK64
         djk32jQQkE4bSOx0OpOS//c5qraxGSmseV4lHJXwi/MvzyH4LnhqDOOditZlNZNoXw+J
         ym+9OuFBbWTsqLWsCo9ZKZl8RqknErs3PoeM37wlrlDbdVgGMG+iU466lGUkQzPHmLAg
         WtPtyfs+HUNdr1nXtcRYNMNEUQ0DFJ2gcSUdyvShP+rk+nIAqthppc1dQgVk97n61bum
         +elQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MHTJ257kdPP2T0j92u2xSaWnQO7aRf9hGbv+c9l6pxM=;
        b=bE1gGQ7cT7InfRTYh9aEQtRXPDy7Wg8Ps2MRvWlUF7OVFfMw+D8Uq6KraIpagGzIJI
         tw3OZxARFv0RSPVEwlFeTIVIiW7GQRH8i870xRQ0zy5aVC+sFeE0flF1lKV7ssVfTNJR
         8LSxH38wEGEi2hlw43xs2IgFOM2YHaofVKRkdcVVt6ZAK/tOHADau6rjHHw+Qe2GaZEG
         ZLtxBw2NbcZTxNru1S4KohcuxI/X2zFFTX4JLNKVrSPScN2fj57rsxC5IW8wyBwFS7Nx
         3w0d3h/SNKi3Al6GXfkO0G+EQFttOKu+c0W+YkTHkSuNQXYsID3YLisnVt4vpP+kVxlJ
         r/dA==
X-Gm-Message-State: APjAAAU68MzqlQXx2AO7R5XZJiDk+fEUKLsvTy2eijak9FSXQpPHM6v5
        1pj/bA72xl0BEqjV86tEV5tTXA==
X-Google-Smtp-Source: APXvYqxo4flzhYOz0OrHaqCdbrMX3sdAJGvFI0sixUo7zYPrRJ8p4Kl9rrP13WwllpyHoZzl7aNzDA==
X-Received: by 2002:a1c:9cd1:: with SMTP id f200mr16321534wme.157.1561978051524;
        Mon, 01 Jul 2019 03:47:31 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d24sm11658802wra.43.2019.07.01.03.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 03:47:30 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC 07/11] dt-bindings: media: meson-ao-cec: add SM1 compatible
Date:   Mon,  1 Jul 2019 12:47:01 +0200
Message-Id: <20190701104705.18271-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701104705.18271-1-narmstrong@baylibre.com>
References: <20190701104705.18271-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AO-CEC compatible string for the Amlogic SM1 SoC family,
a derivate of the G12A AO-CECB controller.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/media/meson-ao-cec.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/meson-ao-cec.txt b/Documentation/devicetree/bindings/media/meson-ao-cec.txt
index c67fc41d4aa2..ad92ee41c0dd 100644
--- a/Documentation/devicetree/bindings/media/meson-ao-cec.txt
+++ b/Documentation/devicetree/bindings/media/meson-ao-cec.txt
@@ -5,10 +5,12 @@ to handle communication between HDMI connected devices over the CEC bus.
 
 Required properties:
   - compatible : value should be following depending on the SoC :
-	For GXBB, GXL, GXM and G12A (AO_CEC_A module) :
+	For GXBB, GXL, GXM, G12A and SM1 (AO_CEC_A module) :
 	"amlogic,meson-gx-ao-cec"
 	For G12A (AO_CEC_B module) :
 	"amlogic,meson-g12a-ao-cec"
+	For SM1 (AO_CEC_B module) :
+	"amlogic,meson-sm1-ao-cec"
 
   - reg : Physical base address of the IP registers and length of memory
 	  mapped region.
@@ -16,9 +18,9 @@ Required properties:
   - interrupts : AO-CEC interrupt number to the CPU.
   - clocks : from common clock binding: handle to AO-CEC clock.
   - clock-names : from common clock binding, must contain :
-		For GXBB, GXL, GXM and G12A (AO_CEC_A module) :
+		For GXBB, GXL, GXM, G12A and SM1 (AO_CEC_A module) :
 		- "core"
-		For G12A (AO_CEC_B module) :
+		For G12A, SM1 (AO_CEC_B module) :
 		- "oscin"
 		corresponding to entry in the clocks property.
   - hdmi-phandle: phandle to the HDMI controller
-- 
2.21.0

