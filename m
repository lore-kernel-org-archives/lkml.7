Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBFCC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A7920672
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vTb5m9+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKNPrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:47:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50664 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfKNPro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:47:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id l17so6178005wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 07:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4wo8zGUvhFjwqDku4wCv5Ttt+MaXXuVDd4WBIo+uQ0g=;
        b=vTb5m9+WaTOE3iBR11VUP1HOuDyLJJ4anFAIcbYrl9gsMDJmtO5LsTgjIcmmzCVOX3
         mmJFbxltKy6H5678MrC572cNRSmTUuoE5sN6ELk7jEEUgCq4IdwLHnUt5eg7M8NofQZ/
         lOE3yR9QAVgaLeeCzW5R08UjHNuvSFEGDuQGB7KT3VnSHuVqBRfrn3sjk2yxwaALzwoY
         Z6MJEszjxjgAod3LNNRN0dZ5W7kaxRJXvI4nfRM+aYkXvPBG287T2ZMZawmx0kFv+X3G
         7EfYFK3UpierUlO6tcUrjUQ7dvK/sDO7lu3Hp96o6FKJi0DZl4zMkFm0pCuFRC01UCPA
         /BcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4wo8zGUvhFjwqDku4wCv5Ttt+MaXXuVDd4WBIo+uQ0g=;
        b=XgS+QhUikqhdbn/e/cYin/47rw2uWHZtumENmcDgmR/Op/yT+EhyOY5hWObOLMPp3E
         k4CpKinN+4MXyVZPjyrz1zFp+rjcz1USFuS07Yop3N/o0PJViMAG0JjluXYJ8UvlBwNk
         1u2xjg9S47f5+CAIKQsKgosNCdtc/CN+aMgT3mpdh/8rYJml1cE0EXRi+k910O4a0JUv
         39M2MxzZwKStwVMHoaYd0BmXoqALhE9uYQcC8nFItERxu4zCZzkkwCLtSzW4EaPavD8V
         adIKdaCRyOoniNb1ei1GDGV4MJl6wBFTQSvvwLd4UV5qF23bsn6OLaeSyEvQrHh5hs6E
         2ycQ==
X-Gm-Message-State: APjAAAWinpKK38IhidxdZmNbJaMD9F2AzJkOVRq1E/ue7GLpAa9Qnkta
        XSmzaoGDK6K8IQj+56qEhUAhiQ==
X-Google-Smtp-Source: APXvYqzJh07JEnxYOEI4mYx1Z1ivxmp/MoUyRRmyw3wJuJusYUN5a6zAe5JPqYIKsp/B7oBTJMaLDg==
X-Received: by 2002:a05:600c:506:: with SMTP id i6mr8873908wmc.153.1573746461977;
        Thu, 14 Nov 2019 07:47:41 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l4sm6428629wml.33.2019.11.14.07.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Nov 2019 07:47:41 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 2/2] ARM64: dts: allwinner: add pineh64 model B
Date:   Thu, 14 Nov 2019 15:47:33 +0000
Message-Id: <1573746453-5123-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573746453-5123-1-git-send-email-clabbe@baylibre.com>
References: <1573746453-5123-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the model B of the PineH64.
The model B is smaller than the pine64 model A and has no PCIE slot.

The only devicetree difference with the pineH64 model A, is the PHY
regulator and the HDMI connector node.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../devicetree/bindings/arm/sunxi.yaml        |  5 +++++
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../allwinner/sun50i-h6-pine-h64-model-b.dts  | 21 +++++++++++++++++++
 3 files changed, 27 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index a02baa374adc..3e3e74cfa3c3 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -604,6 +604,11 @@ properties:
           - const: pine64,pine-h64
           - const: allwinner,sun50i-h6
 
+      - description: Pine64 PineH64 model B
+        items:
+          - const: pine64,pine-h64-model-b
+          - const: allwinner,sun50i-h6
+
       - description: Pine64 LTS
         items:
           - const: pine64,pine64-lts
diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index d2418021768b..62bc43f187bf 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -26,4 +26,5 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-3.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-lite2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
new file mode 100644
index 000000000000..f4c8966a6497
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2019 Corentin LABBE <clabbe@baylibre.com>
+ */
+
+#include "sun50i-h6-pine-h64.dts"
+
+/ {
+	model = "Pine H64 model B";
+	compatible = "pine64,pine-h64-model-b", "allwinner,sun50i-h6";
+
+	/delete-node/ reg_gmac_3v3;
+};
+
+&hdmi_connector {
+	/delete-property/ ddc-en-gpios;
+};
+
+&emac {
+	phy-supply = <&reg_aldo2>;
+};
-- 
2.23.0

