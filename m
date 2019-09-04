Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CD8C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40392339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBQ/mzBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfIDLJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:09:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54285 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfIDLJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:09:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id k2so2816508wmj.4;
        Wed, 04 Sep 2019 04:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sIOd0MuDnfj87B/FqKAPDluIjsWQPUM9aaqhRZ0bJws=;
        b=aBQ/mzBv92LVsEYtD/af016oft/3nD6ld0mcxbE5Y2xiUP1KehAH0S/MRbaSPT9hxh
         R5BWzoWPVPUUy15zoFq28mabmqic7S3dNCXhrapNv9x9J2Y5aL3XHXGNEnv3SjcMf+dw
         QyiNinW9lfztPAuqWPjgWH9QxBq3ZGKn/N/YiIXVFoLyk850amAG18uVGafYvzH8ta9w
         1gaUYN6b7kfcowCzSFxlMy8w4vlRG3q9nTk0032WhcTl9RnAC4AJ+sStJp5TkyKPVg9c
         wJd8dy7Uxt8IE1jo5Eu03aFVMmyANMo0Y8Zg71kUL7aZIydSlYqCjyuUxuBQWYQ66QnT
         zxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sIOd0MuDnfj87B/FqKAPDluIjsWQPUM9aaqhRZ0bJws=;
        b=L7KeubbrI73QSBJuTAUpUn5fWEjXzcNYTznU4WkCKnnbrJR7k04Gjrw2L6EiFNUHtA
         lQnceP7cP+wMWsFyy7czLJWlAmvHV81PSE7nzkShRCAQx2hipfbVW0wv+Q+EfKx9JpH9
         je3zk5FnHtxIZYeS/v1EWfozSr7CDbSicxZ+/RWAdLujLbEUIqKwgSmTGA2CCVBUt3FZ
         Gzg6Z+0aWfk7cKLSVBiErk4x7Pd5BMnYjQxPE7VnFjKyyNh3ppxZdKDpdFVEG8HLmOg0
         dnIodH5/DQ4qYrLWmkG/ICqCftm0LDHXs4Mt5xrZ4dyBFpEeEGc+t1RK0DQO8uKzEmx/
         uwfA==
X-Gm-Message-State: APjAAAVvIriVZ0NaMVg9V9KsJ/EUUmWRnOhdzH6/A6xi8wimwb73IPtv
        dH36thE6LJyxmlkH9pNREEN5iNMSlGo=
X-Google-Smtp-Source: APXvYqxEJDfwjcP23hJH0xu5WSvauV5r7xgP+gXLFvs8HgKoNnxvyZ3Ch6on0sEn1mW2+TwfvJQyZA==
X-Received: by 2002:a1c:cfc9:: with SMTP id f192mr3646204wmg.85.1567595359553;
        Wed, 04 Sep 2019 04:09:19 -0700 (PDT)
Received: from localhost ([194.105.145.90])
        by smtp.gmail.com with ESMTPSA id i93sm28412998wri.57.2019.09.04.04.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 04:09:18 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     m.felsch@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, marcel@ziswiler.com,
        marcel.ziswiler@toradex.com, stefan@agner.ch
Subject: [PATCH v3 1/1] ARM: dts: colibri: introduce dts with UHS-I support enabled
Date:   Wed,  4 Sep 2019 14:09:18 +0300
Message-Id: <20190904110918.25009-1-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Opaniuk <igor.opaniuk@toradex.com>

Introduce DTS for Colibri iMX6S/DL V1.1x re-design, where UHS-I support was
added. Provide proper configuration for VGEN3, which allows that rail to
be automatically switched to 1.8 volts for proper UHS-I operation mode.

Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

v3:
- change hierarchy according to Marco's suggestions [Marco Felsch]
- adjust compatible string adding v1.1 [Stefan Agner]

v2:
- rework hierarchy of dts files, and a separate dtsi for Colibri
  iMX6S/DL V1.1x re-design, where UHS-I was added [Marcel Ziswiler]
- add comments about vgen3 power rail [Marcel Ziswiler]
- fix other minor issues, addressing Marcel's comments. [Marcel Ziswiler]

 arch/arm/boot/dts/Makefile                    |  1 +
 .../boot/dts/imx6dl-colibri-v1_1-eval-v3.dts  | 59 +++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-colibri.dtsi        | 11 +++-
 3 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9159fa2cea90..87dfc3db4343 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -401,6 +401,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-aristainetos2_4.dtb \
 	imx6dl-aristainetos2_7.dtb \
 	imx6dl-colibri-eval-v3.dtb \
+	imx6dl-colibri-v1_1-eval-v3.dtb \
 	imx6dl-cubox-i.dtb \
 	imx6dl-cubox-i-emmc-som-v15.dtb \
 	imx6dl-cubox-i-som-v15.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
new file mode 100644
index 000000000000..92fcf4e62ba2
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
+/*
+ * Copyright 2019 Toradex AG
+ */
+
+/dts-v1/;
+
+#include "imx6dl-colibri-eval-v3.dts"
+
+/ {
+	model = "Toradex Colibri iMX6DL/S V1.1 on Colibri Evaluation Board V3";
+	compatible = "toradex,colibri_imx6dl-v1_1-eval-v3",
+		     "toradex,colibri_imx6dl-v1_1",
+		     "toradex,colibri_imx6dl-eval-v3",
+		     "toradex,colibri_imx6dl",
+		     "fsl,imx6dl";
+};
+
+&iomuxc {
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x170b1
+			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x100b1
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x170b1
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x170b1
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x170b1
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x170b1
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x170f1
+			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x100f1
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x170f1
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x170f1
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x170f1
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x170f1
+		>;
+	};
+};
+
+/* Colibri MMC */
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_mmc_cd>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_mmc_cd>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz &pinctrl_mmc_cd>;
+	vmmc-supply = <&reg_module_3v3>;
+	vqmmc-supply = <&vgen3_reg>;
+	enable-sdio-wakeup;
+	keep-power-in-suspend;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+	/delete-property/no-1-8-v;
+};
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 1beac22266ed..27097ab5eaab 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -215,7 +215,16 @@
 				regulator-always-on;
 			};
 
-			/* vgen3: unused */
+			/*
+			 * +V3.3_1.8_SD1 coming off VGEN3 and supplying
+			 * the i.MX 6 NVCC_SD1.
+			 */
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
 
 			vgen4_reg: vgen4 {
 				regulator-min-microvolt = <1800000>;
-- 
2.17.1

