Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1E2C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8A321906
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408884AbfIXC43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 22:56:29 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60540 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbfIXC40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:56:26 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F86620021A;
        Tue, 24 Sep 2019 04:56:24 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 87D2520037F;
        Tue, 24 Sep 2019 04:56:19 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 98E9C402ED;
        Tue, 24 Sep 2019 10:56:13 +0800 (SGT)
From:   Biwen Li <biwen.li@nxp.com>
To:     leoyang.li@nxp.com, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, ran.wang_1@nxp.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
Subject: [v3,3/3] Documentation: dt: binding: fsl: Add 'fsl,ippdexpcr-alt-addr' property
Date:   Tue, 24 Sep 2019 10:45:48 +0800
Message-Id: <20190924024548.4356-3-biwen.li@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190924024548.4356-1-biwen.li@nxp.com>
References: <20190924024548.4356-1-biwen.li@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'fsl,ippdexpcr-alt-addr' property is used to handle an errata A-008646
on LS1021A

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v3:
	- rename property name
	  fsl,rcpm-scfg -> fsl,ippdexpcr-alt-addr

Change in v2:
	- update desc of the property 'fsl,rcpm-scfg'

 Documentation/devicetree/bindings/soc/fsl/rcpm.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
index 5a33619d881d..157dcf6da17c 100644
--- a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
@@ -34,6 +34,11 @@ Chassis Version		Example Chips
 Optional properties:
  - little-endian : RCPM register block is Little Endian. Without it RCPM
    will be Big Endian (default case).
+ - fsl,ippdexpcr-alt-addr : Must add the property for SoC LS1021A,
+   Must include n + 1 entries (n = #fsl,rcpm-wakeup-cells, such as:
+   #fsl,rcpm-wakeup-cells equal to 2, then must include 2 + 1 entries).
+   The first entry must be a link to the SCFG device node.
+   The non-first entry must be offset of registers of SCFG.
 
 Example:
 The RCPM node for T4240:
@@ -43,6 +48,15 @@ The RCPM node for T4240:
 		#fsl,rcpm-wakeup-cells = <2>;
 	};
 
+The RCPM node for LS1021A:
+	rcpm: rcpm@1ee2140 {
+		compatible = "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1+";
+		reg = <0x0 0x1ee2140 0x0 0x8>;
+		#fsl,rcpm-wakeup-cells = <2>;
+		fsl,ippdexpcr-alt-addr = <&scfg 0x0 0x51c>; /* SCFG_SPARECR8 */
+	};
+
+
 * Freescale RCPM Wakeup Source Device Tree Bindings
 -------------------------------------------
 Required fsl,rcpm-wakeup property should be added to a device node if the device
-- 
2.17.1

