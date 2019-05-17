Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93972C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 03:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB8B205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 03:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfEQDiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 23:38:13 -0400
Received: from inva021.nxp.com ([92.121.34.21]:43888 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbfEQDiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 23:38:11 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 06A0B200065;
        Fri, 17 May 2019 05:38:09 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 54977200014;
        Fri, 17 May 2019 05:38:03 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1B70C402BF;
        Fri, 17 May 2019 11:37:56 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH V2 2/3] Documentation: dt: binding: fsl: Add 'little-endian' and update Chassis define
Date:   Fri, 17 May 2019 11:39:45 +0800
Message-Id: <20190517033946.30763-2-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517033946.30763-1-ran.wang_1@nxp.com>
References: <20190517033946.30763-1-ran.wang_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, QorIQ SoC's RCPM register block is Big Endian. But
there are some exceptions, such as LS1088A and LS2088A, are Little
Endian. So add this optional property to help identify them.

Actually LS2021A and other Layerscapes won't totally follow Chassis
2.1, so separate them from powerpc SoC.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v2:
	- None.

 Documentation/devicetree/bindings/soc/fsl/rcpm.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
index e284e4e..058154c 100644
--- a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
@@ -20,6 +20,7 @@ Required properites:
 	* "fsl,qoriq-rcpm-1.0": for chassis 1.0 rcpm
 	* "fsl,qoriq-rcpm-2.0": for chassis 2.0 rcpm
 	* "fsl,qoriq-rcpm-2.1": for chassis 2.1 rcpm
+	* "fsl,qoriq-rcpm-2.1+": for chassis 2.1+ rcpm
 
 All references to "1.0" and "2.0" refer to the QorIQ chassis version to
 which the chip complies.
@@ -27,7 +28,12 @@ Chassis Version		Example Chips
 ---------------		-------------------------------
 1.0				p4080, p5020, p5040, p2041, p3041
 2.0				t4240, b4860, b4420
-2.1				t1040, ls1021
+2.1				t1040,
+2.1+			ls1021a, ls1012a, ls1043a, ls1046a
+
+Optional properties:
+ - little-endian : RCPM register block is Little Endian. Without it RCPM
+   will be Big Endian (default case).
 
 Example:
 The RCPM node for T4240:
-- 
1.7.1

