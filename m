Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A72C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D592073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfLDP0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:26:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:52482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727828AbfLDP0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:26:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE625AD75;
        Wed,  4 Dec 2019 15:26:01 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tharvey@gateworks.com, davem@davemloft.net, rric@kernel.org,
        sgoutham@cavium.com, Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH] net: thunderx: start phy before starting autonegotiation
Date:   Wed,  4 Dec 2019 16:26:51 +0100
Message-Id: <20191204152651.13418-1-ykaukab@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since "2b3e88ea6528 net: phy: improve phy state checking"
phy_start_aneg() expects phy state to be >= PHY_UP. Call phy_start()
before calling phy_start_aneg() during probe so that autonegotiation
is initiated.

Network fails without this patch on Octeon TX.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 1e09fdb63c4f..504644257aff 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1115,6 +1115,7 @@ static int bgx_lmac_enable(struct bgx *bgx, u8 lmacid)
 				       phy_interface_mode(lmac->lmac_type)))
 			return -ENODEV;
 
+		phy_start(lmac->phydev);
 		phy_start_aneg(lmac->phydev);
 		return 0;
 	}
-- 
2.16.4

