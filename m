Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44C5C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9354E21530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v0zJ8I8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfEHCUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:20:04 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43504 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfEHCUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:20:04 -0400
Received: by mail-yw1-f68.google.com with SMTP id p19so12145825ywe.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 19:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V4MjvAfsmYt35Qj0jxF1NF/Z9s8olO9umFfF5oX+E7s=;
        b=v0zJ8I8yxGiRb6J++uIhWFMwG/diBBv1wJefCabNxV+5fOOf5YVa9I5/6+1zNIpBlO
         GdCpGPuhp6Zsdie8FF+bTPItDmcPSg3bY3yEsOq411LktjRw4vI7qRlirHDw1jwxqSCJ
         OcDUMZCwdJGbWRTLYJljeJer3ElORzUmqDXFeyVHhh2grN7jLA6Uo7SHEvpAZvoQkw9Q
         c5CCJ6//+iOFahhIG7aV/6GOn6isIQoBnM+x+CWocgthqMvflC9Bdtmkvc694Ci4FK0s
         K5/SJkxWxiyeeRCaVGbc3yEf/ZGg4w3eEiO695PPfOSffhO0bCcnS/YcBH/n5WwM7+DO
         g4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V4MjvAfsmYt35Qj0jxF1NF/Z9s8olO9umFfF5oX+E7s=;
        b=D9ViD+AyliQsh6aeO+5wxwW/wE1I43LWoRVUbk+ynEuntYvNhtMnIwec5x8iI3V+j/
         6HhrNSn6pt+fG24YQLM+/yzIjdEh+tJCFauP52J52LgyAcUM5GpjBvSp7PVrHb9ruGDE
         7Eidc0qWnG7OI43PNOwta2aytmGmTIt56QXwE15pKZczH54uuzebbIS3/l8+LDMZs26b
         jOYaNZBIvXUOIEdIfIGvLmS+nHQWqSHR10RBEPyKd1DRrhYg1YFT5K4xlvYHCXNeFyXF
         nOwhncPTK+G1mJb6wCYpsZEjys75Zm4bPsHMY2lTvwD+dQ2+HaECFDOqmatt22l1Tcyd
         fdfw==
X-Gm-Message-State: APjAAAWtKCYaiiLyFBGE05HJX1RNlga4S6dvb3JZg1lRvHRNwsERYezB
        CTvM5bbzKRu6UTS5q/2dETathA==
X-Google-Smtp-Source: APXvYqyU7pDHfVnSkOI32/itiCS+CICRnF48CMOaqcMCCS/1KO/sw44MPaaFQQ+CTk8/ppKC86lrtQ==
X-Received: by 2002:a25:ca12:: with SMTP id a18mr5032891ybg.21.1557282003329;
        Tue, 07 May 2019 19:20:03 -0700 (PDT)
Received: from localhost.localdomain (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id s4sm1168116yws.48.2019.05.07.19.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 19:20:02 -0700 (PDT)
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
Subject: [PATCH v2 03/11] ARM: dts: qcom-apq8064: Update coresight DT bindings
Date:   Wed,  8 May 2019 10:18:54 +0800
Message-Id: <20190508021902.10358-4-leo.yan@linaro.org>
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

This patch switches to the new bindings for CoreSight dynamic funnel and
static replicator, so can dismiss warning during initialisation.

Cc: Andy Gross <agross@kernel.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 65975df6a8c3..8b79b4112ee1 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1603,7 +1603,7 @@
 		};
 
 		replicator {
-			compatible = "arm,coresight-replicator";
+			compatible = "arm,coresight-static-replicator";
 
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
@@ -1636,7 +1636,7 @@
 		};
 
 		funnel@1a04000 {
-			compatible = "arm,coresight-funnel", "arm,primecell";
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x1a04000 0x1000>;
 
 			clocks = <&rpmcc RPM_QDSS_CLK>;
-- 
2.17.1

