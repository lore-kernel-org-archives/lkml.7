Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AF8C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC58C21A49
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SnuwT5mI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389682AbfIENA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:00:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38058 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389611AbfIENAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:00:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id l11so2680273wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 06:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=to9nPxGvpAjI2vmBY6hiBkK0HN4KqohuKcK/qXqDNPY=;
        b=SnuwT5mIhn9C8R/kG87+eslWK4M08z27tnIDQ/toGWNx0ojS1cWn09AJM87Ul8otC7
         syKEujMS+EpLHYDEiwjuyN/zVqjk1XKNHnRjjFPN4NW+7Hy7872vp62w8rS/Q4JF3qkg
         rs98UZRdufTi7TKufZ9JeOQe450oKBOy4WUSlTUQcdNKLHTvUI86418VWK+TXUEx1z8P
         LlT1Wfexo1rLCmmkX8GIWWbLAOiv/YPzM7Zg4HEVtTLcYMkV7iMRt/AGmQMuxWQfs5TL
         ZdT0b4OU5F1WaXI7hc3EZ7lsKR3Tj50eg6jkJSMHVWQyLtuZR5BaxpMWMSpsNNgeyOIa
         SoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=to9nPxGvpAjI2vmBY6hiBkK0HN4KqohuKcK/qXqDNPY=;
        b=A09Oo9X3Il78nw0iOQbCVhUGmfl9cI1bFwKhdbUnq+ojDbqKYS3+ZwDyxxeQa/GWtg
         tPnalVQkOhK+zB8pn+4hjHt04chDr2ahXxgKBBEEvdKMG53Yt5ozRFf+u8UQggzGK7Ww
         etTgX8jVEtXc8SbN44rH7rXiFs+38X0uQhOajrD2fwqmfVQ7vN/hcfNwWA6xTMGrfdVH
         74pkRlgBnb9XoMCEUsQBtVNCNtnzEyMhIuhjUlu8vXF6OBpaI7DCf5FO4Gyl2WzRYjKL
         yqNweT3EvyYNLKjG0zreGIoeK1aSO2aVsIIjc3+ORjlGAbuweqCqTC4BkxCHFCmMd86S
         fA5A==
X-Gm-Message-State: APjAAAXGl02yQDMn1c2mw1sTavmh/mE1oQRXxqX3m/3ybcSTwkgAwXX9
        Fka2RHFxX4Au7BrPnvtRs/7W2w==
X-Google-Smtp-Source: APXvYqyWLZJ5ptNeLjAU/5Y4+RE4paQzv79ZLTG/PR8hFu5o1WDdkpKLnFc5q7mcqJc3J1ZSrLAgjA==
X-Received: by 2002:a05:6000:12d1:: with SMTP id l17mr2510949wrx.91.1567688405327;
        Thu, 05 Sep 2019 06:00:05 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z189sm3727903wmc.25.2019.09.05.06.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 06:00:04 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] arm64: dts: meson: g12: fix audio fifo reg size
Date:   Thu,  5 Sep 2019 14:59:53 +0200
Message-Id: <20190905125956.4384-3-jbrunet@baylibre.com>
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

The register region size initially is too small to access all
the fifo registers.

Fixes: c59b7fe5aafd ("arm64: dts: meson: g12a: add audio fifos")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 3f39e020f74e..0ee8a369c547 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1509,7 +1509,7 @@
 				toddr_a: audio-controller@100 {
 					compatible = "amlogic,g12a-toddr",
 						     "amlogic,axg-toddr";
-					reg = <0x0 0x100 0x0 0x1c>;
+					reg = <0x0 0x100 0x0 0x2c>;
 					#sound-dai-cells = <0>;
 					sound-name-prefix = "TODDR_A";
 					interrupts = <GIC_SPI 148 IRQ_TYPE_EDGE_RISING>;
@@ -1521,7 +1521,7 @@
 				toddr_b: audio-controller@140 {
 					compatible = "amlogic,g12a-toddr",
 						     "amlogic,axg-toddr";
-					reg = <0x0 0x140 0x0 0x1c>;
+					reg = <0x0 0x140 0x0 0x2c>;
 					#sound-dai-cells = <0>;
 					sound-name-prefix = "TODDR_B";
 					interrupts = <GIC_SPI 149 IRQ_TYPE_EDGE_RISING>;
@@ -1533,7 +1533,7 @@
 				toddr_c: audio-controller@180 {
 					compatible = "amlogic,g12a-toddr",
 						     "amlogic,axg-toddr";
-					reg = <0x0 0x180 0x0 0x1c>;
+					reg = <0x0 0x180 0x0 0x2c>;
 					#sound-dai-cells = <0>;
 					sound-name-prefix = "TODDR_C";
 					interrupts = <GIC_SPI 150 IRQ_TYPE_EDGE_RISING>;
@@ -1545,7 +1545,7 @@
 				frddr_a: audio-controller@1c0 {
 					compatible = "amlogic,g12a-frddr",
 						     "amlogic,axg-frddr";
-					reg = <0x0 0x1c0 0x0 0x1c>;
+					reg = <0x0 0x1c0 0x0 0x2c>;
 					#sound-dai-cells = <0>;
 					sound-name-prefix = "FRDDR_A";
 					interrupts = <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>;
@@ -1557,7 +1557,7 @@
 				frddr_b: audio-controller@200 {
 					compatible = "amlogic,g12a-frddr",
 						     "amlogic,axg-frddr";
-					reg = <0x0 0x200 0x0 0x1c>;
+					reg = <0x0 0x200 0x0 0x2c>;
 					#sound-dai-cells = <0>;
 					sound-name-prefix = "FRDDR_B";
 					interrupts = <GIC_SPI 153 IRQ_TYPE_EDGE_RISING>;
@@ -1569,7 +1569,7 @@
 				frddr_c: audio-controller@240 {
 					compatible = "amlogic,g12a-frddr",
 						     "amlogic,axg-frddr";
-					reg = <0x0 0x240 0x0 0x1c>;
+					reg = <0x0 0x240 0x0 0x2c>;
 					#sound-dai-cells = <0>;
 					sound-name-prefix = "FRDDR_C";
 					interrupts = <GIC_SPI 154 IRQ_TYPE_EDGE_RISING>;
-- 
2.21.0

