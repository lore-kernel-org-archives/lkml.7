Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03640C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B3520C01
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DfJSJp1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfEBQyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:54:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42563 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfEBQyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:54:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so1320503pgh.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 09:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tTIyE5NXuHrlOq5gllPk+Q5yU0dC0cT6YPpzWkGZKrk=;
        b=DfJSJp1E5/kYZAponh3b9l8qSiRbPxtIfigHy3nbt5ALTcLcgaq3O7Mf70m0HnH6gv
         dwMR/dRP5XZEE8vludrAZSeMdmUESQGZof734kmI3kTI+ZAFc+GRoVBos6FcRPjbAXRa
         HGTkFPehBpHI2uZJcRITrTaLsrG6K5BUlWGlSaTTKXYFUjnIoaqw2CBHJ4H7k8oO27C6
         c7A+t/XB616J4l4XUFHcCJr5ufa6AHFXYto320cCRRTP8CpcdCsL4qQgymWg9Ksfi9Ap
         TavCrit12Yk8ETY8NTwpFfFkgI8zX+K6NGQlhTxDigh75NS1ZvxrPaZ9Nd16SQlkHjX+
         BA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tTIyE5NXuHrlOq5gllPk+Q5yU0dC0cT6YPpzWkGZKrk=;
        b=fytbJ2g4aHakhWkaalbCLiN+FZgcQKMzhLSXVH/p5XTbzSAd1GGOgnkbLJ4mQjfFb4
         29VD3wmv56s35G1h+IG/RFJoGWsq1z3TBOFXJ110aPWx5YRlIzZ3Z8v7E6/URE3dFnVt
         s6bupQFBkqp99ax3Fa9Tp4rJ5QWnGqEvLBLlVvmKRvTus2iB355W17XXcuYlPceHwo2c
         Cc7R24DFkazW5zr/VkX2vjCATZ+LrKDqFlbJii8ITLyzF3owS6Fmp69oWvWCkj3P4e+J
         aXWBwD9QvzYAS5LuauRMvvcaLxXadn3e6k1a+rNsgI8J1On9pziBZdCw/7Z4zqaSSSSU
         WnSw==
X-Gm-Message-State: APjAAAXTGA14AxNP3fFJDIgouN0YjXxW0MoCBd4H6uRu/Nca3CXjNKgr
        YWkTrIj9se74GcKYZoOZynmM4A==
X-Google-Smtp-Source: APXvYqwWOAmvj3YvTHUYoK36fRkMS9w20Ys3abUSfLJL1Z2FxxvgL5txroZfV32U5+5B+afupPCPBA==
X-Received: by 2002:a63:20f:: with SMTP id 15mr4899953pgc.90.1556816051299;
        Thu, 02 May 2019 09:54:11 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j2sm69949pff.77.2019.05.02.09.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 09:54:10 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: arm: coresight: Unify funnel DT binding
Date:   Thu,  2 May 2019 10:54:04 -0600
Message-Id: <20190502165405.31573-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190502165405.31573-1-mathieu.poirier@linaro.org>
References: <20190502165405.31573-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

Following the same fashion with replicator DT binding, this patch is to
unify the DT binding for funnel to support static and dynamic modes;
finally we get the funnel DT binding as below:

Before patch:

  Static funnel, aka. non-configurable funnel:
    Not supported;

  Dynamic funnel, aka. configurable funnel:
    "arm,coresight-funnel", "arm,primecell";

After patch:

  Static funnel:
    "arm,coresight-static-funnel";

  Dynamic funnel:
    "arm,coresight-dynamic-funnel", "arm,primecell";
    "arm,coresight-funnel", "arm,primecell"; (obsolete)

At the end of this patch, it gives an example for static funnel DT
binding, and updates the dynamic funnel example.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Wanglai Shi <shiwanglai@hisilicon.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../devicetree/bindings/arm/coresight.txt     | 53 +++++++++++++++++--
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index d02d160fa8ac..8a88ddebc1a2 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -8,7 +8,8 @@ through the intermediate links connecting the source to the currently selected
 sink. Each CoreSight component device should use these properties to describe
 its hardware characteristcs.
 
-* Required properties for all components *except* non-configurable replicators:
+* Required properties for all components *except* non-configurable replicators
+  and non-configurable funnels:
 
 	* compatible: These have to be supplemented with "arm,primecell" as
 	  drivers are using the AMBA bus interface.  Possible values include:
@@ -24,8 +25,10 @@ its hardware characteristcs.
 		  discovered at boot time when the device is probed.
 			"arm,coresight-tmc", "arm,primecell";
 
-		- Trace Funnel:
-			"arm,coresight-funnel", "arm,primecell";
+		- Trace Programmable Funnel:
+			"arm,coresight-dynamic-funnel", "arm,primecell";
+			"arm,coresight-funnel", "arm,primecell"; (OBSOLETE. For
+				backward compatibility and will be removed)
 
 		- Embedded Trace Macrocell (version 3.x) and
 					Program Flow Trace Macrocell:
@@ -65,7 +68,7 @@ its hardware characteristcs.
 	  "stm-stimulus-base", each corresponding to the areas defined in "reg".
 
 * Required properties for devices that don't show up on the AMBA bus, such as
-  non-configurable replicators:
+  non-configurable replicators and non-configurable funnels:
 
 	* compatible: Currently supported value is (note the absence of the
 	  AMBA markee):
@@ -74,6 +77,9 @@ its hardware characteristcs.
 			"arm,coresight-replicator"; (OBSOLETE. For backward
 				compatibility and will be removed)
 
+		- Coresight Non-configurable Funnel:
+			"arm,coresight-static-funnel";
+
 	* port or ports: see "Graph bindings for Coresight" below.
 
 * Optional properties for ETM/PTMs:
@@ -203,8 +209,45 @@ Example:
 		};
 	};
 
+	funnel {
+		/*
+		 * non-configurable funnel don't show up on the AMBA
+		 * bus.  As such no need to add "arm,primecell".
+		 */
+		compatible = "arm,coresight-static-funnel";
+		clocks = <&crg_ctrl HI3660_PCLK>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				combo_funnel_out: endpoint {
+					remote-endpoint = <&top_funnel_in>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				combo_funnel_in0: endpoint {
+					remote-endpoint = <&cluster0_etf_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				combo_funnel_in1: endpoint {
+					remote-endpoint = <&cluster1_etf_out>;
+				};
+			};
+		};
+	};
+
 	funnel@20040000 {
-		compatible = "arm,coresight-funnel", "arm,primecell";
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 		reg = <0 0x20040000 0 0x1000>;
 
 		clocks = <&oscclk6a>;
-- 
2.17.1

