Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167A4CA9EBD
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC14421A4A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="csQhuSQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391722AbfJWMo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:44:29 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:37296 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390091AbfJWMoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:44:25 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6A202C0DE0;
        Wed, 23 Oct 2019 12:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571834665; bh=oQQShnjm5R0MR/xjv312sQ6gQ7J+z4O6hvMy/a53QQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=csQhuSQaZbUGLS/Neq9lNc9aM1zzt3cKR2BLe2IrahOS6+K6OlIM3JRDG5aO2vnv1
         97fXqckNqp0XIWWax/pbYTEvxneDTmGapFY54SjaVuBH26MMYuE9p5Rp+FuZKZyrCD
         PMTFpFD/UvsN6ESgb/g53xHlcsft6rA0PSKer6AiSgara37mcNV7EsnNMkJU1pdoah
         lEEYxuponQvdIz5oJwZHVjJK1X+dPmc0eQ817xjuiABBYvjat7zDmQELEu+1wZBk4c
         W/eqzG61FdwP1nuLBbn4s9RgaZUbjxWM8Pc99RvFs+uX0Rbp56Ltdruf0clzbxhyZX
         NHZN4WDWXQZzw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id C45E6A0057;
        Wed, 23 Oct 2019 12:44:23 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 4/8] ARC: HAPS: add HIGHMEM memory zone to DTS
Date:   Wed, 23 Oct 2019 15:44:13 +0300
Message-Id: <20191023124417.5770-5-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023124417.5770-1-Eugeniy.Paltsev@synopsys.com>
References: <20191023124417.5770-1-Eugeniy.Paltsev@synopsys.com>
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

