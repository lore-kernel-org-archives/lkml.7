Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58E6C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7994726715
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="JKVOa9SA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfEaJqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:46:38 -0400
Received: from onstation.org ([52.200.56.107]:51364 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfEaJqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:46:33 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 96F1E45087;
        Fri, 31 May 2019 09:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1559295992;
        bh=P7el3Xz8wlBT8PxKKUD6xEjlNmXFaxsNrW/042rvrXc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JKVOa9SAa7kA2Lli3+GkWmtyF8MNZPxXaea7LmxpPJnge8YifcrGodkFsm8APowey
         Gf7GreekdN/kCh7UNbAXSlfs0p6N7JyTLs1oif1tKegAr9Pe6YhkQK1Nb+gXSyWLqZ
         B/wxNfa1E+rVqfIeHzxq7wcMu7mq2yC05inAeVIA=
From:   Brian Masney <masneyb@onstation.org>
To:     robdclark@gmail.com, sean@poorly.run,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        jonathan@marek.ca, robh@kernel.org, jeffrey.l.hugo@gmail.com
Subject: [PATCH v3 6/6] ARM: dts: qcom: msm8974-hammerhead: add support for display
Date:   Fri, 31 May 2019 05:46:19 -0400
Message-Id: <20190531094619.31704-7-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531094619.31704-1-masneyb@onstation.org>
References: <20190531094619.31704-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for the display found on the LG Nexus 5 (hammerhead)
phone. This is based on work from Jonathan Marek.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 51889d66b55a..4776f01f492c 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -332,6 +332,16 @@
 				function = "gpio";
 			};
 		};
+
+		panel_pin: panel {
+			te {
+				pins = "gpio12";
+				function = "mdp_vsync";
+
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
 	};
 
 	vibrator@fd8c3450 {
@@ -531,6 +541,54 @@
 			};
 		};
 	};
+
+	mdss@fd900000 {
+		status = "ok";
+
+		mdp@fd900000 {
+			status = "ok";
+		};
+
+		dsi@fd922800 {
+			status = "ok";
+
+			vdda-supply = <&pm8941_l2>;
+			vdd-supply = <&pm8941_lvs3>;
+			vddio-supply = <&pm8941_l12>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ports {
+				port@1 {
+					endpoint {
+						remote-endpoint = <&panel_in>;
+						data-lanes = <0 1 2 3>;
+					};
+				};
+			};
+
+			panel: panel@0 {
+				reg = <0>;
+				compatible = "lg,acx467akm-7";
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&panel_pin>;
+
+				port {
+					panel_in: endpoint {
+						remote-endpoint = <&dsi0_out>;
+					};
+				};
+			};
+		};
+
+		dsi-phy@fd922a00 {
+			status = "ok";
+
+			vddio-supply = <&pm8941_l12>;
+		};
+	};
 };
 
 &spmi_bus {
-- 
2.20.1

