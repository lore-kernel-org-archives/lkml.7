Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFFBC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3645820885
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfKUCmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:42:32 -0500
Received: from inva021.nxp.com ([92.121.34.21]:51156 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfKUCmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 21:42:32 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 88DC0200575;
        Thu, 21 Nov 2019 03:42:29 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 24D7A20007A;
        Thu, 21 Nov 2019 03:42:24 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 46CA040286;
        Thu, 21 Nov 2019 10:42:17 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Chen <peter.chen@nxp.com>, Jun Li <jun.li@nxp.com>,
        Leo Li <leoyang.li@nxp.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v3 1/2] usb: dwc3: Add chip-specific compatible string
Date:   Thu, 21 Nov 2019 10:42:05 +0800
Message-Id: <20191121024206.32933-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Layerscape paltforms (such as LS1088A, LS2088A, etc) require update HW
default cache type configuration to fix DWC3 init failure when applying
property dma-coherent.

Note that the cache type configuration is actually native feature of DWC3,
not additional desgin coming from SoC, so add this support here.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v3:
	- Update commit subject according to content change, originanl one is
	  'usb: dwc3: Add node to update cache type setting'
	- Replace sub-node definition with chip-specifc compatible string.

Change in v2:
	- New file.

 Documentation/devicetree/bindings/usb/dwc3.txt | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 66780a4..043c312e 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -4,7 +4,21 @@ DWC3- USB3 CONTROLLER. Complies to the generic USB binding properties
       as described in 'usb/generic.txt'
 
 Required properties:
- - compatible: must be "snps,dwc3"
+ - compatible: must be "snps,dwc3" and (if applicable) may contain a
+	chip-specific compatible string in front of it to allow dwc3 driver be
+	able to update cache type configuration accordingly, otherwise
+	Layerscape SoC will encounter USB init failure when adding property
+	dma-coherent on device tree.
+	Example:
+	* "fsl,ls1012a-dwc3", "snps,dwc3"
+	* "fsl,ls1021a-dwc3", "snps,dwc3"
+	* "fsl,ls1028a-dwc3", "snps,dwc3"
+	* "fsl,ls1043a-dwc3", "snps,dwc3"
+	* "fsl,ls1046a-dwc3", "snps,dwc3"
+	* "fsl,ls1088a-dwc3", "snps,dwc3"
+	* "fsl,ls2088a-dwc3", "snps,dwc3"
+	* "fsl,lx2160a-dwc3", "snps,dwc3"
+
  - reg : Address and length of the register set for the device
  - interrupts: Interrupts used by the dwc3 controller.
  - clock-names: should contain "ref", "bus_early", "suspend"
-- 
2.7.4

