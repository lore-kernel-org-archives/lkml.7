Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45903C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CDB233A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566572084;
	bh=nVeBZNDdilJlUk/CriahhLYe/f50mUXsyCrRoPUpQyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RqmBq4kjVdy9k5AuabLTFk32Wp/TN8oVv35Rcf4mPPiGGs3FgRSTKjLQunWCkhbl3
	 vJdWAF5vWWwH0GSzr4jEGCDeueFnBFKIMgyLEzBbbIgLx5YCZsJAdpOh/jKHWCo6M5
	 vXy8P3teqZDabVNfPbLeXw/tr/7N6Uny31VGNCLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395510AbfHWOym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395491AbfHWOyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:54:41 -0400
Received: from localhost.localdomain (unknown [194.230.147.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8A8523400;
        Fri, 23 Aug 2019 14:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566572080;
        bh=nVeBZNDdilJlUk/CriahhLYe/f50mUXsyCrRoPUpQyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BfbArEVnAyQ6lnHJXzSoXt7gke+8EuV7aJjBvjK7cEBM2nh2K4m6bvMf8Bk0nxh3r
         Ms3qyYmEeElU1dIgbdH1UwlmHjcYibe07HH1klEkV984hH0NKJyw5IZYbj1Hyk5swW
         Txkse5+2OEatK9E3vdMxjFH0nKhYd/veQtFn8kxY=
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
Subject: [RFC 4/9] dt-bindings: arm: samsung: Convert Exynos Chipid bindings to json-schema
Date:   Fri, 23 Aug 2019 16:53:51 +0200
Message-Id: <20190823145356.6341-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823145356.6341-1-krzk@kernel.org>
References: <20190823145356.6341-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung Exynos Chipid bindings to DT schema format using
json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/arm/samsung/exynos-chipid.txt    | 12 ----------
 .../bindings/arm/samsung/exynos-chipid.yaml   | 24 +++++++++++++++++++
 2 files changed, 24 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
deleted file mode 100644
index 85c5dfd4a720..000000000000
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-SAMSUNG Exynos SoCs Chipid driver.
-
-Required properties:
-- compatible : Should at least contain "samsung,exynos4210-chipid".
-
-- reg: offset and length of the register set
-
-Example:
-	chipid@10000000 {
-		compatible = "samsung,exynos4210-chipid";
-		reg = <0x10000000 0x100>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
new file mode 100644
index 000000000000..d22d5376a11e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/samsung/exynos-chipid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC series Chipid driver
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  compatible:
+    items:
+      - const: samsung,exynos4210-chipid
+  reg:
+    maxItems: 1
+
+examples:
+  - |
+    chipid@10000000 {
+      compatible = "samsung,exynos4210-chipid";
+      reg = <0x10000000 0x100>;
+    };
-- 
2.17.1

