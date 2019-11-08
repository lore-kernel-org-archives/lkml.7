Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97E0C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7502085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214543;
	bh=dkQQjEz/3AL8lCoqR+WhrS+wxdB8zSvy0TZOHAZ0ujY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V04lQYJay/WXUAU73hAjXher3OAnw3Yn4/wXvZTxPx1eW6DJUK6aBomZUrGnmLADX
	 Z9b7cDAXrtsx6XW2PbmJefog0K73ITK3hE3ZHL4GG38aS3dx2aKJMvt5JplPsz3Hd0
	 4vEOZnB60HyexALWZGpSoaU48iDRdtGLEXejNlmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391819AbfKHMCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:02:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388506AbfKHLnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:43:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85E95222CE;
        Fri,  8 Nov 2019 11:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213399;
        bh=dkQQjEz/3AL8lCoqR+WhrS+wxdB8zSvy0TZOHAZ0ujY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3GvHRLAXFL3mkPir24mZGKmJXlKkmu5zTrbhM+t83COXBacYNiI1vZeI1XUGMSKj
         rVTm0puyt52LELRiBcyV3CoLusYb6fCJVjOxIO9sHkPZsl9WJYhPtYccyWb96DFEKs
         erXfWMRtdJojGHXb4icVXXOWr7BOcfYVHxCuv0Ig=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 006/103] arm64: dts: allwinner: a64: NanoPi-A64: Fix DCDC1 voltage
Date:   Fri,  8 Nov 2019 06:41:31 -0500
Message-Id: <20191108114310.14363-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

