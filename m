Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAACC2D0D1
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B1C2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrg17tqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfLREVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 23:21:48 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51762 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfLREVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:21:33 -0500
Received: by mail-pj1-f65.google.com with SMTP id j11so261196pjs.1;
        Tue, 17 Dec 2019 20:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5JoZyySS78BiNU1aODtc8vpSYvJMQn2ITDVR9fgmYmY=;
        b=mrg17tqFWEI9echCXToFXJOHp77UK2JA5GbsZqzLwqAR9vCr05p/FJRVWY9OwE6y3N
         HWGuB1pME0LUdbMAydBMZM/sHwBJCuL3Avx6yPr3LDqgDVD6PPg16aH5QPVJbGZ4NGVv
         G/AXM21EGT1glWaaUNt00qP8k2WjbPjiSLJqsrkOXEK9NdMU6iR7EeNDjXoEbNeEsEu3
         f8CNijAHCI+itYbDnIcycmbkBIG4AHbyc4YHGOqmjCpYt1ZNm5v4Yi5rmHY7m5hAyLh/
         yVpIyHyiRlAn8ABaEv0kZoKmCGTul/w4bXFjV7KWrlL1JsGRBVHMoTq9rhqCkDyd0SRa
         mDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5JoZyySS78BiNU1aODtc8vpSYvJMQn2ITDVR9fgmYmY=;
        b=J2Z63azT42Pph0801ZDmm0FO8MtSqi/4MZwxgUU/7KaFBj8+LMKoWFB+6equuuyfpg
         fh+pWRaxTbGIp6aF7cbRH2VPEz+cMJ4DYHvYGr34uF75MBQysmKGwMbhdzHB92GRk6z3
         gruiLRkcj3kLg/q/hpoCyWiQaB9WRLFG8I0lSjiEZCEhUDc1BjLRZoIQd17tjk57siep
         UvKHftK9XEMb0ciOPc9rN85d2xT0/lsNePF1gGHJCwCI+wWCkPmm0wqSU0E/Es2Ll9tO
         Z2ufsSfxyylYDQ4um8EY5wgCl8EG9Q7S+8dC7ijbib0RXnoO8W9LVXSMjBkixg3UId+d
         4Ncw==
X-Gm-Message-State: APjAAAXcvcAc5Io+E5Fn+6SPC1RhOVTqiRUsSGEFY7BuMA/zseYFzGWg
        RLXD+Zn1mT4vhQCtN0ZhZQw=
X-Google-Smtp-Source: APXvYqwkHZDDMPW+eIbPKCNS8iHXIe0g9IqSkmFDGFTAYkookNiFDEI9gFJvmiTBJUJtxJ4Fzg2tjA==
X-Received: by 2002:a17:902:9a49:: with SMTP id x9mr261739plv.331.1576642892784;
        Tue, 17 Dec 2019 20:21:32 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id g17sm775380pfb.180.2019.12.17.20.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 20:21:32 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megous@megous.com>,
        linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v7 5/7] arm64: dts: allwinner: h5: Add thermal sensor and thermal zones
Date:   Tue, 17 Dec 2019 20:21:19 -0800
Message-Id: <20191218042121.1471954-6-anarsoul@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218042121.1471954-1-anarsoul@gmail.com>
References: <20191218042121.1471954-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

There are two sensors, one for CPU, one for GPU.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index e92c4de5bf3b..f9df95b2d542 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -176,6 +176,32 @@ mali: gpu@1e80000 {
 			assigned-clocks = <&ccu CLK_GPU>;
 			assigned-clock-rates = <384000000>;
 		};
+
+		ths: thermal-sensor@1c25000 {
+			compatible = "allwinner,sun50i-h5-ths";
+			reg = <0x01c25000 0x400>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&ccu RST_BUS_THS>;
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+			clock-names = "bus", "mod";
+			nvmem-cells = <&ths_calibration>;
+			nvmem-cell-names = "calibration";
+			#thermal-sensor-cells = <1>;
+		};
+	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 0>;
+		};
+
+		gpu_thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 1>;
+		};
 	};
 };
 
-- 
2.24.1

