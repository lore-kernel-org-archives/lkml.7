Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A2BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361DF2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355804;
	bh=HlA1l8YBLo80eU+FnB7BNPGxYdou/96umeVdS1CVP6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oaiBhb+erNoeiKNaxHpv05j+9LUZojqdzk4QephiUJ8cQ0djF9GK+7OClOzpOQh98
	 Lg4rBsUFaxKiJzykc7i16gd/bfh5/5dRLTNAm4bwU3p6FzKBCDAPRt3sY4hL+QpaYk
	 rBEPJduoCv5aKkO5EELlgUYIfOYfznNKMACzlGfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbfDOTQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731469AbfDOTNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDA9E2075B;
        Mon, 15 Apr 2019 19:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355581;
        bh=HlA1l8YBLo80eU+FnB7BNPGxYdou/96umeVdS1CVP6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tWJdXv4bSXggfLdOYsPIBAOOyjUrp5auWzrkgEZeJJ60eriAHVDol/u1Bx/FoCecS
         +YScdmZnFNyy82M0gOEI2luje1dOabm7Xaz0PY9eStkUtExIq5vROvNd1a+3fPtnfR
         CIj92zolt2xcBnYqgbxmBRPtMCEu9kqRRBdkBhXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        David Summers <beagleboard@davidjohnsummers.uk>,
        Jonas Karlman <jonas@kwiboo.se>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 5.0 089/117] ARM: dts: rockchip: Fix SD card detection on rk3288-tinker
Date:   Mon, 15 Apr 2019 21:00:59 +0200
Message-Id: <20190415183749.408085731@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Summers <beagleboard@davidjohnsummers.uk>

commit 8dbc4d5ddb59f49cb3e85bccf42a4720b27a6576 upstream.

The Problem:

On ASUS Tinker Board S, when booting from the eMMC, and there is card
in the sd slot, there are constant errors.

Also when warm reboot, uboot can not access the sd slot

Cause:

Identified by Robin Murphy @ ARM. The Card Detect on rk3288
devices is pulled up by vccio-sd; so when the regulator powers this
off, card detect gives spurious errors. A second problem, is during
power down, vccio-sd apprears to be powered down. This causes a
problem when warm rebooting from the sd card. This was identified by
Jonas Karlman.

History:

A common fault on these rk3288 board, which impliment the reference
design.

When this arose before:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/281153.html

And Ulf and Jaehoon clearly said this was a broken card detect design,
which should be solved via polling

Solution:

Hence broken-cd is set as a property. This cures the errors. The
powering down of vccio-sd during reboot is cured by adding
regulator-boot-on.

This solutions has been fairly widely reviewed and tested.

Fixes: e58c5e739d6f ("ARM: dts: rockchip: move shared tinker-board nodes to a common dtsi")
Cc: stable@vger.kernel.org
[Heiko: slightly inaccurate fixes but tinker is a sbc (aka like a Pi) where
 we can hopefully expect people not to rely on overly old stable kernels]
Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/rk3288-tinker.dtsi |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -254,6 +254,7 @@
 			};
 
 			vccio_sd: LDO_REG5 {
+				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vccio_sd";
@@ -430,7 +431,7 @@
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
-	card-detect-delay = <200>;
+	broken-cd;
 	disable-wp;			/* wp not hooked up */
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;


