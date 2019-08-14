Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467CEC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CA02173E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565787164;
	bh=12jQA7SKu9YWp05BoGshP3ZwcVafGjl4GiaRbND/YMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mKzztFz62g4xGJENEjhZuOTuylgA+y8JZkADiAsLE36DCMGy9C6Sn4Ug4lm9mhuNQ
	 Wnvo78sCt9xPG0BCu6PNyR8l8Lhp+ANKYpFgwvvkuHeyxS4XwEWFM26CQ54cfpFD2t
	 +vtn15WLKCx7SQ3xw8MW17mHZAL9QwQP99QXOXBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfHNMwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727687AbfHNMwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:52:41 -0400
Received: from localhost.localdomain (unknown [171.76.115.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B66382173E;
        Wed, 14 Aug 2019 12:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565787161;
        bh=12jQA7SKu9YWp05BoGshP3ZwcVafGjl4GiaRbND/YMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fkHc2JmOf1Tx4Hqp4VoD5knj/EBXXSLxiY1jo6zsjxQPqFtJiyDeSr1cafElFC5H6
         wlRQUjXJb24Zn/IBGwUQbcv8v9oNRY21Xm4F2N8DlY27LLkvDd0kFf7II2jPW6JsnQ
         ScGjGv34zWjH+J8yHiPrTY76guraDOnfOtAoP0ow=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/22] arm64: dts: qcom: pm8150l: Add gpio node
Date:   Wed, 14 Aug 2019 18:20:04 +0530
Message-Id: <20190814125012.8700-15-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814125012.8700-1-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the gpio node found in pm8150l PMIC.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pm8150l.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index d685dac426a3..dce72bff0e7a 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -44,6 +44,25 @@
 				label = "die_temp";
 			};
 		};
+
+		pm8150l_gpios: gpio@c000 {
+			compatible = "qcom,pm8150l-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <0x4 0xc0 0 IRQ_TYPE_NONE>,
+				     <0x4 0xc1 0 IRQ_TYPE_NONE>,
+				     <0x4 0xc2 0 IRQ_TYPE_NONE>,
+				     <0x4 0xc3 0 IRQ_TYPE_NONE>,
+				     <0x4 0xc4 0 IRQ_TYPE_NONE>,
+				     <0x4 0xc5 0 IRQ_TYPE_NONE>,
+				     <0x4 0xc6 0 IRQ_TYPE_NONE>,
+				     <0x4 0xc7 0 IRQ_TYPE_NONE>,
+				     <0x4 0xc8 0 IRQ_TYPE_NONE>,
+				     <0x4 0xc9 0 IRQ_TYPE_NONE>,
+				     <0x4 0xca 0 IRQ_TYPE_NONE>,
+				     <0x4 0xcb 0 IRQ_TYPE_NONE>;
+		};
 	};
 
 	qcom,pm8150@5 {
-- 
2.20.1

