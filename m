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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1915C43215
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871BA20740
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EVVkWJcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfKQOHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 09:07:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35423 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfKQOHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 09:07:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id s5so16399724wrw.2;
        Sun, 17 Nov 2019 06:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tiyYxTb8Rk/mH72C96BXIjZ0994JQE265VRKbdZ6Y4s=;
        b=EVVkWJcFjAUrdne3BkCeB4MZ1JQmeLwk168bJwNqsL7WjU+GOUeD6/qGmmqltNv+pb
         +gB2wG9KbzlzWwFQb6WRV5ac1d950G8wG6UGLncopSi6JOof9v6RfpFc0wxZH4iTi3pG
         1Y32KlJ11z3OQLFduc78NnjwMiekx/m50BD56AMK3tNx+wbX2jtzBk8TTBjjTWJF9W4P
         3WqUeWOeQIT+YSDKFtwsofghZyWxQoILvQZFMJBXG2WEx73NVvCClFJCZsn0pGz0IYCy
         k1SY9jXB/xKS75alrQvK7A1SB52LgIwKMwMbF3Us0axjaE9ZLGjR83DS8AmZhZGK6Kea
         Y6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tiyYxTb8Rk/mH72C96BXIjZ0994JQE265VRKbdZ6Y4s=;
        b=QRf4HuJOyLcw0xEvHPcUPs8MfHED9dZb94lYFij5gSPOorHFSRgA66/P4h13zWZkSZ
         CqWArmBPoBOW/WTUz+hdnJfIydwUh9HiO3o3TUw1SdnBI9DFo3oQo7oTsMrAXUir9R5g
         dY/MBiS+c/C0l/l1jL9L+hsVL0Y8pW0d0K5X4+lpO8eizXgJv/wPG5tCFlG97ymkqOtQ
         Ea9P7rn9uVLvzCUB1BdybJI01LcQRiGfVnGuser9AGHY8TqDOWcAuKfQK9SwG1mD95xm
         nAu3JZqj/OXnN5Nf9mbbpNX8Mv1EZpGsjhT2aKWvXqPoNrjQsEe0r+Api2SAVG7Ezwac
         ywqg==
X-Gm-Message-State: APjAAAXNO5VaFs4KN5Z2C9wViIDAJKGEPGJQXbRr4iqwPTgFB4qmgJHk
        w18YvEDdWap3CMHEvIt9zjc=
X-Google-Smtp-Source: APXvYqzMq+83TkjxUSM11kZkx3mF/4DvBV0+2sGks49oMiHitp16MlZiefH8kui2kfgFepTTKQYiCA==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr25727213wrv.247.1573999661231;
        Sun, 17 Nov 2019 06:07:41 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id n23sm16632977wmc.18.2019.11.17.06.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 06:07:40 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: clock: add the Amlogic Meson8 DDR clock controller binding
Date:   Sun, 17 Nov 2019 15:07:30 +0100
Message-Id: <20191117140731.137378-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191117140731.137378-1-martin.blumenstingl@googlemail.com>
References: <20191117140731.137378-1-martin.blumenstingl@googlemail.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../clock/amlogic,meson8-ddr-clkc.yaml        | 50 +++++++++++++++++++
 include/dt-bindings/clock/meson8-ddr-clkc.h   |  4 ++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,meson8-ddr-clkc.yaml
 create mode 100644 include/dt-bindings/clock/meson8-ddr-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,meson8-ddr-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,meson8-ddr-clkc.yaml
new file mode 100644
index 000000000000..4b8669f870ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,meson8-ddr-clkc.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
2.24.0

