Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77FEC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A648A21019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qIQj7mU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfEHCVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:21:03 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45451 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfEHCVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:21:02 -0400
Received: by mail-yw1-f67.google.com with SMTP id w18so14958827ywa.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 19:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VT/DoumIOruXiAt+IEfHVTj8xFMF06dsPV76vTKLKmU=;
        b=qIQj7mU4c7YJHHe7BHgZEUYGBUP8UfrrrZBbYdGM5Yu+nz6qHXQGamhEyeAGJrzMJ9
         3gl8WGLMdi3K4E4XsP8ft4URWKos/ny2JcrGqYZcBd90V+IfE4RpP28jyXsIZ+wDbVpZ
         sLWdTy+6Q6P96HNODOJIlLlCDRoFLonAdzVThLDnR2hShGvXw6aRh8HRhyPtoIEWmms3
         OY5Dc8BO/PrYgDGwP3JAfuXxgZeQvYQAgv7NYNxIU6nWHrIl3KJf56MWOJ7PX91e2Kn2
         Erpnd30Fb/uVAnXAp3vpywTsDvqCZKUg0agcDNdzQOSl3OPlWni+s0jYRalouzi03tDj
         ufXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VT/DoumIOruXiAt+IEfHVTj8xFMF06dsPV76vTKLKmU=;
        b=YAutXSyGQFcVqiVh/H7j6MyPZ0n458sE5B4EatUO9hJZafunaDXtv808/1ytaZ00g3
         yuVLzJM6qdolVAAjYi34AGLryDxaSiy/qrFH+gxj38Sp1hromJPWWmxlq4y6kiDLgEof
         jiiw8fc96lVnDgmqTht03tKZ8ZcBLM6mBKwbGiTnYAdHZntzc4TJZNQ5HjmZA2b8iClE
         gUqcYPPqclC+dFgyHQk8i5hLmHGaQj4RCMQCqxpjlXT0GGDRM1i2bmY0bcEHrqvY7ClU
         YvZjUAokuJbZ0qeT6yxN5vt0g/FHN51NBU4ZrKQ7MlwkgyNiNyRlwHpExty7zwvbJHVc
         hjrA==
X-Gm-Message-State: APjAAAVqQ262WfmJ36qloQ/pcLCDOPOzm2MBaVFnF/EFylh/I9CEsMAL
        wkRWNNSdU4PKpxJW04luSv2c6Q==
X-Google-Smtp-Source: APXvYqwUV2PSsioGsTEJtGNisNfeTjMAt5+acFaEPT1kWqqPlXnSGAxrpT/5JBTWNkf7gyrMX5zVZw==
X-Received: by 2002:a81:6d87:: with SMTP id i129mr20367881ywc.424.1557282061711;
        Tue, 07 May 2019 19:21:01 -0700 (PDT)
Received: from localhost.localdomain (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id s4sm1168116yws.48.2019.05.07.19.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 19:21:01 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH v2 11/11] arm64: dts: sc9860: Update coresight DT bindings
Date:   Wed,  8 May 2019 10:19:02 +0800
Message-Id: <20190508021902.10358-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508021902.10358-1-leo.yan@linaro.org>
References: <20190508021902.10358-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight DT bindings have been updated, thus the old compatible strings
are obsolete and the drivers will report warning if DTS uses these
obsolete strings.

This patch switches to the new bindings for CoreSight dynamic funnel,
so can dismiss warning during initialisation.

Cc: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc9860.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
index b25d19977170..e27eb3ed1d47 100644
--- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
@@ -300,7 +300,7 @@
 		};
 
 		funnel@10001000 { /* SoC Funnel */
-			compatible = "arm,coresight-funnel", "arm,primecell";
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0 0x10001000 0 0x1000>;
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
@@ -367,7 +367,7 @@
 		};
 
 		funnel@11001000 { /* Cluster0 Funnel */
-			compatible = "arm,coresight-funnel", "arm,primecell";
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0 0x11001000 0 0x1000>;
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
@@ -415,7 +415,7 @@
 		};
 
 		funnel@11002000 { /* Cluster1 Funnel */
-			compatible = "arm,coresight-funnel", "arm,primecell";
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0 0x11002000 0 0x1000>;
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
@@ -513,7 +513,7 @@
 		};
 
 		funnel@11005000 { /* Main Funnel */
-			compatible = "arm,coresight-funnel", "arm,primecell";
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0 0x11005000 0 0x1000>;
 			clocks = <&ext_26m>;
 			clock-names = "apb_pclk";
-- 
2.17.1

