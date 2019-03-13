Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CA8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA74520657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505518;
	bh=mMofaRByHjHV8jKqOEAERfdAx178lalRUCmPJoX82eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GJIWL3drNIb+KSCnykpxRsBSvmiGwSGkkl9a4MZt3hoT3JFUl3BZUMuBS+MVSMwtV
	 nz4/OpIOV6U+kdADwiP5NrS/QZmMz9+lgWRV//SQtUWYc7xqXF4B6dFMqzyDtVK/im
	 HSCCKFWQg3nZdnieq+4aH/75O6DtJu4+4nNmxhOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfCMTb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbfCMTL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:11:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 616AF2173C;
        Wed, 13 Mar 2019 19:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504285;
        bh=mMofaRByHjHV8jKqOEAERfdAx178lalRUCmPJoX82eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C87J9lgtA3pB/INTHWdBlMdYyub8So14f4yVl8uc9qe9XNyYXeW3vJAGpnxL38ca5
         NIn9jDNZ7DSVqHwOmW/w+nQGIqASzjXXQ/r3M0UhSwwMHMQ3g3UBrw03xry2AU5VKv
         Oc3Mr30QCT94LKuLXQCJTS1sLi3jyw2JHlqNoaa8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thierry Reding <treding@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 31/60] ARM: tegra: Restore DT ABI on Tegra124 Chromebooks
Date:   Wed, 13 Mar 2019 15:09:52 -0400
Message-Id: <20190313191021.158171-31-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 94d9b9337d09bdd27735005b3251d97ab29f7273 ]

Commit 482997699ef0 ("ARM: tegra: Fix unit_address_vs_reg DTC warnings
for /memory") inadventently broke device tree ABI by adding a unit-
address to the "/memory" node because the device tree compiler flagged
the missing unit-address as a warning.

Tegra124 Chromebooks (a.k.a. Nyan) use a bootloader that relies on the
full name of the memory node in device tree being exactly "/memory". It
can be argued whether this was a good decision or not, and some other
bootloaders (such as U-Boot) do accept a unit-address in the name of the
node, but the device tree is an ABI and we can't break existing setups
just because the device tree compiler considers it bad practice to omit
the unit-address nowadays.

This partially reverts the offending commit and restores device tree ABI
compatibility.

Fixes: 482997699ef0 ("ARM: tegra: Fix unit_address_vs_reg DTC warnings for /memory")
Reported-by: Tristan Bastian <tristan-c.bastian@gmx.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Tested-by: Tristan Bastian <tristan-c.bastian@gmx.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index d5f11d6d987e..bc85b6a166c7 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -13,10 +13,25 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory@80000000 {
+	/*
+	 * Note that recent version of the device tree compiler (starting with
+	 * version 1.4.2) warn about this node containing a reg property, but
+	 * missing a unit-address. However, the bootloader on these Chromebook
+	 * devices relies on the full name of this node to be exactly /memory.
+	 * Adding the unit-address causes the bootloader to create a /memory
+	 * node and write the memory bank configuration to that node, which in
+	 * turn leads the kernel to believe that the device has 2 GiB of
+	 * memory instead of the amount detected by the bootloader.
+	 *
+	 * The name of this node is effectively ABI and must not be changed.
+	 */
+	memory {
+		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
+	/delete-node/ memory@80000000;
+
 	host1x@50000000 {
 		hdmi@54280000 {
 			status = "okay";
-- 
2.19.1

