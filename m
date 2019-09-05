Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C13C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB49F218DE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="h/8tLCzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389626AbfIENAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:00:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37264 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389597AbfIENAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:00:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id r195so2927553wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9o518Q9M+VA62cCsQMBXOXpf3ntmSugaTgtOZlotIoo=;
        b=h/8tLCzMrNIiSCKb1hq3bANqq0O7NXfwEbtD1KjJQJdIo9X0zm4Sg6VlbVIyFJa22D
         fzT9tMGKti05cgQ7H5y55cnhLBYmX1S6TUg3vFz7rEoF8Gqmyfy/9JM5lYKBYHNkeTHb
         uMznWW0jHU57LOQa9ej99KKjg/geC2wnY8xK4m/1czGaQlWrzt5H4bDJzFfpXz/sXqF3
         o7MKD0cGl24WBul/wImWbW2Vrb0tnQeJTwwZziBEeyzu2C1ttCJRsS0fH+F3bUFgMUFd
         NSrIRGELQk+/+zzLzSuQGkzCmQrV2T2Sdx08DtmDLkGGgBeU3X9BoAo5X12pB+hwIEBw
         4ZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9o518Q9M+VA62cCsQMBXOXpf3ntmSugaTgtOZlotIoo=;
        b=bRZ5u0P71cAK8ruF4UxtAXBEe+paDmdbxV4Zut6ENZbuxU+5wzRn9vedp+7hkM4M6e
         8jPotONPeS3s5hl8Z0bpoMXvvoj1RL7cox5amo2lUCHPUuwshReR/I7fm8XPSPhdFZSn
         Ryi4Xo5kJDQje6vS8H3UDUzdYQ2lpzxCfUVh2lAnRcMN2O1U314HGXN1NPZ/aTMwHKqP
         TQg3oR4f57Ouv86wny3Cdkzt8BM8NATr3IC5U9HiPRev3eUyZG2lRwBtbKfvDhv5Swpt
         PYkxddNc+rkDEawJNae2pYwtSTeBSL4Eb8VgGS4jeLz81x72jWoro09t8d5edNlTVAeY
         MxyA==
X-Gm-Message-State: APjAAAVFK5rNTzEvr5LW1jQ5nZI7zTicKAC69vkpXy5gY7HGJ90srkzD
        97PmgO4T3Ib9Un+VFRJTDTq5ZQ==
X-Google-Smtp-Source: APXvYqwTs4hlT/F1FYODJLFlYoxd4c+WS6plu/pzJAf6EYVvYB882hNz9pcfxd/K5ReyoWJJ4fwRQw==
X-Received: by 2002:a1c:c911:: with SMTP id f17mr2880993wmb.73.1567688404367;
        Thu, 05 Sep 2019 06:00:04 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z189sm3727903wmc.25.2019.09.05.06.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 06:00:03 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] arm64: dts: meson: axg: fix audio fifo reg size
Date:   Thu,  5 Sep 2019 14:59:52 +0200
Message-Id: <20190905125956.4384-2-jbrunet@baylibre.com>
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

Fixes: f2b8f6a93357 ("arm64: dts: meson-axg: add audio fifos")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 82919b106010..bb4a2acb9970 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1162,7 +1162,7 @@
 
 			toddr_a: audio-controller@100 {
 				compatible = "amlogic,axg-toddr";
-				reg = <0x0 0x100 0x0 0x1c>;
+				reg = <0x0 0x100 0x0 0x2c>;
 				#sound-dai-cells = <0>;
 				sound-name-prefix = "TODDR_A";
 				interrupts = <GIC_SPI 84 IRQ_TYPE_EDGE_RISING>;
@@ -1173,7 +1173,7 @@
 
 			toddr_b: audio-controller@140 {
 				compatible = "amlogic,axg-toddr";
-				reg = <0x0 0x140 0x0 0x1c>;
+				reg = <0x0 0x140 0x0 0x2c>;
 				#sound-dai-cells = <0>;
 				sound-name-prefix = "TODDR_B";
 				interrupts = <GIC_SPI 85 IRQ_TYPE_EDGE_RISING>;
@@ -1184,7 +1184,7 @@
 
 			toddr_c: audio-controller@180 {
 				compatible = "amlogic,axg-toddr";
-				reg = <0x0 0x180 0x0 0x1c>;
+				reg = <0x0 0x180 0x0 0x2c>;
 				#sound-dai-cells = <0>;
 				sound-name-prefix = "TODDR_C";
 				interrupts = <GIC_SPI 86 IRQ_TYPE_EDGE_RISING>;
@@ -1195,7 +1195,7 @@
 
 			frddr_a: audio-controller@1c0 {
 				compatible = "amlogic,axg-frddr";
-				reg = <0x0 0x1c0 0x0 0x1c>;
+				reg = <0x0 0x1c0 0x0 0x2c>;
 				#sound-dai-cells = <0>;
 				sound-name-prefix = "FRDDR_A";
 				interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
@@ -1206,7 +1206,7 @@
 
 			frddr_b: audio-controller@200 {
 				compatible = "amlogic,axg-frddr";
-				reg = <0x0 0x200 0x0 0x1c>;
+				reg = <0x0 0x200 0x0 0x2c>;
 				#sound-dai-cells = <0>;
 				sound-name-prefix = "FRDDR_B";
 				interrupts = <GIC_SPI 89 IRQ_TYPE_EDGE_RISING>;
@@ -1217,7 +1217,7 @@
 
 			frddr_c: audio-controller@240 {
 				compatible = "amlogic,axg-frddr";
-				reg = <0x0 0x240 0x0 0x1c>;
+				reg = <0x0 0x240 0x0 0x2c>;
 				#sound-dai-cells = <0>;
 				sound-name-prefix = "FRDDR_C";
 				interrupts = <GIC_SPI 90 IRQ_TYPE_EDGE_RISING>;
-- 
2.21.0

