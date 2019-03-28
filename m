Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B9AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3485F2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zAfkv3nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfC1CgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:36:19 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37108 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbfC1CgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:36:18 -0400
Received: by mail-yw1-f68.google.com with SMTP id w66so1735717ywd.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 19:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=izMEmenMwBdlubPiof5Ev5xU+2SW+3nUdBrCi2sga88=;
        b=zAfkv3nlCpcu6TSOQFT/3Fyd0KL9msGTLGDNLLdL4jyUY8HHZM7r1qIMIET5tQpfiw
         TjC8X6n3xhPLWHBo8UPhTiCo6hS3QrZUScBJ2e6WDGj0afXx5Kva5v8NhIBkpMkBjefV
         P6Ek2BuEzRCJAZjUGxK8xGWEYMj1XgAGSJ/t2nQJvZNldaplak/ZPmeP4xn+2mR/WA1N
         8UbesXQ57KGQF6q1oG9HtoPv6YYmnaiAwSn0kBGv999xFlgxHdJtaR9xf10rKBjwxny7
         LdGLJ7ra65NijJWIgompQrHWOZnRBmArejxpWVGJOpgPVX7LDRClEU4vh+A3A/QB0783
         Ms+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=izMEmenMwBdlubPiof5Ev5xU+2SW+3nUdBrCi2sga88=;
        b=OQCLDca6CC5WTo156odN609RFJJxY8r025FBCl0cYzgfsHWoXEqaBXAppjJ0FDci2a
         kTzYD0+0gHinTlC3I7vnv1OtCgxaIQyUyfgqQOFI0+D7tjCx+QPuci4aqVjnfTXsO4Vn
         b1agn2E9Lttk87jbVvlIv8DxO47Jl/XRIBhufMqgaEu3XWSSEQ4/ZXUBMGo3RVjvsw9f
         VoOu8YJ7QskX9keqjQ5a0BrP9Q5erpCWZjtQMNagRn0jzwsZ/gtor1Lrer2t/eMf6Fjy
         LBON2NKn4j4w4/liRZTRLJ8ggXMrzTp/+LpttFKChehZL5bS+aoIIBlnHWWVFFYeUj82
         MNkQ==
X-Gm-Message-State: APjAAAVUktWiBDijgYUfc04BHGRYnmAiFq7J2+KCeOV3F0n3k4oMNVX+
        mTXM8+Gr6Pdw6+BxXgOr8Frlzw==
X-Google-Smtp-Source: APXvYqwB7GdcortQECd6/UG4VHGVsKglb9EDWg3seBigzNpC07TfOW3K/oYjIK9kNWvGCaIRH8P/rg==
X-Received: by 2002:a81:ad61:: with SMTP id l33mr31841567ywk.506.1553740577793;
        Wed, 27 Mar 2019 19:36:17 -0700 (PDT)
Received: from localhost.localdomain (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id t71sm16272787ywc.4.2019.03.27.19.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 19:36:16 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        Wanglai Shi <shiwanglai@hisilicon.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: coresight: Support static funnel
Date:   Thu, 28 Mar 2019 10:35:08 +0800
Message-Id: <20190328023509.22242-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190328023509.22242-1-leo.yan@linaro.org>
References: <20190328023509.22242-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document DT binding for static (non-configurable) funnel and give an
example for it.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Wanglai Shi <shiwanglai@hisilicon.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../devicetree/bindings/arm/coresight.txt     | 45 +++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index f8aff65ab921..42935c6ca9d6 100644
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
@@ -24,7 +25,7 @@ its hardware characteristcs.
 		  discovered at boot time when the device is probed.
 			"arm,coresight-tmc", "arm,primecell";
 
-		- Trace Funnel:
+		- Trace Programmable Funnel:
 			"arm,coresight-funnel", "arm,primecell";
 
 		- Embedded Trace Macrocell (version 3.x) and
@@ -65,11 +66,12 @@ its hardware characteristcs.
 	  "stm-stimulus-base", each corresponding to the areas defined in "reg".
 
 * Required properties for devices that don't show up on the AMBA bus, such as
-  non-configurable replicators:
+  non-configurable replicators and non-configurable funnels:
 
 	* compatible: Currently supported value is (note the absence of the
 	  AMBA markee):
 		- "arm,coresight-replicator"
+		- "arm,coresight-static-funnel"
 
 	* port or ports: see "Graph bindings for Coresight" below.
 
@@ -200,6 +202,43 @@ Example:
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
 		compatible = "arm,coresight-funnel", "arm,primecell";
 		reg = <0 0x20040000 0 0x1000>;
-- 
2.17.1

