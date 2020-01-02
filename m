Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C76BC2D0DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 01:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3C221734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 01:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgABB1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 20:27:20 -0500
Received: from foss.arm.com ([217.140.110.172]:43514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgABB1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 20:27:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D369ADA7;
        Wed,  1 Jan 2020 17:27:19 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DA593F703;
        Wed,  1 Jan 2020 17:27:18 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/3] ARM: dts: sun8i: R40: Upgrade GICC reg size to 8K
Date:   Thu,  2 Jan 2020 01:26:55 +0000
Message-Id: <20200102012657.9278-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20200102012657.9278-1-andre.przywara@arm.com>
References: <20200102012657.9278-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GIC used in the R40 SoC is an ARM GIC-400 with virtualization support,
so let's advertise the full 8K region of the GICC MMIO frame to enable
KVM's usage of the GIC (as we do already for all other SoCs).

Tested by running KVM on a Bananapi M2 Berry.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 82ea0b5b0710..768dffb37117 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -831,7 +831,7 @@
 		gic: interrupt-controller@1c81000 {
 			compatible = "arm,gic-400";
 			reg = <0x01c81000 0x1000>,
-			      <0x01c82000 0x1000>,
+			      <0x01c82000 0x2000>,
 			      <0x01c84000 0x2000>,
 			      <0x01c86000 0x2000>;
 			interrupt-controller;
-- 
2.14.5

