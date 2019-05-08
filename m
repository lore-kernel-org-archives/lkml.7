Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85878C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCEA21530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SfmmCjcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfEHCUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:20:42 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43528 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfEHCUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:20:41 -0400
Received: by mail-yw1-f68.google.com with SMTP id p19so12146715ywe.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 19:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Bpgr+A7spO4G6xG1o8X5Nj3Ve9xjSTX28GmWNncxVY=;
        b=SfmmCjcvk9Y21x1LfjHYxUkIQw9bgTk0QhnF1djSDcjZiSPGKSrTrTEYang4HBroMy
         YZ0P/Fgt4s5zBAK1hnyK711Cg9C31QbZumEGeaa5M5FsRv+Ce3e52h9uY+7qvJXmRkUC
         +0EX0xyuXES9oqa6ZHwewEAZAOBBLjBY0A3MS+VYMzbUAeWCOq2XyBRvoOOhpTMqqdHY
         2IE31whDVQpvwtquaQ2GitvxfbfvFT4wftJlhq8Y8ny2T2Hh8yQcVnO8aK3tPI1FDKaX
         xLWZ/SI2dO5J/MySmYLrCfc7WdjHgRqYLb9UJIrIzDcKzBA5jZlko5QuiVPNAdWAOWDy
         yvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Bpgr+A7spO4G6xG1o8X5Nj3Ve9xjSTX28GmWNncxVY=;
        b=Kyfm8+ktHPE+rxf0cBUyBN4hqQI3K+VQFGefWL9bZhp+EcazrCbvfMl2pYaWBvBxNu
         uAFpZ84RpBxRp3xa8bcB6AdHHng4VoAvZexA6FKDTx1R7iWWu+lKxN4D89tZDyRlFGat
         U34ekCihikYCvXLyF9SoBd8pq5zx3T2CdNiAJpbtd3BN3+oNeIVGDwqoNgZlkSv7tRCD
         4RsEUfSkWzIRkbCfOCL/+bS5QQbn9U238G2r3BirBdCd/HtniX05M1V6kdKOokLEfaG6
         hpezddkJ/Ll966jlpF84x8tChSGn1xI6ro62kSjiZr/d7Pen4Y1+FXwXumf7J224RjvQ
         T6Fw==
X-Gm-Message-State: APjAAAVt+69UI4A9I4jJ9Uhsn0L/K7MOitKeZqdQ8LAvGam2UqQi5Aet
        F9bVXhgBFViCWYWuj1m1KL6phg==
X-Google-Smtp-Source: APXvYqwW/sU9i8WFXuedix5B3visshOvwFzz/UJY//oEMVD5Ht2WeqcQvvFu6G9uzUT9ZYWujIRGvQ==
X-Received: by 2002:a0d:cd03:: with SMTP id p3mr22253182ywd.192.1557282040243;
        Tue, 07 May 2019 19:20:40 -0700 (PDT)
Received: from localhost.localdomain (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id s4sm1168116yws.48.2019.05.07.19.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 19:20:39 -0700 (PDT)
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
Subject: [PATCH v2 08/11] arm64: dts: juno: Update coresight DT bindings
Date:   Wed,  8 May 2019 10:18:59 +0800
Message-Id: <20190508021902.10358-9-leo.yan@linaro.org>
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

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi    | 6 +++---
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 7446e0dc154d..26a039a028b8 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -150,7 +150,7 @@
 
 	/* main funnel on Juno r0, cssys0 funnel on Juno r1/r2 as per TRM*/
 	main_funnel: funnel@20040000 {
-		compatible = "arm,coresight-funnel", "arm,primecell";
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 		reg = <0 0x20040000 0 0x1000>;
 
 		clocks = <&soc_smc50mhz>;
@@ -281,7 +281,7 @@
 	};
 
 	funnel@220c0000 { /* cluster0 funnel */
-		compatible = "arm,coresight-funnel", "arm,primecell";
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 		reg = <0 0x220c0000 0 0x1000>;
 
 		clocks = <&soc_smc50mhz>;
@@ -366,7 +366,7 @@
 	};
 
 	funnel@230c0000 { /* cluster1 funnel */
-		compatible = "arm,coresight-funnel", "arm,primecell";
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 		reg = <0 0x230c0000 0 0x1000>;
 
 		clocks = <&soc_smc50mhz>;
diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
index cf285152deab..eda3d9e18af6 100644
--- a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 / {
 	funnel@20130000 { /* cssys1 */
-		compatible = "arm,coresight-funnel", "arm,primecell";
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 		reg = <0 0x20130000 0 0x1000>;
 
 		clocks = <&soc_smc50mhz>;
@@ -47,7 +47,7 @@
 	};
 
 	funnel@20150000 { /* cssys2 */
-		compatible = "arm,coresight-funnel", "arm,primecell";
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 		reg = <0 0x20150000 0 0x1000>;
 
 		clocks = <&soc_smc50mhz>;
-- 
2.17.1

