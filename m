Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BEDC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBBF21743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="abB3juO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfEAEhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:37:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44855 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfEAEhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:37:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so8105833pfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 21:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kYQemACgtqbxChV7HlM7UTpQsyhEGfC7nSYz5voNBQE=;
        b=abB3juO+SS2LUU1SgcrraCl+bJp/tnE8gP4EhklXGXaopPMd9nyPKTj9cDfLGONhhe
         5ShLVmxluI/igrC+r+yfxlYEuR+TfbVAr7+o+BPc2zR7IhDLvHsldeFNBw9D7h/nqvGh
         lciItM4yv4MEzy5epyposxToqpTDoht8Vg9SILWfIaItHB+d+J5j56D8x0yCaS11j/P4
         yK61kli9KOcJimIA7VoJZZk1KFAY9yTACLwR0CIkFS42aqohHGJMy2WLaqqcbUi3MYA0
         bYWoq5isfXJTRhUYKwAPcO4xOs9H4P1zyRWh5m7OIaA/CVslg97vw2AffgNNBRQsX4h2
         HZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kYQemACgtqbxChV7HlM7UTpQsyhEGfC7nSYz5voNBQE=;
        b=YGaNOaDVgriUzlklQV+PpTfC5BT1SQ55DCUKonmKKMmoUXwl2Zc6usNB546MRHha9R
         bJKUHC6E4tDjfc6kxgnF9Ml1pEAMkYjLKgFUIjfX4zOfKFaihpgBsEnnsU7J1L61Vo8i
         Sc6qBqKzs0iPE6KXF9TLy/nfkLRkAW09bWIIayVCOOqFmr0W2CPBd54ZrCV3YSGYijnn
         zFTkrIpBgr6hLNsLc1eSKqp3Ynl4HeJg8DlmxD7yqQSkr3wnjar1pXKkooc1+6TlpAtD
         gtX05KzX5CWiwiqS0pAfT6buGjqCt8pI15mLpyntLA6R7zMcjJmh4b4pypwMxp5+8iWu
         wQwQ==
X-Gm-Message-State: APjAAAXyITWf73z/KcefhRD++iDZ+WvrlZg98HKp741g+CTeclAbTkOn
        /ethzV329oaRywSwJh0pFH1Qsw==
X-Google-Smtp-Source: APXvYqzrZ9SoEybJnVOhC2d/a1LUv6LnCcxn3uWAj24FD3GC79oNQ4GXyHclR7myxMoOuGWGiVZyew==
X-Received: by 2002:a65:5682:: with SMTP id v2mr43006216pgs.100.1556685462966;
        Tue, 30 Apr 2019 21:37:42 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q128sm55912865pga.60.2019.04.30.21.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:37:41 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/4] arm64: dts: qcom: Add AOSS QMP node
Date:   Tue, 30 Apr 2019 21:37:33 -0700
Message-Id: <20190501043734.26706-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190501043734.26706-1-bjorn.andersson@linaro.org>
References: <20190501043734.26706-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AOSS QMP provides a number of power domains, used for QDSS and
PIL, add the node for this.

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v6:
- Added #clock-cells

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index fcb93300ca62..666bc88d3e81 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/interconnect/qcom,sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
+#include <dt-bindings/power/qcom-aoss-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/reset/qcom,sdm845-pdc.h>
@@ -2142,6 +2143,15 @@
 			#reset-cells = <1>;
 		};
 
+		aoss_qmp: qmp@c300000 {
+			compatible = "qcom,sdm845-aoss-qmp";
+			reg = <0 0x0c300000 0 0x100000>;
+			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&apss_shared 0>;
+
+			#clock-cells = <0>;
+			#power-domain-cells = <1>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0 0x0c440000 0 0x1100>,
-- 
2.18.0

