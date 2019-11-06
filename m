Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B8AC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A76B2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gr1EjVwR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ha/6bioh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbfKFGvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 01:51:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45910 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731312AbfKFGva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:51:30 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 43EA861330; Wed,  6 Nov 2019 06:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573023089;
        bh=fEZf00z8jps2/hBakpFD4q4oJwFCmwz6uh5j1HvyHGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gr1EjVwR/YYSypvnPNaiKqSaHpVajuqMu260kd+1RBjwZqrUo9+z13dnfcyGZiu72
         7Fqgm4glJOkXxPnU2ZflNEkPwOrg5xyKXbRBPgPXVAQ/SGX2izevJXqsUV5rsu5oig
         Cg6CaVLa0K5Tf1IySf53zrvi/pIrOLlUwLyo3Kbw=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2118061328;
        Wed,  6 Nov 2019 06:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573023088;
        bh=fEZf00z8jps2/hBakpFD4q4oJwFCmwz6uh5j1HvyHGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ha/6biohQkrC6w7w1MTUZLZ54shCduDoxdDOgMY8HKuQDTgJ3FAWUlFdykSqaRgfM
         3FedQUTMnStp+6OKU69UIgg9uxefv32DP4QgTulAS4ptQiuvfbKUNlrRgFyppyv2mQ
         AP0n2mMkQm5AYkfwQI3uSBaBDy5AiqLwXTeXfXRg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2118061328
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        swboyd@chromium.org, Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v4 10/14] arm64: dts: qcom: sc7180: Add SPMI PMIC arbiter device
Date:   Wed,  6 Nov 2019 12:20:13 +0530
Message-Id: <20191106065017.22144-11-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191106065017.22144-1-rnayak@codeaurora.org>
References: <20191106065017.22144-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kiran Gunda <kgunda@codeaurora.org>

Add SPMI PMIC arbiter device to communicate with PMICs
attached to SPMI bus.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 14b8986c8a5f..ff0197df9a7f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -233,6 +233,25 @@
 			};
 		};
 
+		spmi_bus: spmi@c440000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0 0x0c440000 0 0x1100>,
+			      <0 0x0c600000 0 0x2000000>,
+			      <0 0x0e600000 0 0x100000>,
+			      <0 0x0e700000 0 0xa0000>,
+			      <0 0x0c40a000 0 0x26000>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+			cell-index = <0>;
+		};
+
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sc7180-smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x100000>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

