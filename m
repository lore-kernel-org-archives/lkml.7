Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3FCC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C230B22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566572093;
	bh=j4MBXQfXeRt5HrbT58rdgLpG2/WPrTHwL01G7iEVZkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lnyexWhL08A98KO40ErX7HABUsS5UK4B6bMRtx/kpatbliBvSV6mC1gOtaqLldhH3
	 4sYZxlOxtRNydBOsfqLpMYZvuKxNlnyPP1KGDY3lWeqhHQxi7XSL96lV9ttr9TdkQt
	 1Ow9wfLnYcYwBw7E98H+OK3sXTz8P9ryeSrElPNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395541AbfHWOyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395526AbfHWOyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:54:51 -0400
Received: from localhost.localdomain (unknown [194.230.147.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E02E2341E;
        Fri, 23 Aug 2019 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566572089;
        bh=j4MBXQfXeRt5HrbT58rdgLpG2/WPrTHwL01G7iEVZkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0gZqf4+dLAoMLg+ZAh+iQql6ipE1NcuXTc8lwvECckA9wf2/BLCNhxEiuS3dKzf+d
         mjguR/uZN2moAHEwpe7dQJGZhB1Hkusqo0tiDTtZ+vBXBtHrLrk6HH4DCkIsKf2dXx
         2CmlahHN67ZS1jXgk1Csi5f1D8EIKnfnPgKG4+5o=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     notify@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: [RFC 6/9] dt-bindings: arm: samsung: Convert Exynos System Registers bindings to json-schema
Date:   Fri, 23 Aug 2019 16:53:53 +0200
Message-Id: <20190823145356.6341-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823145356.6341-1-krzk@kernel.org>
References: <20190823145356.6341-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung Exynos System Registers (SYSREG) bindings to DT schema
format using json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Example somehow fails:
Documentation/devicetree/bindings/arm/samsung/pmu.example.dt.yaml:
system-controller@10040000: compatible:0: 'samsung,exynos5250-pmu' is
not one of ['samsung,exynos4-sysreg', 'samsung,exynos5-sysreg']

It seems that PMU schema is applied to sysreq nodes (and vice-versa).
---
 .../bindings/arm/samsung/sysreg.txt           | 19 -----------
 .../bindings/arm/samsung/sysreg.yaml          | 33 +++++++++++++++++++
 2 files changed, 33 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/samsung/sysreg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/sysreg.yaml

diff --git a/Documentation/devicetree/bindings/arm/samsung/sysreg.txt b/Documentation/devicetree/bindings/arm/samsung/sysreg.txt
deleted file mode 100644
index 4fced6e9d5e4..000000000000
--- a/Documentation/devicetree/bindings/arm/samsung/sysreg.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-SAMSUNG S5P/Exynos SoC series System Registers (SYSREG)
-
-Properties:
- - compatible : should contain two values. First value must be one from following list:
-		- "samsung,exynos4-sysreg" - for Exynos4 based SoCs,
-		- "samsung,exynos5-sysreg" - for Exynos5 based SoCs.
-		second value must be always "syscon".
- - reg : offset and length of the register set.
-
-Example:
-	syscon@10010000 {
-		compatible = "samsung,exynos4-sysreg", "syscon";
-		reg = <0x10010000 0x400>;
-	};
-
-	syscon@10050000 {
-		compatible = "samsung,exynos5-sysreg", "syscon";
-		reg = <0x10050000 0x5000>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/samsung/sysreg.yaml b/Documentation/devicetree/bindings/arm/samsung/sysreg.yaml
new file mode 100644
index 000000000000..a3d44646e441
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/sysreg.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/samsung/sysreg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S5P/Exynos SoC series System Registers (SYSREG)
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - samsung,exynos4-sysreg
+          - samsung,exynos5-sysreg
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+examples:
+  - |
+    syscon@10010000 {
+      compatible = "samsung,exynos4-sysreg", "syscon";
+      reg = <0x10010000 0x400>;
+    };
+
+    syscon@10050000 {
+      compatible = "samsung,exynos5-sysreg", "syscon";
+      reg = <0x10050000 0x5000>;
+    };
-- 
2.17.1

