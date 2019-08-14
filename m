Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01F1C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1382083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565787130;
	bh=OTu/rVwYzp82ReggRCSSQw57VpPiQ6WZYNxd+LzJVUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wM8ATZvIQCaFWufnFAngHJSE0A0oqjmsA4LOcV3KeJ/GDo0W4x0yFPufa4eckK9uP
	 qyIi0W3NQAG9byFMY6Xi9PLre6L4jwiWUjsQZPMWKoFTRKKXgTGobNjYDctmER7+7M
	 wON+MJ3i00oMgtmI5Ki3tuV0IVjwLRDnOCf0eYB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfHNMwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:52:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHNMwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:52:06 -0400
Received: from localhost.localdomain (unknown [171.76.115.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC61221721;
        Wed, 14 Aug 2019 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565787126;
        bh=OTu/rVwYzp82ReggRCSSQw57VpPiQ6WZYNxd+LzJVUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SiBdvYwInZVlBtKvONEoLS8fcRjvGgPbk8jJSgibBwntoXu3xi0mXnmFGYOcp0hGf
         /GL7O2oN6K1BdLyUsnPRkSoQuLLGdy6WFkmRBN4s7hcgdfubhLc0jwR6ok6aHBtOlR
         1Y61tMRXZDk3WwpjmtF768UKMjVtGGh2zOxqyx6E=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/22] arm64: dts: qcom: sm8150: Add spmi node
Date:   Wed, 14 Aug 2019 18:19:55 +0530
Message-Id: <20190814125012.8700-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814125012.8700-1-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPMI node which is used for spmi_bus

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 5f2f21270e2d..5c6b103b042b 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -272,6 +272,24 @@
 			};
 		};
 
+		spmi_bus: spmi@c440000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x0c440000 0x0001100>,
+			      <0x0c600000 0x2000000>,
+			      <0x0e600000 0x0100000>,
+			      <0x0e700000 0x00a0000>,
+			      <0x0c40a000 0x0026000>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts = <GIC_SPI 481 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+			cell-index = <0>;
+		};
 	};
 
 	timer {
-- 
2.20.1

