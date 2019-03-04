Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D7FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838F32070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cb23GoF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCDI7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:59:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34649 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfCDI7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:59:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id i130so2622847pgd.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 00:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=erjr86oMLhdwQf8KWy1LxxMQVqAK5fko/hTjOOdELXM=;
        b=cb23GoF1rFTCR3NT0z1HHqUH3WdzZ/dCIhy6/WnT5dmwIgz35dDJsZOnHsPbszXzB1
         MypgQ9kGA4ucK/5Ha3Lt6JKyLrgSH02NaKXwZNRRokkET1u+qz+a0+jrGqWaNjpqYII1
         JItWci+qsRCshGdGqKc1S063Wq+RKB9LjGssGmn06sHUfrv3aN0O74xW1CZDTTXwc3tS
         7s/BO7Oz9+q4dIuYK1CC8JWCKMJ1mHBPcOSXkcyCy96uM+O82zswvdRSqBdg67IzsApd
         FHtybPvmneKWmuAFalmPbORSP0umz4WrbcOBpyM5effr5eEA7zdLZgm+MCHKMKPcntmo
         ljXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=erjr86oMLhdwQf8KWy1LxxMQVqAK5fko/hTjOOdELXM=;
        b=HHf35Vur4bGZjldLkV0j5ZCk2iw+vgOa/pqZfalq8OoXVHyAKo5n/vFNtkoscQQWiT
         lCtbVyzj3ZqCC6ZRhF/VOcLC6hJvA8XEjGHhS7keT581RphGWtpE/TaqP8E+JZDP0krH
         6i94EjK2g7DRW6f3bK+DuQGzTfpRAziaJNQ+Ojh8+dx4g3nvlFziayXPK45X6lExrsFQ
         Pogr0P5/OJ+HLt0Brnh0RPKhdW+0BISDfw8rDpxLEXla/lSW8SYBLSHMmv4s+9JUvZHM
         8lzKmdOjEozsu3UR/sBHca5hxb9lZUga9voufGAs+ikcVoS3QuaYhdDC1VVDUHSjQKr8
         QJ/g==
X-Gm-Message-State: APjAAAV/M9E4IZD7HIud+9m1BaU4V3W/HHWgWOXtZtanQelUcoLIo22b
        nDP6rsmjIDc2fc2LzA7BHOihpw==
X-Google-Smtp-Source: APXvYqwfH5XIzZ2A914lPKbkf3WzB4Dyc3t6aLlJu/hMS9Tv+cfevyAQePFD57izZ3DUXozVG1d24Q==
X-Received: by 2002:a17:902:b708:: with SMTP id d8mr18875488pls.322.1551689955316;
        Mon, 04 Mar 2019 00:59:15 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id k8sm7395523pgg.75.2019.03.04.00.59.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 00:59:14 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: serial: sprd: Add clocks and clocks-names properties
Date:   Mon,  4 Mar 2019 16:58:21 +0800
Message-Id: <5ab4cff84b36146cfcdbc0a341a46ac6d9a05dd2.1551689518.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1551689518.git.baolin.wang@linaro.org>
References: <cover.1551689518.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1551689518.git.baolin.wang@linaro.org>
References: <cover.1551689518.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lanqing Liu <lanqing.liu@unisoc.com>

This patch adds clocks and clocks-names properties, which are used to do
power management for our UART driver.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/serial/sprd-uart.txt       |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
index cab40f0..6eb5863 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
@@ -7,7 +7,13 @@ Required properties:
 
 - reg: offset and length of the register set for the device
 - interrupts: exactly one interrupt specifier
-- clocks: phandles to input clocks.
+- clock-names: Should contain following entries:
+  "enable" for UART module enable clock,
+  "uart" for UART clock,
+  "source" for UART source (parent) clock.
+- clocks: Should contain a clock specifier for each entry in clock-names.
+  UART clock and source clock are optional properties, but enable clock
+  is required.
 
 Example:
 	uart0: serial@0 {
@@ -15,5 +21,6 @@ Example:
 			     "sprd,sc9836-uart";
 		reg = <0x0 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&ext_26m>;
+		clock-names = "enable", "uart", "source";
+		clocks = <&clk_ap_apb_gates 9>, <&clk_uart0>, <&ext_26m>;
 	};
-- 
1.7.9.5

