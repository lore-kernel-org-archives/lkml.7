Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA69BC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B744721D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CldZpSat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436484AbfIYOMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:12:42 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8537 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407032AbfIYOMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:12:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d8b75df0001>; Wed, 25 Sep 2019 07:12:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 25 Sep 2019 07:12:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 25 Sep 2019 07:12:41 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Sep
 2019 14:12:40 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 25 Sep 2019 14:12:40 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.133.50]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d8b75d70001>; Wed, 25 Sep 2019 07:12:40 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vidyas@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 1/2] arm64: tegra: Fix 'active-low' warning for Jetson Xavier regulator
Date:   Wed, 25 Sep 2019 15:12:28 +0100
Message-ID: <20190925141229.10992-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1569420768; bh=mRH9L/QunaEx9SUNNraErffS4SKINZgMoJCSGIrHlG4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=CldZpSat9hh/byurnqkXZdAUYFwYRRp5yq6F1RtCHxeyWD8nRiPUK0TavCkyNqYlp
         4YlqfJrz9XCpbkQZQ72PZ6oxwg2wA8PoXqJvV2vHRESKT4pmwPwqx90sTyuGndcWDN
         CmEwg4kmg/1P+FcbQfQIPrUXtuY1Kvj9sfKP/97rtbaCL4eaHLJFM8AwhhNy7fY3vJ
         yIAsL81a+aYOz+Gz94lWMENU1EKtJE0fIQOdlJ4z0DCivFUjDE/0hjh3U49G6MuT27
         fVzp9T55DAin76hCjfC41iorIe+Zk+rCjw5FLHaKDIQauQZCeUk7oono0mZENm8hKd
         +t8NEfF6LL/Zw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4fdbfd60a3a2 ("arm64: tegra: Add PCIe slot supply information
in p2972-0000 platform") added regulators for the PCIe slot on the
Jetson Xavier platform. One of these regulators has an active-low enable
and this commit incorrectly added an active-low specifier for the GPIO
which causes the following warning to occur on boot ...

 WARNING KERN regulator@3 GPIO handle specifies active low - ignored

The fixed-regulator binding does not use the active-low flag from the
gpio specifier and purely relies of the presence of the
'enable-active-high' property to determine if it is active high or low
(if this property is omitted). Fix this warning by setting the GPIO
to active-high in the GPIO specifier. Finally, remove the
'enable-active-low' as this is not a valid property.

Fixes: 4fdbfd60a3a2 ("arm64: tegra: Add PCIe slot supply information in p2972-0000 platform")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 4c38426a6969..02909a48dfcd 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -309,9 +309,8 @@
 			regulator-name = "VDD_12V";
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
-			gpio = <&gpio TEGRA194_MAIN_GPIO(A, 1) GPIO_ACTIVE_LOW>;
+			gpio = <&gpio TEGRA194_MAIN_GPIO(A, 1) GPIO_ACTIVE_HIGH>;
 			regulator-boot-on;
-			enable-active-low;
 		};
 	};
 };
-- 
2.17.1

