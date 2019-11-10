Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F40C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C41721848
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355546;
	bh=ZPjfq3pUDu+AsWiU2zu9iZRPXobWVshwV8XGX7wGb6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tKHCJEvA0jBdMwiuwF77vxkSp68L5aJOhKm3ZHyNa0zhU3XZc+6MSYftJKgbbMKhv
	 PzEfzS5DyVFn81fG2w27awcIAzTmNa6XDEVlSI6swCjofWYExK0Gpm0aFZD/INegbS
	 41MTgKi6eKVyWjQ3koNozr7jJzXN+rMzCOgCYTB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfKJDMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:12:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbfKJCnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:43:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5AAD21655;
        Sun, 10 Nov 2019 02:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353797;
        bh=ZPjfq3pUDu+AsWiU2zu9iZRPXobWVshwV8XGX7wGb6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zSzxb2Cre9lKEpFQBuwJTV2YRb2jqznHW79aK4xvYMTg0eJ3D8h/5VaXgUryakfTF
         b9A8CrPkkfQho/9umD40nVXyWz+B0kLF8aWRt/z0Zyd99ALhLIfIqgtv26BzHclER3
         dsQvjB3WAMTzE3VWKzYodVgO6g0qoTmxWxCIMSHE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Sasha Levin <sashal@kernel.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 096/191] ARM: dts: rockchip: explicitly set vcc_sd0 pin to gpio on rk3188-radxarock
Date:   Sat,  9 Nov 2019 21:38:38 -0500
Message-Id: <20191110024013.29782-96-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko@sntech.de>

[ Upstream commit a2df0984e73fd9e1dad5fc3f1c307ec3de395e30 ]

It is good practice to make the setting of gpio-pinctrls explicitly in the
devicetree, and in this case even necessary.
Rockchip boards start with iomux settings set to gpio for most pins and
while the linux pinctrl driver also implicitly sets the gpio function if
a pin is requested as gpio that is not necessarily true for other drivers.

The issue in question stems from uboot, where the sdmmc_pwr pin is set
to function 1 (sdmmc-power) by the bootrom when reading the 1st-stage
loader. The regulator controlled by the pin is active-low though, so
when the dwmmc hw-block sets its enabled bit, it actually disables the
regulator. By changing the pin back to gpio we fix that behaviour.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/rk3188-radxarock.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 45fd2b302dda1..4a2890618f6fc 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -93,6 +93,8 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio3 RK_PA1 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_pwr>;
 		startup-delay-us = <100000>;
 		vin-supply = <&vcc_io>;
 	};
@@ -315,6 +317,12 @@
 		};
 	};
 
+	sd0 {
+		sdmmc_pwr: sdmmc-pwr {
+			rockchip,pins = <RK_GPIO3 1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	usb {
 		host_vbus_drv: host-vbus-drv {
 			rockchip,pins = <0 3 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.20.1

