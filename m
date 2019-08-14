Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D090BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77DD206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565787122;
	bh=YdtxPf4XXyQuYQucX40BXQ2HBXw1BGso1F7v/Ha34ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JhTVgtICE+46aodAygacRpPV3Sv4WiOA+Fav1jPGCVymnlguZOejmnZx/tYV8qY8t
	 zJTCVZnoQQ3vBAv3sQheBdSua7KqUEIjozxWK1L5AkbswP7IflXfe2GdEdLbYadShV
	 OHL8EJ9ODnGqnK34GS/3iUYKzrVqU0ZE3Oj4OJvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfHNMwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHNMv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:51:58 -0400
Received: from localhost.localdomain (unknown [171.76.115.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCA29206C2;
        Wed, 14 Aug 2019 12:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565787118;
        bh=YdtxPf4XXyQuYQucX40BXQ2HBXw1BGso1F7v/Ha34ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=op3unB+Qa3Tj6B2MeB+KYSU4h+54f6a0mM1pJtGL/5iMjRGuWM47QDFvkbyuTrYhe
         bGwlaAkl6XDINGncLOZ7b1f3AP887ixWkJDbpFKdz5Mjgfh18fZVw3f2llreIgJnfH
         AmBB9U2dmlj3JRvyr7aq2cFUIusThc84X6Sz6IGg=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/22] arm64: dts: qcom: sm8150: add tlmm node
Date:   Wed, 14 Aug 2019 18:19:53 +0530
Message-Id: <20190814125012.8700-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814125012.8700-1-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index cd9fcadaeacb..5f2f21270e2d 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -189,6 +189,21 @@
 			};
 		};
 
+		tlmm: pinctrl@3100000 {
+			compatible = "qcom,sm8150-pinctrl";
+			reg = <0x03100000 0x300000>,
+			      <0x03500000 0x300000>,
+			      <0x03900000 0x300000>,
+			      <0x03D00000 0x300000>;
+			reg-names = "west", "east", "north", "south";
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-ranges = <&tlmm 0 0 175>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			interrupt-controller;
-- 
2.20.1

