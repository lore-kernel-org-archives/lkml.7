Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0A8C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C4020B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QvX/PBOh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="irmFmWX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfFLTLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:11:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44720 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfFLTLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:11:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 196C360867; Wed, 12 Jun 2019 19:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560366700;
        bh=gzQuKl0o/e3tySi7jEcUIRPo7BWItIraq2Tmj80meag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QvX/PBOhtyRgI9Vpk0vhFTzPx6mJMy1gwZ4nzcz8bgkiZg871zYABTT7dCffYCwN0
         jfiEgCKdGahHkTT/952qLUPSZ7+vnyNDmUU8Uu9rdYWXBciaiOoUOa3KPISu0ShF6I
         0wQ8jphZDvzaqkziWRispFXzVEdNxLU/GcpaMmNI=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 556C160237;
        Wed, 12 Jun 2019 19:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560366698;
        bh=gzQuKl0o/e3tySi7jEcUIRPo7BWItIraq2Tmj80meag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=irmFmWX0x09TQqyk4tYLAy8LR1iDKEITMAFz8jIFf5wHOLmM91nopT57VWnsDfbXY
         lIz5KDNnVvnrTR3kCayhRyMJhkDyeDwTGoeoZsB587eM6i/SbbiVqcaNe1bmj/mEpV
         2wWAMg5GmJ+XfEur4td5YZm37vlca6x5SjuiH+LM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 556C160237
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     marc.w.gonzalez@free.fr, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v5 2/6] arm64: dts: msm8998: Add xo clock to gcc node
Date:   Wed, 12 Jun 2019 13:11:23 -0600
Message-Id: <1560366683-5940-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560366600-5826-1-git-send-email-jhugo@codeaurora.org>
References: <1560366600-5826-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC is a consumer of the xo clock.  Add a reference to the clock supplier
to the gcc node.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 574be78..9c88801 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -709,6 +709,8 @@
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
 			reg = <0x100000 0xb0000>;
+			clock-names = "xo";
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
 		};
 
 		tlmm: pinctrl@3400000 {
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

