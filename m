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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B99EECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE492064A
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTzV7avy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbfJNSA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:00:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46348 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfJNSA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:00:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id r18so3903762eds.13;
        Mon, 14 Oct 2019 11:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vQyWa6OC5nMW2WVQGplpiKZG6tNwtAjnKydlEJdldAw=;
        b=BTzV7avy5noZHilLMuFTcRNQXWljNOYgVVEISOo4CIuNeMPYmYvkmc+E/+sM0qFxob
         2QIZZ+7tVLh1r7eJeQbRJNqkJK677TXDLTAQ8JXVLoHJI60hxbKBPIe3xIlMDyvVKRTi
         ao9rFGkwYRWddLkWtMkRiySDsJZp30eWmE0MouGZLlTWvmM4fJvkngSBdta5iWlEFZlO
         Ibwi08nb8Y/qM0MVN3/V1CG9caENKLDQ/N4drou4MUkFEcI4kLq9o+GT+SP0iTtqOyU/
         w6DTx/Kz+JlmaP9wxMTkhBczLMeINCbO8r/Qkc/ZuXpmj/jNFcJHZ3DWOgycCA1Qn9IS
         r7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vQyWa6OC5nMW2WVQGplpiKZG6tNwtAjnKydlEJdldAw=;
        b=Ifu88pRvuAFO9vC28C6TmMS7lQYFFhfDVDWTqEu+ltyH3LzKJc4Lli2Buh4ifj+omi
         bU2MLucDqVlTjNpC5eBNeYaoqZnEjg9nsssuJ7w39icLRLq5wC3FTPcrRxh5O336bGc3
         jgqeGK3nex6kWlXEh8x8Q3uIyCrdYYDY6itE8FUFpkHO4MlbZl4TJhWuPp5sejRj36L6
         ijDgrxEPewmZ7E0o8jSB4AmWHsVT4JFb0GUwmh8jQaPiUwSW5gkOPvgIJf1dmPItbUhm
         mLZa0KKS8IGp24GqMS6QCHLYQkaOysLWPk9gxcSHDBNYXqX9aYP7vVstRIZxxqKBCT3b
         sSwQ==
X-Gm-Message-State: APjAAAW8r18k1HrAhWz5QGSVmdJ2+weukTjLrdnKbX6TppNmjDbdUeJ4
        VbCNh75MGNhrDe3oZSzUDBGG+rdo
X-Google-Smtp-Source: APXvYqykC7fDAqxl/5vUmUxhu3JBS7WBVVkSY/ZrTMq1S7z2QoVnj2FLqEDT+SMFdU7++K3zrHxhgQ==
X-Received: by 2002:aa7:ca52:: with SMTP id j18mr29318868edt.299.1571076056199;
        Mon, 14 Oct 2019 11:00:56 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j9sm3255183edt.15.2019.10.14.11.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 11:00:55 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: remove some tabs and spaces from dtsi files
Date:   Mon, 14 Oct 2019 20:00:45 +0200
Message-Id: <20191014180045.11804-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the Rockchip dtsi files a little bit
by removing some tabs and spaces.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi           |  4 ++--
 arch/arm/boot/dts/rk3288-rock2-som.dtsi |  2 +-
 arch/arm/boot/dts/rk3288-tinker.dtsi    | 14 +++++---------
 3 files changed, 8 insertions(+), 12 deletions(-)

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
index 9f9e2bfd1..14aebd447 100644
--- a/arch/arm/boot/dts/rk3288-rock2-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
@@ -237,7 +237,7 @@
 
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

