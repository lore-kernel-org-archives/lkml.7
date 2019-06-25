Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B319C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F25F2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jY2/AWow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbfFYQsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:48:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47079 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732038AbfFYQry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:47:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so18628191wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oKGLSmgisRO2Nmb0wB40LqsaDficvDLdoxm6cO408zE=;
        b=jY2/AWowAS6G+jRVmNv+y8BiYzhIt/RwfEmwSQlOnP1M7xgKx2duEfwCXzEbp79MUm
         HORhBMcl+LdI616MEYj/rjmZO6lywFy6CNbUIc4cs6zy9OwoFI24Jx//abCXlxz98rCU
         i5q1biTMevsMS3u1LnlQXfL5f7XGHeHTI2QAVU4B1HdB1zmVplLZtKe8327ZhiW71peI
         z7Nf7lVk1fdGvJA3Fx1Nu2BYIv/faT9mwmCA+Oo8BLyQ4ByCn8GCfSSGUa21td5D33Rc
         6K5yR8rL3LQZsN7nHJFeEqOHDKamNXhUesE1mXZYR44nHlsZrdCo9C9N/htchBYsH34w
         QGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oKGLSmgisRO2Nmb0wB40LqsaDficvDLdoxm6cO408zE=;
        b=HLE3U1ikDkfKhXn/ifA+PGos2gbg/qcXfbzMurgdF3Mo+O8NfO5tOL0py5Y4ynlhQm
         LEIM1w1DlUKpVqwc7oavbaWdikB621sXJH9amg4SG3e0dbJBr06izBSwmFswzeI07Nr7
         jWQxfDhj2eBLj7wnBRNMV1Sx0bf8RxfiBNWo98+onMjbsRlpLEHgjwsHyPlLqVEyOss0
         wRK2Ttv7ie/o1crVYMOOPgKu+53rHey111j0n+vraGqyvo/D51TsE2BUnfw4dRJ30yeV
         RDl0g13F40aKx7ZZFm9FAB+kZoUEagRNgL8H4292v+ago7cSqve6MOKs3XkABDLF9Lh8
         0n4g==
X-Gm-Message-State: APjAAAWySnw7EuJANqdKVVqKm7VyH2Q/sULTka8On8jDgbX7UH5xXSnL
        EjrOSC5bjtS2XdFmSiJ6dDtrTA==
X-Google-Smtp-Source: APXvYqw+ITnXXrhjAcfOWEotCFY+bkWsQz+aEVksguE1mMHz7rXtZpCo/wyL1bmjHCUy7fRC8W94Mw==
X-Received: by 2002:adf:f186:: with SMTP id h6mr24857872wro.274.1561481272938;
        Tue, 25 Jun 2019 09:47:52 -0700 (PDT)
Received: from localhost.localdomain (30.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.30])
        by smtp.gmail.com with ESMTPSA id d18sm42594476wrb.90.2019.06.25.09.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jun 2019 09:47:52 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, david.brown@linaro.org,
        jassisinghbrar@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org, will.deacon@arm.com,
        arnd@arndb.de, horms+renesas@verge.net.au, heiko@sntech.de,
        sibis@codeaurora.org, enric.balletbo@collabora.com,
        jagan@amarulasolutions.com, olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v3 09/14] arm64: dts: qcom: msm8916: Add the clocks for the APCS mux/divider
Date:   Tue, 25 Jun 2019 18:47:28 +0200
Message-Id: <20190625164733.11091-10-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
References: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the clocks that feed the APCS mux/divider instead of using
default hardcoded values in the source code.

The driver still supports the previous bindings; however with this
update it we allow the msm8916 to access the parent clock names
required by the driver operation using the device tree node.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 5ea9fb8f2f87..96dc7a12aa94 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -429,7 +429,8 @@
 			compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
 			reg = <0xb011000 0x1000>;
 			#mbox-cells = <1>;
-			clocks = <&a53pll>;
+			clocks = <&gcc GPLL0_VOTE>, <&a53pll>;
+			clock-names = "aux", "pll";
 			#clock-cells = <0>;
 		};
 
-- 
2.21.0

