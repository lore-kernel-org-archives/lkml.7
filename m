Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2B5C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC0521721
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565787138;
	bh=yeBAsV9wsLsSufBVbD1jJS7wrJSACIFA1hoU8KqV5kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PRns4reCw4QaT7nBoklRIkp93HJtWiUJG3M9EueZq6rCqXsrX61s8EV3AZFbQd0aQ
	 dSaWppqB8uQEcepMFtOIs14D1Rm8yuq8bsrNqhCPmk5+7nl2cd8YeW+MS70yPrZYyZ
	 fyoJxI4k+HortHcMZz2ylDdjRkdB5qQLyY+7v0LE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfHNMwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHNMwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:52:14 -0400
Received: from localhost.localdomain (unknown [171.76.115.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8504C206C2;
        Wed, 14 Aug 2019 12:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565787133;
        bh=yeBAsV9wsLsSufBVbD1jJS7wrJSACIFA1hoU8KqV5kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDSMH69tTFr6WcoUkLpAedqFp9WjNowGTFilngHPI/dShg3Dt5PnkPMki6jozh+bq
         fkoEbxDn9Auf5o9yJixpyhpNF7TV147Gr4BX+3L5zorTxAhMTr7Cpcw6v0dKGVB12i
         7g0kg28/tqBu0n0C5/bjWirMCHX1jRNqB4/PAzM8=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/22] arm64: dts: qcom: pm8150: Add pon and rtc nodes
Date:   Wed, 14 Aug 2019 18:19:57 +0530
Message-Id: <20190814125012.8700-8-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814125012.8700-1-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PM8150 PMIC contains pon and rtc devices so add nodes for these.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pm8150.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index b533e254a203..2cb727ce30eb 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -2,6 +2,7 @@
 // Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
 // Copyright (c) 2019, Linaro Limited
 
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
@@ -12,6 +13,25 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pon: pon@800 {
+			compatible = "qcom,pm8916-pon";
+			reg = <0x0800>;
+			pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				linux,code = <KEY_POWER>;
+			};
+		};
+
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
+		};
+
 		pm8150_gpios: gpio@c000 {
 			compatible = "qcom,pm8150-gpio";
 			reg = <0xc000>;
-- 
2.20.1

