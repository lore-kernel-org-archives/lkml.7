Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9699BC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EE32173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUwiyaIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbfHHIm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:42:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50668 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHIm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:42:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so1545778wml.0;
        Thu, 08 Aug 2019 01:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o0gY6GIOGxAdAcOqxh/7txJTZ7y4Fp96qJrFWzmJvJs=;
        b=RUwiyaImbBGQoy18xa2BhqGI8xsDFamrbahqE96VfeFA6VE0a+pYf+hMqnuX0AZhmo
         Z+mJc+SlQn5ApVviiHsgsXmnDePZl0YFD0+TWX2vDF/RUl2FiIq6m2KsXrM1v1C48xmJ
         7nN6hfG9Sbn4S4s2FztFp25RDmu+C91Jv9V6VjynVMBYlaIypgm3v9xzgqJD/XOftZpj
         Zg9jkrI1j2cnfDSgNsF/lHXvEW7hgX0WfokMqFvil8cKK9kyV4VWlV0o4m4J4Zj8OfVi
         nhdoe7sl2TURQXr2WEzaXbScdo97ImFTTpXg5AfS0d60/mGaaYnDFL10jlkslAIjTZFK
         lg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o0gY6GIOGxAdAcOqxh/7txJTZ7y4Fp96qJrFWzmJvJs=;
        b=QGsHu+NSfXTBdUonyHAi+iP53h4sJAWo0KzHiqwn7+5LuSoTga181bu6tnSkPrC4eE
         HsLsvMoWHXND5zz1FnfNcjYNeNjup/D2kZvQCA9aWtKbeij1w+rDanmALnbH7RHx0J/v
         TsZoPyTumtzjvUDdQCqOG+gZyA4u4TcKw6m2EvVpfWIVXqG5FY6xo8D7CUwGTqbsU6fj
         ZAEzFJAjkTTVmuEb/Dr2iMeXzCmCpwkKQsXzZB8HdXrEOaSWDo57kMHPQ8lXbziLkIr7
         iuyo0+tmfr2wHWoiyRdsP6U536j3wuLtkVcJ3mTITzsU86oFddQmx13x/zhAtHS6mteI
         ZZaw==
X-Gm-Message-State: APjAAAVlqEEUKzXxpLHNAsscMq9GONnRcGewvpim/SeWHZ7J9iIradRS
        sZvM8WuCWJMY5CB4vi5idmWN6Kko
X-Google-Smtp-Source: APXvYqwlO+R71FW8BynOKwYku3Wp9gYOHeIIBZF6I/QjRTsEvLX/UseL7h//+kMmc+MbDlaAx5ji/g==
X-Received: by 2002:a7b:c383:: with SMTP id s3mr2992226wmj.44.1565253776712;
        Thu, 08 Aug 2019 01:42:56 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id c1sm2059259wmc.40.2019.08.08.01.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 01:42:56 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] ARM64: dts: allwinner: Add devicetree for pine H64 modelA evaluation board
Date:   Thu,  8 Aug 2019 10:42:53 +0200
Message-Id: <20190808084253.10573-1-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the evaluation variant of the model A of the PineH64.
The model A has the same size of the pine64 and has a PCIE slot.

The only devicetree difference with current pineH64, is the PHY
regulator.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../sun50i-h6-pine-h64-modelA-eval.dts        | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index f6db0611cb85..9a02166cbf72 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -25,3 +25,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-3.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-lite2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-modelA-eval.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
new file mode 100644
index 000000000000..d8ff02747efe
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2019 Corentin Labbe <clabbe.montjoie@gmail.com>
+ */
+
+#include "sun50i-h6-pine-h64.dts"
+
+/ {
+	model = "Pine H64 model A evaluation board";
+	compatible = "pine64,pine-h64-modelA-eval", "allwinner,sun50i-h6";
+
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+};
+
+&emac {
+	phy-supply = <&reg_gmac_3v3>;
+};
-- 
2.21.0

