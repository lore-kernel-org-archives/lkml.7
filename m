Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88443C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535792173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Yj6vl4eZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aF+2eOLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfEUOrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:47:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44618 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfEUOrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:47:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3C888602DC; Tue, 21 May 2019 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558450054;
        bh=nOL0ZfDvKdfLKfg+Hfj/JLFwg1nF49UIc/OcuNpuoR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yj6vl4eZTvAn/GBRyJgSxF/M0sa6vWWzhCIEdx460KJq/7ALNh6+ee4CkZBCGY1+t
         TSeqsZyoyeOesi99HVkvaNKfZ+WKqonptaIV26xbnquh0yO8jHTsewmj3glhtPD9Rq
         vy3xn4oWACSUJqvnKffzW4/PLH1An6yKcpXP0K+8=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FFC6602B7;
        Tue, 21 May 2019 14:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558450053;
        bh=nOL0ZfDvKdfLKfg+Hfj/JLFwg1nF49UIc/OcuNpuoR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aF+2eOLZDFbjhSvvIQFC+9LfQZbH3QLJC1vbdnzmwgfMchESgrJsmKJeVnusdxhaG
         2ribrmGFfelQu64GuAwCc08U4u0nxdLl6h0GRwjEAcUisUNhT98k4J+auVppCDhHPR
         oLALodq7qWs7MS5yu5IF2/y5xrP5MBCiymznKYks=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FFC6602B7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        david.brown@linaro.org
Cc:     marc.w.gonzalez@free.fr, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v4 2/6] arm64: dts: msm8998: Add xo clock to gcc node
Date:   Tue, 21 May 2019 08:47:19 -0600
Message-Id: <1558450039-20941-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558449843-19971-1-git-send-email-jhugo@codeaurora.org>
References: <1558449843-19971-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC is a consumer of the xo clock.  Add a reference to the clock supplier
to the gcc node.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 574be78..141488e 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -709,6 +709,8 @@
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
 			reg = <0x100000 0xb0000>;
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
 		};
 
 		tlmm: pinctrl@3400000 {
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

