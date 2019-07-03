Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E613C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6B2206E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562120586;
	bh=+Jv8G9Bv9bksetOHe/bcYYYfL0WmjVsX+d9rjn+Cmss=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qFroKYPx8sMS2H8cmVwQcfxD+8SbG6ESzbz3TA8r7lTtlLN9alEYVPY94vH2PP7Zw
	 WR9jqTvLs+j+iJ4sTE/MRxbZD+11Uw0RnEG+LxmdXryPC2nqqguoOWWeSRAKTszZEE
	 FAXGRgQORuUbs67fXp+Y8Ry+kZBGQWdbSeN99CeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfGCCPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfGCCPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:15:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A5842187F;
        Wed,  3 Jul 2019 02:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562120116;
        bh=+Jv8G9Bv9bksetOHe/bcYYYfL0WmjVsX+d9rjn+Cmss=;
        h=From:To:Cc:Subject:Date:From;
        b=XQFn13ipJP+0+zHKTMq5Udp5IFm8Su6S/Gql6yvyzI9FQVPQ5O219aFKm8uuLm5hG
         8NJKqUc5lfgf8/5G9AH9UPJjeXmj9UlY58UnN2eF7FwlHA+BJdZ1Q0AAbJMpt9ssjq
         i61Z78Ce5FEilda7LuNNPuig3FTjxJTsOgiJLH5s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 5.1 01/39] ARM: dts: meson8: fix GPU interrupts and drop an undocumented property
Date:   Tue,  2 Jul 2019 22:14:36 -0400
Message-Id: <20190703021514.17727-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 01dfdd7b4693496854ac92d1ebfb18d7b108f777 ]

The interrupts in Amlogic's vendor kernel sources are all contiguous.
There are two typos leading to pp2 and pp4 as well as ppmmu2 and ppmmu4
incorrectly sharing the same interrupt line.
Fix this by using interrupt 170 for pp2 and 171 for ppmmu2.

Also drop the undocumented "switch-delay" which is a left-over from my
experiments with an early lima kernel driver when it was still
out-of-tree and required this property on Amlogic SoCs.

Fixes: 7d3f6b536e72c9 ("ARM: dts: meson8: add the Mali-450 MP6 GPU")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/meson8.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index a9781243453e..048b55c8dc1e 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -248,8 +248,8 @@
 				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
@@ -264,7 +264,6 @@
 			clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_MALI>;
 			clock-names = "bus", "core";
 			operating-points-v2 = <&gpu_opp_table>;
-			switch-delay = <0xffff>;
 		};
 	};
 }; /* end of / */
-- 
2.20.1

