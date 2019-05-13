Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A33C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEB621473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="s81Q/nj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbfEMQKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:10:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52644 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731557AbfEMQKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:10:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id y3so5071627wmm.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 09:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JqGaHlIjyBZcHL+1Uk7TO1VdGGQ+VNwRvhWRgdD8u+I=;
        b=s81Q/nj0b9sg47KHQMwgCsiibnz7uODQRc4cOBZuKV7pQed2u1GsLyOXHktH+8g1nn
         GhnVFageiBpRb4Rn7welw5qivYUOS1ktQ9bZ63l4JQeZetI/WFwXU88wRzhbe0hhacTj
         V+m8org59/ox+hPvRQxX3TmmSpjsDsSw/3hlhZMcBuy8f/6HtR1JbYzHgd8xfb1Fkp4p
         FOtDiYpmHDJ29kMRalxq5En03DhrECZZlQGfszELZ5fXauTCvTV9SLVAvkWc9U9eNzns
         AuB66bceNrCtqReOAWrpSHr3Cj8YOO84YwuE/dmgCljSIhIz/UzNzZt7bWxvHzmkMI7H
         s0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JqGaHlIjyBZcHL+1Uk7TO1VdGGQ+VNwRvhWRgdD8u+I=;
        b=GVC+Fy7xG9bD8QWoYkKEaS1CUJXT/sH8IXOE8RVscAc4zacLr123iWxaXDiTWzMsAU
         yrpXaLaYo7PIHFIk9+LlFvFFCSnmmDGsbZrkx8UheyU8850v9uRR9qrAx4g2Ja2E65kr
         jEGIikhARxk2+W6mODiIojPsanA5RrMQrDe8yBfh3TjqawviC4ywV8O1nC18aRdeQZKu
         Rsbx/9VVaLn71eJeYrUWQu2C1gakuvFDqMKmxIIO6JDAUQHueuD8A5Y2ik3NHHynnruz
         1Mr0p7ABgcLWGC9NnVbuxnrbTgz3jdvRm0if7lArbFTnMqR78nLJEwjdTXmEG71ypdxc
         nj6g==
X-Gm-Message-State: APjAAAWGlhHA7pyuL+JS9XBaks9ksAQgvYZDWQFfuA88CUllHN87JyK1
        tPgdCCcPszndzWylSHYwRnXdFg==
X-Google-Smtp-Source: APXvYqxMLRkEx0cLtuQGRRyxHRBWoEA2UxknKMgmyMpLaTxy23C/mio8fREFtNrJkRoAb6WS2YeWSQ==
X-Received: by 2002:a1c:f719:: with SMTP id v25mr16554524wmh.90.1557763837536;
        Mon, 13 May 2019 09:10:37 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-11-31.w90-86.abo.wanadoo.fr. [90.86.214.31])
        by smtp.gmail.com with ESMTPSA id n2sm24439089wra.89.2019.05.13.09.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 09:10:36 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 5/5] arm64: dts: mt6392: Add PMIC mt6392 dtsi
Date:   Mon, 13 May 2019 18:10:26 +0200
Message-Id: <20190513161026.31308-6-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513161026.31308-1-fparent@baylibre.com>
References: <20190513161026.31308-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the regulator nodes for the MT6392 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

V2:
	* Use 'pmic' as node name for the pmic.
	* Use 'regulators' as node name for the regulators
	* use dash instead of underscore for regulator's node names.

---
 arch/arm64/boot/dts/mediatek/mt6392.dtsi | 208 +++++++++++++++++++++++
 1 file changed, 208 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
new file mode 100644
index 000000000000..5621968c64e4
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ */
+
+&pwrap {
+	mt6392_pmic: pmic {
+		compatible = "mediatek,mt6392", "mediatek,mt6323";
+		mediatek,system-power-controller;
+
+		regulators {
+			compatible = "mediatek,mt6392-regulator";
+
+			mt6392_vproc_reg: buck-vproc {
+				regulator-name = "buck_vproc";
+				regulator-min-microvolt = < 700000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <12500>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vsys_reg: buck-vsys {
+				regulator-name = "buck_vsys";
+				regulator-min-microvolt = <1400000>;
+				regulator-max-microvolt = <2987500>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vcore_reg: buck-vcore {
+				regulator-name = "buck_vcore";
+				regulator-min-microvolt = < 700000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <12500>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vxo22_reg: ldo-vxo22 {
+				regulator-name = "ldo_vxo22";
+				regulator-min-microvolt = <2200000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-enable-ramp-delay = <110>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vaud22_reg: ldo-vaud22 {
+				regulator-name = "ldo_vaud22";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vcama_reg: ldo-vcama {
+				regulator-name = "ldo_vcama";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vaud28_reg: ldo-vaud28 {
+				regulator-name = "ldo_vaud28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vadc18_reg: ldo-vadc18 {
+				regulator-name = "ldo_vadc18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vcn35_reg: ldo-vcn35 {
+				regulator-name = "ldo_vcn35";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vio28_reg: ldo-vio28 {
+				regulator-name = "ldo_vio28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vusb_reg: ldo-vusb {
+				regulator-name = "ldo_vusb";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vmc_reg: ldo-vmc {
+				regulator-name = "ldo_vmc";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-boot-on;
+			};
+
+			mt6392_vmch_reg: ldo-vmch {
+				regulator-name = "ldo_vmch";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-boot-on;
+			};
+
+			mt6392_vemc3v3_reg: ldo-vemc3v3 {
+				regulator-name = "ldo_vemc3v3";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-boot-on;
+			};
+
+			mt6392_vgp1_reg: ldo-vgp1 {
+				regulator-name = "ldo_vgp1";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vgp2_reg: ldo-vgp2 {
+				regulator-name = "ldo_vgp2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vcn18_reg: ldo-vcn18 {
+				regulator-name = "ldo_vcn18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vcamaf_reg: ldo-vcamaf {
+				regulator-name = "ldo_vcamaf";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vm_reg: ldo-vm {
+				regulator-name = "ldo_vm";
+				regulator-min-microvolt = <1240000>;
+				regulator-max-microvolt = <1390000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vio18_reg: ldo-vio18 {
+				regulator-name = "ldo_vio18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <264>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6392_vcamd_reg: ldo-vcamd {
+				regulator-name = "ldo_vcamd";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vcamio_reg: ldo-vcamio {
+				regulator-name = "ldo_vcamio";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vm25_reg: ldo-vm25 {
+				regulator-name = "ldo_vm25";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+
+			mt6392_vefuse_reg: ldo-vefuse {
+				regulator-name = "ldo_vefuse";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-enable-ramp-delay = <264>;
+			};
+		};
+	};
+};
-- 
2.20.1

