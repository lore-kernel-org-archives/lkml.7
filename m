Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E667C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 16:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78AD20B1F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 16:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHSAFu/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDFQBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 12:01:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46727 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfDFQBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 12:01:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so11354668wrw.13;
        Sat, 06 Apr 2019 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TWy7YAMuzaPSs58knLCiZ9Z/DyS8fzrxZF3xNjO2PHQ=;
        b=jHSAFu/Sx3sNx21yayGsjh4oNvpejDrQpLtvSim7VkrlnTbPJS7vBL2k4VLpOHtm3T
         tiw7oAJmwBYZzrDGSx7FrFXMzUxtpzLLdPEAFJG74HbAjA/6FEip/47dZ9qfDjhOREwD
         FAtGQySYl0YCn/d3F6pg8dMk2oAdjQ7kpIBhpdemxfYNCNMTzJCl3kGhhtt71U06ToJ1
         AyZxrxNgPyKYTP63Cy32KJTp0t7bwkpHR0i1i399xVTRUIHUhSJBXS+rl0tK2J1a5I9y
         pl3vLvtEJD8XowNZu/upbb31wbNefrXe/5/+UQwke7/Mp5AI0Qs0FopyB1GwwwPglOpX
         7uXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TWy7YAMuzaPSs58knLCiZ9Z/DyS8fzrxZF3xNjO2PHQ=;
        b=HlAWEEsvSbMr33rb6+Za7T/Se28yKCCl3d6sZ3+gIHKQo5uPuq/VckXrSLyf5XysZK
         xZ/8IoyP5cFhOvvIaGnEEr+2lzV7sSQVtsaB++0VTmUMk0/brh8lQl3jiy2egdEUVJgE
         R7fD4RwcomJlQeHQPyAE9f20VYydvF6eqHtupQfflQ3hQNzNtc2cY25uE6Y2M/k4PAos
         70I4kXfmNQ6JUUeCSwoG1l1TnjYjr6Lyn9ZU2HoNIr1RsNJZjpTHPeWbKH+u+U1n1V6B
         5kP+4Jp3s3CuwN/Mv6RCQvTllf/ORWHhmHFZuIfb9ZgYHxtVK+bwzprZaDsfMnK7jP5P
         O1ng==
X-Gm-Message-State: APjAAAWAihTu5NLq2AOVetBwO/XqCgKQfTGfiNVpDlCgGfcenNJ0c/Aq
        afiAxVjvK/ZmSHU5LD0BZfo=
X-Google-Smtp-Source: APXvYqxllgkItiPOaeiRWRKEddGAEcjk7sUHoUI6OmzHs7L2ytR2dCB7gea8rOy3UKW8V+5ni/lkxw==
X-Received: by 2002:a5d:4646:: with SMTP id j6mr4635017wrs.56.1554566479387;
        Sat, 06 Apr 2019 09:01:19 -0700 (PDT)
Received: from armhf-buildhost.asgard.net (ipbcc343bd.dynamic.kabel-deutschland.de. [188.195.67.189])
        by smtp.gmail.com with ESMTPSA id z8sm24783828wrh.80.2019.04.06.09.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Apr 2019 09:01:18 -0700 (PDT)
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
Subject: [PATCH] ARM: dts: imx6qdl-udoo: Add Pincfgs for OTG
Date:   Sat,  6 Apr 2019 18:00:20 +0200
Message-Id: <1554566420-1008-1-git-send-email-kueffner.markus@gmail.com>
X-Mailer: git-send-email 2.1.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Pincfgs to enable the i.MX6's OTG feature for UDOO

Signed-off-by: Markus Kueffner <kueffner.markus@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-udoo.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index 776bfc7..42954ee 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -221,6 +221,14 @@
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
 		pinctrl_ac97_running: ac97running {
 			fsl,pins = <
 				MX6QDL_PAD_DI0_PIN2__AUD6_TXD		0x1b0b0
@@ -294,6 +302,14 @@
 	status = "okay";
 };
 
+&usbotg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	fsl,power-line-polarity-active-high;
+	fsl,over-current-polarity-active-low;
+	status = "okay";
+};
+
 &audmux {
 	status = "okay";
 };
-- 
2.1.4

