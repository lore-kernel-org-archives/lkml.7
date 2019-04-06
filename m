Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714B3C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 11:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BFD2087F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 11:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKaTd1XN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfDFLWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 07:22:34 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35013 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDFLWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 07:22:32 -0400
Received: by mail-yw1-f66.google.com with SMTP id d132so3281883ywa.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 04:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MF+LyKhdoU3hTyItL4k9rMey7QhjKplrEVwhrLx8K+k=;
        b=GKaTd1XNwC+NCs4UdvfIhT9EeA1ihEtU8RMheZ4131dQvjG9XcTr94HaBLw1kKAWIR
         8DrOBuT2lBXjMbhbqL4GT8MuwdecJ96PsJfyT11XdBptVnPpkheKYFFF1oojvVLQGj6Z
         QA6O+6ZabG2zkzMX0BI8h7nY3F+QHGAScnQqXvYSnVQLs/5P50Jqz9Je0653ARtQt8TY
         eW1T0mdvjWxv1u5s0qQMyIKMhMkEa2n4AHuZY6KJSeduX6K2H5XzXlNM2PTeISttqqt9
         oGGJKEsodWjb2+eMsEeszLS/EB06mj8fG8s7ykRNnkZ02iuN+nPjulPd6njjFDnS6p8e
         3MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MF+LyKhdoU3hTyItL4k9rMey7QhjKplrEVwhrLx8K+k=;
        b=q4LCao1k36IcjxjcAiuWWReKzOsYoeb+/9HSUYMLA0XU8frqHlQr2Id035z7gRlxQO
         EjDr8XLKRO948aRYR6cbCZagyEVF0LH6WgWU00lngVh0x9IHQJKS07Ys99mdOc7TfBEo
         tHWBDDNh9B5AJr7/DmzN2bkM70jNtzIYqhXy4CdlH4UJAq8foHDX4ATKOYWofdiaRMCP
         cyheWq1yZaoKDiWXknGf40YCfmA8Gwwc7TIGSEIn6Vsn2FnS+3Hrv2XjhSfn3X4idwPJ
         twOtTGhRLKxvNx0KsKBztA9Y8/pNpmLTANJCDMYadXrWxvMtf+bko5OEACfjGbDuQegG
         otQQ==
X-Gm-Message-State: APjAAAVxMYyOjFxSKT2OTKnIfpHU2UVRU0eNCNS21C88d8qKxsmgFYuu
        ZL2dG85dCd3iooqsNhi6t8F0TQ==
X-Google-Smtp-Source: APXvYqyruaCUsy2DQlE5OPs7Vn5PK28AuHEcTi9eg3GAgkrzqijYXxsrWHq3XswqPJ3iCC+qzQS1Aw==
X-Received: by 2002:a81:9982:: with SMTP id q124mr14774369ywg.390.1554549751987;
        Sat, 06 Apr 2019 04:22:31 -0700 (PDT)
Received: from localhost.localdomain (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id w22sm12729360yww.58.2019.04.06.04.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:22:31 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wanglai Shi <shiwanglai@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 3/4] dt-bindings: arm: coresight: Unify funnel DT binding
Date:   Sat,  6 Apr 2019 19:21:44 +0800
Message-Id: <20190406112145.15184-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190406112145.15184-1-leo.yan@linaro.org>
References: <20190406112145.15184-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
    "arm,coresight-funnel", "arm,primecell"; (obsolete)
    "arm,coresight-dynamic-funnel", "arm,primecell";

At the end of this patch, it gives an example for static funnel DT
binding, and updates the dynamic funnel example.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Wanglai Shi <shiwanglai@hisilicon.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../devicetree/bindings/arm/coresight.txt     | 52 +++++++++++++++++--
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index f8f794869af2..f8ad11a17cd5 100644
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
@@ -24,8 +25,11 @@ its hardware characteristcs.
 		  discovered at boot time when the device is probed.
 			"arm,coresight-tmc", "arm,primecell";
 
-		- Trace Funnel:
+		- Trace Programmable Funnel, the compatible string
+		  "arm,coresight-funnel" is obsolete, keep it to support
+		  the old DT bindings:
 			"arm,coresight-funnel", "arm,primecell";
+			"arm,coresight-dynamic-funnel", "arm,primecell";
 
 		- Embedded Trace Macrocell (version 3.x) and
 					Program Flow Trace Macrocell:
@@ -65,7 +69,7 @@ its hardware characteristcs.
 	  "stm-stimulus-base", each corresponding to the areas defined in "reg".
 
 * Required properties for devices that don't show up on the AMBA bus, such as
-  non-configurable replicators:
+  non-configurable replicators and non-configurable funnels:
 
 	* compatible: Currently supported value is (note the absence of the
 	  AMBA markee):
@@ -75,6 +79,9 @@ its hardware characteristcs.
 			"arm,coresight-replicator";
 			"arm,coresight-static-replicator";
 
+		- Coresight Non-configurable Funnel:
+			"arm,coresight-static-funnel";
+
 	* port or ports: see "Graph bindings for Coresight" below.
 
 * Optional properties for ETM/PTMs:
@@ -204,8 +211,45 @@ Example:
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

