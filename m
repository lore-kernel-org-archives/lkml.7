Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B40C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC7020740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z3bvyxB5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z3bvyxB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfKOWSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:18:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47738 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfKOWRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:17:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ED7CF611F4; Fri, 15 Nov 2019 22:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573856273;
        bh=mIQ4v4TtXbKkzUHo+zgoS3YSMUO7ZwTbJ8+SwRHFG9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z3bvyxB5UbcRwwSBI3GloVhnUs+yrIaCXFi2xn/k9OLOnboAgc9vmdFNViS/wWN6S
         uUllXAQPLeE+hKN34GTUtxaNwz8U1Y6F31d8iCvAeRykGoPlpCa0cV8h3IjMvBo6n3
         8CX4JvEEn3iknisAa6LfAO+xq8yOOcF3aOlRhb9Q=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6694C611B8;
        Fri, 15 Nov 2019 22:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573856273;
        bh=mIQ4v4TtXbKkzUHo+zgoS3YSMUO7ZwTbJ8+SwRHFG9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z3bvyxB5UbcRwwSBI3GloVhnUs+yrIaCXFi2xn/k9OLOnboAgc9vmdFNViS/wWN6S
         uUllXAQPLeE+hKN34GTUtxaNwz8U1Y6F31d8iCvAeRykGoPlpCa0cV8h3IjMvBo6n3
         8CX4JvEEn3iknisAa6LfAO+xq8yOOcF3aOlRhb9Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6694C611B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, maz@kernel.org, linus.walleij@linaro.org,
        bjorn.andersson@linaro.org
Cc:     evgreen@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, agross@kernel.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v2 10/12] arm64: dts: qcom: add PDC interrupt controller for SDM845
Date:   Fri, 15 Nov 2019 15:11:53 -0700
Message-Id: <1573855915-9841-11-git-send-email-ilina@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573855915-9841-1-git-send-email-ilina@codeaurora.org>
References: <1573855915-9841-1-git-send-email-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PDC interrupt controller device bindings for SDM845.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index da8aa59..fb060a4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2939,6 +2939,15 @@
 			#power-domain-cells = <1>;
 		};
 
+		pdc_intc: interrupt-controller@b220000 {
+			compatible = "qcom,sdm845-pdc", "qcom,pdc";
+			reg = <0 0x0b220000 0 0x30000>;
+			qcom,pdc-ranges = <0 480 94>, <94 609 15>, <115 630 7>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+		};
+
 		pdc_reset: reset-controller@b2e0000 {
 			compatible = "qcom,sdm845-pdc-global";
 			reg = <0 0x0b2e0000 0 0x20000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

