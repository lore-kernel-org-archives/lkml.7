Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5607C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F4321920
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VdmoyV2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389134AbfIENAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:00:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33872 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389617AbfIENAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:00:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so4949332wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 06:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Fy7M7fhIwMYXWwgYxjk3dKvxE3VtX41dFWW4vYeizE=;
        b=VdmoyV2GFf68u5cOuuZJp+zO4JtRHb6ufNYTVBiqOEosYCBvyoAQCseEtKiVMloE/j
         kU/3nIpPNHq7hbBEod+k9kr6y6z/rQI7QXP4n0L8QDNPcxPD++o4u6/YI3bCSUnOEPmn
         rKQWXhwE4On6LNa0ZAi4r8iOHA5VRFOaSUMtbss/lao9+ZkBSyDAGeP0DLEYPH2JgnF0
         Pm7o5EjxhgNWZMiu/jQRNObmhEnBitXLwSUcVwf+MXfR7pj4XcY3Rs/ZzPZlzS0QWRE3
         qk7Q9/K9KzCNNqqzR2BUmNlaxlJJxet6KwTrtL02JQDiiHC4DXqGWKbb+aRO4KjZPIcB
         veYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Fy7M7fhIwMYXWwgYxjk3dKvxE3VtX41dFWW4vYeizE=;
        b=rWrNCf4hvbsvfhpIt7LJ3JdLWOV8Bx4xsctxN0GdqD8t5DWzUylAFWD3DHcrzcinra
         L2HoF/8xszFQwtbuRJLJOaSrLOue8b5eJBL9r6tqpkk5Dr5mlgG6j79a1/JEAn9sn+AK
         +rPawl9CLItD1B+gnO5VEpsX20QJ7o98KCaa78XVRM5OrDooKjIR5jR23U+6J7aPQ3A+
         Hx0Rzrr0AQRYBBJLR4A+03cIk/Whj7c15IjwXIeJ47NpnKnZpM2l34ICGe+SCvzZls21
         KGMh//J1DzUOnaA9H768OV5pyRPIslBEem3LTWRvbMODwtj6dirw6E6Xegg33xr+bgyT
         Ol+w==
X-Gm-Message-State: APjAAAUFiPeqWC7c0wBQ1Raa8bOjtyGo8CW0OHxCz9xEycPsneFkBon8
        RhFy7Vg5vzv4juRirYezoWQ8kA==
X-Google-Smtp-Source: APXvYqwdWRfcJe7WNtZFLvTZ+W60rV8daZ9/FFFjadu+rO6EUD9fqSV5kfKKtp3zWU65QBx0LrKXrg==
X-Received: by 2002:a1c:2b85:: with SMTP id r127mr2812339wmr.30.1567688406192;
        Thu, 05 Sep 2019 06:00:06 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z189sm3727903wmc.25.2019.09.05.06.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 06:00:05 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] arm64: dts: meson: g12: add a g12 layer
Date:   Thu,  5 Sep 2019 14:59:54 +0200
Message-Id: <20190905125956.4384-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190905125956.4384-1-jbrunet@baylibre.com>
References: <20190905125956.4384-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the sm1 is very close to the g12a/b family, somethings apply
differently on the g12a/b and not the sm1. This introduce a new layer
of dtsi for part which apply to the g12a and g12b but not the sm1.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi  | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12.dtsi

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
new file mode 100644
index 000000000000..1e30061fb2a7
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#include "meson-g12-common.dtsi"
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index eb5d177d7a99..69339d69dfd4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
  */
 
-#include "meson-g12-common.dtsi"
+#include "meson-g12.dtsi"
 #include <dt-bindings/power/meson-g12a-power.h>
 
 / {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
index 5628ccd54531..eefac0ef092b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
@@ -4,7 +4,7 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-g12-common.dtsi"
+#include "meson-g12.dtsi"
 #include <dt-bindings/power/meson-g12a-power.h>
 
 / {
-- 
2.21.0

