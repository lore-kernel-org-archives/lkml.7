Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C4EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD92320850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yPKfCE75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfDLK2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:28:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42142 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfDLK2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:28:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id w139so7498168oie.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 03:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TVn8dSjjHAjnUPi8i4DcVyaJDVuLc6w06N90aexbdd8=;
        b=yPKfCE75VVrUcD6JiDsUWrln5V+ZYLYS+8l0jP5LCqSGqu1DYXF7Q8WELVIg7jB5M6
         ywFTk3ftdjVjq7Bft/uzTliVctphixGmZx+fH76nVFz31EApMrGmSxucTWSD4vmWglqx
         YPxWfq3DpNIVyoqFmAx4ZrpBUVkNjDy1BRl8Cxfs3jdi54Uo0TeK7wH+y4PEpuhJSHwt
         dVJ9DT88yG1eCR00/j/RFMesIA7CYN/vA16svo34m0mbdgdmdVmC9qVV85lPjFmtsYIw
         gY1sPo9YlKs+A7NIozanwu/fGuY1MDffOZT8+FNK5nu21Hc8RMCOZi92C3gykJffuH8q
         MQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TVn8dSjjHAjnUPi8i4DcVyaJDVuLc6w06N90aexbdd8=;
        b=KkC82pgGUBeR0vuJt+aMOKRI022sNSpVHR99KQjxHOi0STm9qjaCWoocFAWJpzqeOt
         5dNDW9u2rZKeB4B1kWLCFp62Zj8jiv+AZw238ZzROT8ynYPwUzbVYFuLwvesr+my4Tff
         FxgUeKn3Cw2WSsni2iD08N7IpjD8U6KdmtYZpxm+ttSScqICRCMFyJlyP555NxDkIjvH
         oP0pz+Tg6NSVmk1h7R39/y63XfF/553V6GwezkLWUEvU14tI5eyI3vgDd/Xf48cPTaCm
         ysBL1MQGjRYcthLy1xRxQXWvmHjXOq3pL/e/UAusbHqxGNvyr2WM8Mbblbbr2bzLXhkn
         6FJQ==
X-Gm-Message-State: APjAAAWpRjheItJJ5W2Yp3gRa7r10GE/77XOXsrDU+pJC/FNqiN6aXL+
        vynKZQiRkbJGGmxk7K/u5FfGpg==
X-Google-Smtp-Source: APXvYqyNpwzetvHvKbpfxI/TTtuzwcmDeOwKsi2Stz2v950N9yfrCoqE+fb2dexrXKk4FqwsirmvPw==
X-Received: by 2002:aca:5a89:: with SMTP id o131mr10258811oib.17.1555064889350;
        Fri, 12 Apr 2019 03:28:09 -0700 (PDT)
Received: from localhost.localdomain (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id 88sm17530692otj.3.2019.04.12.03.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 03:28:08 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Wanglai Shi <shiwanglai@hisilicon.com>
Subject: [PATCH v5 3/4] dt-bindings: arm: coresight: Unify funnel DT binding
Date:   Fri, 12 Apr 2019 18:27:37 +0800
Message-Id: <20190412102738.12679-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412102738.12679-1-leo.yan@linaro.org>
References: <20190412102738.12679-1-leo.yan@linaro.org>
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
    "arm,coresight-dynamic-funnel", "arm,primecell";
    "arm,coresight-funnel", "arm,primecell"; (obsolete)

At the end of this patch, it gives an example for static funnel DT
binding, and updates the dynamic funnel example.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Wanglai Shi <shiwanglai@hisilicon.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
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

