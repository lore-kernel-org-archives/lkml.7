Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A83C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0010B2186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZMXmbW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfHZQsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:48:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34497 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733158AbfHZQsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:48:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so16028682wrn.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 09:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hupd+NjOPBz3nsSvh0rk5zeJMQwvXm41o+AWQWydlzs=;
        b=sZMXmbW/POftkL+zpxhLc3nCQusl/cB7uTur1BFVbUfZyvQsqUqPfym57arfEXR2Cn
         DG0liyQvnOMuCA0CmTTj3hJl0rKOlizTGr6OgTmD89IPRb7rhLUrJT04ug8k1A2TseiM
         pHGC4jtNOb6j8tq5bT6g4/ckm2RTcvcHP4OhYEK6OY69iWOU061WMyEAit1+cCXVe6KW
         xixlCql9ZclJjWOS/v1TjzqRFwvvxZ5szDII1BA8mcMG+M4HvyDYWGnJbJXTiTW/QUiy
         4+ouMYHEPFBUD5ZDH8AaKZofmFjeMFQJA32aJPGde2N0z6JSW9OTHOsRNhBNtwnMab6e
         +6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hupd+NjOPBz3nsSvh0rk5zeJMQwvXm41o+AWQWydlzs=;
        b=NPwxvqKEzkAJQmoooK14hJXwnfNSoRG9+Eo/4lBtYqzJTv/4Khv/txejjKrtoF7udQ
         HQIoRP6a2aMbwKYww2g6YXdjyFlmqChuBXz5aIVffybAkNXi/UWsvYpNyDlZMHrtT2Nh
         eDVxkTMsHgNHXSuWYT+kst6irCscqjJsCWZsMM3jsUavs1FwvZucoYhRWu5Y9UButA5H
         2hIzfn0nf5UKfh3amT0LMsf8YDc2B6vNoDbWYQWYX/xozEObt9wJnceCtF/LAM+9GcgW
         Q3h8ldzpK7q2efixpvqgvF5tIBjlH15Y7lw82VS2UEadwDurDtxukMYkVQ3AfBh1iTwl
         avTw==
X-Gm-Message-State: APjAAAWsyM7VDdkBStKL6Kf7naPvku+lFtBAr7Tx3J6YA4hSyzjv/RjZ
        ohf5F4754jed/zp/0BrWmSUX8g==
X-Google-Smtp-Source: APXvYqw+jUQO21Sx7hEAv1JbZEW5Wja41iOujx/BJs9D3ZC3XBTDMBZ17MJWoxtMAWPeoQzBcFsccg==
X-Received: by 2002:a05:6000:104c:: with SMTP id c12mr22240971wrx.328.1566838093314;
        Mon, 26 Aug 2019 09:48:13 -0700 (PDT)
Received: from localhost.localdomain (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id o14sm21800076wrg.64.2019.08.26.09.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Aug 2019 09:48:12 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, agross@kernel.org, mark.rutland@arm.com
Cc:     niklas.cassel@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] arm64: dts: qcom: qcs404: Add the clocks for APCS mux/divider
Date:   Mon, 26 Aug 2019 18:48:05 +0200
Message-Id: <20190826164807.7028-4-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190826164807.7028-1-jorge.ramirez-ortiz@linaro.org>
References: <20190826164807.7028-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the clocks that feed the APCS mux/divider instead of using
default hardcoded values in the source code.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 75ea356a3fb0..34360b2d3e0d 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -867,6 +867,9 @@
 			compatible = "qcom,qcs404-apcs-apps-global", "syscon";
 			reg = <0x0b011000 0x1000>;
 			#mbox-cells = <1>;
+			clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
+			clock-names = "aux", "pll";
+			#clock-cells = <0>;
 		};
 
 		apcs_hfpll: clock-controller@b016000 {
-- 
2.22.0

