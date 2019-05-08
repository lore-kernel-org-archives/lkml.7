Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BCFC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F1821019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzbVCtOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfEHCU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:20:56 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45447 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfEHCUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:20:55 -0400
Received: by mail-yw1-f66.google.com with SMTP id w18so14958639ywa.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 19:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o9v2i1BskzOhYoxvbGa0Ks+cL4rPkVrKBIZw1YQ7z2U=;
        b=TzbVCtOVob5wGFXsMeQt0szq3hqpslDw1dcya+lfdauPQ4SUbYScHMu+d2gv3hX9Ov
         EwnuYG5EqJtbGCu/QbiISJBC+ePP7p33BQcfCj0w3IVS9f9lL4H/qdoLFQwEg20AAzBU
         GL9TWj2xicfLC5S3+ZA7p3Nh4W7CeWZd2Ba+WhDNd6QHjjewOFnakwyFnTDbnl3wxyAG
         U5oeUaFoTc7l3NSdaHQSNom77wgB0xYWnt3dsONCmE0nebUXjuIrxfzhZUSl1QqvYMn/
         kO8NW0xCiCi8sSYJkLA2XDQ1lc5EJvYbdfl4+lhu9/4894loyKV5EzDyW814j8usdt/D
         t53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o9v2i1BskzOhYoxvbGa0Ks+cL4rPkVrKBIZw1YQ7z2U=;
        b=GJAuSKIn6vXpTTBRyzh8E961nkk/iMm65gDUES5q07fdLQ2yx3blejZGM2bXUPBGcS
         9s2chGW/7c91CriWb2YkEoWiEOpSPIBSPG21Gmir+AP9d/YuJrLOm0MZwmB6IdaA9zTC
         kveP7lcokvfsG5zPSF5sKmQGQ7CSPZVDG/hGmvnl5p3shfL1+Uy914woT0fuxSINULOo
         1Un+25wCHfyObIg/a0VtA81k91jAZzTJXIbVV51pEanNaRNxoJVXZpq8+xzhmeDWDvZM
         TMJjK+f2YY6vTQ1BqYNaV2gTOtMEW/bNkA71PRp4lZ0qvXpDV0TOAdPtPJuFDSvpgXea
         W4xA==
X-Gm-Message-State: APjAAAXJ3OA7dJBHIZxy4gUx2HwjflRHAcjqI22rLa9D512TSJ68IdWM
        frwqV7btBa3fnsxoOO1X6kVAyQ==
X-Google-Smtp-Source: APXvYqxkbRQnf94BeqIG33NbLKJtoaoexo6xYGJu9Cz84P9/WBrCI33zQx6dAYnDIHlYdksEySD2/Q==
X-Received: by 2002:a0d:fec2:: with SMTP id o185mr22939115ywf.116.1557282054378;
        Tue, 07 May 2019 19:20:54 -0700 (PDT)
Received: from localhost.localdomain (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id s4sm1168116yws.48.2019.05.07.19.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 19:20:53 -0700 (PDT)
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
Subject: [PATCH v2 10/11] arm64: dts: sc9836: Update coresight DT bindings
Date:   Wed,  8 May 2019 10:19:01 +0800
Message-Id: <20190508021902.10358-11-leo.yan@linaro.org>
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
 arch/arm64/boot/dts/sprd/sc9836.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9836.dtsi b/arch/arm64/boot/dts/sprd/sc9836.dtsi
index 286d7173f94f..231436be0e3f 100644
--- a/arch/arm64/boot/dts/sprd/sc9836.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9836.dtsi
@@ -60,7 +60,7 @@
 	};
 
 	funnel@10001000 {
-		compatible = "arm,coresight-funnel", "arm,primecell";
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 		reg = <0 0x10001000 0 0x1000>;
 		clocks = <&clk26mhz>;
 		clock-names = "apb_pclk";
-- 
2.17.1

