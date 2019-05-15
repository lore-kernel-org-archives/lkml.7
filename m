Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8009FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457EB20862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ist3JW0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfEOPeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:34:09 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:40176 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726335AbfEOPeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:34:09 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B3CA8C1284;
        Wed, 15 May 2019 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557934454; bh=Jg4Yd5RfGMHbRvftES66Q+l5G//3wv/Kjk6wF+VWL0M=;
        h=From:To:Cc:Subject:Date:From;
        b=ist3JW0sgzDkKDy2OfOiTCXXA9tOF9hr8IN5FfCb2enXPVjajxK9HPsAbtXyvYSNa
         qjYWTsf4gLE3z2hKGDSy/PVIjb/pagEZUPoEbsJRAXuaNIE1Aaqxrz69OYoJEzWDNQ
         688MuSJYsxMHQKjqBFCDYlGYsn/4+B8rRGwkzkOANCe3avwFvKizgJAIov5ztLJVgE
         FB+nEJFuEIgsw0T20ZQhvRQY/jLSWdwLCNbPvni6MzUVXb1HZttseF9wqb5ZmCd8Ln
         cfPgMGgVc8EnAjGxe0limbFMm0USewTyZ2aZNHr/kPw5a3oYRNIM+EgS6/JcLIRpeL
         HNFfKgBNIqOLA==
Received: from ru20arcgnu1.internal.synopsys.com (ru20arcgnu1.internal.synopsys.com [10.121.9.48])
        by mailhost.synopsys.com (Postfix) with ESMTP id D0CEFA0065;
        Wed, 15 May 2019 15:34:06 +0000 (UTC)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] ARC: [plat-hsdk] Get rid of inappropriate PHY settings
Date:   Wed, 15 May 2019 18:33:40 +0300
Message-Id: <20190515153340.40074-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial bring-up of the platform was done on FPGA prototype
where TI's DP83867 PHY was used. And so some specific PHY
options were added.

Just to confirm this is what we get on FPGA prototype in the bootlog:
| TI DP83867 stmmac-0:00: attached PHY driver [TI DP83867] ...

On real board though we have Micrel KZS9031 PHY and we even have
CONFIG_MICREL_PHY=y set in hsdk_defconfig. That's what we see in the bootlog:
| Micrel KSZ9031 Gigabit PHY stmmac-0:00: ...

So essentially all TI-related bits have to go away.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Trent Piepho <tpiepho@impinj.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 arch/arc/boot/dts/hsdk.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index 7425bb0f2d1b..f88a898029ce 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -11,7 +11,6 @@
  */
 /dts-v1/;
 
-#include <dt-bindings/net/ti-dp83867.h>
 #include <dt-bindings/reset/snps,hsdk-reset.h>
 
 / {
@@ -201,9 +200,6 @@
 				compatible = "snps,dwmac-mdio";
 				phy0: ethernet-phy@0 {
 					reg = <0>;
-					ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-					ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-					ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 				};
 			};
 		};
-- 
2.16.2

