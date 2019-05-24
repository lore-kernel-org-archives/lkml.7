Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC30C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835A42081C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZOww9yLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403982AbfEXOD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 10:03:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35261 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403917AbfEXODZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:03:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so10173531wrv.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 07:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jJO+puwZK6RzCFU2E9wohjn3CAPQY0mhK89CaYjzY5M=;
        b=ZOww9yLUDApgLL5TUAoXfOGMzpkCgGDxw0plJtaFTLSk+wi8FDjn2GqkP2BCeo+5jX
         enylShZI4X3eWHu7OJW0RXlAt/fBZ7UmhFV/E6Inw4lXFYJWCGGXEUBTjp2FmCq1blZk
         YrfGDKLp5Mc40tTWU4btARTPvSroJukzK3zH7XQXJEhyV8esWK5UTf8PcdTm+X+PpMP8
         wFNj4uHG6uG4GUOUsNZWuvS1uWps/RFVqGOkILjlJEVpJZo2O+gK2mwR4TGoawrFioip
         w9bBBGNUsp/c7EbfBnxh/n474XEaYICIcZU7s2KaYF+d0a0eB0w8PyhCDz9Ze6LSvxYD
         5mAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJO+puwZK6RzCFU2E9wohjn3CAPQY0mhK89CaYjzY5M=;
        b=SoTcG0GNRXLk4ds8InHH0e5Q1mGR4prqDObaDvjY2lVPkPmu1HWkgt7WunqHa0X2gy
         lpnr1dRvzJfiYra4nUQkEsfj1qsQu/CHvl1Iq6rTMJrWvhKxDYdsGu68XcGBNW3PHWoJ
         V+I9Z1etHhWZAe/B0uhKZXGYPSnH1B5lKVy5nA9AruanaAVrBJ5+6VDJmPAy0BSmdTyM
         k3k0Z29C0GUZ1mf+fMBtOELQIXaSrEmZvo900ZL85qc+Vu9p3lsdjLSlXGaSK1Ex62F8
         pLuB3o6LjZslWxrjqK+ijLTB82x8aEOX6lsRtCbcW3+8+wQS4bCBuBZZaaUx+idZgmL5
         6l5g==
X-Gm-Message-State: APjAAAULy+1eSDWMHH+lh6J8AjFhVh6D9GUEDbAoWrTx+Zr/NENFNlCX
        sKrmR3/HVfQOAiVWE17ujZX/CA==
X-Google-Smtp-Source: APXvYqwPqM/A9ghI9cWm9xIbx3Gh9KcPOkIzeLjObeDa31TAuaJDFYcB71ff+OvnhdyV3PBR2CaLmA==
X-Received: by 2002:a5d:6506:: with SMTP id x6mr94660wru.339.1558706604206;
        Fri, 24 May 2019 07:03:24 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id t7sm2797114wrq.76.2019.05.24.07.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 07:03:23 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 1/2] arm64: dts: meson: sei510: add max98357a DAC
Date:   Fri, 24 May 2019 16:03:17 +0200
Message-Id: <20190524140318.17608-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524140318.17608-1-jbrunet@baylibre.com>
References: <20190524140318.17608-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Jourdan <mjourdan@baylibre.com>

The SEI510 board features a max98357a audio codec for built-in
speaker

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index be1d9ed6d521..c6d032ed9a8b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -32,6 +32,13 @@
 		ethernet0 = &ethmac;
 	};
 
+	mono_dac: audio-codec {
+		compatible = "maxim,max98357a";
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "U16";
+		sdmode-gpios = <&gpio GPIOX_8 GPIO_ACTIVE_HIGH>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-- 
2.20.1

