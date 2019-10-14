Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAACECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 21:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73995217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 21:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEO9wXFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbfJNVGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 17:06:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43881 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfJNVGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 17:06:31 -0400
Received: by mail-ed1-f65.google.com with SMTP id r9so15984257edl.10;
        Mon, 14 Oct 2019 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x9ockYP1+BmQj621KtYqZs8B3/GWqAGczAzI5iUAWRw=;
        b=OEO9wXFnCJwat3sRy/K8V5vm/cPyvPBdevw/VU7ygiCSQzFodpMz0uiBqeZ3v/Wnrz
         egb+i1v75SC/vErryPQ6upIFeR8Wviucv2h05Yu2WoVQxrXtTD+pPd9s70F207XrC2em
         DzXSxRMgfwwv3urvWsyE8Rhd3Am0LNbYf+mL8UDC6p9O0NoYTbBzcX2A2PGN4bBuMAsh
         Y+q3BgdLUI0crxlFo0183TNmH0oFRfh9pYOKioMRNJ7t35hkF3FZmk8jMJrh5Mfg/lj/
         EJ3cSdWcGPzVRAxCMpqsERUAmrwRbrex1FkTxQsdv/oaykbZ8NOr30S4Tp93trMXfx8U
         KYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x9ockYP1+BmQj621KtYqZs8B3/GWqAGczAzI5iUAWRw=;
        b=dvw0nhCTS6Lgm+OOsmdIHEwwuRmt2K5Jy6AE5+01W5qE1ZQVIPTFYB4nt39MzxyZ6h
         KZEdaJ65UCivkgwnnndwNEd1ssNYkGdDu0cuxRd4gNK9f0Yn3IctpaaTGMuvllRsoDuH
         rJL2snWU+U6wOK0qIdcnGJHManjpUmIxOl4Y7cB0ECan43TGaTz/UFxcs1AcTuit/odo
         XI4jBlU29i/1zQxuBebsmlnHQX58rNXv8lYyCpTEJ4lp8YBnRv+X/lr3BOy2vUOzKrwG
         dgfuqujiGWUdKHPAihLWQVrDU4vMiQjYwda7mYt2lG5wjWSPt+28xIYfEPzQ6GQcJcwl
         6g/g==
X-Gm-Message-State: APjAAAXmHo7AHcCvB3hjEhteGXJy026gv+w8ZJXuuY2kH/njrdF9l4hb
        MLTFEcbbOJmK4QSFyu8m4wo=
X-Google-Smtp-Source: APXvYqy0OUC8jXYlII8DhITV2pund1WqtG58pZL6x+LXKrLsB325rkU4DCULRlppkR3UWN6HWRqqCQ==
X-Received: by 2002:aa7:d5d3:: with SMTP id d19mr29637012eds.213.1571087189200;
        Mon, 14 Oct 2019 14:06:29 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id y29sm3366939edd.7.2019.10.14.14.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 14:06:28 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: rockchip: remove some tabs and spaces from dtsi files
Date:   Mon, 14 Oct 2019 23:06:19 +0200
Message-Id: <20191014210619.12778-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191014174521.11611-1-jbx6244@gmail.com>
References: <20191014174521.11611-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the Rockchip dtsi files a little bit
by removing some tabs and spaces.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi           |  4 ++--
 arch/arm/boot/dts/rk3288-rock2-som.dtsi |  8 ++++----
 arch/arm/boot/dts/rk3288-tinker.dtsi    | 14 +++++---------
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index c776321b2..c70182c5a 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -696,8 +696,8 @@
 
 		hdmi {
 			hdmi_ctl: hdmi-ctl {
-				rockchip,pins = <1 RK_PB0  1 &pcfg_pull_none>,
-						<1 RK_PB1  1 &pcfg_pull_none>,
+				rockchip,pins = <1 RK_PB0 1 &pcfg_pull_none>,
+						<1 RK_PB1 1 &pcfg_pull_none>,
 						<1 RK_PB2 1 &pcfg_pull_none>,
 						<1 RK_PB3 1 &pcfg_pull_none>;
 			};
diff --git a/arch/arm/boot/dts/rk3288-rock2-som.dtsi b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
index 9f9e2bfd1..44bb5e6f8 100644
--- a/arch/arm/boot/dts/rk3288-rock2-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
@@ -230,14 +230,14 @@
 	};
 
 	emmc {
-			emmc_reset: emmc-reset {
-				rockchip,pins = <3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
-			};
+		emmc_reset: emmc-reset {
+			rockchip,pins = <3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 
 	gmac {
 		phy_rst: phy-rst {
-			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO  &pcfg_output_high>;
+			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_output_high>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
index 81e4e953d..0aeef23ca 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -382,18 +382,15 @@
 
 	pmic {
 		pmic_int: pmic-int {
-			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO \
-					&pcfg_pull_up>;
+			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 
 		dvs_1: dvs-1 {
-			rockchip,pins = <0 RK_PB3 RK_FUNC_GPIO \
-					&pcfg_pull_down>;
+			rockchip,pins = <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_down>;
 		};
 
 		dvs_2: dvs-2 {
-			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO \
-					&pcfg_pull_down>;
+			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_down>;
 		};
 	};
 
@@ -406,8 +403,7 @@
 		};
 
 		sdmmc_clk: sdmmc-clk {
-			rockchip,pins = <6 RK_PC4 1 \
-					&pcfg_pull_none_drv_8ma>;
+			rockchip,pins = <6 RK_PC4 1 &pcfg_pull_none_drv_8ma>;
 		};
 
 		sdmmc_cmd: sdmmc-cmd {
@@ -432,7 +428,7 @@
 	sdio {
 		wifi_enable: wifi-enable {
 			rockchip,pins = <4 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>,
-				<4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
+					<4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 };
-- 
2.11.0

