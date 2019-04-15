Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC99C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC3C20674
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0aQd45g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfDOKoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:44:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35952 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfDOKoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:44:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so15190870ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mCjjQOD/ZfFecm9hHGoOQGAL+HEJt+HMGA/6wg4ncrc=;
        b=r0aQd45gX01nfBxag0dGNkt3R63i1s1+DXpD3VxantumGCcYcophA52d4ndhQJKI1i
         W2f7sQFEXVxu/EgQouyxWKJXat3pDbzUJV6Q6blSBfdNKIDRCMeqLzIO0tfP2LO+/q6Q
         cWRFHoAr2Dexy5lau0KkmCmi0VcNV2U79QG+Xwh16A+akc20R9dd5nbHgVXrq+yIHWNf
         OWKpH6G/mGxh/29xP3E7gJQRfdrgGW8s05lvXZnE7UyJh/Bl9zqfzcLeMTbrIlzwv+ay
         RuCndQCv3Qx/2+NyOW/+BxXC6RNo9wVJbGuNgiemUg4Fu38X01ojsgKo38O+LZpyycaE
         z6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCjjQOD/ZfFecm9hHGoOQGAL+HEJt+HMGA/6wg4ncrc=;
        b=EWyECHKviBPWkXO9ggRTG/y32LSgtK5yEUQOl9gdK3klXCYCWvMq6yy8iznOX0RPCS
         4o2KgICLfKvnFY/I51OflYb0kgcoAm+wB9qZQQOwoPmjSYKr1dqbZHaT0mEXF9Yt91fi
         HCvkHa+/IRsrHQSU2SzmGUwxcpymMRwHkSAECbRTwbLx4Yd8uAuF9/Ve3lymDTCFFQBz
         g8a/Rv1mQexiTkIR36WbIA0K1WvRl7DZ1tqrTp7T4ymMBj5gScrtua+mv599h3t0l5uK
         OybQOxAdfyzll5Et6WRk5mJqNaOeJ448p9X8iMc2Ykhdt3nZOOMHvliOAjF/0l3zWyUP
         5Srg==
X-Gm-Message-State: APjAAAXKOvDFhyRqPpjd+MrsjkxijrJ4FbWBQVqgn1UX4qz1SHXLrkSw
        IQlwBFDWFNgTZIoRJnF/Z2Vz8w==
X-Google-Smtp-Source: APXvYqwlEQuzFw+oXnHRSIaYAjuA/y5k8J2KN3EpYAx69FWw3EPMNUSTSNxfLRDbKwcDkyvGghUqzA==
X-Received: by 2002:a2e:86c7:: with SMTP id n7mr16016801ljj.44.1555325044913;
        Mon, 15 Apr 2019 03:44:04 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k21sm9812596ljk.21.2019.04.15.03.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 03:44:04 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: qcs404: Add interconnect provider DT nodes
Date:   Mon, 15 Apr 2019 13:43:56 +0300
Message-Id: <20190415104357.5305-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415104357.5305-1-georgi.djakov@linaro.org>
References: <20190415104357.5305-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT nodes for the network-on-chip interconnect buses found
on qcs404-based platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

v2:
- No changes.

 arch/arm64/boot/dts/qcom/qcs404.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index e8fd26633d57..706e918f79f6 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018, Linaro Limited
 
+#include <dt-bindings/interconnect/qcom,qcs404.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-qcs404.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
@@ -226,6 +227,30 @@
 			compatible = "qcom,rpm-qcs404";
 			qcom,glink-channels = "rpm_requests";
 
+			bimc: interconnect@0 {
+				compatible = "qcom,qcs404-bimc";
+				#interconnect-cells = <1>;
+				clock-names = "bus_clk", "bus_a_clk";
+				clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+					<&rpmcc RPM_SMD_BIMC_A_CLK>;
+			};
+
+			pcnoc: interconnect@1 {
+				compatible = "qcom,qcs404-pcnoc";
+				#interconnect-cells = <1>;
+				clock-names = "bus_clk", "bus_a_clk";
+				clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
+					<&rpmcc RPM_SMD_PNOC_A_CLK>;
+			};
+
+			snoc: interconnect@2 {
+				compatible = "qcom,qcs404-snoc";
+				#interconnect-cells = <1>;
+				clock-names = "bus_clk", "bus_a_clk";
+				clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+					<&rpmcc RPM_SMD_SNOC_A_CLK>;
+			};
+
 			rpmcc: clock-controller {
 				compatible = "qcom,rpmcc-qcs404";
 				#clock-cells = <1>;
