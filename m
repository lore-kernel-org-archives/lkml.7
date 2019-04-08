Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC876C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF90208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOySidlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfDHJWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:22:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34410 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfDHJWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:22:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id r186so14759121wmf.1;
        Mon, 08 Apr 2019 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KAIN5KK91kY4ITqeAKSPL8DOT67g+hbERSyfTlOuus8=;
        b=JOySidlVKJhOQZYIEJwVO2L7xGRtWnqgLgLDTILx0futaFhY605DkPqpcqEiE+s+Q7
         mpfIhYwPkH63fzaCr9d+nH7C8yotjNcdfCCcQxvtSQThWRs5K+zXV/Td4U0A9bJZFo7u
         3wb6Nm8jKesaaEU4iK+H2cpEb1fuiIVJC8EGVui1y8B3yFDyD8ROhmxt7xjzG8GzTMy3
         KoCOwtIAzdfnhPjiHpeSh33hqJF0ObJcqH5PJDs6G8tqVwIMRU2reeBsSzMc4zJZmYG0
         TrJJjuFGl2p22vU5HdA7SFO+B8QaEexQ7GU+gEorg6MdM7AG0vMXqV2AbXt+Osmni5+W
         tCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KAIN5KK91kY4ITqeAKSPL8DOT67g+hbERSyfTlOuus8=;
        b=S8ijaamy8YyoMy0pg4HbjffRZPxhTmnykT+yKxoSjXi3hkV165MJCuEWhRHjDXLfNV
         DqvAXlnm3Me0fmf0fhK8H99qGKwf9iwKaxcA+D+O6gsvCO96U8ApF/i1SckmxG8Y6fx/
         sYjsgM+AZDOhjXUGphEzTs30gR352DVCL/dVNsuquzYYT1glmNCpkdSvepNq5d5wvLjN
         TVrHc08o8lUsz9DJU8fZpA/zxox1grq7KTtCCbFe4l1i2u2SeSgkDRxLU7qX8yBHB/pH
         tG+pkFAFmP5N5rSY7AEq9EdyiK0DfDEed8AIutND6lAba/IEPpLoaDbv+hIHCaSnziCj
         PMJQ==
X-Gm-Message-State: APjAAAVnkyxyHOyoSNCYvbrY6i2uE2WNnm8w6GinuXk6hw4B7te0YPll
        DQ9ohagYHBzphI0rbYyX+8w=
X-Google-Smtp-Source: APXvYqzRsC3IsAU6XvdcZRvLUDUcmrYDfQGd/YHf/VIrCXcqly03qHQ4GQ6b2bnt15cAWOi15yeGEw==
X-Received: by 2002:a05:600c:2294:: with SMTP id 20mr15392010wmf.56.1554715352526;
        Mon, 08 Apr 2019 02:22:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id u17sm22671883wmu.36.2019.04.08.02.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 02:22:31 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 5/6] arm64: allwinner: h6: orangepi: Add PIO regulators
Date:   Mon,  8 Apr 2019 11:26:18 +0200
Message-Id: <20190408092619.23152-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408092619.23152-1-peron.clem@gmail.com>
References: <20190408092619.23152-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OrangePi One Plus and OrangePi Lite2 use the same PIO regulators.

Add this in the common device tree.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-orangepi.dtsi  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 62e27948a3fa..16280525fd5a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -70,6 +70,12 @@
 	status = "okay";
 };
 
+&pio {
+        vcc-pc-supply = <&reg_bldo2>;
+        vcc-pd-supply = <&reg_cldo1>;
+        vcc-pg-supply = <&reg_bldo3>;
+};
+
 &r_i2c {
 	status = "okay";
 
@@ -189,6 +195,17 @@
 	};
 };
 
+&r_pio {
+	/*
+	 * PL0 and PL1 are used for PMIC I2C
+	 * don't enable the pl-supply else
+	 * it will fail at boot
+	 *
+	 * vcc-pl-supply = <&reg_aldo1>;
+	 */
+        vcc-pm-supply = <&reg_bldo3>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.17.1

