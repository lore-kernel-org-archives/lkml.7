Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC62C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC0320C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367975;
	bh=QBIAP/MdE1LicPqiYO+TooAHCkQp8ej87U2G+4+8zPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nIDd3WiNrjeXq6dE7Lq8hemmb4KobhWPgKX0Qe6NcLGjRV5pBrXqT9uP0+THkiwHD
	 ghWZZgHUHVoMcTAxeiItisezVMwtSz/iBkdrubQl9BpsXdPqLqcQyC8A6TmD9xSo/i
	 KG9nNRhupxZ7wTtOh9nwtnQ/+nGF6bVqrXpBcni4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733227AbfB1PIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:08:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733099AbfB1PIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE1A52184A;
        Thu, 28 Feb 2019 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366526;
        bh=QBIAP/MdE1LicPqiYO+TooAHCkQp8ej87U2G+4+8zPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKwY5VZzDNulAZ2quAweDY5t2/QbNUMUjqBYFw56UQEog9ZMHXNwzJa8bSKDRYdT7
         i5mhMWxcBGF2gNgpet03/6D0rQ8OIVzkJAxH24BEoHZaShrcns9Fy4dla5ywvvJhfZ
         ccP02wxPq+gZwITKQkW3eamCG8qiEtgxI0m1Q2Zc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arthur Demchenkov <spinal.by@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 20/81] ARM: dts: n900: fix mmc1 card detect gpio polarity
Date:   Thu, 28 Feb 2019 10:07:12 -0500
Message-Id: <20190228150813.10256-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Demchenkov <spinal.by@gmail.com>

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
index 182a53991c901..826920e6b8787 100644
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

