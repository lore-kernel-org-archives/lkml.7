Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BADFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13707217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410792;
	bh=wRwmnL1iG0DMdpwvf44JMRUUpif6BKGiLNR+dwroUcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nfD+YQisLl0LAYQviyV36rSHuJigOCMFoJ/Wiv7BpnSwuBdT1YluprRQ6MbOGGdDy
	 P9lhGKOqi0rL55ZuePlpXiofLfKR50/ssVD4vO2/tARxmTf4a6cOVHypWc5AeIp7Y0
	 9WwA9JNVOHxM3UKwft2Hnq/DKpIuURCSC+wLdElw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfCLRNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfCLRMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:39 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD1A521741;
        Tue, 12 Mar 2019 17:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410758;
        bh=wRwmnL1iG0DMdpwvf44JMRUUpif6BKGiLNR+dwroUcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ly5VYP27ajukafHMQCTfodrLrUkChChOffXC6i3NlQIle1/Xg5w07Edmzk9pzSx2L
         Ipz+5EKKVhRps9aXrAmHD+z03h1EXBRq9fuEKSQBkYJkCvc/Pc5tLQOM+PUv8vQBtp
         fkndlO4jDgj3U89dGoU2Gd8y4rK1y9RA51PEmtJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arthur Demchenkov <spinal.by@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 090/171] ARM: dts: n900: fix mmc1 card detect gpio polarity
Date:   Tue, 12 Mar 2019 10:07:50 -0700
Message-Id: <20190312170355.719508851@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ac9c908eecde3ed252cb1d67fc79b3c1346f76bc ]

Wrong polarity of card detect GPIO pin leads to the system not
booting from external mmc, if the back cover of N900 is closed.
When the cover is open the system boots fine.

This wasn't noticed before, because of a bug, which was fixed
by commit e63201f19 (mmc: omap_hsmmc: Delete platform data GPIO
CD and WP).

Kernels up to 4.19 ignored the card detect GPIO from DT.

Fixes: e63201f19438 ("mmc: omap_hsmmc: Delete platform data GPIO CD and WP")
Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 182a53991c90..826920e6b878 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -814,7 +814,7 @@
 	/* For debugging, it is often good idea to remove this GPIO.
 	   It means you can remove back cover (to reboot by removing
 	   battery) and still use the MMC card. */
-	cd-gpios = <&gpio6 0 GPIO_ACTIVE_HIGH>; /* 160 */
+	cd-gpios = <&gpio6 0 GPIO_ACTIVE_LOW>; /* 160 */
 };
 
 /* most boards use vaux3, only some old versions use vmmc2 instead */
-- 
2.19.1



