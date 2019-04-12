Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2285DC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E887B2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="L6sPYtYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfDLMvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:51:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33626 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLMvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:51:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so407013wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LyEpL17LgBNZeGjq/1bCg8MXLn3ABQcKDag1wbyqyFQ=;
        b=L6sPYtYcW2TpMtcF2CXTtyvSfab1PYutcI+IRWV06fe/fHjYd0kO0dxeElOFb2HO7M
         M6tYMDXWM7Dar2FshOm/ezWzIGBkkF6g6nZL3TGqRxXdHaNUsIInSwDhGCd4pWB4Uuo+
         9vtTQIVxtgM+GV9oM0/tNDr7s4wbqI0uuGQoeofInM/rBk6JURzCQrpvne96slZzyEcZ
         MH4Y2NARyZNHUryKkctOwDoKGbQO3QdxgAD5o0JTQZHgeRKRoDOMl4U7PPihKtBKUOQp
         msGVbJhN3qHOAonr7O0q3Zpik/HmJfuTlyEzi0MJL02uOA72cX0KCUYJPxt8BCmbP0l6
         i80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LyEpL17LgBNZeGjq/1bCg8MXLn3ABQcKDag1wbyqyFQ=;
        b=GZ26yftS42rpWrE4ay/nzO+7I6lBuX5UpUbNQI3PbJXOV14iEIEVPDW+FGfwV+9NcR
         7lKWURTzsl5iA4UgizOZnioEydGQdndHKsvIywyzRx8ycVqNgzBRXRufeZzp2EEch+5h
         KmFGGLPmrutGDyuvYAR00vZflfvplhwOWVMlAflu56UQHf4twT7vxX9fK8rHcQjxDZOx
         kjiDNtMApKMxjAz9dFaAjmoTDm3PHxVOd5Z0wfuhB+28CFB0akCZmeXd30Tku9RzhYpJ
         yNQ3cCQqRmonH9l5KHxQ0LUlHzYL9KhiklBiU6ePhdsFP0HoHyq0i8d6T4QEnAUtXMbM
         L11A==
X-Gm-Message-State: APjAAAU0O/MK8r57B88EEc+EIcxpjzX4HfWl5rbD6M5zblhQ3883kdnX
        5GR7utegr6SGz/ebe/Qdck1d3A==
X-Google-Smtp-Source: APXvYqzEGdtoEfCd85te0YIevixYWmQNLaY+2lAnWUA8HaoI4yIi7XkNcL10AdjISzwUjO+BWkGIiw==
X-Received: by 2002:a1c:bd8b:: with SMTP id n133mr11154540wmf.73.1555073510078;
        Fri, 12 Apr 2019 05:51:50 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id b3sm42049702wrx.57.2019.04.12.05.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 05:51:49 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patchwork-bot+notify@kernel.org
Subject: [PATCH 2/7] arm64: dts: meson: g12a: add audio memory arbitrer
Date:   Fri, 12 Apr 2019 14:51:31 +0200
Message-Id: <20190412125136.28232-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412125136.28232-1-jbrunet@baylibre.com>
References: <20190412125136.28232-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DDR memory arbitrer dedicated to audio subsystem of the g12a

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 1ab2a77b01eb..b2acece1b66b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/axg-audio-clkc.h>
 #include <dt-bindings/clock/g12a-clkc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -238,6 +239,14 @@
 
 					resets = <&reset RESET_AUDIO>;
 				};
+
+				arb: reset-controller@280 {
+					status = "disabled";
+					compatible = "amlogic,meson-axg-audio-arb";
+					reg = <0x0 0x280 0x0 0x4>;
+					#reset-cells = <1>;
+					clocks = <&clkc_audio AUD_CLKID_DDR_ARB>;
+				};
 			};
 		};
 
-- 
2.20.1

