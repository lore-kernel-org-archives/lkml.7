Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C777DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955EA24860
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vB+Hs12y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfFDIPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:15:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42233 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfFDIPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:15:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so1997161pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dER5z7AUiZqvyewGFEgnTI66kajUzFaGGa3MWKBcALw=;
        b=vB+Hs12ydRRg7xKl2y5pq42c9TjetjyW0KPP4CLQt1K5QD8u1082ngypqoz/11y6pf
         HsTDlpjOvwfLUalvg4uG96nQ2MLMmkyHNeAodvBKqe1k6KliNxZtqwgdUPx1nRVCDaLS
         d/gpsoMpSCfGI5CUCM+4zoY7lZ6mNNLD4jXkaJ21sHDJsdpjn0SIxSCt9tqmtkfOofB7
         RqQpd+nyHy8bd1NIy3azycy35bMkxl7stgprnj3dhXBUQy7smuGvkPvmCPP9+IRlqzDl
         nw7NJ48xznSFJhLrRThp2Bn4mrOl4dcFT4lxs6ckloBL3l1TfCRU8gfHKoeqhcD/oe+G
         fhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dER5z7AUiZqvyewGFEgnTI66kajUzFaGGa3MWKBcALw=;
        b=YIuYy51o04Ru63Uo7cO8z4MULsI2N48Te97vAqhDuERaooB2TpDyHmoT0S/qPzvkXU
         YDEOX6BR5R/14VUdEL4ks3Ly1+w3JtaAjgxmeQldcwg0BaC4oKrtzW3Ag2ItK9KwTduB
         nEpabvPcXXgG5IIkWBdSFukD7OHz2zsZc2prxfYQ420uKD6qZj9ZTRE2vLtFtFg6ifWz
         GtNxBfUP45wtvyYcNfz/0FyP5NetDgxf2+TxsPeRHNAIZp2EJR2mmy1km9LBhQbPAWuJ
         Ci0tLvQyAmScha31G4+tCkCZ5/cZLvKY63eN36ZuaWjzZPIexQZb+7yOEfspI6koyiHc
         tqXg==
X-Gm-Message-State: APjAAAURfs7BCXxN3XpExHnXBjJUITBfyofEgdyM9O+ebLdhkh69PHFk
        zUqJl+dmN9Qsy9Q43KALeK7f0Q==
X-Google-Smtp-Source: APXvYqwm5O/KPp7XNf1fWqY832/e4ZO4cZ+12EaAKnp9jkR2KI4E6QiX8CcY/sQ9R+DjpbaetygTiw==
X-Received: by 2002:a17:90a:1a84:: with SMTP id p4mr35971999pjp.15.1559636129484;
        Tue, 04 Jun 2019 01:15:29 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j4sm14818804pgc.56.2019.06.04.01.15.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 01:15:29 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 9/9] arm64: dts: sprd: Add Spreadtrum SD host controller support
Date:   Tue,  4 Jun 2019 16:14:29 +0800
Message-Id: <3ca273e341f2f5f66b121d411428c60afd412586.1559635435.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
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
index 4bb862c..79b9591c 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -130,6 +130,34 @@
 				clock-names = "enable";
 				clocks = <&apahb_gate CLK_DMA_EB>;
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
@@ -272,4 +300,11 @@
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

