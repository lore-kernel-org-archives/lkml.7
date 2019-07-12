Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17962C742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 06:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB2D20863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 06:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfGLGvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 02:51:48 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45292 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfGLGvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 02:51:48 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F2001A0085;
        Fri, 12 Jul 2019 08:51:45 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 078EA1A01E0;
        Fri, 12 Jul 2019 08:51:41 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 62BA6402D5;
        Fri, 12 Jul 2019 14:51:35 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH V2 1/2] usb: dwc3: Add node to update cache type setting
Date:   Fri, 12 Jul 2019 14:42:05 +0800
Message-Id: <20190712064206.48249-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Layerscape paltforms (such as LS1088A, LS2088A, etc) encounter USB
detect failues when adding dma-coherent to DWC3 node. This is because the
HW default cache type configuration of those SoC are not right, need to
be updated in DTS.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v2:
	- New file.

 Documentation/devicetree/bindings/usb/dwc3.txt | 43 ++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 8e5265e..7bc1cef 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -110,6 +110,43 @@ Optional properties:
  - in addition all properties from usb-xhci.txt from the current directory are
    supported as well
 
+* Cache type nodes (optional)
+
+The Cache type node is used to tell how to configure cache type on 4 different
+transfer types: Data Read, Desc Read, Data Write and Desc write. For each
+treasfer type, controller has a 4-bit register field to enable different cache
+type. Quoted from DWC3 data book Table 6-5 Cache Type Bit Assignments:
+----------------------------------------------------------------
+MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
+----------------------------------------------------------------
+AHB      |Cacheable     |Bufferable   |Privilegge |Data
+AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
+AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
+AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
+Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
+----------------------------------------------------------------
+Note: The AHB, AXI3, AXI4, and PCIe busses use different names for certain
+signals, which have the same meaning:
+  Bufferable = Posted
+  Cacheable = Modifiable = Snoop (negation of No Snoop)
+
+In most cases, this node is not required unless the default values of related
+registers are not correct *and* DWC3 node has enabled dma-coherent. So far we
+have observed USB device detect failure on some Layerscape platforms if this
+programming is not conducted properly.
+
+Required properties:
+- transfer_type_datard:	A value for 4-bit register which decide cache type of
+  Data Read transfer. According to above table, we can know that different
+  master bus type will cause different definition of cache type control bit. So
+  developer need to know which master bus type his platforms are using in
+  advance, then decide the value for this transfer type.
+- transfer_type_descrd:	A value for 4-bit register which decide cache type of
+  Desc Read transfer.
+- transfer_type_datawr:	A value for 4-bit register which decide cache type of
+  Data Write transfer.
+- transfer_type_descwr:	A value for 4-bit register which decide cache type of
+  Desc Write transfer.
 
 This is usually a subnode to DWC3 glue to which it is connected.
 
@@ -119,4 +156,10 @@ dwc3@4a030000 {
 	interrupts = <0 92 4>
 	usb-phy = <&usb2_phy>, <&usb3,phy>;
 	snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+	cache_type: cache_type {
+		transfer_type_datard = <0x2>;
+		transfer_type_descrd = <0x2>;
+		transfer_type_datawr = <0x2>;
+		transfer_type_descwr = <0x2>;
+	};
 };
-- 
2.7.4

