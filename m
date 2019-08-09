Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AF6C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EB220665
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406609AbfHIOke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:40:34 -0400
Received: from foss.arm.com ([217.140.110.172]:48090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfHIOke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:40:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 218CC15A2;
        Fri,  9 Aug 2019 07:40:34 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 700D33F706;
        Fri,  9 Aug 2019 07:40:33 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: Extend SCMI to support new reset protocol
Date:   Fri,  9 Aug 2019 15:40:27 +0100
Message-Id: <20190809144027.20912-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMIv2.0 adds a new Reset Management Protocol to manage various reset
states a given device or domain can enter. Extend the existing SCMI
bindings to add reset protocol support by re-using the reset bindings
for both reset providers and consumers.

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 .../devicetree/bindings/arm/arm,scmi.txt        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Hi Rob,

I am posting this separately to avoid reposting the driver patches that
are already reviewed/asked. I need your ack to take the changes for v5.4
I might have messed up something that it got missed from your patchworks
Full series @[1]

Regards,
Sudeep

[1] https://lore.kernel.org/lkml/20190806170208.6787-4-sudeep.holla@arm.com/

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
index 317a2fc3667a..083dbf96ee00 100644
--- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -73,6 +73,16 @@ SCMI provides an API to access the various sensors on the SoC.
 			 as used by the firmware. Refer to  platform details
 			 for your implementation for the IDs to use.

+Reset signal bindings for the reset domains based on SCMI Message Protocol
+------------------------------------------------------------
+
+This binding for the SCMI reset domain providers uses the generic reset
+signal binding[5].
+
+Required properties:
+ - #reset-cells : Should be 1. Contains the reset domain ID value used
+		  by SCMI commands.
+
 SRAM and Shared Memory for SCMI
 -------------------------------

@@ -93,6 +103,7 @@ Each sub-node represents the reserved area for SCMI.
 [2] Documentation/devicetree/bindings/power/power_domain.txt
 [3] Documentation/devicetree/bindings/thermal/thermal.txt
 [4] Documentation/devicetree/bindings/sram/sram.txt
+[5] Documentation/devicetree/bindings/reset/reset.txt

 Example:

@@ -152,6 +163,11 @@ firmware {
 			reg = <0x15>;
 			#thermal-sensor-cells = <1>;
 		};
+
+		scmi_reset: protocol@16 {
+			reg = <0x16>;
+			#reset-cells = <1>;
+		};
 	};
 };

@@ -166,6 +182,7 @@ hdlcd@7ff60000 {
 	reg = <0 0x7ff60000 0 0x1000>;
 	clocks = <&scmi_clk 4>;
 	power-domains = <&scmi_devpd 1>;
+	resets = <&scmi_reset 10>;
 };

 thermal-zones {
--
2.17.1

