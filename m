Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B90CC04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F143321530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/eBgw2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfEHCU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:20:27 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45418 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfEHCU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:20:26 -0400
Received: by mail-yw1-f68.google.com with SMTP id w18so14957944ywa.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 19:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AG3FqXHLs4/OFGe9lSxLhNOZ2EEYR0vwOTMhYn26hGo=;
        b=P/eBgw2AZxiQULSdHa/cTRJXa0hypgcD0Sg7WsC+8N1aAaZkkB5Zf79CxpulQW2L66
         H0y4n5HkqbK6Cj22lHTSc63ASar/nQT6Q1d4VsJStFQXUVb7ORvlTSEziogYg5vkwq/A
         5OJJm23AUom2BG0qsfj4piAmSEQdDXTH5p+W7+pajHJkcsKPTnvtVZM2Qx+knKNMKJyW
         T5spVxIbcgr94pyej+So1AJYp9vmsjJeaIZBU24g+hYruPyYwJteP6z5DeSDJfG62s6H
         5AUslmpr6EiXAYrvyjFIpfYXMIwWafgJ5ufqz5eo6/zYDLk8t/3HoQYwi8ahi2+jYzs/
         ca/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AG3FqXHLs4/OFGe9lSxLhNOZ2EEYR0vwOTMhYn26hGo=;
        b=eERDeTlAJ3oZXaiH3yEQYNdVN4EavjTIEJ2pfb4qHa/J5S7YwyE/gBCqj9J0QNdYTI
         2qKqqbgGOwwCx/wy9BGQ03xmuHDH7/1DUJlK9NQ7Nus2PVCZ0VrnRZQ/xTgEsvi8E0C6
         R1o8vSz/vv/nSnSrxF1h6/wbhneiF+PQ19O/41NQV5w1KH0Qqysws1t/ooHdz1jw0K39
         1MCUDXh4EVorxkwfdFhDjO1H2RF7VLM3nhtkmCCSrn7tNGk27yC7fpDwuRqpW8nUpmvP
         PA5UKkqXtwqKCfQLmKTo2D1/duTmBLs+jC5MGVU0zD7auJyvhWh1Y59oNiDtXLMxSG6k
         sD3g==
X-Gm-Message-State: APjAAAU/IF827l8rJLLdbzPqSvaeAWCXhv1mkPIXbi+t7SmEO/j8vL5g
        BoyMk5wF8ktMJLCorcnT6RU+ZQ==
X-Google-Smtp-Source: APXvYqw0FKw200XiMULFd5Py9JxtXGaMTZc+CwuyFGd8KR6CqMPQe9hjhCvI5Ix31kUBUi/8D01W3w==
X-Received: by 2002:a81:a414:: with SMTP id b20mr25269935ywh.278.1557282025269;
        Tue, 07 May 2019 19:20:25 -0700 (PDT)
Received: from localhost.localdomain (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id s4sm1168116yws.48.2019.05.07.19.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 19:20:24 -0700 (PDT)
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
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 06/11] ARM: dts: qcom-msm8974: Update coresight DT bindings
Date:   Wed,  8 May 2019 10:18:57 +0800
Message-Id: <20190508021902.10358-7-leo.yan@linaro.org>
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

Cc: Andy Gross <agross@kernel.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 45b5c8ef0374..272ebea20a5f 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -897,7 +897,7 @@
 		};
 
 		funnel@fc31b000 {
-			compatible = "arm,coresight-funnel", "arm,primecell";
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0xfc31b000 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
@@ -931,7 +931,7 @@
 		};
 
 		funnel@fc31a000 {
-			compatible = "arm,coresight-funnel", "arm,primecell";
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0xfc31a000 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
@@ -969,7 +969,7 @@
 		};
 
 		funnel@fc345000 { /* KPSS funnel only 4 inputs are used */
-			compatible = "arm,coresight-funnel", "arm,primecell";
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0xfc345000 0x1000>;
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
-- 
2.17.1

