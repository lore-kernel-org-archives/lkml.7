Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38BCC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E5721726
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bQk9vGvE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eOlBBdXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfH2S0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:26:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35656 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbfH2S0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:26:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D67716984F; Thu, 29 Aug 2019 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567103174;
        bh=BLLEmixfGGtKTMt3kN2ZQV5lnoo8OcCb4fQaHMm4IdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQk9vGvEMk70TtltL+htp8j53PBXWRP+S8Rb81SlxOLQi+Pr0N08qgHFqk2ri6dSB
         /QWvIrsKLQxESKUhpW12Hc9eU+rXepF9ZlfMB/Im4T/XgxZKVCNFCc4g7dPFfroY4R
         b1nsmQHrN4XB6UOJIcihZsnVZA5AnhdOYQwAbbSE=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D016168A65;
        Thu, 29 Aug 2019 18:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567102353;
        bh=BLLEmixfGGtKTMt3kN2ZQV5lnoo8OcCb4fQaHMm4IdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eOlBBdXM8HbGfBS28FOVWykOj/WhXUte0t5oR+Ma8p+9p7oUnqGEbxaOxl/3GgHZu
         3yrMfiZZBO/C1dYOSfs5AKOkro3LW92VcZ1KbXrYRM9qM4hitd68S0uDHw0uF0h0z0
         YIKyF8n3aKhpMc/sM4RYxpfzVW/0osYJrFRoJppI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D016168A65
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com,
        linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, rnayak@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RFC 12/14] arm64: dts: qcom: add PDC interrupt controller for SDM845
Date:   Thu, 29 Aug 2019 12:12:01 -0600
Message-Id: <20190829181203.2660-13-ilina@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829181203.2660-1-ilina@codeaurora.org>
References: <20190829181203.2660-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PDC interrupt controller device bindings for SDM845.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index be0022e09465..ffe28b3e41d8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2375,6 +2375,16 @@
 			#power-domain-cells = <1>;
 		};
 
+		pdc_intc: interrupt-controller@b220000 {
+			compatible = "qcom,sdm845-pdc";
+			reg = <0 0x0b220000 0 0x30000>, <0x179900f0 0x60>;
+			qcom,pdc-ranges = <0 480 94>, <94 609 15>, <115 630 7>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+			qcom,scm-spi-cfg;
+		};
+
 		pdc_reset: reset-controller@b2e0000 {
 			compatible = "qcom,sdm845-pdc-global";
 			reg = <0 0x0b2e0000 0 0x20000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

