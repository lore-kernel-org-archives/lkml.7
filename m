Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A4CFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553602085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214622;
	bh=ITiLQa7PhFYebKtxc6Fl3GvTzg0Y6H8CyAE5H5v51fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eR5KJkMarLkiQ7Y85NBHyT3wgqZBp9SeHdJ2G82sZsJRfgY5+oaFneCuFYwhqSejd
	 z/mLLTBZkfMUG6hd3fTIhS/NCkifbIaGIhMRGeVdhQbtRHjfwAZfqu5KGfWEC1RAta
	 csKao5I1QadrknkGqFO8B3DoYawTtB/HFM41QXsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390604AbfKHMDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:03:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390057AbfKHLmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:42:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E18E222C4;
        Fri,  8 Nov 2019 11:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213355;
        bh=ITiLQa7PhFYebKtxc6Fl3GvTzg0Y6H8CyAE5H5v51fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lwm2Rqkn5RfLXYUu7Zv9+THrcc6xfEhiSaobpBIVyW3aw0MFnB7rv3j9hPqmwdGAc
         vL9vpSJhkaQmo3pS+IUdID6XljiHFLEleFdaaL0G2ii3cvUCp86k/xuvIeMxhRGxHl
         bnzDisgbYqjJ/kw3WZpHp+8Ynqk+rrrcyMTo8KsI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 186/205] ARM: dts: sun9i: Fix I2C bus warnings
Date:   Fri,  8 Nov 2019 06:37:33 -0500
Message-Id: <20191108113752.12502-186-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 57a83c5222c1b5e7b3acc72c6e60fce00a38991a ]

dtc has new checks for I2C buses. The sun9i-a80 dts file has a node named
'i2c' which causes a false positive warning. As the node is a RSB bus,
correct the node name to be 'rsb' to fix the warnings.

arch/arm/boot/dts/sun9i-a80-cubieboard4.dtb: Warning (i2c_bus_reg): /soc/i2c@8003400/codec@e89:reg: I2C address must be less than 10-bits, got "0xe89"
arch/arm/boot/dts/sun9i-a80-cubieboard4.dtb: Warning (i2c_bus_reg): /soc/i2c@8003400/pmic@745:reg: I2C address must be less than 10-bits, got "0x745"
arch/arm/boot/dts/sun9i-a80-optimus.dtb: Warning (i2c_bus_reg): /soc/i2c@8003400/codec@e89:reg: I2C address must be less than 10-bits, got "0xe89"
arch/arm/boot/dts/sun9i-a80-optimus.dtb: Warning (i2c_bus_reg): /soc/i2c@8003400/pmic@745:reg: I2C address must be less than 10-bits, got "0x745"

Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 25591d6883ef2..d9532fb1ef650 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -1196,7 +1196,7 @@
 			};
 		};
 
-		r_rsb: i2c@8003400 {
+		r_rsb: rsb@8003400 {
 			compatible = "allwinner,sun8i-a23-rsb";
 			reg = <0x08003400 0x400>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.20.1

