Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84247C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B4721019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p/eCSvrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfEHCT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:19:57 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37679 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfEHCT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:19:56 -0400
Received: by mail-yw1-f67.google.com with SMTP id 186so6151057ywo.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 19:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EJcheVh2VdnVEm8ir4B4beYwlwhOMfHWAEVZqUrLmdY=;
        b=p/eCSvrcLDZ3saZccWINQ109dB0I3a8hAVs99je3InpqziiOYpiYVfCJjumpxjXllc
         XCnYvbctI+g4kL0+WVM2sCWoAuOwXIAhLHG3iyAXhHr5+E84B60yt0AcT0fEFkzRL8LK
         I9+n3PSNFP9niT7U3k5Ags6fH+hYcB+p4ph5y9KIzcFqDWz+fzD/qsG4gMowdUw/GViv
         UGwf4wAyl9+YnQA86zfj6xq7pnk52N0F8usHXwiWPVUpKPSx74JTmWlxhn7URI02VgxN
         xlenWVyVV3TH0J8RnUqEk9hoU8hvK5Z7agLQhLLE+IYVuc1H2UEBZdsiHAgSL6HdyITu
         v3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EJcheVh2VdnVEm8ir4B4beYwlwhOMfHWAEVZqUrLmdY=;
        b=gJxYC10zclPI+a4V38TyYQymXijuHToaz3UzDyBCUbUsh99MdvKzzvhT/Ajv1RtVn4
         5VP48zjvWbnLtc7T294IN35x3ZovfdtFLtCGuBMOXn4F+XCtAxZE8Iak3ITsUesKirUE
         YVmVXqG+eexKjp9fAunuSC0QLYOvBJucmIrEITRqGhtpxx2oB9e4VgEDGZYJQsHUpNhi
         7l28Z9U43ePc2DxxSKAB+AMPQxOFqFrjB9aZcpLbpw+vSbXRjbbgGW/a1aHpIXljdWnz
         VI2cZeZ1fV5QBCRA6IM8yHhfsFmrZTeMlsQZWdMO9ils2M/2FXQMyAAP2FuxfZizWIse
         H5fQ==
X-Gm-Message-State: APjAAAVIze5gCSLVVIWK3cR6GgFFDqNZw3OTxigDtFJGvZz3yF/H/OYS
        5CEjwLH4tr8bE1OGGcelyIX++A==
X-Google-Smtp-Source: APXvYqy114deqNgQb7N10yZoINB5kBO7zPcLq30xR6rE9zB8xFdeDOpPGqIuNv46YKnOqdetLwfiig==
X-Received: by 2002:a25:d64a:: with SMTP id n71mr23617255ybg.462.1557281996153;
        Tue, 07 May 2019 19:19:56 -0700 (PDT)
Received: from localhost.localdomain (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id s4sm1168116yws.48.2019.05.07.19.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 19:19:55 -0700 (PDT)
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
Cc:     Leo Yan <leo.yan@linaro.org>, Chris Healy <cphealy@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 02/11] ARM: dts: imx7s: Update coresight DT bindings
Date:   Wed,  8 May 2019 10:18:53 +0800
Message-Id: <20190508021902.10358-3-leo.yan@linaro.org>
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

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm/boot/dts/imx7s.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 106711d2c01b..d8b4eb67146d 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -117,7 +117,7 @@
 		 * non-configurable replicators don't show up on the
 		 * AMBA bus.  As such no need to add "arm,primecell"
 		 */
-		compatible = "arm,coresight-replicator";
+		compatible = "arm,coresight-static-replicator";
 
 		out-ports {
 			#address-cells = <1>;
@@ -175,7 +175,7 @@
 		ranges;
 
 		funnel@30041000 {
-			compatible = "arm,coresight-funnel", "arm,primecell";
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x30041000 0x1000>;
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
@@ -217,7 +217,7 @@
 		};
 
 		funnel@30083000 {
-			compatible = "arm,coresight-funnel", "arm,primecell";
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x30083000 0x1000>;
 			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 			clock-names = "apb_pclk";
-- 
2.17.1

