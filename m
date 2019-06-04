Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA7EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6935924C67
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rk1RfYD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfFDIPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:15:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42218 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfFDIPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:15:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so1996925pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=psGipp4xyvA6ITMw9MQePCESgWaNPblRsxWV83tCX+4=;
        b=Rk1RfYD3O1B47PXjsboBmdlUBgc8lREPnmsvxmlZ4K8tbkh9XtlFbnik9hg4P56Aue
         vqCyok4QonGQdHkxZSSuuFS6jhSm/NPbnnsrHIUNGu0BDi0lEwrpQqGPtV9+JT6czANw
         n6jjOqhPttUEOa8TtLKAQ9Eak8U0r9YB6rMRVZz+D4bWe6j738SSpVm3TR3OKtR/ICwX
         FtnPJSEFPw9flefbuW7WCJ+xLAqJTcCte3FVf3L/rqnX2mYXrYhElN0tb0xYCnYU//c2
         z1JGQfgT7b6nq/Z1fc3StiLbNMErzmcJ2zLaSjcx8Rswz5rPxDpQl1VFS2Oqjd5LnE6A
         4nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=psGipp4xyvA6ITMw9MQePCESgWaNPblRsxWV83tCX+4=;
        b=B43zH0fctk2Gg9tKLfW/NViO+omaFnqka03fc4ojFlancRlFAkPH+JFOCtOF3ObtNm
         55f57q110zxQlPm76Udq+OIZhaETEQIdugZ2NLvmXCShPr73mmNH5DytkloQLasmihzy
         UgtwusrAo9EJPoP+w/jaVer2Ib5dKekgwjMvYtTlGooJQSP9PzyE1NWxiFVe/aWPcOyl
         78YIJ36fO0YoMqA19XxMVcjNRLYGANFpFvi05fKO5i2b3JLkRt+AmwT8+O2gxLq4W61F
         PG8bNiNsrv/IqZs1dZN9b5/ych1e9vcZC4fZe9MLSzMx2RWP9l4nyCidr52hzVzay2Wi
         q1Mw==
X-Gm-Message-State: APjAAAVkMeWc1OiOqVrr+aZCAyCD1vzDDnvXBFyn/2y7OjO8N5V6k8j/
        7JV7ivKkSeRJ7Kjp8dFJkp8lxg==
X-Google-Smtp-Source: APXvYqw8S604f3AEfkc8EEZ0C+3dntoJhFVMgGRVMpVEZsSDNYKOAKmWI7L5sK+Tqxo8qYOOAAGJzg==
X-Received: by 2002:a63:70f:: with SMTP id 15mr17140238pgh.432.1559636120682;
        Tue, 04 Jun 2019 01:15:20 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j4sm14818804pgc.56.2019.06.04.01.15.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 01:15:20 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 7/9] dt-bindings: mmc: sprd: Add PHY DLL delay documentation
Date:   Tue,  4 Jun 2019 16:14:27 +0800
Message-Id: <6caaa6afd1b69fc491c36c665a954becb50d616b.1559635435.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce some PHY DLL delays properties to help to sample the PHY clock.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/mmc/sdhci-sprd.txt         |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
index a285c77..e675397 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
@@ -20,6 +20,23 @@ Optional properties:
 - assigned-clocks: the same with "sdio" clock
 - assigned-clock-parents: the default parent of "sdio" clock
 
+PHY DLL delays are used to delay the data valid window, and align the window
+to sampling clock. PHY DLL delays can be configured by following properties,
+and each property contains 4 cells which are used to configure the clock data
+write line delay value, clock read command line delay value, clock read data
+positive edge delay value and clock read data negative edge delay value.
+Each cell's delay value unit is cycle of the PHY clock.
+
+- sprd,phy-delay-legacy: Delay value for legacy timing.
+- sprd,phy-delay-sd-highspeed: Delay value for SD high-speed timing.
+- sprd,phy-delay-sd-uhs-sdr50: Delay value for SD UHS SDR50 timing.
+- sprd,phy-delay-sd-uhs-sdr104: Delay value for SD UHS SDR50 timing.
+- sprd,phy-delay-mmc-highspeed: Delay value for MMC high-speed timing.
+- sprd,phy-delay-mmc-ddr52: Delay value for MMC DDR52 timing.
+- sprd,phy-delay-mmc-hs200: Delay value for MMC HS200 timing.
+- sprd,phy-delay-mmc-hs400: Delay value for MMC HS400 timing.
+- sprd,phy-delay-mmc-hs400es: Delay value for MMC HS400 enhanced strobe timing.
+
 Examples:
 
 sdio0: sdio@20600000 {
@@ -33,6 +50,7 @@ sdio0: sdio@20600000 {
 	assigned-clocks = <&ap_clk CLK_EMMC_2X>;
 	assigned-clock-parents = <&rpll CLK_RPLL_390M>;
 
+	sprd,phy-delay-sd-uhs-sdr104 = <0x3f 0x7f 0x2e 0x2e>;
 	bus-width = <8>;
 	non-removable;
 	no-sdio;
-- 
1.7.9.5

