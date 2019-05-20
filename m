Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A6CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818A5206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dg9voSlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbfETKNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:13:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33174 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732535AbfETKND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:13:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id y3so6528094plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 03:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ap6Go4OzNxJ532m09L3XvGYt1ETDxtVIslcDJHxqhh8=;
        b=dg9voSlkL9Tcl87q88SNV55S8GA0JmQ0duHA+37dyzDY6OcpNFosrqe5mS3YzRmQOK
         KPzF/tT9V0EzWBhy2zsLMNsoshKCx2xZyxd4iwz9E9Z+2nn92gIHu5ZHF9a2rvSKpInj
         ca0v4q6NwLwD/s3f1bL/W4RAqzlQCYCkHWlRExJXrGi1L4hv02Om0lUPuSKo3CmzH1mz
         d34F0kjxLbephXWC09QvmFZSnEu6Ekd6KSVve5DHXWh8KKISDCiIzD1Vjtqw0xlrah4s
         Fmbp7jB3XlkVoe7T9o5bHTcpAiwbDpZHyq8FlWAt8RUnDgGdDJmKqnmM8+kdwtqJT8jL
         8bLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ap6Go4OzNxJ532m09L3XvGYt1ETDxtVIslcDJHxqhh8=;
        b=J1X3lpCVx6DAZfXV63jTqvYn1l7xd3Jqttefo4IS1Kw1rGvQMAeTUBbJltkuTnOTZP
         +/RBPK2fsxEroPl1BHBH4ly4Hny3jG5sHTDvjd/5ne5v3JZG8GaKK3O/pVhIBV/Q8uTj
         FDfjm5/e46BicDS/KOCnr1s1U2D4i1lqAeBS0J7ocfXDgZJ9NZ5AfHmlamE6g49Z/bzn
         Oazc+iErowCsR+O+Gm0L31D1J6EWuwtcD5d9oBGJEYHYSVF+oWYR8E2i1ye+evn7dZ8g
         OAM5NOybYC8BJYKZ4eqRIHbzkOzCnrvFkN+zdC3XHfnKC+fZ6n3+TgIKnzkIXzDPBYtU
         yUag==
X-Gm-Message-State: APjAAAWMnebOEUMKq+XNfS6MJPNbLSm1XOQt6SpXj41f584w6zDEHZp1
        +tzMNRh47LfUXatJbW+AJ1FKkw==
X-Google-Smtp-Source: APXvYqz/VZ5IYWao7ZtNYoD6jisYi4sIXfq0npMXqR3qxjBzeqk+s2PVbN80bOiH+xksI9cdfVZ8gQ==
X-Received: by 2002:a17:902:bb06:: with SMTP id l6mr16803820pls.78.1558347182324;
        Mon, 20 May 2019 03:13:02 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b3sm30098127pfr.146.2019.05.20.03.12.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 03:13:01 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 9/9] arm64: dts: sprd: Add Spreadtrum SD host controller support
Date:   Mon, 20 May 2019 18:12:02 +0800
Message-Id: <7fc6cd63966bda900b07ac9b2156e313a6f2ac17.1558346019.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one Spreadtrum SD host controller to support eMMC card for Spreadtrum
SC9860 platform.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |   35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index b5c5dce..86ec2b0 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -168,6 +168,34 @@
 				vdd-supply = <&vddusb33>;
 				sprd,vdd-voltage = <3300000>;
 			};
+
+			sdio3: sdio@50430000 {
+				compatible  = "sprd,sdhci-r11";
+				reg = <0 0x50430000 0 0x1000>;
+				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+
+				clock-names = "sdio", "enable", "2x_enable";
+				clocks = <&aon_prediv CLK_EMMC_2X>,
+				       <&apahb_gate CLK_EMMC_EB>,
+				       <&aon_gate CLK_EMMC_2X_EN>;
+				assigned-clocks = <&aon_prediv CLK_EMMC_2X>;
+				assigned-clock-parents = <&clk_l0_409m6>;
+
+				sprd,phy-delay-mmc-hs400 = <0x44 0x7f 0x2e 0x2e>;
+				sprd,phy-delay-mmc-hs200 = <0x0 0x8c 0x8c 0x8c>;
+				sprd,phy-delay-mmc-ddr52 = <0x3f 0x75 0x14 0x14>;
+				sprd,phy-delay-mmc-hs400es = <0x3f 0x3f 0x2e 0x2e>;
+				vmmc-supply = <&vddemmccore>;
+				bus-width = <8>;
+				non-removable;
+				no-sdio;
+				no-sd;
+				cap-mmc-hw-reset;
+				mmc-hs400-enhanced-strobe;
+				mmc-hs400-1_8v;
+				mmc-hs200-1_8v;
+				mmc-ddr-1_8v;
+			};
 		};
 
 		aon {
@@ -310,4 +338,11 @@
 		clock-frequency = <100000000>;
 		clock-output-names = "ext-rco-100m";
 	};
+
+	clk_l0_409m6: clk_l0_409m6 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <409600000>;
+		clock-output-names = "ext-409m6";
+	};
 };
-- 
1.7.9.5

