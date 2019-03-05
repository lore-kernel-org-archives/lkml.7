Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD66C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FAF2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L//TbXO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfCEHHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:07:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37650 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfCEHHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:07:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id s22so4993450pfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 23:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tE1o9iX8L+r84IgpiaHI1OuxaKLOrxKaDGgiYst47qI=;
        b=L//TbXO2bjFzqJeeuQvXqaqZl1Sw6JzCN4Ovu1osXQa6rU3RwCUbnQs7R+YGJtMcrZ
         RNQiipUuGD1rwtQ3ING+0BFvLpKZCE0CLTCElxWi69dxHqwrpTeVlhGLBW9shgHN7WpB
         GCNj3uUcnXRoNLjD5kV3HFrmpwU16nTbISOd1t6sboHB3EFLc3ugSucswsgXt/L3M7E+
         KiWDVfUFrZJW9BwW7CIuASCja/IqvT6GLy3aihDzllQWJKSXFTr8erQVF9+93tsHdinj
         YCNV89Up4PsFO5VMzTwxEIC1rGLEwVdsaybtNo/F3PS1B/D50c6QHx2Al+d6PTNhVpAr
         a/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tE1o9iX8L+r84IgpiaHI1OuxaKLOrxKaDGgiYst47qI=;
        b=emAfCfOD3GHxbk0XgNdawtwzhIEF2ErASrDeZtTwJdfIJCAYBaKdWVXoN/Bgej1tFp
         cb3IZHH9+/ADDv/freSGjTU4KxiBHb0M6RrgGyPkRMLiiNknUwx1gIeiHh0+Vka/qUtG
         hx4Cn425x/508ZyHGlMZHNyjBUqnZ1yvG/tnNdewMCDN61rA4Iqs5V+eJ4krDH9xJLui
         MD0p1eX+tPIB4sQ9UXL1JEPXVXQR4W6YoPCvZ5OxkFC2Qexr1gL3EKFsUstkPBzJ67bY
         DhN5h4z6KGG8fZst03NMwvkNxWSvExhTq+BUULYY4TTkMNxX38w4czFLyve1urKMv+8Y
         kqrA==
X-Gm-Message-State: APjAAAW9SHtzGH6z/nAemOGmi+7x1qdO7Q8nqZo1YaM+EPH435uoFcdU
        zVE5+nteVl6trltrscRGK6CLZQ==
X-Google-Smtp-Source: APXvYqwQFZxzjb9tKfZVkx/ZhjNJGU5vBD0E8VuRwqw/g3naJ9+9VJ7lnkCzvfyQw5Bx55dQonPHfg==
X-Received: by 2002:a17:902:8504:: with SMTP id bj4mr24026725plb.200.1551769658649;
        Mon, 04 Mar 2019 23:07:38 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l7sm30367662pfj.162.2019.03.04.23.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 23:07:38 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: qcs404-evb: Enable uart3 and add Bluetooth
Date:   Mon,  4 Mar 2019 23:08:23 -0800
Message-Id: <20190305070823.11845-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable blsp1_uart3, define its pinconf and add the bluetooth node.

It seems provisioning is lacking a valid BD address, preventing the
interface from initializing, so provide a dummy for now.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 536f735243d2..5c502e6db424 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -7,6 +7,7 @@
 / {
 	aliases {
 		serial0 = &blsp1_uart2;
+		serial1 = &blsp1_uart3;
 	};
 
 	chosen {
@@ -19,6 +20,32 @@
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	vdd_ch0_3p3:
+	vdd_esmps3_3p3: vdd-esmps3-3p3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "eSMPS3_3P3";
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
+
+&blsp1_uart3 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3990-bt";
+		vddio-supply = <&vreg_l6_1p8>;
+		vddxo-supply = <&vreg_l5_1p8>;
+		vddrf-supply = <&vreg_l1_1p3>;
+		vddch0-supply = <&vdd_ch0_3p3>;
+
+		local-bd-address = [ 02 00 00 00 5a ad ];
+
+		max-speed = <3200000>;
+	};
 };
 
 &remoteproc_adsp {
@@ -205,3 +232,21 @@
 		bias-disable;
 	};
 };
+
+&blsp1_uart3_default {
+	cts {
+		pins = "gpio84";
+		bias-disable;
+	};
+
+	rts-tx {
+		pins = "gpio85", "gpio82";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	rx {
+		pins = "gpio83";
+		bias-pull-up;
+	};
+};
-- 
2.18.0

