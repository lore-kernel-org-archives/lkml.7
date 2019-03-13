Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751CBC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C872075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SuP0zDPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfCMTd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:33:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41082 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfCMTdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:33:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id p1so3302660wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UDDK3ZuE18UBaMnSKNW3aRwC8Z//s3DoM8HiLpa/VRw=;
        b=SuP0zDPYF7Ulece5iTXk+pmnpyLWc3eKtMd3+JQD9+5ZSuuoyhbfZQZc8sUODuGHC5
         JFC6ro1dq9n4/YzAHnyjlSsC2V8GvEfSBEAaJk+vR1ZAAhqA7jhJQX5fgPMWDpJ/jI6f
         fS0GjegeCK80Xf3Vs4VPYDIIvRxnnwA1VduNtWTULlzHJwd6KJcuGzSUfWiutkyI7VmQ
         veR1lv6BTzWDlUQypA8mI0X2Bj+s2a1Yw7rNQlWBawSnXlFb5+d6ZA+qh+FU0lDK5DPE
         BvLfqFrKbiVigytHRDh+O4RSElgR46/umz92BeeBB4l0OoGqS2APJMVE6TY2FqqlTENl
         nURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDDK3ZuE18UBaMnSKNW3aRwC8Z//s3DoM8HiLpa/VRw=;
        b=DPDsjyDvaXGZnIFSFMHYsWGPS0MadbQ4z2Mb3+iIPGOgfdQNq6gn92IxpUc8RUV/N5
         3wi+c7aon1MXxPbRTP3I73sdzNKBBX5nRhK1QqZkkBUdsEU+tw6V8lmkLh1kbY7uyJZ2
         Cp4iBCJuvWve2Qs1DlaAse62NaPHX0gOk2nGRdrdh1dCusQklnMnOYoChGYBcMC02BXT
         dBhm8LB99mMJZBDGlyn3AhuCV8ad/PhDSa4ArqHNjH2ecwCmbgSmfN7ynHBdh4vYIKuy
         xhuZJyW0XEudkjxqBgxSOle4ox9JWA51Ddw5YDi7IWgpSUfgRDkvD2MWYqXdKrWASO4F
         B5BQ==
X-Gm-Message-State: APjAAAW+ILsPEjXIBcrsDxzqvu4Ienr/WEo+OFSqd5dr9lGFVIk1iU/P
        HcPGVIdsGY/fn9aqChmdXtMfdLNpw/I=
X-Google-Smtp-Source: APXvYqw3Ol5Hk3XjFB887ctA6G+qqgk2Oz8WuN2IY5XIz8KOcXb/f929xK7OrfCqOwiKJoS0VKAMMw==
X-Received: by 2002:a5d:4a4d:: with SMTP id v13mr572670wrs.169.1552505628705;
        Wed, 13 Mar 2019 12:33:48 -0700 (PDT)
Received: from localhost.localdomain (205.66.21.93.rev.sfr.net. [93.21.66.205])
        by smtp.gmail.com with ESMTPSA id z198sm3017497wmc.10.2019.03.13.12.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 12:33:47 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     linux-pm@vger.kernel.org, georgi.djakov@linaro.org
Cc:     mturquette@baylibre.com, ptitiano@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zening.wang@nxp.com, aisheng.dong@nxp.com, khilman@baylibre.com,
        ccaione@baylibre.com, Alexandre Bailon <abailon@baylibre.com>
Subject: [RFC PATCH 3/3] dt-bindings: interconnect: Document fsl,busfreq-imx8mm bindings
Date:   Wed, 13 Mar 2019 20:34:08 +0100
Message-Id: <20190313193408.23740-4-abailon@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190313193408.23740-1-abailon@baylibre.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the device-tree bindings interconnect driver for i.MX8MM SoC.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 .../bindings/interconnect/imx8mm.txt          | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/imx8mm.txt

diff --git a/Documentation/devicetree/bindings/interconnect/imx8mm.txt b/Documentation/devicetree/bindings/interconnect/imx8mm.txt
new file mode 100644
index 000000000000..81f0cf134de2
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/imx8mm.txt
@@ -0,0 +1,24 @@
+i.MX busfreq driver binding
+----------------------------------------------------
+
+Required properties :
+- compatible : must be "fsl,busfreq-imx8mm"
+- #interconnect-cells : should contain 1
+- clocks : list of phandles and specifiers to all interconnect bus clocks
+- clock-names : clock names must include "dram-alt", "dram-apb", "dram-core",
+                "noc", "ahb" and "axi"
+
+Examples:
+
+	icc0: icc {
+		compatible = "fsl,busfreq-imx8mm";
+		#interconnect-cells = <1>;
+		clocks = <&clk IMX8MM_CLK_DRAM_ALT>,
+			 <&clk IMX8MM_CLK_DRAM_APB>,
+			 <&clk IMX8MM_CLK_DRAM_CORE>,
+			 <&clk IMX8MM_CLK_NOC_DIV>,
+			 <&clk IMX8MM_CLK_AHB_DIV>,
+			 <&clk IMX8MM_CLK_MAIN_AXI>;
+		clock-names = "dram-alt", "dram-apb", "dram-core", "noc",
+			 "ahb", "axi";
+	};
-- 
2.19.2

