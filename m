Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38B6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29202083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aXSmLsC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388999AbfDRM1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:27:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52666 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388954AbfDRM1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:27:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so2548919wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/BGCe1eki0ypePWlklAvZFtE9hfEanLs5FHl2Y8rFBU=;
        b=aXSmLsC9kwcBB0jbrDsNrpTHQHqehGDEJBuAqz7aNLJhpICMqiZUCg0Nt9l5vi5Mpf
         UkOP8xOuPgh1FhldHPrHhbkeLERD4m/+oFcC5SAE3p28skoT1FBqpoxNKROFxU2Nndhd
         4roy1g/skQe9pAyyRTMdwDIo519tt0KCuxZD/byjEMgWvEZLLrUNw/BI9fWJWVpcpOAB
         NyvsIcox0mXqN83J99/X5ilweXV/vfNCeSdM4/Vpsj2wUuO8NW6YWFbe34E01KMq+T0p
         yZ+gF85BBy2d4I1i9wH0VLjIdngbZmPIrnHVK6ic/ZIVCZL/c8Lt/SLi83CMkk7X/zos
         QkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/BGCe1eki0ypePWlklAvZFtE9hfEanLs5FHl2Y8rFBU=;
        b=bOW4oi2m1PzGtZ3ek5Ml1dMlqaqwhR6lGJMNV7e0/w+AOFZHqvqEZCd5jkxHg+MJvc
         faeLd9NeIkh2bnxC1IjQUC/boCLQaSsRyAjBY3cX6f04UMl7tJ/khqRcBv9Xl7Oqq8EQ
         caRhdnYsEXD131LW2fn0P67o99MKk0yd3H1MhpzM72tDWqRDyQpcUwaiu/LQlmv/lNu3
         K6kKNsD4y4WqmNhOUSaJ1rhik1T2h1J90PCJiNcXb3LuXxSgunhr0hYsxiQo+ABjzVsH
         xyd0Rj3lPzg3yaKNTMedMVk/dm3mj4TQGqrmcjCEygrXNO1+mSOBjMDt9sINGcSPCf4O
         lw9A==
X-Gm-Message-State: APjAAAUCAwg/3rLWZxggYHr+UwvDbiFCC03zmsyjS41Jxu+v/kjWIrSQ
        CQKacZPa51hKgrq4Y5zmb49QAA==
X-Google-Smtp-Source: APXvYqyZFTYpcxXqgbPZlYOUI+ezl0irlZHBWbC3ZvtKC5Wl/crhT61zDLrxrpgqqcIOmGTNQKidcw==
X-Received: by 2002:a1c:dc09:: with SMTP id t9mr2963246wmg.142.1555590449560;
        Thu, 18 Apr 2019 05:27:29 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z14sm1510110wro.81.2019.04.18.05.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 05:27:28 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patchwork-bot+notify@kernel.org
Subject: [PATCH 5/6] arm64: dts: meson: vim2: add missing clk-gate pinctrl
Date:   Thu, 18 Apr 2019 14:27:13 +0200
Message-Id: <20190418122714.30805-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418122714.30805-1-jbrunet@baylibre.com>
References: <20190418122714.30805-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason the vim2 is missing the clk-gate pinctrl setting all
the other board have. Just add this missing bit

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 27beb813015b..766194ab0aa8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -324,7 +324,8 @@
 &sd_emmc_a {
 	status = "okay";
 	pinctrl-0 = <&sdio_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 	#address-cells = <1>;
 	#size-cells = <0>;
 
@@ -349,7 +350,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -366,7 +368,8 @@
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	cap-sd-highspeed;
-- 
2.20.1

