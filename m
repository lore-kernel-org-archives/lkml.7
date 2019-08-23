Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A34AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC53F2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ksIuzB7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394357AbfHWPou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:44:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37457 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405936AbfHWPoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:44:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id z11so9060894wrt.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 08:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmtWBO1n+ZKCQXJ6AqaMInrPsxYx+c+GGrvrczYdURo=;
        b=ksIuzB7/OWZsHX54bVPcYMM69ePDkVsFJvpeEsHhF4PW4hBLzg2GjNxDflSD0UxGMp
         oUPTkgr1sIAZB+gvKG18hZ+lflkeq5Qp2Hcu2B7FcIiXjqdOMd8OV7ZUpGMSRaauI8z6
         gk0gPdGbNJ8fqcQeu+zQBcoHyd60DwagCxo/tT/DELtGbZNhdsU/gIQheaGCQXHSSO6P
         pR9CDJACYL2tVEc58sL42M5ylPgsFhTsBprDYuZ+gTLeUo2mNooGOlRUnQkNjikrZo8g
         47PfvX2DrhrsX2aNzyo71qmww6NQa+NCvxlECIBP+t+mLecpfoUs6Bq/+99b6bvxRSxO
         GCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmtWBO1n+ZKCQXJ6AqaMInrPsxYx+c+GGrvrczYdURo=;
        b=q66VRsnP/hTBwHW3SoBwEDRNLScVrqNrmXvrFxQX1Xd+rUmODrwh4K33d/c/Do4yNO
         9Y1c/MQewrWmuBhQw01RDUqII4Nuy5w6OiuIz1XNbRYZeG4LLpOxsBKlpJdRQkRKxCbv
         IS2ZhytFrqbRAV85UF9XVJFCXo0qS0IZNoqsz7ZMZU6V23GZurzVtYTiV+X2gb38+34u
         T5/ZReoshPLWw5IN4FdHHrtbUxvt0XiC/k0wDuB6wQ+efehm/FpLJLhkl6mUtq8xSlxm
         e8g1OKKsnmkSM0ZFIz81Mllk7OaitqNgH9PNeuyb5ModGz6JsTBlGP2mxuXRr5jDbLha
         sztg==
X-Gm-Message-State: APjAAAVIKHoAioYTXIDpKeLe4yAxe7abQg4C1Yxq6xiriuAVe5vfeVF2
        G32CVxqEdmRXy+xGIOuCGFPekFtq8V0=
X-Google-Smtp-Source: APXvYqwijk5AmRYmJRxLF0wlW75lhH46QFkzLlttL1bzSCN8eI/O+klK5GLvJSjNodHvRP0l4Z6f6g==
X-Received: by 2002:a5d:63d1:: with SMTP id c17mr2612595wrw.3.1566575077641;
        Fri, 23 Aug 2019 08:44:37 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v7sm3567342wrn.41.2019.08.23.08.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 08:44:37 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 2/2] arm64: dts: meson: g12a: add reset to tdm formatters
Date:   Fri, 23 Aug 2019 17:44:32 +0200
Message-Id: <20190823154432.16268-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823154432.16268-1-jbrunet@baylibre.com>
References: <20190823154432.16268-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reset to the TDM formatters of the g12a. This helps
with channel mapping when a playback/capture uses more than 1 lane.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index edbc30572958..ee1b71284a83 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
+#include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
 #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
 
 / {
@@ -1543,6 +1544,7 @@
 						     "amlogic,axg-tdmin";
 					reg = <0x0 0x300 0x0 0x40>;
 					sound-name-prefix = "TDMIN_A";
+					resets = <&clkc_audio AUD_RESET_TDMIN_A>;
 					clocks = <&clkc_audio AUD_CLKID_TDMIN_A>,
 						 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK>,
 						 <&clkc_audio AUD_CLKID_TDMIN_A_SCLK_SEL>,
@@ -1558,6 +1560,7 @@
 						     "amlogic,axg-tdmin";
 					reg = <0x0 0x340 0x0 0x40>;
 					sound-name-prefix = "TDMIN_B";
+					resets = <&clkc_audio AUD_RESET_TDMIN_B>;
 					clocks = <&clkc_audio AUD_CLKID_TDMIN_B>,
 						 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK>,
 						 <&clkc_audio AUD_CLKID_TDMIN_B_SCLK_SEL>,
@@ -1573,6 +1576,7 @@
 						     "amlogic,axg-tdmin";
 					reg = <0x0 0x380 0x0 0x40>;
 					sound-name-prefix = "TDMIN_C";
+					resets = <&clkc_audio AUD_RESET_TDMIN_C>;
 					clocks = <&clkc_audio AUD_CLKID_TDMIN_C>,
 						 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK>,
 						 <&clkc_audio AUD_CLKID_TDMIN_C_SCLK_SEL>,
@@ -1588,6 +1592,7 @@
 						     "amlogic,axg-tdmin";
 					reg = <0x0 0x3c0 0x0 0x40>;
 					sound-name-prefix = "TDMIN_LB";
+					resets = <&clkc_audio AUD_RESET_TDMIN_LB>;
 					clocks = <&clkc_audio AUD_CLKID_TDMIN_LB>,
 						 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK>,
 						 <&clkc_audio AUD_CLKID_TDMIN_LB_SCLK_SEL>,
@@ -1627,6 +1632,7 @@
 					compatible = "amlogic,g12a-tdmout";
 					reg = <0x0 0x500 0x0 0x40>;
 					sound-name-prefix = "TDMOUT_A";
+					resets = <&clkc_audio AUD_RESET_TDMOUT_A>;
 					clocks = <&clkc_audio AUD_CLKID_TDMOUT_A>,
 						 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK>,
 						 <&clkc_audio AUD_CLKID_TDMOUT_A_SCLK_SEL>,
@@ -1641,6 +1647,7 @@
 					compatible = "amlogic,g12a-tdmout";
 					reg = <0x0 0x540 0x0 0x40>;
 					sound-name-prefix = "TDMOUT_B";
+					resets = <&clkc_audio AUD_RESET_TDMOUT_B>;
 					clocks = <&clkc_audio AUD_CLKID_TDMOUT_B>,
 						 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK>,
 						 <&clkc_audio AUD_CLKID_TDMOUT_B_SCLK_SEL>,
@@ -1655,6 +1662,7 @@
 					compatible = "amlogic,g12a-tdmout";
 					reg = <0x0 0x580 0x0 0x40>;
 					sound-name-prefix = "TDMOUT_C";
+					resets = <&clkc_audio AUD_RESET_TDMOUT_C>;
 					clocks = <&clkc_audio AUD_CLKID_TDMOUT_C>,
 						 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK>,
 						 <&clkc_audio AUD_CLKID_TDMOUT_C_SCLK_SEL>,
-- 
2.21.0

