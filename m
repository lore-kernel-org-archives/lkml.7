Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6A7C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352E0204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dxdi6ZD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbfFYQsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:48:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51290 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732219AbfFYQr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:47:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so3560240wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YWv+ENYtDt9ayygv5AeNhTcINipts+nB0V2FRLcgbPQ=;
        b=Dxdi6ZD33iGpwH42tE/qn+Iq4qpd9Q6uWsQShpkmqZS8uMNtMk4VAEgSDHLFGUcEzc
         ESZloIWaRMy4AJgVcjFwGdZr5oL6Am2doHYp6EgXjBsFk/LbQnE2C4BKTkD4Zm+L7ONr
         csb95VD80/aDbOBTm8p3fUFh6w81NVLCvmVOZNhhxQsy2NOWkzTk3rGeaCHXA632fA8c
         RHakhy/AjDBjOZog1iWpRlFe9YY6J2eJOuW31Rkow0QeTClcSAtUATkhipMh/KqVUzg+
         fw/hS8ts7UhwtDQ8OEeWIV5B1kXaTutTxgEBFcpE/chiQeD+kuwPB/cH90Ywhxr3sRlw
         BwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YWv+ENYtDt9ayygv5AeNhTcINipts+nB0V2FRLcgbPQ=;
        b=EAX60Wp46SCezI2l/PEtmE8SVatH2yPpNxFjWDPGdia9ZgcqDbcemk40MzZ2TJm52w
         gKmcN0fL2XOVUX7udJTMh+wTNvJoZlQBkBeQVg6Eu7pqebnju9SblBppUvM6XHxrGddO
         Oy1d6R8wfnGZNNog2oboGKxObPQ4+WfBvUPO8Wsbm9PptutAojwptSPiXlSfWUsSpR6G
         dM2UjJY5FUJmo8EaJzK/G2PYjv8qzPMPbtuYZ6McOyq9mEaiCfo4yhSRMT5RkE7ncwNK
         wEUQUySjOs6SBkilrqMRyZwot2dh8pMEyx3ItHSASTNV9J9zXrRg+1n/66mYKZmBhU9z
         KwZw==
X-Gm-Message-State: APjAAAVs0y6oJJ4nfVZLC+lTP7uRISZCamTeAUX9xKimBUwViJ+GXN4J
        uKRYxPJOg5MEOUnIEBBCC34uTA==
X-Google-Smtp-Source: APXvYqyctq0fJwYMqXovLwVH+Rv/g41oIdZlbNT5SBNXiqMQk4fgjk1F1lSz3e94rDFGPxFy/vVOuQ==
X-Received: by 2002:a1c:f102:: with SMTP id p2mr19064644wmh.60.1561481278013;
        Tue, 25 Jun 2019 09:47:58 -0700 (PDT)
Received: from localhost.localdomain (30.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.30])
        by smtp.gmail.com with ESMTPSA id d18sm42594476wrb.90.2019.06.25.09.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jun 2019 09:47:57 -0700 (PDT)
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
Subject: [PATCH v3 12/14] arm64: dts: qcom: qcs404: Add the clocks for APCS mux/divider
Date:   Tue, 25 Jun 2019 18:47:31 +0200
Message-Id: <20190625164733.11091-13-jorge.ramirez-ortiz@linaro.org>
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

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 94471aa31979..9569686dbc41 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -850,6 +850,9 @@
 			compatible = "qcom,qcs404-apcs-apps-global", "syscon";
 			reg = <0x0b011000 0x1000>;
 			#mbox-cells = <1>;
+			clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
+			clock-names = "aux", "pll";
+			#clock-cells = <0>;
 		};
 
 		apcs_hfpll: clock-controller@b016000 {
-- 
2.21.0

