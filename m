Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBECCA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DEA21479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="fuisXx2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389596AbfJ1V7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:59:05 -0400
Received: from vps.xff.cz ([195.181.215.36]:50250 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731405AbfJ1V7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1572299943; bh=OGy4tk2NtSVhCsY1un9winjfE+tY6tvjqJKdXuqJvTI=;
        h=From:To:Cc:Subject:Date:From;
        b=fuisXx2w1vW3gGTDpaVdepq1nYuN90cLhhIPx0lzAnWF9TzDfq2wG601mYk1SZyv7
         2ANgeRKXdkcA6KAUBZ//s4zgd7lHrc5625rn8VtoIU2JFHONOP7/WvFyq3e7n2nhm4
         uDwt3qLRSd+saKx1gAZJVcAa8MsBrIMgfNfqX5x8=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: sun8i-a83t-tbs-a711: Fix WiFi resume from suspend
Date:   Mon, 28 Oct 2019 22:58:58 +0100
Message-Id: <20191028215859.3467317-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without enabling keep-power-in-suspend, we can't wake the device
up using WOL packet, and the log is flooded with these messages
on resume:

sunxi-mmc 1c10000.mmc: send stop command failed
sunxi-mmc 1c10000.mmc: data error, sending stop command
sunxi-mmc 1c10000.mmc: send stop command failed
sunxi-mmc 1c10000.mmc: data error, sending stop command

So to make the WiFi really a wakeup-source, we need to keep it powered
during suspend.

Fixes: 0e23372080def7 ("arm: dts: sun8i: Add the TBS A711 tablet devicetree")
Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 43b21599898e..5b8c9c24350b 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -311,6 +311,7 @@
 	vqmmc-supply = <&reg_dldo1>;
 	non-removable;
 	wakeup-source;
+	keep-power-in-suspend;
 	status = "okay";
 
 	brcmf: wifi@1 {
-- 
2.23.0

