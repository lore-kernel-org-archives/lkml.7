Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD1BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F2F2192D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138330;
	bh=GOj/N+iB4CzHUgIsVqY2z80c0lJlBDVR5jMxFEJIybw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UACW4R6fcCmu9pL1qtiI2Hmle/fkvLcfdrSqTJ1WZvMCgi0XDBBesXqAXte6isEIt
	 uVX0hBggnaCWka/FoULjmZNCAkSJFw5+FFzG3L45ZdbkV1wNxGrTMDR2hwZRJ4qO+5
	 C03mYiI7PrbtUhSfNi5jbourdO274wzy9gzqjQto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfDARF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfDARF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:05:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6DDA21929;
        Mon,  1 Apr 2019 17:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138325;
        bh=GOj/N+iB4CzHUgIsVqY2z80c0lJlBDVR5jMxFEJIybw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wr8OndJl82AL4eNIfv2R0FoPKYT6ToY+zVRxLM5dNTWF/O8v0xu4CrEcsXb0mqVVe
         ngBfvat9Ja1j6CCeIJDytHCjDy8/n2cJZOAXS7jcp+tHpOddfXDUkG4Nc2nTPW3IaX
         a6WciaTdnwiodop6vCh99H7IuNaHP8hkY8HIsG3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Reid <preid@electromag.com.au>,
        liweihang <liweihang@hisilicon.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 033/146] net: phy: dont clear BMCR in genphy_soft_reset
Date:   Mon,  1 Apr 2019 19:00:45 +0200
Message-Id: <20190401170051.315584721@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit d29f5aa0bc0c321e1b9e4658a2a7e08e885da52a ]

So far we effectively clear the BMCR register. Some PHY's can deal
with this (e.g. because they reset BMCR to a default as part of a
soft-reset) whilst on others this causes issues because e.g. the
autoneg bit is cleared. Marvell is an example, see also thread [0].
So let's be a little bit more gentle and leave all bits we're not
interested in as-is. This change is needed for PHY drivers to
properly deal with the original patch.

[0] https://marc.info/?t=155264050700001&r=1&w=2

Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
Tested-by: Phil Reid <preid@electromag.com.au>
Tested-by: liweihang <liweihang@hisilicon.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy_device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1827,7 +1827,7 @@ int genphy_soft_reset(struct phy_device
 {
 	int ret;
 
-	ret = phy_write(phydev, MII_BMCR, BMCR_RESET);
+	ret = phy_set_bits(phydev, MII_BMCR, BMCR_RESET);
 	if (ret < 0)
 		return ret;
 


