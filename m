Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB82C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADCC25EEB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559192119;
	bh=Hx/9KAYVK97mnvSDuNU+dPrOJ3A2j8SqY9kszNUgStI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wfo8revBPuAHifrvXfkb58XIWbJ6z4/v8ir0A3PHWcfps0SaldoA/MW81BhoVngsl
	 BujCOMrI9HLAptOO+NVG68o/sIZBDllaY/hTAvGGEja2uej3US/EWfKCiCy8KgVJvO
	 l/h/PXuFyYsXp+WqKLF4YhtXBpcNQoMbSmpmJfHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389111AbfE3EzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbfE3DKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:10:17 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF4BE2449D;
        Thu, 30 May 2019 03:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185816;
        bh=Hx/9KAYVK97mnvSDuNU+dPrOJ3A2j8SqY9kszNUgStI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H79yEwZjXE0cIjprwvR8nMvGscsywJ7wMNPkmLQp7ie4J9aWAbNicxTMn9whmns5D
         kpEDPzNWqLF+p1w2f57gwnIpS79AmMAEBL2XrpjgwtDxxr0akOJ15fMhZfE7Y8j61Y
         7enJTay/6PtBr4Lr4Kq48hUZEhHC/ZGrdNVOLyxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 110/405] net: phy: improve genphy_soft_reset
Date:   Wed, 29 May 2019 20:01:48 -0700
Message-Id: <20190530030546.569711943@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8c90b795e90f7753d23c18e8b95dd71b4a18c5d9 ]

PHY's behave differently when being reset. Some reset registers to
defaults, some don't. Some trigger an autoneg restart, some don't.

So let's also set the autoneg restart bit when resetting. Then PHY
behavior should be more consistent. Clearing BMCR_ISOLATE serves the
same purpose and is borrowed from genphy_restart_aneg.

BMCR holds the speed / duplex settings in fixed mode. Therefore
we may have an issue if a soft reset resets BMCR to its default.
So better call genphy_setup_forced() afterwards in fixed mode.
We've seen no related complaint in the last >10 yrs, so let's
treat it as an improvement.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index cd5966b0db571..f6a6cc5bf118d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1829,13 +1829,25 @@ EXPORT_SYMBOL(genphy_read_status);
  */
 int genphy_soft_reset(struct phy_device *phydev)
 {
+	u16 res = BMCR_RESET;
 	int ret;
 
-	ret = phy_set_bits(phydev, MII_BMCR, BMCR_RESET);
+	if (phydev->autoneg == AUTONEG_ENABLE)
+		res |= BMCR_ANRESTART;
+
+	ret = phy_modify(phydev, MII_BMCR, BMCR_ISOLATE, res);
 	if (ret < 0)
 		return ret;
 
-	return phy_poll_reset(phydev);
+	ret = phy_poll_reset(phydev);
+	if (ret)
+		return ret;
+
+	/* BMCR may be reset to defaults */
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		ret = genphy_setup_forced(phydev);
+
+	return ret;
 }
 EXPORT_SYMBOL(genphy_soft_reset);
 
-- 
2.20.1



