Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D01C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F232083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565787190;
	bh=/h3YqqWp1GHG2tFB04Jfi8yAYbuoQfxznrc6/QZfTZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z5ZslSV3PWPM3HyiSJXKUuNw0PgH9lU1ofz89SeJ7uLfjFoo5cLfPR9Ban1LY8GpB
	 0fFRpAgapXkybDc57BBp11IWyNLhspv7/9XpEu57uwD0cXzPWbGLRgk6JbobMZT84t
	 9jCgB9Vwj3UYgHPzjGhfzv3jQtIngn6bwaHW6tjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfHNMxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbfHNMxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:53:04 -0400
Received: from localhost.localdomain (unknown [171.76.115.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A11B2083B;
        Wed, 14 Aug 2019 12:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565787184;
        bh=/h3YqqWp1GHG2tFB04Jfi8yAYbuoQfxznrc6/QZfTZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SEAwZgLIU4Lj8Pzg3/OyeOHVZuaJMJPxR/sttBTVzoWxQsqrHs2PUEjfG84CZyTvA
         XQWiO7ez2qhhHs3NcFMLo481iDvJxZZOBiZYx3WGGBQcYpi/KuWJJa/CPJPoIR1fUS
         kpfq35JV8s2C+hj+TlOYI8RqwGBKhBYt7p2SF9MY=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 20/22] arm64: dts: qcom: sm8150: Add pmu node to SM8150 SoC
Date:   Wed, 14 Aug 2019 18:20:10 +0530
Message-Id: <20190814125012.8700-21-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814125012.8700-1-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

Add the CPU PMU on SM8150 to get perf support for hardware events.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 7111e1f092f4..19be87dc893f 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -148,6 +148,11 @@
 		reg = <0 0x80000000 0 0>;
 	};
 
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.20.1

