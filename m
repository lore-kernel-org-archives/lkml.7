Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61ABCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A917921925
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bv1lKagg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WYkSAqYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390771AbfJWJDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:03:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42388 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390750AbfJWJDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:03:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 71D3D60A74; Wed, 23 Oct 2019 09:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571821387;
        bh=16/3Qk33qTtXPZLtswsxSP4xNHGlzt5Ev3uNdsJNtYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bv1lKagg/BvQ2XTsYqFtwF+GhwG90Tn0QFIvs6cKtIKHQ990x8x2PPTOD2DAEGXg7
         kGKHxtRiUnoB2Atx2mq5yFt5w60Aa3fk4APtFJmkeYrfMVfZJdd3gEay2kwz1sDBlE
         r5sMShV+tnbc6cz1pP3ucxtFQ40H35es3p/2UG8Q=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94DE560D96;
        Wed, 23 Oct 2019 09:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571821386;
        bh=16/3Qk33qTtXPZLtswsxSP4xNHGlzt5Ev3uNdsJNtYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WYkSAqYbhgNpcqyIe8uTBd4ic2RMa9u6JX1Wiu+QOwMG3GnJxbUy4SKsHeDYJDNJk
         rXE9OHy7PFKenE56GcujWnmY9f48VFZoeF4tPxy3+afuh+xR3Kw0ldi1AWbd2i0/2t
         bIvYETKbsGlgxtMlZ2+9QQFLLKb3hXlsjGbliAo0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94DE560D96
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v3 07/11] arm64: dts: qcom: sc7180: Add SPMI PMIC arbiter device
Date:   Wed, 23 Oct 2019 14:32:15 +0530
Message-Id: <20191023090219.15603-8-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191023090219.15603-1-rnayak@codeaurora.org>
References: <20191023090219.15603-1-rnayak@codeaurora.org>
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
index 04808a07d7da..6584ac6e6c7b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -224,6 +224,25 @@
 			};
 		};
 
+		spmi_bus: spmi@c440000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0 0xc440000 0 0x1100>,
+			      <0 0xc600000 0 0x2000000>,
+			      <0 0xe600000 0 0x100000>,
+			      <0 0xe700000 0 0xa0000>,
+			      <0 0xc40a000 0 0x26000>;
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

