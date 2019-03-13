Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4000EC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1298E2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504445;
	bh=mMofaRByHjHV8jKqOEAERfdAx178lalRUCmPJoX82eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YmUNBKXGBjA+x675Mu9r0S8olJWDKsPuMRfZHZ45K1lpDMeZQ8Zh1ZWQbcLRkp5RD
	 N7SMgr4SF061cvGP8xpfj8Vx0efxfI0MQSDOWT/vM1IDkcD00iZiq7EqdxdbiNvtDt
	 i0yH8Tn5ZHSOpzo8l8Zl+EAAi9fHyGriwuR/WW2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfCMTOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:14:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbfCMTN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:13:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDE71213A2;
        Wed, 13 Mar 2019 19:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504435;
        bh=mMofaRByHjHV8jKqOEAERfdAx178lalRUCmPJoX82eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2cCKqmsfyP9x6w9zfdaXwED022hhvzgaHmGEuY1AARpvXAc+NBbsrHTHg4hN83c0p
         kqrxZ8NAaWnRQKmppkpdLQoJW76GsYD732ZeuriI44RnGY2/mKr+WYKlaMbnTZA11A
         dMZBJtjmw8aNtU/wcOAzhaSPrToPrQXqGsSRHLKI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thierry Reding <treding@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 25/48] ARM: tegra: Restore DT ABI on Tegra124 Chromebooks
Date:   Wed, 13 Mar 2019 15:12:27 -0400
Message-Id: <20190313191250.158955-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191250.158955-1-sashal@kernel.org>
References: <20190313191250.158955-1-sashal@kernel.org>
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

