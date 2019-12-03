Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D999C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA40D20656
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414192;
	bh=2w/kboaBv4rUB7rYsu5zoyYIANyHwCLGXNh5BOtOEiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xe7gsM2i3t5LU5jHHErDsQjH9i9UJKoxd1J4HzKrQAvPI44q8omBfxCRkZe3fPsst
	 Euuqk3olhb6iFOdk5fVwOZUVJuqFCBd4Sppd+ZFFBeRORvMoZ3HKn+jUCPKhy3lI8N
	 GFzAyV6DrL3asJDPUCwhPwWXbCgOgbHKC1uwJ/PA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfLCWx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbfLCWxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:53:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C7520656;
        Tue,  3 Dec 2019 22:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413603;
        bh=2w/kboaBv4rUB7rYsu5zoyYIANyHwCLGXNh5BOtOEiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KLeBTkM8LuIti+8ZKCUXGTZxhAwjKCd87egDMH+PjlpnJQJtB5Orr1RF5U53PtrOK
         mwo9rpSQlKd+ECGZKGbc09dRump5kJBVuzn93EEtoWbn6H6fj7tEiYbS0wkuyKydR+
         jabw2lnRgN3ooeMIfPA8axWqvQ9zUPdEY9dRvPJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 191/321] net: dsa: bcm_sf2: Propagate error value from mdio_write
Date:   Tue,  3 Dec 2019 23:34:17 +0100
Message-Id: <20191203223437.055515275@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 17cec68e56b4f..02a4187d81bd0 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -309,11 +309,10 @@ static int bcm_sf2_sw_mdio_write(struct mii_bus *bus, int addr, int regnum,
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



