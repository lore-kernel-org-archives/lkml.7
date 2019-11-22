Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1353AC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D324A2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402727;
	bh=cOvGadzz/Ilq3zzfuxDAcHCG50XJYvtc3zrOv6YrSSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bx9pjdBCkOY9TsTzuU8hZUOQhZc7hQhjs8gwot7ixAz85b5zeoetS2rvk80gJ3kC7
	 qXl1rQjy2Ye11gzZkbpsTKfxSLHGrIHtcxNR7ZSjZWmj6ENy8NhhYCU+h4HJfMen6r
	 arvKUI2pBbCuNp2CrPbkJ/BK6fnueZpPevCDf/0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfKVGF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:05:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729779AbfKVGCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:02:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B82EA20659;
        Fri, 22 Nov 2019 06:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402559;
        bh=cOvGadzz/Ilq3zzfuxDAcHCG50XJYvtc3zrOv6YrSSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tEDLf0b1rp5dN8cPakIyioxvsYYKDvDOM88lHduefP/Vt5wGwhF3GHTtamZw+OGx0
         o7xxIkt2tnYLuvoR8pV1MQK1mHp47TZ52ZQmLUoTTsmkOm9p41Hdp/BnWGDLGuIqFE
         KjBQVAK/cjqkG4lxM7kRIN6doR+0S+fsX9QV2tBg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 64/91] net: dsa: bcm_sf2: Propagate error value from mdio_write
Date:   Fri, 22 Nov 2019 01:01:02 -0500
Message-Id: <20191122060129.4239-63-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122060129.4239-1-sashal@kernel.org>
References: <20191122060129.4239-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit e49505f7255be8ced695919c08a29bf2c3d79616 ]

Both bcm_sf2_sw_indir_rw and mdiobus_write_nested could fail, so let's
return their error codes upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/bcm_sf2.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index c2cd540e9c9ec..a3a8d7b62f3fb 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -405,11 +405,10 @@ static int bcm_sf2_sw_mdio_write(struct mii_bus *bus, int addr, int regnum,
 	 * send them to our master MDIO bus controller
 	 */
 	if (addr == BRCM_PSEUDO_PHY_ADDR && priv->indir_phy_mask & BIT(addr))
-		bcm_sf2_sw_indir_rw(priv, 0, addr, regnum, val);
+		return bcm_sf2_sw_indir_rw(priv, 0, addr, regnum, val);
 	else
-		mdiobus_write_nested(priv->master_mii_bus, addr, regnum, val);
-
-	return 0;
+		return mdiobus_write_nested(priv->master_mii_bus, addr,
+				regnum, val);
 }
 
 static irqreturn_t bcm_sf2_switch_0_isr(int irq, void *dev_id)
-- 
2.20.1

