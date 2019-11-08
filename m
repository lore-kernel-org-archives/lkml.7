Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CD2FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBAE21924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214043;
	bh=r+cwo/X5fE8Ob1/HpYowtMH9G1G2Oo19ACVQ34s6LFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aJVi8sb5bB0rBqNG8wedoiIatr/9Ak7OQFAjff1JmCa/kj3fq18tSbJzTKfwLgDqy
	 yvOEg7TQxnGbExS03PhuhKG/nF8Wy/biVpPaWfplBEEhqm3dwAfM/KYD4mgejWsOQk
	 ZsyGeRGMcpq2FJ1USmzl14yWqDi/+qn/o6sErG7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391670AbfKHLyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:54:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391353AbfKHLqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:46:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B9AE21D82;
        Fri,  8 Nov 2019 11:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213590;
        bh=r+cwo/X5fE8Ob1/HpYowtMH9G1G2Oo19ACVQ34s6LFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ufxM4zUtgGQxis9Oy1K2nvEnyhVNtrBwa5KBwwfeISuM1dnhDXgT/fZiGSGyfhfhO
         gMjgaixTt7lKcCElmzEv9cyPOYu4nIfWt5te+9WhXg88zKGcb4JR9W3aCAVtwVlgDS
         QzmEcfEJpSdCCglvQo5mPRN6XFYF3c0AxgozgNyI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 32/64] ARM: dts: omap3-gta04: make NAND partitions compatible with recent U-Boot
Date:   Fri,  8 Nov 2019 06:45:13 -0500
Message-Id: <20191108114545.15351-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114545.15351-1-sashal@kernel.org>
References: <20191108114545.15351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

[ Upstream commit fa99c21ecb3cd4021a60d0e8bf880e78b5bd0729 ]

Vendor defined U-Boot has changed the partition scheme a while ago:

* kernel partition 6MB
* file system partition uses the remainder up to end of the NAND
* increased size of the environment partition (to get an OneNAND compatible base address)
* shrink the U-Boot partition

Let's be compatible (e.g. Debian kernel built from upstream).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 6e809b0ff5c9f..6b8e013e49bb9 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -607,22 +607,22 @@
 
 		bootloaders@80000 {
 			label = "U-Boot";
-			reg = <0x80000 0x1e0000>;
+			reg = <0x80000 0x1c0000>;
 		};
 
-		bootloaders_env@260000 {
+		bootloaders_env@240000 {
 			label = "U-Boot Env";
-			reg = <0x260000 0x20000>;
+			reg = <0x240000 0x40000>;
 		};
 
 		kernel@280000 {
 			label = "Kernel";
-			reg = <0x280000 0x400000>;
+			reg = <0x280000 0x600000>;
 		};
 
-		filesystem@680000 {
+		filesystem@880000 {
 			label = "File System";
-			reg = <0x680000 0xf980000>;
+			reg = <0x880000 0>;	/* 0 = MTDPART_SIZ_FULL */
 		};
 	};
 };
-- 
2.20.1

