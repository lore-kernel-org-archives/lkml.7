Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0521CC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC87920674
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n3bfc+y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfDOKoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:44:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41197 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbfDOKoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:44:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id t30so12670295lfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 03:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WnMjrli1zTUtUE5+GT4k5X5hghHhqsPUuTlBpNnfz/8=;
        b=n3bfc+y6021NjYFPdYL0NUa4U/Zj0uMTb2RRNUH9KzCteZ+gMVZO4Q/BFUfyXaHQDu
         nNLzl6YO+QiCJ9bOWxtcJ3/IaUT9aUmtsLpfCH+dlHKN2NI6Wne/UUSZXi6gGj1eSELO
         8wvw8cLtoX+kz5cu5N3hfLMQvqgmsktB8oMVoE1SiEbvLvN5xxrR9+6VO8Je2H1BvSbj
         cNgf6MnLgkC8z3bpkDwwC0qSLpQ0lX5N1dIiIL64s5ytJC4Zpjnt2By5jnL4M0GYwCVg
         wALX/z4aWjTs+G8fIENT+AhcTLoQBnF2QRSo6QFCLYbFAMngDgr2GaW04My6bRj44/bN
         pPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WnMjrli1zTUtUE5+GT4k5X5hghHhqsPUuTlBpNnfz/8=;
        b=stcii6Xfp/rvRYTkHenzBAJfBiZeKgSLU9Iq3gKgR+WOjH1THi8iqIL9ytle/R57vS
         dIxZLk0rlRS86MyTArpRRzj6+CQ/QE6mbeGu6un6vFFKK3/FMCmSHq0dvM+EoQ6+nHwC
         AffYRqVdYPkyN4DKubPnkz0T/y4WojaqJZ9VLdjC+i9EkXrf/KwD3t0j4fbDIq66HvSb
         Fjs1G0s+T03Z54GluJs3XengA1hQRg2NPnpkOHG7NyAq0x+1omU4xalTXUX9/+6sFemJ
         4szfqUF2qad2iGV8s7LXjc3W9V35hXhcgOrlhes9StIJdpJhemZH+X333923bMe73oBb
         atHg==
X-Gm-Message-State: APjAAAXsv51ti83U+a9JL5Tamhl3vJ+eOi52qLmLGIoV3UvMv55knuK8
        vj1T4n4ZxqQZWSVLyty9KtihcA==
X-Google-Smtp-Source: APXvYqy6TALo37iE80bKRfYMtmDS/ANnrjXT8127ijvhP4gsL9QhkxFQhehSG2eceYrkW2Jt2T9WRw==
X-Received: by 2002:ac2:4357:: with SMTP id o23mr16889458lfl.146.1555325046597;
        Mon, 15 Apr 2019 03:44:06 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k21sm9812596ljk.21.2019.04.15.03.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 03:44:05 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 4/4] dt-bindings: interconnect: qcs404: Introduce qcom,qos DT property
Date:   Mon, 15 Apr 2019 13:43:57 +0300
Message-Id: <20190415104357.5305-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415104357.5305-1-georgi.djakov@linaro.org>
References: <20190415104357.5305-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are separate hardware blocks per each interconnect that allow QoS
configuration to be applied to each port (node). There are different kinds of
priorities that could be set on these ports. Each port supports also various
QoS modes such as "fixed", "limiter", "bypass" and "regulator". Depending on
the mode, there are a few additional knobs that could be configured.

Introduce the qcom,qos property, so that we describe this relation in DT and
allow the interconnect provider drivers can make use of it.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

v2:
- New patch.

 .../bindings/interconnect/qcom,qcs404.txt     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
index 9befcd14a5b5..b971e0ee2963 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
@@ -11,9 +11,37 @@ Required properties :
 Optional properties :
 clocks : list of phandles and specifiers to all interconnect bus clocks
 clock-names : clock names should include both "bus_clk" and "bus_a_clk"
+qcom,qos : phandle to the QoS device-tree node
 
 Example:
 
+soc {
+	...
+	bimc_qos: interconnect@400000 {
+		compatible = "qcom,qcs404-bimc-qos";
+		reg = <0x400000 0x80000>;
+		clock-names = "bus_clk", "bus_a_clk";
+		clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+			<&rpmcc RPM_SMD_BIMC_A_CLK>;
+	};
+
+	pcnoc_qos: interconnect@500000 {
+		compatible = "qcom,qcs404-pcnoc-qos";
+		reg = <0x500000 0x15080>;
+		clock-names = "bus_clk", "bus_a_clk";
+		clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
+			<&rpmcc RPM_SMD_PNOC_A_CLK>;
+	};
+
+	snoc_qos: interconnect@580000 {
+		compatible = "qcom,qcs404-snoc-qos";
+		reg = <0x580000 0x14000>;
+		clock-names = "bus_clk", "bus_a_clk";
+		clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+			<&rpmcc RPM_SMD_SNOC_A_CLK>;
+	};
+};
+
 rpm-glink {
 	...
 	rpm_requests: glink-channel {
@@ -24,6 +52,7 @@ rpm-glink {
 			clock-names = "bus_clk", "bus_a_clk";
 			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
 				<&rpmcc RPM_SMD_BIMC_A_CLK>;
+			qcom,qos = <&bimc_qos>;
 		};
 
 		pnoc: interconnect@1 {
@@ -32,6 +61,7 @@ rpm-glink {
 			clock-names = "bus_clk", "bus_a_clk";
 			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
 				<&rpmcc RPM_SMD_PNOC_A_CLK>;
+			qcom,qos = <&pcnoc_qos>;
 		};
 
 		snoc: interconnect@2 {
@@ -40,6 +70,7 @@ rpm-glink {
 			clock-names = "bus_clk", "bus_a_clk";
 			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
 				<&rpmcc RPM_SMD_SNOC_A_CLK>;
+			qcom,qos = <&snoc_qos>;
 		};
 	};
 };
