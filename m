Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6539AC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345AE208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142309;
	bh=dkQQjEz/3AL8lCoqR+WhrS+wxdB8zSvy0TZOHAZ0ujY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hwQdk90OS0VWOzeMAb3dXEmV7OOSkP8KfNY6QlaOdKjFm7PBB3/wA6puVnXaqu2Ce
	 OkVfXpg+Fecw1j9E/WCGC5HtjJOgonyJJHN/rB977VLynaMP/31mlBCyYpbi+4wiwh
	 G2Zag4E7NuE5K7YReLHebfxzHGraVLa4yURNNpho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfKSFpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730908AbfKSFpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:45:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5493C208C3;
        Tue, 19 Nov 2019 05:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142299;
        bh=dkQQjEz/3AL8lCoqR+WhrS+wxdB8zSvy0TZOHAZ0ujY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=clKd9zEMbtwQt5cMTl+lCciovaHDzg/WHLgY4faYhlMwpQgS6TTd0O1JunI98FqvL
         lbssxFJOLP0vVB6xfpprZZukls/JOI2lFnZKeOPR35U4RhvODB1dmP9EUoD3LCEcLu
         mjlLxx1Cusyg4BldvwylCjE7gGC0JzOevVQ5Zvz8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 033/239] arm64: dts: allwinner: a64: NanoPi-A64: Fix DCDC1 voltage
Date:   Tue, 19 Nov 2019 06:17:13 +0100
Message-Id: <20191119051303.951967036@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Przywara <andre.przywara@arm.com>

[ Upstream commit 480f58cdbe392d4387a2193b6131a277e0111dd0 ]

According to the NanoPi-A64 schematics, DCDC1 is connected to a voltage
rail named "VDD_SYS_3.3V". All users seem to expect 3.3V here: the
Ethernet PHY, the uSD card slot, the camera interface and the GPIO pins
on the headers.
Fix up the voltage on the regulator to lift it up to 3.3V.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index 2beef9e6cb885..aa0b3844ad63e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -126,9 +126,9 @@
 
 &reg_dcdc1 {
 	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "vcc-3v";
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3";
 };
 
 &reg_dcdc2 {
-- 
2.20.1



