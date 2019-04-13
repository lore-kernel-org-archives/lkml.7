Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C048AC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 13:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D20220818
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 13:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpcoiE4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfDMNUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 09:20:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53991 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfDMNUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 09:20:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so14511747wmj.3;
        Sat, 13 Apr 2019 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Ps806CbdF+Vy9hVqCMx6Y1YhgnAdCgwxnXGiSyCaEg=;
        b=BpcoiE4Adxrg4N1BoLEAfDPPJuKsGZ/w9WV0r1Nbo6vbMprxGid6Wh+qz4xHZBaepI
         bwl/eA16HWdC1PPOibh41/yN50JQ1WArFm0rNHZLUzJn/BrOxBGsIhveWn5YCq8xUCJS
         +T1zKo36iZuT3EsHhYhjB8LytfF4GKHfpm+zSqaGZJhTZ/ips5ag3fGXLkU8kk7ITC18
         3ydyeVs1FTX/jqp5CgUQq1w/EhUGlnFAlEhOGkUSfBDE3mTlQ+r+Xm+jIOQA9xoQNuaR
         Pfx6VjVb179l4ozTCl8r2r39l0GF1FhvIyj4m1YUUPFGvU46eIO4IvW529Q9VhmmMYxB
         1inQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Ps806CbdF+Vy9hVqCMx6Y1YhgnAdCgwxnXGiSyCaEg=;
        b=YtrKlmN4Ftn3FZrIJ6l9QwRRyZEzHME+exZisR8lYPqLSk0C3LN/UpNfnyBfCfNqJQ
         A4nVAW83D926TEapE/3rALrcwuWt3ASYckticHPzpDLyymks4alVBCYmrOG2+zF3HzaP
         OJaG0W2NNQh6zL38J/N2javF4RZWbhKnDRQH9FwkV7MoIgTqc+1IQjaZY/9uhVS7Yaak
         SEDN7YWKWmIFAPAaR14dmTdkqMuWC2amTu8Et9hH2hAI6oUkkuHx0DGDXi6P2uajUKVc
         VA5wjazV3hnXwT3ncsCUMTNFz7p2O3kGYxSfBDHB7il5qZRbUEG0EFMJ29nVgeaDF6PH
         ONIw==
X-Gm-Message-State: APjAAAUr7vT+weFQGW1VOk60jpz25r+qoDa0mNId9PigeyH4k0w0QSI5
        p7ZSB8tpY37GyLFTiQW5j1Q=
X-Google-Smtp-Source: APXvYqwndRez9Ma90oSRugf9B3xHU/oB5jsPkQSqvwWCZoZzKixi8v0HBnq+8WDJ7i876bVZUqhnRg==
X-Received: by 2002:a1c:2d45:: with SMTP id t66mr15236392wmt.106.1555161621194;
        Sat, 13 Apr 2019 06:20:21 -0700 (PDT)
Received: from armhf-buildhost.asgard.net (ipbcc343bd.dynamic.kabel-deutschland.de. [188.195.67.189])
        by smtp.gmail.com with ESMTPSA id g8sm71659835wro.77.2019.04.13.06.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 06:20:20 -0700 (PDT)
From:   Markus Kueffner <kueffner.markus@gmail.com>
Cc:     Markus Kueffner <kueffner.markus@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: imx6qdl-udoo: Add Pincfgs for OTG
Date:   Sat, 13 Apr 2019 15:19:36 +0200
Message-Id: <1555161577-1533-1-git-send-email-kueffner.markus@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <20190411065440.GB26817@dragon>
References: <20190411065440.GB26817@dragon>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Pincfgs to enable the i.MX6's OTG feature for UDOO

Signed-off-by: Markus Kueffner <kueffner.markus@gmail.com>
---
Changes in v2:
- put pinctrl_usbotg node after pinctrl_usbh as suggested
- remove unsupported properties from &usbotg

 arch/arm/boot/dts/imx6qdl-udoo.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index 776bfc7..828dd20 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -210,6 +210,14 @@
 			>;
 		};
 
+		pinctrl_usbotg: usbotg {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x17059
+				MX6QDL_PAD_EIM_D22__USB_OTG_PWR 0x17059
+				MX6QDL_PAD_EIM_D21__USB_OTG_OC 0x17059
+			>;
+		};
+
 		pinctrl_usdhc3: usdhc3grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
@@ -287,6 +295,12 @@
 	status = "okay";
 };
 
+&usbotg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	status = "okay";
+};
+
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
-- 
2.1.4

