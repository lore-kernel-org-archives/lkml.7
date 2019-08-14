Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8B4C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 03:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EA820842
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 03:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iolgrg+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfHNDJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 23:09:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46345 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfHNDJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 23:09:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3so15112180pgt.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 20:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HT5agnFB9Ua1f+HiJVMbjVMLi62oFKHY9sExG5RcmRA=;
        b=iolgrg+yXRNATYsbEOlu9D72Y6cuxWB1oF5q6TXekIkX8mRpEK69FdqiNFv7XLjA+t
         FcGQ/WsyRg41D/BOnJQYjxSQgmko05AoDrQP8l7PRwVl3zym4hrqsRdFf/C5NJdKmsX7
         GZ2P20Urso3DH3FtiPIJArW43M2VOidJwP1fvmpZusTymGcOa/i60G3smXH+F1/miznf
         3QsZV4UthI9GdIyw26ruyfIBbZ0N/faj+B/5VeUhED07B+AhHEdLce+Nzuahj7O4xDG8
         Ff1sKUAeEmJL2mQ+1/OMUBZSm4fHnJw2ydQ1XD5QzHBVi1DI4NPaFbhBCeCAO6AQvivo
         v6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HT5agnFB9Ua1f+HiJVMbjVMLi62oFKHY9sExG5RcmRA=;
        b=kM8kKdn3P74p5yHIxNj6PkHctAoFbmbRT5z8iZkViw3uiuVjuEXPk7waoSn2UaU/Tl
         /rv9jnoJF0nOFy9jHn12UyeH6SClD21ySJRYfWb3GQK9i2tHb69DH0MZp9fY0z2id/OX
         zqrdSGnrAO1Q9Wmoet58nJV5+xmSxIjQyx8ssBGHVLCmP+lBmH6HXndYbXhf5pgHCils
         tr0zNdLz8Xlv48t3xsujFZ4iglQQgd7rnkYbMUARlshWewJujQXfGO8Zm1GAqJXDTWi2
         cUlXSQgKPFcS9T/YkI0DA5zUs/41c7lSvCW0NVBAD1bSyfSHQx004rfE9A7fvj+3mg3Z
         Ir3w==
X-Gm-Message-State: APjAAAU6Vl0WxWTZIbU3btak386LK06PLmdzvaZGAjbRFjxoN5UBcA/i
        W4q0sjmSy+TQ2kVPHkdWONHzmw==
X-Google-Smtp-Source: APXvYqyF1tE3QKOyyK7LvQGdigD6LOt/gywd4f3eQFSrL0cCzGCl9LSpCTeL5FSziRSrw3Bo/+rhjw==
X-Received: by 2002:a63:e948:: with SMTP id q8mr35922012pgj.93.1565752186336;
        Tue, 13 Aug 2019 20:09:46 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u1sm106170929pgi.28.2019.08.13.20.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 20:09:45 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: qcs404-evb: Mark WCSS clocks protected
Date:   Tue, 13 Aug 2019 20:09:42 -0700
Message-Id: <20190814030942.2638-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'7d0c76bdf227 ("clk: qcom: Add WCSS gcc clock control for QCS404")'
introduces two new clocks to gcc. These are not used before
clk_disable_unused() and as such the clock framework tries to disable
them.

But on the EVB these registers are only accessible through TrustZone, so
these clocks must be marked as "protected" to prevent the clock code
from touching them.

Numerical values are used as the constants are not yet available in a
common tree.

Reported-by: Mark Brown <broonie@kernel.org>
Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 2289b01ee9f0..501a7330dbc8 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -61,7 +61,9 @@
 	protected-clocks = <GCC_BIMC_CDSP_CLK>,
 			   <GCC_CDSP_CFG_AHB_CLK>,
 			   <GCC_CDSP_BIMC_CLK_SRC>,
-			   <GCC_CDSP_TBU_CLK>;
+			   <GCC_CDSP_TBU_CLK>,
+			   <141>, /* GCC_WCSS_Q6_AHB_CLK */
+			   <142>; /* GCC_WCSS_Q6_AXIM_CLK */
 };
 
 &pms405_spmi_regulators {
-- 
2.18.0

