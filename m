Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F3DCA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE9121855
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="trPLlTjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfKBAb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 20:31:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35762 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbfKBAb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 20:31:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id c8so7471622pgb.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 17:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IzNtFT+Ywg6fAANt4Dbe5JETPNXOEpHrB/MK+SSdmpc=;
        b=trPLlTjmU0FOKvC+IFGbJIX6Xg3RtTJc6kQWsSfAflR2mK+AOUsDDE+k9iVRLEIVjg
         nqSWWL17ieUWYq6S4NmnIPOfNZPCVo3nF1/jTaDgNDXgGoeki1QEflduK941OcBgvnXC
         F6LwbHizOMV4TXEs8EYBiKGixJaJqZ1y2capBCXogKe4RmlVA+h6XN7KA6U+2xMwOZCI
         PDwbcu+WSAXSRz5Iy+A61/8cY/wKKE4nOl3sRUKKvvujpzwCdFfTp5C6bYgAgsAxvvjJ
         Pewv6Dh/Sp5MPGtttGIQ/d9dJLWAXWCLl/N2WsUl3ZNHofgZRJ9GmnMzMbk6+nqjji7K
         HexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IzNtFT+Ywg6fAANt4Dbe5JETPNXOEpHrB/MK+SSdmpc=;
        b=JAREMXjH6kAzSv77wqyyz7pi3f4OZmEqX9l0/MXnI0ucLSCP4bBPvyVOPfEE7qwjEj
         H92XQlegUYoS8g2Z2sc42tV6pMeOcJ5HRXl7r8G0uz0fVli5/JuT1UvfooJRp70tMwvc
         B4hTFyid2m3DmCUpTvpps2ruK+PsOXBmu12PRsshYQrHgFecWPuQDRpwQpm8fimu+F9y
         aXB8GqbRpSFWOiul3U+ypEruAWVan1Qj5Z7VJpswohlISSnUU6oM97LTL+fNwnq5GR23
         8Mnxxn8izcxRds644qrsHtf9pIIJcdxyVYHqngtVlWIIordCEm/i5lZ+Y8J8utai9RTz
         A5Ng==
X-Gm-Message-State: APjAAAU0j9nwvdtFrQ9a6gdOpY6gautJxTJivp3Ys35rW3kX5VybVL/R
        rqnO6SdG2jX6fWeRZdbf/x7QSA==
X-Google-Smtp-Source: APXvYqytbiz95EC/cgJxnFlwqHQtaYez+AuORPX6vKWHXecRxc/A0TOfu4PpQ3ilxIqO+VriFYELqw==
X-Received: by 2002:a63:e055:: with SMTP id n21mr16303184pgj.411.1572654715530;
        Fri, 01 Nov 2019 17:31:55 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v2sm7957522pfm.13.2019.11.01.17.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 17:31:54 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: db845c: Enable PCIe controllers
Date:   Fri,  1 Nov 2019 17:31:48 -0700
Message-Id: <20191102003148.4091335-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191102003148.4091335-1-bjorn.andersson@linaro.org>
References: <20191102003148.4091335-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the two PCIe controllers found on the Dragonboard845c.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index f5a85caff1a3..c314b5d55796 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -340,6 +340,39 @@
 			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>;
 };
 
+&pcie0 {
+	status = "okay";
+	perst-gpio = <&tlmm 35 GPIO_ACTIVE_LOW>;
+	enable-gpio = <&tlmm 134 GPIO_ACTIVE_HIGH>;
+
+	vddpe-3v3-supply = <&pcie0_3p3v_dual>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_default_state>;
+};
+
+&pcie0_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l26a_1p2>;
+};
+
+&pcie1 {
+	status = "okay";
+	perst-gpio = <&tlmm 102 GPIO_ACTIVE_LOW>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_default_state>;
+};
+
+&pcie1_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l26a_1p2>;
+};
+
 &pm8998_gpio {
 	vol_up_pin_a: vol-up-active {
 		pins = "gpio6";
@@ -382,6 +415,31 @@
 };
 
 &tlmm {
+	pcie0_default_state: pcie0-default {
+		clkreq {
+			pins = "gpio36";
+			function = "pci_e0";
+			bias-pull-up;
+		};
+
+		reset-n {
+			pins = "gpio35";
+			function = "gpio";
+
+			drive-strength = <2>;
+			output-low;
+			bias-pull-down;
+		};
+
+		wake-n {
+			pins = "gpio37";
+			function = "gpio";
+
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
 	pcie0_pwren_state: pcie0-pwren {
 		pins = "gpio90";
 		function = "gpio";
@@ -390,6 +448,39 @@
 		bias-disable;
 	};
 
+	pcie1_default_state: pcie1-default {
+		perst-n {
+			pins = "gpio102";
+			function = "gpio";
+
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		clkreq {
+			pins = "gpio103";
+			function = "pci_e1";
+			bias-pull-up;
+		};
+
+		wake-n {
+			pins = "gpio11";
+			function = "gpio";
+
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		reset-n {
+			pins = "gpio75";
+			function = "gpio";
+
+			drive-strength = <16>;
+			bias-pull-up;
+			output-high;
+		};
+	};
+
 	sdc2_default_state: sdc2-default {
 		clk {
 			pins = "sdc2_clk";
-- 
2.23.0

