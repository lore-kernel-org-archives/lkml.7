Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6057AC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F4C22BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148555;
	bh=yWv4w82eJ4DUrjGMKIX9faGTTSZolnoRlKDkvEU6Osg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iIjfxGLCH1xBo94hRWXOVRVVMnX8Zraw9o2vhc+6J0fBGSpjPlPLfi1jQIohweH2/
	 N+QvheFHCquzkSjbX6OX/7YRs5T1rbKHX2ikSdRW6BLKq49m3U8hjFNdEiEc/KGWus
	 lCxp3YAyPg8g6KCX7XhEOvkFfS5ArHtU8BTFRvMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbfGZNme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:42:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387916AbfGZNmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:42:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3353722BF5;
        Fri, 26 Jul 2019 13:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148540;
        bh=yWv4w82eJ4DUrjGMKIX9faGTTSZolnoRlKDkvEU6Osg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W6FNxRoJLtF4OurkX65gp7xlr6j1bGMGzW1ivCmEWZxHXqZAjAlreYjCslAkcmvq0
         HU4FYLMwXyaDphRIIGTrL1fMv36y4b/USlB+NFb25Ni0lD+go8LHj3xsDzDG/yj6CV
         UwTaHLqK3tXkuall4Zu8Boo5+oF09EktDYOHTERs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helen Koike <helen.koike@collabora.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 07/47] arm64: dts: rockchip: fix isp iommu clocks and power domain
Date:   Fri, 26 Jul 2019 09:41:30 -0400
Message-Id: <20190726134210.12156-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134210.12156-1-sashal@kernel.org>
References: <20190726134210.12156-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helen Koike <helen.koike@collabora.com>

[ Upstream commit c432a29d3fc9ee928caeca2f5cf68b3aebfa6817 ]

isp iommu requires wrapper variants of the clocks.
noc variants are always on and using the wrapper variants will activate
{A,H}CLK_ISP{0,1} due to the hierarchy.

Tested using the pending isp patch set (which is not upstream
yet). Without this patch, streaming from the isp stalls.

Also add the respective power domain and remove the "disabled" status.

Refer:
 RK3399 TRM v1.4 Fig. 2-4 RK3399 Clock Architecture Diagram
 RK3399 TRM v1.4 Fig. 8-1 RK3399 Power Domain Partition

Signed-off-by: Helen Koike <helen.koike@collabora.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index df7e62d9a670..cea44a7c7cf9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1643,11 +1643,11 @@
 		reg = <0x0 0xff914000 0x0 0x100>, <0x0 0xff915000 0x0 0x100>;
 		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
 		interrupt-names = "isp0_mmu";
-		clocks = <&cru ACLK_ISP0_NOC>, <&cru HCLK_ISP0_NOC>;
+		clocks = <&cru ACLK_ISP0_WRAPPER>, <&cru HCLK_ISP0_WRAPPER>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
+		power-domains = <&power RK3399_PD_ISP0>;
 		rockchip,disable-mmu-reset;
-		status = "disabled";
 	};
 
 	isp1_mmu: iommu@ff924000 {
@@ -1655,11 +1655,11 @@
 		reg = <0x0 0xff924000 0x0 0x100>, <0x0 0xff925000 0x0 0x100>;
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH 0>;
 		interrupt-names = "isp1_mmu";
-		clocks = <&cru ACLK_ISP1_NOC>, <&cru HCLK_ISP1_NOC>;
+		clocks = <&cru ACLK_ISP1_WRAPPER>, <&cru HCLK_ISP1_WRAPPER>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
+		power-domains = <&power RK3399_PD_ISP1>;
 		rockchip,disable-mmu-reset;
-		status = "disabled";
 	};
 
 	hdmi_sound: hdmi-sound {
-- 
2.20.1

