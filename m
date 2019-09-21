Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7DCC4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EC3208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AwdZfkWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438133AbfIUPSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 11:18:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40395 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392043AbfIUPSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 11:18:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id l3so9591654wru.7;
        Sat, 21 Sep 2019 08:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0VvVyYbylhhn27lwnpj3kEDmecswF/DtGt6I7xL1THE=;
        b=AwdZfkWa2Zgunj0RMms1Csk0t/Bg4v/uFPqVU7GERZOhx5a+rh7P2KefE2ys3mgPqu
         8sp95P0w1G334sr3PxEdxmIvH2QCvBrTN8aHPLl2ln2VNjMp6QF5U41qAzgt07Vt3jNK
         etQuibrNO5D+4kjr6tb1quq6zE7UmuiM+whDQ0Pt/ca8TCmboJA/I8j3/SW2Rd1eHr5v
         Bt+60xkXfqkCmntTrq5oeWVgY5ZLULnV9aLK4uBFGEQAh9bMJLtL+wlSnXiPM1WCpoU/
         JDdwt0avJHJ+mwWhE5P5hFn29PnNssxuJtf25y/JaSPcy2boWyrnXBP8saOOd30Vdqz+
         NHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0VvVyYbylhhn27lwnpj3kEDmecswF/DtGt6I7xL1THE=;
        b=Q4Ei4hDgrQluqeCKdGK/ey8uA0hLUurNL6Zy4kAkpFUWoIOaKDvh7vsTiLKkLe+uYX
         FSnaiMh045EQBs3fAiIAukUfKNDHJtKSZRhIoTMeK1jsJjvaop3fT3s/JqV+3XzT3emP
         jbyncNQl3dTOvZsnBZro1zZLJuriC0DxUINGCwl0ZlT0Tj9UhvXIT012+br8C7IW+/Zc
         KivgCN7ZPbrF3QvG1cgoMXZpDZ/4CX/EbPLp4L49zo4baPoleg9IL8QItKzZXa2kWEGb
         jSeZqVVXvcbNrU5PvXsBEq+ZfpX9oLn+fV8LMGn1ClNgI90CxKJ9/w4IWfv5xm16EIx3
         /evg==
X-Gm-Message-State: APjAAAX8UPF4Dx0AkWNTv5Sn+5i06RX2A3D2hciWyU1DRdr8OvrdckGc
        3NEPiBW5zoaXrNderoxkkbo=
X-Google-Smtp-Source: APXvYqzjLsxL6Hb5gWpypNfZmMuuKIqU6e8iKaQeFtNzeVg/UC9EEacsUopb1O4+mKK7gli1ftsl7g==
X-Received: by 2002:a5d:6885:: with SMTP id h5mr16181417wru.92.1569079128474;
        Sat, 21 Sep 2019 08:18:48 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133CE0B0028BAA8C744A6F562.dip0.t-ipconnect.de. [2003:f1:33ce:b00:28ba:a8c7:44a6:f562])
        by smtp.googlemail.com with ESMTPSA id c6sm6003120wrb.60.2019.09.21.08.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 08:18:47 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/6] dt-bindings: clock: add the Amlogic Meson8 DDR clock controller binding
Date:   Sat, 21 Sep 2019 17:18:30 +0200
Message-Id: <20190921151835.770263-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190921151835.770263-1-martin.blumenstingl@googlemail.com>
References: <20190921151835.770263-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic Meson8, Meson8b and Meson8m2 SoCs have a DDR clock controller in
the MMCBUS registers. There is no public documentation on this, but the
GPL u-boot sources from the Amlogic BSP show that:
- it uses the same XTAL input as the main clock controller
- it contains a PLL which seems to be implemented just like the other
  PLLs in this SoC
- there is a power-of-two PLL post-divider

Add the documentation and header file for this DDR clock controller.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../clock/amlogic,meson8-ddr-clkc.yaml        | 50 +++++++++++++++++++
 include/dt-bindings/clock/meson8-ddr-clkc.h   |  4 ++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,meson8-ddr-clkc.yaml
 create mode 100644 include/dt-bindings/clock/meson8-ddr-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,meson8-ddr-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,meson8-ddr-clkc.yaml
new file mode 100644
index 000000000000..bf3ca5888485
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,meson8-ddr-clkc.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,meson8-ddr-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic DDR Clock Controller Device Tree Bindings
+
+maintainers:
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson8-ddr-clkc
+      - amlogic,meson8b-ddr-clkc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: xtal
+
+  "#clock-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    ddr_clkc: clock-controller@400 {
+      compatible = "amlogic,meson8-ddr-clkc";
+      reg = <0x400 0x20>;
+      clocks = <&xtal>;
+      clock-names = "xtal";
+      #clock-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/meson8-ddr-clkc.h b/include/dt-bindings/clock/meson8-ddr-clkc.h
new file mode 100644
index 000000000000..a8e0fa2987ab
--- /dev/null
+++ b/include/dt-bindings/clock/meson8-ddr-clkc.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define DDR_CLKID_DDR_PLL_DCO			0
+#define DDR_CLKID_DDR_PLL			1
-- 
2.23.0

