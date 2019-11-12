Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F1BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B2320650
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cJUgssu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfKLO26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:28:58 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40868 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfKLO26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:28:58 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACESu9l045437;
        Tue, 12 Nov 2019 08:28:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573568936;
        bh=tLf8SXtD5MIh4RuLfkAo79HCpF/i9eG4PtrsPy5Sv/A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cJUgssu8m5EDKUlH/Jj+Xy4FMD9CdRsej78csFeM0HE7jvidwnCnss7ksmDtDG0TM
         LsM9SWHPw5UkydpDx4yiWu0XqQuvfGD+R9N6lQ37CtvUqDUL/w3OoADNmGILOv3V2K
         qLJoCm8FSANrUOfXuvoqa5ZpoP4gvc4gPmTVBPJU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xACESu64026632
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Nov 2019 08:28:56 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:28:38 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:28:38 -0600
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACESriD044422;
        Tue, 12 Nov 2019 08:28:55 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benoit Parrot <bparrot@ti.com>
Subject: [Patch v3 01/20] dt-bindings: media: cal: update binding to use syscon
Date:   Tue, 12 Nov 2019 08:31:33 -0600
Message-ID: <20191112143152.23176-2-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112143152.23176-1-bparrot@ti.com>
References: <20191112143152.23176-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Device Tree bindings for the CAL driver to use syscon to access
the phy config register instead of trying to map it directly.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 Documentation/devicetree/bindings/media/ti-cal.txt | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/ti-cal.txt b/Documentation/devicetree/bindings/media/ti-cal.txt
index ae9b52f37576..93096d924786 100644
--- a/Documentation/devicetree/bindings/media/ti-cal.txt
+++ b/Documentation/devicetree/bindings/media/ti-cal.txt
@@ -10,9 +10,14 @@ Required properties:
 - compatible: must be "ti,dra72-cal"
 - reg:	CAL Top level, Receiver Core #0, Receiver Core #1 and Camera RX
 	control address space
-- reg-names: cal_top, cal_rx_core0, cal_rx_core1, and camerrx_control
+- reg-names: cal_top, cal_rx_core0, cal_rx_core1 and camerrx_control
 	     registers
 - interrupts: should contain IRQ line for the CAL;
+- ti,camerrx-control: phandle to the device control module and offset to
+		      the control_camerarx_core register.
+		      This node is meant to replace the "camerrx_control"
+		      reg entry above but "camerrx_control" is still
+		      handled for backward compatibility.
 
 CAL supports 2 camera port nodes on MIPI bus. Each CSI2 camera port nodes
 should contain a 'port' child node with child 'endpoint' node. Please
@@ -25,13 +30,12 @@ Example:
 		ti,hwmods = "cal";
 		reg = <0x4845B000 0x400>,
 		      <0x4845B800 0x40>,
-		      <0x4845B900 0x40>,
-		      <0x4A002e94 0x4>;
+		      <0x4845B900 0x40>;
 		reg-names = "cal_top",
 			    "cal_rx_core0",
-			    "cal_rx_core1",
-			    "camerrx_control";
+			    "cal_rx_core1";
 		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+		ti,camerrx-control = <&scm_conf 0xE94>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-- 
2.17.1

