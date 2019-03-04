Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A57C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F43206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gi58neNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbfCDK6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:58:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45367 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfCDK6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:58:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id w17so5004369wrn.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 02:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+NgtwWtuC29F27eufSWdAd18iEdNfLM9/qUuy/ZRY+Q=;
        b=gi58neNLjfxzF9XN+uzR4rq2lPrTk2SI5aE8CnL2oHd2yYAKhYxyAN/+fDNAwoNBt4
         6Rm5JX1eGhyrMa16km98QA3koKGeB86cVPVsVYrifXheCck9lOkIdwOKIq0eY4T6qfpQ
         NNBmgozURb86hM9myyU17vwAzsXAtPNM8/VrB9aTSuPhOZYo3PtdGWAfTyPBsrwhxobv
         7fbXGNnLj0weAuOM+ojln3QPWB0Y1K/fg7yUTow9+Vki1eoq0z2iNjThep5xVdYSkWYg
         no9l3W/52e9oSnUAgVldCYwpYZqa699mGZasVLezlj95iOLnXKeTKAoKyHDqTf4SDi1z
         60oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+NgtwWtuC29F27eufSWdAd18iEdNfLM9/qUuy/ZRY+Q=;
        b=fy5wGWwich0IrU09tNYHbM27cXP2oQE93M59vVZyJRaqCoJoIUChyjAI+3meQ7ilca
         Xm7hIcXqw44MiDzvgZ4aELZYlB//k+gfSWT4ExezfyZO6iZlY+MNN10eGSfW3cQiQBnv
         fUn10+cLpfSXH8VNTB1Xn7jBCuqXKik4EphsbckzJb8+MlSVKo5fkJOdHWMvpEaGe1p0
         hjLwZq7AQlotbyOErOv0C8fcOrhKxThhpdmKLzX3bEAQR0pwXj7oEgYy5XiT3nu/NgoR
         knLuebLYzeoI0B4Tg1RY7eNaxfWhmFf8cWz/qBgpAIAEcLSwxTEeH77Tw+mZfqsrjN34
         YFWg==
X-Gm-Message-State: APjAAAW3Wk/pasm8PagQ7fj8BCA9rg7esL+1nxyoA94l98PQhVm1DEIP
        RHtgZAIEzExMe1Zfu9TrAEDCKA==
X-Google-Smtp-Source: APXvYqyIcdlK+lbLVNxV+ui8IL2XFxXNxLlfDqWCiJA4vYjfpaXkaVv13IkojX1pngcBKDpC63P1xw==
X-Received: by 2002:adf:9e47:: with SMTP id v7mr12658314wre.190.1551697084774;
        Mon, 04 Mar 2019 02:58:04 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w4sm8038165wrk.85.2019.03.04.02.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 02:58:04 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] dt-bindings: gpu: add bindings for the ARM Mali Bifrost GPU
Date:   Mon,  4 Mar 2019 11:58:02 +0100
Message-Id: <20190304105802.6010-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the bindings for the Bifrost family of ARM Mali GPUs.

The Bifrost GPU architecture is similar to the Midgard family,
but with a different Shader Core & Execution Engine structures.

Bindings are based on the Midgard family bindings, but the inner
architectural changes makes it a separate family needing separate
bindings.

The Bifrost GPUs are present in a number of recent SoCs, like the
Amlogic G12A Family, and many other vendors.
The Amlogic vendor specific compatible is added to handle the
specific IP integration differences and dependencies.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/gpu/arm,mali-bifrost.txt         | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt

Changes since v2:
- moved to a single compatible since HW is fully discoverable

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
new file mode 100644
index 000000000000..e068fccf4ce9
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
@@ -0,0 +1,90 @@
+ARM Mali Bifrost GPU
+====================
+
+Required properties:
+
+- compatible :
+  * Must contain one the following:
+    + "arm,mali-bifrost"
+  * which must be preceded by one of the following vendor specifics:
+    + "amlogic,meson-g12a-mali"
+
+- reg : Physical base address of the device and length of the register area.
+
+- interrupts : Contains the three IRQ lines required by Mali Bifrost devices.
+
+- interrupt-names : Contains the names of IRQ resources in the order they were
+  provided in the interrupts property. Must contain: "job", "mmu", "gpu".
+
+Optional properties:
+
+- clocks : Phandle to clock for the Mali Bifrost device.
+
+- mali-supply : Phandle to regulator for the Mali device. Refer to
+  Documentation/devicetree/bindings/regulator/regulator.txt for details.
+
+- operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
+  for details.
+
+- resets : Phandle of the GPU reset line.
+
+Vendor-specific bindings
+------------------------
+
+The Mali GPU is integrated very differently from one SoC to
+another. In order to accomodate those differences, you have the option
+to specify one more vendor-specific compatible, among:
+
+- "amlogic,meson-g12a-mali"
+  Required properties:
+  - resets : Should contain phandles of :
+    + GPU reset line
+    + GPU APB glue reset line
+
+Example for a Mali-G31:
+
+gpu@ffa30000 {
+	compatible = "amlogic,meson-g12a-mali", "arm,mali-bifrost";
+	reg = <0xffe40000 0x10000>;
+	interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "job", "mmu", "gpu";
+	clocks = <&clk CLKID_MALI>;
+	mali-supply = <&vdd_gpu>;
+	operating-points-v2 = <&gpu_opp_table>;
+	resets = <&reset RESET_DVALIN_CAPB3>, <&reset RESET_DVALIN>;
+};
+
+gpu_opp_table: opp_table0 {
+	compatible = "operating-points-v2";
+
+	opp@533000000 {
+		opp-hz = /bits/ 64 <533000000>;
+		opp-microvolt = <1250000>;
+	};
+	opp@450000000 {
+		opp-hz = /bits/ 64 <450000000>;
+		opp-microvolt = <1150000>;
+	};
+	opp@400000000 {
+		opp-hz = /bits/ 64 <400000000>;
+		opp-microvolt = <1125000>;
+	};
+	opp@350000000 {
+		opp-hz = /bits/ 64 <350000000>;
+		opp-microvolt = <1075000>;
+	};
+	opp@266000000 {
+		opp-hz = /bits/ 64 <266000000>;
+		opp-microvolt = <1025000>;
+	};
+	opp@160000000 {
+		opp-hz = /bits/ 64 <160000000>;
+		opp-microvolt = <925000>;
+	};
+	opp@100000000 {
+		opp-hz = /bits/ 64 <100000000>;
+		opp-microvolt = <912500>;
+	};
+};
-- 
2.20.1

