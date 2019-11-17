Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74431C43141
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B0F2075C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sgCJr1rc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfKQO1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 09:27:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39750 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfKQO1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 09:27:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id l7so16399033wrp.6;
        Sun, 17 Nov 2019 06:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vHGYzBidRsQQsL3jCB4yF0aDNoupkTyw//nzq4YR9EQ=;
        b=sgCJr1rcICGBo7VwcWQVMH3ZCmoLywXz34QtHHcaYNgbyPluxyDvivoxcI+xtRvFG1
         tk9HTwb8NRNlN4c6Oxl5Nw79vmPJj43MlQtXQwomespiRZk4pwoGCOyqNhb9oCQmOYEZ
         IBksKpVJaIAdcEgGQHCxMF1IDv+kxqMC1dOeKVTJrmyfP+hvRReITPdfjqcMnNBIWzVC
         pcv44mpsuW7NB3o4KhdVmXW6ZdfeIcEmztEHmdh4Ps2C58Y8mcB2Xv6Rm0/iRIadyZgU
         HRmHrLlQW1yhUcxZGd95eCBA/hISbP4ZxWoZS5K3Zn0UII5kiRsN6OrwILac57tD6TFn
         VvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vHGYzBidRsQQsL3jCB4yF0aDNoupkTyw//nzq4YR9EQ=;
        b=Qln0p9HekH7TZxD9CGbrUqwCldp103nk0EVEUjmVkWYyO7mi75DgrBEXSeNoOWbqgg
         XVnfse+o2+snrnl1tB6vx+evUbVMouFLv4ZwmIRjR/eWcMqMoFC2oixKx7bpCDctnZ48
         m8l/LVH5xY4WHsxvWNaJ7ItlTWPkKjzoce1uuzVTXi4Mhr4jRI2/s4QiCsp/6jE2fdAa
         tNrmJdap2/nZqhWgQkPGkQaC9Cwfv0HvqIJi+qeSgHFBdDP+oFU7SUHAOB7uAxJGfobU
         chCede5dDhjTaOVNkxJLYqU3WC8s3RJPIqHP4Buvip8BVUTHMsTENCwOv/pA6A50BdRI
         ITOA==
X-Gm-Message-State: APjAAAVIEa6NKRMUst70mFsbRuZvrS7wRNK3rueTpOZSi/1q001mnUTT
        pnfSos/GpBjEPnf8H4zfSPM=
X-Google-Smtp-Source: APXvYqwT18GZmJpvpNeh2iFJtU1+2xOuk86H/DHrSS1Qn4jh1cZ92rwqjud9yjUSqJNcKjkY/fhSSQ==
X-Received: by 2002:adf:ef42:: with SMTP id c2mr7133152wrp.89.1574000849794;
        Sun, 17 Nov 2019 06:27:29 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id y6sm19298404wrw.6.2019.11.17.06.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 06:27:29 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org
Cc:     jianxin.pan@amlogic.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, yinxin_1989@aliyun.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/2] dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
Date:   Sun, 17 Nov 2019 15:27:15 +0100
Message-Id: <20191117142716.154764-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191117142716.154764-1-martin.blumenstingl@googlemail.com>
References: <20191117142716.154764-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents the devicetree bindings for the SDHC MMC host controller
found in Meson6, Meson8, Meson8b and Meson8m2 SoCs. It can use a
bus-width of 1/4/8-bit and it supports eMMC spec 4.4x/4.5x including
HS200 mode (up to 100MHz clock).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
new file mode 100644
index 000000000000..862aedba680f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/amlogic,meson-mx-sdhc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson SDHC controller Device Tree Bindings
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+maintainers:
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+description: |
+  The SDHC MMC host controller on Amlogic SoCs provides an eMMC and MMC
+  card interface with 1/4/8-bit bus width.
+  It supports eMMC spec 4.4x/4.5x including HS200 (up to 100MHz clock).
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - amlogic,meson8-sdhc
+        - amlogic,meson8b-sdhc
+        - amlogic,meson8m2-sdhc
+      - const: amlogic,meson-mx-sdhc
+
+  reg:
+    minItems: 1
+
+  interrupts:
+    minItems: 1
+
+  clocks:
+    minItems: 5
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: clkin0
+      - const: clkin1
+      - const: clkin2
+      - const: clkin3
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mmc@8e00 {
+      compatible = "amlogic,meson8-sdhc", "amlogic,meson-mx-sdhc";
+      reg = <0x8e00 0x42>;
+      interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>;
+      clocks = <&sdhc_pclk>, <&xtal>, <&fclk_div4>, <&fclk_div3>, <&fclk_div5>;
+      clock-names = "pclk", "clkin0", "clkin1", "clkin2", "clkin3";
+    };
-- 
2.24.0

