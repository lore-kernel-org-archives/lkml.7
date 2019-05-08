Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB92BC04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB79F214AE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cscdb65J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfEHCUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:20:48 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38599 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfEHCUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:20:47 -0400
Received: by mail-yw1-f66.google.com with SMTP id b74so14858544ywe.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 19:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ELPN95of+YiOXZ1OxQ8uPptCoKBLr4pqVfRwM3q7Rn4=;
        b=cscdb65Ju8PNF/KJxd7OgJitjE7xvD2hH+EOqa3yAm/uFo29RFZ0ERGQbKoqO0q9Gq
         zSwcdpJVS5MsuUm/T8tKqVO3RfOIRDRu5aQiqGPIbWM18R952ENHLGhUQnm83PGMmKe1
         EgQal7cm7LlxCvwcYlSTCmJV/MZWGEpist0neYA/7IBRuJwhjlrEQrfw3vvlriUP+kyt
         3ufU5Byby6hWfhMlfD6/MXxpxE2IMyTU78S9/Al7YONQFjUnpwRgxHFDjbL+q1E9jWGB
         FbPBL34cfSR80zIQPoIudRAqVdHiqB7GENsCrGdtBelXwbdTlCXzzjvovHf7d/0iMlgm
         YwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ELPN95of+YiOXZ1OxQ8uPptCoKBLr4pqVfRwM3q7Rn4=;
        b=ppN9liZ48XSm6B8vLaSy0+5MZ8tZ4iUPhuB5946ILZNQuzDRnMm60B5jeJKyUvMLiK
         xZO0w/wf73RaghsDj45MqqVaRrhF6XdCz8JNlhaNl4iqU7vnNPfTMUqbDejTex6733dl
         37LogaqjS2tfmYnw2rJili0MnqblyyDcIazZfyfFu6l/0a8y2sKXn9cf79Sv19terGCT
         dtwN9DwUBSmDqW0KtTYceahKic8zvrrQ3nYVdlObDKJI3iGwapQNfnIM+qrXD/W/ZWSY
         RsX7lpNpxxAFDzeoRLsNsGkSrOAHUZutlV1BhKKrJnLURzH34fBnfm4CH9/kfY9IPUEv
         HrOw==
X-Gm-Message-State: APjAAAVErvhK8uY4tKR2bnE44EWURMJjgZc/zSwhAI9+VrttzI/NayZK
        tD73Y+0DuYYZNoIinpNMXGmTog==
X-Google-Smtp-Source: APXvYqzvOq6p0lda62atGvMBmnBlPHx7Zw5jRgRsJ+HkkunEAVkvajT5fwLabmYeGsoo85gnyPLuTA==
X-Received: by 2002:a0d:e6c1:: with SMTP id p184mr9009462ywe.201.1557282047160;
        Tue, 07 May 2019 19:20:47 -0700 (PDT)
Received: from localhost.localdomain (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id s4sm1168116yws.48.2019.05.07.19.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 19:20:46 -0700 (PDT)
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
Subject: [PATCH v2 09/11] arm64: dts: qcom-msm8916: Update coresight DT bindings
Date:   Wed,  8 May 2019 10:19:00 +0800
Message-Id: <20190508021902.10358-10-leo.yan@linaro.org>
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
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 423dda996b5d..de49ec110fc2 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1172,7 +1172,7 @@
 		};
 
 		funnel@821000 {
-			compatible = "arm,coresight-funnel", "arm,primecell";
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x821000 0x1000>;
 
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
@@ -1285,7 +1285,7 @@
 		};
 
 		funnel@841000 {	/* APSS funnel only 4 inputs are used */
-			compatible = "arm,coresight-funnel", "arm,primecell";
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x841000 0x1000>;
 
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
-- 
2.17.1

