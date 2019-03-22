Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BC6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996B92070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258715;
	bh=EgGGDnFrIMDvi2CHZcM+azdqhwirYFoJnxII5qNoCvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0eEeN5V+NxRe1RVZtqEpXuw/BPOG5e9hIz3qPLKIbYH5wMXqbMYYCHQRc30ztIRRP
	 M4CuDTmzv1IKCu/Ny4knwh/2mJWuAewyb5wrT1D24tlsTFBX/sXpQkY9GM3ooT2gel
	 ugI9W3/kcv9Jyf5LUs3M6qwYL3OngYkrTRApmYik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388108AbfCVMpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730518AbfCVMAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:00:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBF7621934;
        Fri, 22 Mar 2019 12:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256042;
        bh=EgGGDnFrIMDvi2CHZcM+azdqhwirYFoJnxII5qNoCvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sCzyQckKEoCTgR0Xz4pef6FCdeksikBF84DywJWj77RlkPnjKuTe3tkFy0LT33PXE
         v8eXExQ7/8rGjngYfc9cTQSD/7leQfP3SPSQoin+C8vQlKNA0yyplvm2CmfhiaijP3
         UPmR+MGNVcOcD7SMMe/G17AfwOzuyJvOZr0C0MCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tristan Bastian <tristan-c.bastian@gmx.de>,
        Thierry Reding <treding@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 091/280] ARM: tegra: Restore DT ABI on Tegra124 Chromebooks
Date:   Fri, 22 Mar 2019 12:14:04 +0100
Message-Id: <20190322111311.595593858@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



