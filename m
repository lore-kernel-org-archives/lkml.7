Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E283DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B731C21D7F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pCgUOiR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfJ0QXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 12:23:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43824 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfJ0QXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 12:23:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so7362610wrr.10;
        Sun, 27 Oct 2019 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GWbTlN2rWt2ied7AfeNCro8kNhdCw9BqWl6E/dShDHM=;
        b=pCgUOiR/1l5Uat1i9ODdivZgGrUR8Pa1WmVT+96e3Io7y6zNE8LiPpSLbneTIFPDpS
         RhL1RIlEFtXXqBNKZlHkkUOgflEhYPq2hMiZp+ko8yo5lADiImaWyuWsECR3uT6UDOhi
         tmPjdhrI3bX+bNcTc+oRxSCqEb45PFWrXjBu7TpDXbBarGEudlmDdfx2eLIlOUOcTNaA
         5NyA49hZ35RznaDd7fBTq2Y5Hmu2+oM8iIrc2NUO7VOzXrpq1bRx9b3aY60rW7mDSg+f
         ltmja1byUvCyRGdFdiBdixcM070kcvyClAfl/BkQyLcOWpm0voT5BOXIXtXLPvwzODmz
         Ed5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GWbTlN2rWt2ied7AfeNCro8kNhdCw9BqWl6E/dShDHM=;
        b=L9yxu5Obtnr3eNx+PMsDRxwaz3qqBO76HSX3fZRozrh9FYWoamGV+d8uB8r88vCBRy
         lUwWmwRucQ0go3BaFzZhi33DP3J8qFv6/R/AJlAFTPDyGMLh4iCwuB4D4Orhe9+JKkTJ
         t9nlitfPdtPQlqFTfuyRtd+ZHVauWinOW85685aCUuTWwrU5bCpZ7dEy7pFJRxi9XCYO
         qqcISSmr5gjDR9mE4IGVkd5nU3N/OZbuZMJ8kOfegaAWG2rP23i/r4oSo27LyGd81TIG
         VqzDDSidL5/n2KU+GZgKJZdf5NNtkKu2OOQKZM5NKYq47a/1XOTLYE1FnOYzzXS1ZyMQ
         pi8w==
X-Gm-Message-State: APjAAAXpcDffoX7cJiUGQtoEyRO6ZiHKF3ppuLx87xefEswUXqIkFNWt
        HILNZ05dm/wjk0r5jRnRXoU=
X-Google-Smtp-Source: APXvYqwiHWUOdqyOryfoxyoMSXW3biIYINgbbr5FI/oRW27dSCoa7yemhpwRw0z73LhgcDRjGmNbMg==
X-Received: by 2002:adf:e403:: with SMTP id g3mr11120841wrm.128.1572193421194;
        Sun, 27 Oct 2019 09:23:41 -0700 (PDT)
Received: from localhost.localdomain (p200300F133D01300428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33d0:1300:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id 1sm8243299wrr.16.2019.10.27.09.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 09:23:40 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/5] dt-bindings: clock: add the Amlogic Meson8 DDR clock controller binding
Date:   Sun, 27 Oct 2019 17:23:24 +0100
Message-Id: <20191027162328.1177402-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027162328.1177402-1-martin.blumenstingl@googlemail.com>
References: <20191027162328.1177402-1-martin.blumenstingl@googlemail.com>
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
2.23.0

