Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A30C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE95021848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NsZnHTnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733179AbfHZQsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:48:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46067 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbfHZQsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:48:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id q12so15959845wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 09:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YOocsbJSeEFZluDhuzPE1zAAorjfBXrmhgRxid6+uG4=;
        b=NsZnHTnbHWll2bdVW2ovEHICEh3GJqof/NEoMfJ4Y8yrH0xeFp417Yy+3C+h1fJv1p
         AjePh5kfIe6BX5pLNWHmxs6MSQzBqgP7+JmZiY7k7pKJauPYW+NYLjUnQ64q6jljK/d4
         ErMrPOf5XameBxDFh50wEbNTfj8M4NJ/Ujq/x5LYBFq79CY6PQp9SHDudQaIRyQvFZvH
         ZcPK/pW7zutvsABFwvilgc1rRl9mkzJvaD0EBfooe1GdX0K47j+4wlQN3fWe5i0LcIgw
         Fgb85bN60puObL2yXFhMaOiox2CBlB+yEu20ZaBaDUlhk2wKX4CPOQi8fhJx8ngVqJYW
         QNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YOocsbJSeEFZluDhuzPE1zAAorjfBXrmhgRxid6+uG4=;
        b=OphDjtsheC1Mi3O+IfENufPNbeRuV+LhTQkDoGO58BX5j+zLedJW5EgfBlren2Jx/N
         LXk/KDgYoEou26vdsMQTiGruu3s1Dfa3FHmd8uNPfMxEBVTEs/ZBWUAYGmNF3wOGKJ6B
         VpBRJFCPaw1A2Wf/QVyulcZIX+PYxIGcQXlgAfvGEc+P9u4JfXdIXLdYQxnCOd7OOxFd
         ztxYU037j+M95GB9G/fRvrvASugdSgPK6pvIa0+2Huh/ekSbhqjBkijMJl76GRowQLfN
         Kr3Pb+9mLwA/y+yRZV9cr4xy5aAy30LgulHrfcww3p2QsdW4Tf6gpmiyb5d2a2yxcQE9
         fEKQ==
X-Gm-Message-State: APjAAAVtV1tGEcqRVbFUC7AqmaFNjU/WkwU5w8VWBfQreYj8cc+ancFK
        VlUs09BXIvRO0IFIzzcymyLAYA==
X-Google-Smtp-Source: APXvYqzPcgyMXXhYl1Q3zNI2CZd1u12C3LHziyafTloiYXqCJAA7EACMMiSblht14P9NtKAoKIy1ow==
X-Received: by 2002:adf:e887:: with SMTP id d7mr23481374wrm.282.1566838090464;
        Mon, 26 Aug 2019 09:48:10 -0700 (PDT)
Received: from localhost.localdomain (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id o14sm21800076wrg.64.2019.08.26.09.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Aug 2019 09:48:10 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, agross@kernel.org, mark.rutland@arm.com
Cc:     niklas.cassel@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: mailbox: qcom: Add clock-name optional property
Date:   Mon, 26 Aug 2019 18:48:02 +0200
Message-Id: <20190826164807.7028-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the APCS clock is registered (platform dependent), it retrieves
its parent names from hardcoded values in the driver.

The following commit allows the DT node to provide such clock names to
the platform data based clock driver therefore avoiding having to
explicitly embed those names in the clock driver source code.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../mailbox/qcom,apcs-kpss-global.txt         | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
index 1232fc9fc709..b69310322b09 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
@@ -18,10 +18,11 @@ platforms.
 	Usage: required
 	Value type: <prop-encoded-array>
 	Definition: must specify the base address and size of the global block
+
 - clocks:
-	Usage: required if #clocks-cells property is present
-	Value type: <phandle>
-	Definition: phandle to the input PLL, which feeds the APCS mux/divider
+	Usage: required if #clock-names property is present
+	Value type: <phandle array>
+	Definition: phandles to the two parent clocks of the clock driver.
 
 - #mbox-cells:
 	Usage: required
@@ -33,6 +34,12 @@ platforms.
 	Value type: <u32>
 	Definition: as described in clock.txt, must be 0
 
+- clock-names:
+	Usage: required if the platform data based clock driver needs to
+	retrieve the parent clock names from device tree.
+	This will requires two mandatory clocks to be defined.
+	Value type: <string-array>
+	Definition: must be "aux" and "pll"
 
 = EXAMPLE
 The following example describes the APCS HMSS found in MSM8996 and part of the
@@ -65,3 +72,14 @@ Below is another example of the APCS binding on MSM8916 platforms:
 		clocks = <&a53pll>;
 		#clock-cells = <0>;
 	};
+
+Below is another example of the APCS binding on QCS404 platforms:
+
+	apcs_glb: mailbox@b011000 {
+		compatible = "qcom,qcs404-apcs-apps-global", "syscon";
+		reg = <0x0b011000 0x1000>;
+		#mbox-cells = <1>;
+		clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
+		clock-names = "aux", "pll";
+		#clock-cells = <0>;
+	};
-- 
2.22.0

