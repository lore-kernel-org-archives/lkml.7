Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF741C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933A0218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wrn2n5OR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfJBAhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 20:37:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34409 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfJBAhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 20:37:34 -0400
Received: by mail-io1-f65.google.com with SMTP id q1so52938381ion.1;
        Tue, 01 Oct 2019 17:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jcliF93zjSpaTafpPEiTUMAs8EwGUjS9FawXIfHTmOk=;
        b=Wrn2n5OReD+a85dWS1z7k055rb5DZ8+oHi3v3I8tzx3TblLi/iebka8KYugxSfKaFh
         lbfEX5veNkmxm81GjQr3aZAm6qrHhm45WPJEuTHcjnqIKe2T0peL14H3fvJiTzwc/704
         8nA6VV6rtsQAhwcUtN2hJ8srdCKtr7/EYOoEn8HtJmBVafwqmjLt4e5OztHBPRZqfZAD
         utGaV3q/2zuwHn/9ZMfABfAgMj2ksstLKbCifueWL5Chx3u0ygwisbW6GKdOncQzvKbV
         vAI8j7vGrALYNdhZAf8Su69kjNhHrVQNyrh6dBM4avxg/MfuSqs7opuDqPP/NaQVTaNM
         89BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jcliF93zjSpaTafpPEiTUMAs8EwGUjS9FawXIfHTmOk=;
        b=LEwb5aYe2A1WlCmcevH48NX3b9OjWJLMcI2hHhERmWF6LhokZNVbDV53S98qf/Luti
         VzzLEGe9PQFhq06OdAwdIOFTCU3X+DVGykBMRicPOEg8vTWTPgAQ8LwviagJvsLKz1R2
         YzEbEbCe3tFRRdCmiBCaBWmQ1S+QNR+uLiTvHlktrjKZlWlnRCfTuM712o/ll60hPKkl
         VaX8j8uZqnfFpG1NsnE9TRra89qm86X3n9urC73ntTFdWzpwSXtubpmNm3Co8bmZkm/R
         91dJffPNJBUDZd6F8zQ8Y3otPookB70VHebbe7jxF6Kq3Klx5ObPLKiqr1ugF7K3QAcZ
         exWg==
X-Gm-Message-State: APjAAAUgQtJtIAIOyTKJAOrS+UMQ/8PuuCQaxiBHjxWAgiZn9xxGeNry
        55HAKZ4I/fK/6lSVDJiIKBU=
X-Google-Smtp-Source: APXvYqxKW2GcgOaxeK5224SHDsGkHzbQJTQX93RjK75sn/scNHmOLmbaQwd1RmNm9DzZM5chvQMwmw==
X-Received: by 2002:a6b:2b91:: with SMTP id r139mr996811ior.293.1569976653514;
        Tue, 01 Oct 2019 17:37:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id v69sm8149604ila.6.2019.10.01.17.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 17:37:32 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     adam.ford@logicpd.com, shawnguo@kernel.org,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx6q-logicpd: Fix 3.3V regulator on SDHC1
Date:   Tue,  1 Oct 2019 19:37:12 -0500
Message-Id: <20191002003713.21332-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVCC_SD1 is driven by a selector which chooses between 3.3V and
1.8.  Currently, this is pulled down by a 10k resistor, but
occasionally, voltage spikes on this rail cause the regulator to
jump between 1.8 and 3.3V.

This patch explicitly sets GPIO_19 to choose the 3.3V rail by
forcing this IO pin low to stabilize NVCC_SD1.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/imx6-logicpd-som.dtsi b/arch/arm/boot/dts/imx6-logicpd-som.dtsi
index 547fb141ec0c..233762acbaaf 100644
--- a/arch/arm/boot/dts/imx6-logicpd-som.dtsi
+++ b/arch/arm/boot/dts/imx6-logicpd-som.dtsi
@@ -15,6 +15,18 @@
 		reg = <0x10000000 0x80000000>;
 	};
 
+	reg_sdhc1: regulator-sdhc1 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_sdhc1>;
+		regulator-name = "reg_sdhc1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio4 5 GPIO_ACTIVE_LOW>;
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+
 	reg_wl18xx_vmmc: regulator-wl18xx {
 		compatible = "regulator-fixed";
 		regulator-name = "vwl1837";
@@ -267,6 +279,12 @@
 		>;
 	};
 
+	pinctrl_reg_sdhc1: regsdhc1grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_19__GPIO4_IO05	0x1b0b0
+		>;
+	};
+
 	pinctrl_tempsense: tempsensegrp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_CS2__GPIO6_IO15 0x1b0b0
@@ -343,7 +361,9 @@
 	non-removable;
 	keep-power-in-suspend;
 	wakeup-source;
+	no-1-8-v;
 	vmmc-supply = <&sw2_reg>;
+	vqmmc-supply = <&reg_sdhc1>;
 	status = "okay";
 };
 
-- 
2.17.1

