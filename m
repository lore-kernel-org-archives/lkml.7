Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ABFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78692089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Evvf5DHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442728AbfJRMWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:22:13 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:36970 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2442699AbfJRMWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:22:12 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5975EC04D7;
        Fri, 18 Oct 2019 12:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571400951; bh=oQQShnjm5R0MR/xjv312sQ6gQ7J+z4O6hvMy/a53QQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Evvf5DHGG7VfVLWRKmvc8rRiZVi3Qxi7atXeNgJ54Nl/mqE4NqWeq8GWpaKNh2tsy
         BmolhZsh4uSf1pTIQFm1TkXsBY79ZAaeeAvlWY2hU2W11GkF9EdS12yot+l+NNfOUN
         A7ZmrLEKK9A3BAJxy2FWcA+FQqNU29zCRaNpRClzANrBwJSUd8Cv/BBLKQz17L5VAY
         HA4w2K/DtimhvZt1LB5fJIDzlLeTbcMqCpt6eYkyznpISkCDrNut+uuFoanr+I0+cf
         uJ4tKECNqKNpGeEM1uDUQNMMLpLTv8fxkopmSkISUD/fceknO7B1pjNcCOWm+FK5Zw
         oZroCuxRoVOvQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id 542A1A006D;
        Fri, 18 Oct 2019 12:15:49 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [RFC 4/6] ARC: HAPS: add HIGHMEM memory zone to DTS
Date:   Fri, 18 Oct 2019 15:15:43 +0300
Message-Id: <20191018121545.8907-5-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191018121545.8907-1-Eugeniy.Paltsev@synopsys.com>
References: <20191018121545.8907-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required as a preparation of merging nSIM and HASP
defonfig and device tree.

As we have HIGHMEM disabled in both HAPS and nSIM defconfigs
this doesn't lead to any functional change.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/boot/dts/haps_hs.dts | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arc/boot/dts/haps_hs.dts b/arch/arc/boot/dts/haps_hs.dts
index 11fad2f79056..60d578e2781f 100644
--- a/arch/arc/boot/dts/haps_hs.dts
+++ b/arch/arc/boot/dts/haps_hs.dts
@@ -9,13 +9,15 @@
 / {
 	model = "snps,zebu_hs";
 	compatible = "snps,zebu_hs";
-	#address-cells = <1>;
-	#size-cells = <1>;
+	#address-cells = <2>;
+	#size-cells = <2>;
 	interrupt-parent = <&core_intc>;
 
 	memory {
 		device_type = "memory";
-		reg = <0x80000000 0x20000000>;	/* 512 */
+		/* CONFIG_LINUX_RAM_BASE needs to match low mem start */
+		reg = <0x0 0x80000000 0x0 0x20000000	/* 512 MB low mem */
+		       0x1 0x00000000 0x0 0x40000000>;	/* 1 GB highmem */
 	};
 
 	chosen {
@@ -31,8 +33,9 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		/* child and parent address space 1:1 mapped */
-		ranges;
+		/* only perip space at end of low mem accessible
+			  bus addr,  parent bus addr, size    */
+		ranges = <0x80000000 0x0 0x80000000 0x80000000>;
 
 		core_clk: core_clk {
 			#clock-cells = <0>;
-- 
2.21.0

