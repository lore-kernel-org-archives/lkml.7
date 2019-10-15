Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACA2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614D820854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qtue6CQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389306AbfJOTKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:10:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52770 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389296AbfJOTKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:10:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id r19so243735wmh.2;
        Tue, 15 Oct 2019 12:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q85wWT1Ntix0umS+jHesJR+Bc8njDJ95cdjzzQg8isg=;
        b=Qtue6CQgRcmNCCevDgHkx1nw6nwFmlUixidcjbgaIDm4CTFvf9nEgb5BaqJwTwk33t
         qDClhJVxShLHZtTLCcaqSqt1ubXo5CHnT1ckRwUGXiQb06xdXNw8cAWPvChjA/mQidDW
         3Xa6unKQyCYmR+lI0WDYtykal4JiuA690wKtJ8Kmclf0Ot8Lajas8/OG3zshPSp044Gd
         ZuUssuVp1oVhFQyWdfoCXOa5v6ofDAuiaou4inXUVvR/KbSVqwpwI4hAr9oDnrnJaCj6
         +PxyeVYecH51/ZEKinF324uy+IMrEfsgDT5hV3ha/+xaBnEGP22pQplalarGlqT19JF3
         vldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q85wWT1Ntix0umS+jHesJR+Bc8njDJ95cdjzzQg8isg=;
        b=FDhgsged6qpW4RbYoOnEmLdMWB3ge7impcfuEYBN7CkJ7+Txlrti1BAmFKmKA0xj93
         hJl8yn1G4vaWxucY9c9jsKwzOE/OWvO5ZWUuY9GjblvtlgHmlvgcp2wKjjQovYsYLWV4
         xAcR2lx6r9Bv6kr1NRdHLg/pRzYJFY9+KtIPx5sUh86+GmpQK4i8R1mMO6XOS0q78oQu
         zFH1479Dtzfa9tbKwB3vcGlHpUiAvUvJ9apGzRPME7JnJq20nrq+tYfTjgA60ne2HZyQ
         xVuUUPj/PWvM/TdDbC+zl+q3VxxCHE/7YG+HfSowrrGyj5MaNK2maSfidtPv7VuMCsuW
         ZSXA==
X-Gm-Message-State: APjAAAV7oMxq3ENDGaAJ/sjzqQdBGkz8+VAz5J3N0ce99a0l053/PjqC
        BydJEWx7SsGfLpFaHXOn7vfrCyO8
X-Google-Smtp-Source: APXvYqzKZdq6eLHh6x7PFZAJKQx0U0RnCiTFPg+KYwQ0VlKMan5QzmHnChRFPM30ZpQC7osTfYxqhA==
X-Received: by 2002:a7b:cd87:: with SMTP id y7mr61400wmj.93.1571166610784;
        Tue, 15 Oct 2019 12:10:10 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u26sm25089984wrd.87.2019.10.15.12.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 12:10:10 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: rockchip: rk3399-rock-pi-4: restyle rockchip,pins
Date:   Tue, 15 Oct 2019 21:09:59 +0200
Message-Id: <20191015191000.2890-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The define RK_FUNC_1 is no longer used,
so restyle the rockchip,pins definitions.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
index 1ae1ebd4e..188d9dfc2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
@@ -486,21 +486,18 @@
 
 	sdio0 {
 		sdio0_bus4: sdio0-bus4 {
-			rockchip,pins =
-				<2 20 RK_FUNC_1 &pcfg_pull_up_20ma>,
-				<2 21 RK_FUNC_1 &pcfg_pull_up_20ma>,
-				<2 22 RK_FUNC_1 &pcfg_pull_up_20ma>,
-				<2 23 RK_FUNC_1 &pcfg_pull_up_20ma>;
+			rockchip,pins = <2 RK_PC4 1 &pcfg_pull_up_20ma>,
+					<2 RK_PC5 1 &pcfg_pull_up_20ma>,
+					<2 RK_PC6 1 &pcfg_pull_up_20ma>,
+					<2 RK_PC7 1 &pcfg_pull_up_20ma>;
 		};
 
 		sdio0_cmd: sdio0-cmd {
-			rockchip,pins =
-				<2 24 RK_FUNC_1 &pcfg_pull_up_20ma>;
+			rockchip,pins = <2 RK_PD0 1 &pcfg_pull_up_20ma>;
 		};
 
 		sdio0_clk: sdio0-clk {
-			rockchip,pins =
-				<2 25 RK_FUNC_1 &pcfg_pull_none_20ma>;
+			rockchip,pins = <2 RK_PD1 1 &pcfg_pull_none_20ma>;
 		};
 	};
 
@@ -532,8 +529,7 @@
 
 	wifi {
 		wifi_enable_h: wifi-enable-h {
-			rockchip,pins =
-				<0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
 		wifi_host_wake_l: wifi-host-wake-l {
-- 
2.11.0

