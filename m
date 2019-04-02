Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284CBC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9672082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LcCo62mZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbfDBTSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:18:25 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:41666 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDBTSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:18:25 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id CC6BE10C0F5F;
        Tue,  2 Apr 2019 12:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1554232704; bh=ByDI/KJNqJEArUWnhkZTp8SvCGXT1p14aRUfg2hMysM=;
        h=From:To:CC:Subject:Date:From;
        b=LcCo62mZz62zqz9kTxMwjFIOP54iqBLRX4Pjdi4mTyxMAnvhkELmGIAgjnwKxKwVT
         6SSz+XYjdF6Q+fdD3jetIJmfKj3mxp0rD0oEJilUmnfTLuPyuB23I9l92CKh2fwF7H
         Wnj2rQSAWwgCovqtl5b7IhyCXGQovLcMADGw9xXQgc2kRIRtOdeQc6XPCQss6cn+cJ
         esEBqmm0yB0RvLLnFxAkgOEDK+SAeyu+uG+qMG73GrqjNDNv7EgLmmXKIEbsWBU/JS
         9bqwtXiWN+dMq/8GGlpO7nu5+e6QkcEH1EJCAklVFqP8jrcF/ONeAh27O/4IoC9Jvc
         jYYtOo1O9d61w==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9E16BA005A;
        Tue,  2 Apr 2019 19:18:23 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 2 Apr 2019 12:18:21 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 3 Apr 2019 00:48:28 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.13.182.230) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 3 Apr 2019 00:48:26 +0530
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <eugeniy.paltsev@synopsys.com>,
        <robh@kernel.org>, Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: [PATCH] ARC: [hsdk] Make it easier to add PAE40 region to DTB
Date:   Tue, 2 Apr 2019 12:18:03 -0700
Message-ID: <1554232683-8173-1-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.182.230]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Bump top level address-cells/size-cells nodes to 2 (to ensure all
   down stream addresses are 64-bits, unless explicitly specified
   otherwise (in "soc" bus with all peripherals)

2. "memory" also specified with address/size 2

3. Add a commented reference for PAE40 region beyond 4GB physical
   address space

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/boot/dts/hsdk.dts | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index 69bc1c9e8e50..7425bb0f2d1b 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -18,8 +18,8 @@
 	model = "snps,hsdk";
 	compatible = "snps,hsdk";
 
-	#address-cells = <1>;
-	#size-cells = <1>;
+	#address-cells = <2>;
+	#size-cells = <2>;
 
 	chosen {
 		bootargs = "earlycon=uart8250,mmio32,0xf0005000,115200n8 console=ttyS0,115200n8 debug print-fatal-signals=1";
@@ -105,7 +105,7 @@
 		#size-cells = <1>;
 		interrupt-parent = <&idu_intc>;
 
-		ranges = <0x00000000 0xf0000000 0x10000000>;
+		ranges = <0x00000000 0x0 0xf0000000 0x10000000>;
 
 		cgu_rst: reset-controller@8a0 {
 			compatible = "snps,hsdk-reset";
@@ -269,9 +269,10 @@
 	};
 
 	memory@80000000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <2>;
 		device_type = "memory";
-		reg = <0x80000000 0x40000000>;  /* 1 GiB */
+		reg = <0x0 0x80000000 0x0 0x40000000>;  /* 1 GB lowmem */
+		/*     0x1 0x00000000 0x0 0x40000000>;     1 GB highmem */
 	};
 };
-- 
2.7.4

