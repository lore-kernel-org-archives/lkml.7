Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A545C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369CC2183F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VHaXfJdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbfDAIJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:09:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39959 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfDAIJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:09:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so10652839wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 01:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7SXBcrbS9KCRcmuyNW9EJ6Y/KM3pAhmpFZqWRrW2iFw=;
        b=VHaXfJdgPTsOnM1UbH5jS4lTRwYYbolGe35KFdhENyQEndBiUexYY/kWQdjMLU2cb2
         IL9bGCajRMztzwb1zWL+VlwFhpXiOc8is6PdScLU7r5noAJoFVa85OTvcAZ/8KXarb6g
         /Gxz6mJ3PTWEkgRDO8hgpn96IGhzcEzHmU2LSMPb0ZWN/dWGEhyskhaJPhxHbsabfaNV
         YzKxUQUbgQM56La83RkeX5hHz+ANS1C9irJAZZVtNmEZ61Jb4U9lRAMWPBlOaIPMgCpo
         /VDu68Z8n6Z5eNALeb2rjzcFl3aSN88X5cmXIs4QtvL8Qx7I3Nv2zpFmE5LhmI3mpzKB
         V+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7SXBcrbS9KCRcmuyNW9EJ6Y/KM3pAhmpFZqWRrW2iFw=;
        b=jdDzZcoNMu7fX7wYeRXETKUc+W4TGrJxrEVSPZ2r7eYQKUy/X6/Y0srj9kEE4Fzy8D
         8fpTo1jbc0pWJ+g2Ex6Ll00zpS2q6qGZWYreV6hXKqfPd/RjAdjzZsv5Ts2UN3+j2DO9
         l0eSRMCAJ1a944LECr3K7SVQRv2ylozEXdMsJCvOVJRFj/XZ3MefJilNRDx34yWmsF2B
         5AqZUB00rwXxnImAsvOrMc787prV/NGp+rFzCYnACwgCsjuAn383fC69FiqWwlqhod8U
         YdBhxUP3IV5CiwBQb2OBwNQxE+eZKt5cgc2SC+At5Nwd9Dol69C75ScL4OtmT4EbPlW/
         gk0Q==
X-Gm-Message-State: APjAAAWJzX0n1kuIjsKIDg9l+aLpK+FGm5dtqahjUIaTBlMsswRj9jQc
        rGeUD6O+5KhIqTFtgsgzfQrEXg==
X-Google-Smtp-Source: APXvYqwQyleX7O0FOgoViolZnE2qVnOQr5PewF+5/G9ufSEn70h6UdJ0gkdPEuCMBzfDanFKY/tjTQ==
X-Received: by 2002:a05:6000:1209:: with SMTP id e9mr20354796wrx.35.1554106194688;
        Mon, 01 Apr 2019 01:09:54 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id p6sm2032350wrs.6.2019.04.01.01.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Apr 2019 01:09:54 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, robh@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4] dt-bindings: gpu: add bindings for the ARM Mali Bifrost GPU
Date:   Mon,  1 Apr 2019 10:09:49 +0200
Message-Id: <20190401080949.14550-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
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
 .../bindings/gpu/arm,mali-bifrost.txt         | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt

Changes since v3:
- Added note about discoverable model/revision
- Enforced fixed defined irq order
- Fixed typo in accommodate

Changes since v2:
- moved to a single compatible since HW is fully discoverable

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
new file mode 100644
index 000000000000..711c9ead17a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
@@ -0,0 +1,92 @@
+ARM Mali Bifrost GPU
+====================
+
+Required properties:
+
+- compatible :
+  * Since Mali Bifrost GPU model/revision if fully discoverable by reading
+    some determined registers, must contain the following:
+    + "arm,mali-bifrost"
+  * which must be preceded by one of the following vendor specifics:
+    + "amlogic,meson-g12a-mali"
+
+- reg : Physical base address of the device and length of the register area.
+
+- interrupts : Contains the three IRQ lines required by Mali Bifrost devices,
+  in the following defined order.
+
+- interrupt-names : Contains the names of IRQ resources in this exact defined
+  order: "job", "mmu", "gpu".
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
+another. In order to accommodate those differences, you have the option
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
2.21.0

