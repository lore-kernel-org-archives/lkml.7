Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22896C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07920206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfKNMXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:23:25 -0500
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:54976 "EHLO
        SHSQR01.unisoc.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726057AbfKNMXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:23:24 -0500
X-Greylist: delayed 2023 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Nov 2019 07:23:22 EST
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id xAEBnZYP019500;
        Thu, 14 Nov 2019 19:49:35 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id xAEBm05r017883
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 14 Nov 2019 19:48:01 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from localhost (10.0.74.112) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Thu, 14 Nov 2019 19:48:04
 +0800
From:   Orson Zhai <orson.zhai@unisoc.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <steven.tang@unisoc.com>, Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH 1/2] dt-bindings: Add syscon-names support
Date:   Thu, 14 Nov 2019 19:45:24 +0800
Message-ID: <20191114114525.12675-2-orson.zhai@unisoc.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191114114525.12675-1-orson.zhai@unisoc.com>
References: <20191114114525.12675-1-orson.zhai@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.112]
X-ClientProxiedBy: shcas04.spreadtrum.com (10.29.35.89) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com xAEBm05r017883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Make life easier when syscon consumer want to access multiple syscon
nodes.
Add syscon-names and relative properties to help manage complicated
cases when accessing more one syscon node.

Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
---
 .../devicetree/bindings/mfd/syscon.txt        | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon.txt
index 25d9e9c2fd53..ca7bc7608c15 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.txt
+++ b/Documentation/devicetree/bindings/mfd/syscon.txt
@@ -17,6 +17,8 @@ Optional property:
 - reg-io-width: the size (in bytes) of the IO accesses that should be
   performed on the device.
 - hwlocks: reference to a phandle of a hardware spinlock provider node.
+- #syscon-cells: represents the number of args. Used when syscon-names
+  is going to be used. The value is vendor specific.
 
 Examples:
 gpr: iomuxc-gpr@20e0000 {
@@ -30,3 +32,37 @@ hwlock1: hwspinlock@40500000 {
 	reg = <0x40500000 0x1000>;
 	#hwlock-cells = <1>;
 };
+
+
+==Syscon names==
+
+Refer to syscon node by names with phandle args in syscon consumer node.
+
+Required properties:
+- syscons:	List of phandle and any number of args. Args is specific to
+		differnet vendor. For example: In Unisoc SoCs, the 1st arg
+		will be treated as register address offset and the 2nd is bit
+		mask as default.
+
+- syscon-names:	List of syscon node name strings sorted in the same
+		order as the syscons property.
+
+Examples:
+
+apb_regs: syscon@20008000 {
+	compatible = "sprd,apb-glb", "syscon";
+	#syscon-cells = <2>;
+	reg = <0x20008000 0x100>;
+};
+
+aon_regs: syscon@40008000 {
+	compatible = "sprd,aon-glb", "syscon";
+	#syscon-cells = <1>;
+	reg = <0x40008000 0x100>;
+};
+
+display@40500000 {
+	...
+	syscons = <&ap_apb_regs 0x4 0xf00>, <&aon_regs 0x8>;
+	syscon-names = "enable", "power";
+};
-- 
2.18.0


