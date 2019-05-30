Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772D8C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A27825933
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZ0kUco2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfE3M6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:58:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36406 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfE3M6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:58:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id u22so3930210pfm.3;
        Thu, 30 May 2019 05:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GvIkFSS6zYb3I2dgFnSydPQ6jC4jn1KdG+v4VePYDQk=;
        b=gZ0kUco2TbQiQDQDexJBvPdg0HouSZLKePsOfYv6pLG+qWJ0GrIa4KS0xDHzq7Njp1
         JVX6Yd55JBSYaL22fwI4u7uzTEp4gJcZqLcB73bkSZlzEjKFp8dDB5P7Tk6X/kaB1YHn
         QfAC/0xUHvqisTK71ekwrUFYQyTNhCU6wOjlTvrB8tX7crU4DR8FV65k4FyheSikFYjv
         KJASKPKyS3NfhgHPlOcoDys4WcuH/Mm67Qie62B23Y+m20R7rZKGS5EALfq3AP2zT5HX
         5VC1IujrphDhnuTa9lxmASESCmScK/wXSsufBZX9TIBVC9ofCknRuN8wwtquBNt3PU71
         YTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GvIkFSS6zYb3I2dgFnSydPQ6jC4jn1KdG+v4VePYDQk=;
        b=jEOwsIAKsxbW4dRBMBAWVHr4R4se60MMXpJND2XaZRHxkH+BryxrS5h3R/2ysMTyng
         hvMDzxF7kG/kp97/kaV/ysspCnH15ReW0M3F38OdgVv0HfDUI/Rr3V8sVBuGGINuRNrW
         lkQjFFXT8oi5P/ZMhjQablfHHRxk8bc4tZM16tstQEeh2wVGspKdZ6+4AvaSNEJg9TxZ
         OXm0s//ArtBv/RicDZ7ZwocVA92YHTaMhYBxntPkMtJ4tcoKIWSwNmg8S2ymnTh2BoSy
         RQcmo57TuhUCAl5qpuREdlFYwF1dA168oFfqsGHs24zVGtBqw8siZoQowoeLJ9xm4T9c
         P5Ow==
X-Gm-Message-State: APjAAAXxZGFO9EXZU8nwnN2tTEXexbnBWiPWJbhB15+Jz8nfQsXBpoTa
        WjrMo4Qc0HiPXaIZhU+mKpo=
X-Google-Smtp-Source: APXvYqzU0QjvBVCx0ssrUfq8kLh4g1PKTBBj2qaRjGJOAuYeog+j57yeoXYuz55utK4trv6oBJIKWw==
X-Received: by 2002:a63:8ac3:: with SMTP id y186mr3590817pgd.22.1559221124817;
        Thu, 30 May 2019 05:58:44 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.35])
        by smtp.gmail.com with ESMTPSA id j13sm2928912pfh.13.2019.05.30.05.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 05:58:44 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Add missing PCIe pwr amd rst configuration
Date:   Thu, 30 May 2019 12:58:37 +0000
Message-Id: <20190530125837.730-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add missing PCIe gpio and pinctrl for power (#PCIE_PWR)
also add PCIe gpio and pinctrl for reset (#PCIE_PERST_L).

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Tested on Rock960 Model A
---
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index c7d48d41e184..f5bef6b0fe89 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -55,9 +55,10 @@
 
 	vcc3v3_pcie: vcc3v3-pcie-regulator {
 		compatible = "regulator-fixed";
+		gpio = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		pinctrl-names = "default";
-		pinctrl-0 = <&pcie_drv>;
+		pinctrl-0 = <&pcie_drv &pcie_pwr>;
 		regulator-boot-on;
 		regulator-name = "vcc3v3_pcie";
 		regulator-min-microvolt = <3300000>;
@@ -381,9 +382,10 @@
 };
 
 &pcie0 {
+	ep-gpio = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
 	num-lanes = <4>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie_clkreqn_cpm>;
+	pinctrl-0 = <&pcie_clkreqn_cpm &pcie_perst_l>;
 	vpcie3v3-supply = <&vcc3v3_pcie>;
 	status = "okay";
 };
@@ -408,6 +410,16 @@
 		};
 	};
 
+	pcie {
+		pcie_pwr: pcie-pwr {
+			rockchip,pins = <2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie_perst_l:pcie-perst-l {
+			rockchip,pins = <2 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	sdmmc {
 		sdmmc_bus1: sdmmc-bus1 {
 			rockchip,pins =
-- 
2.21.0

