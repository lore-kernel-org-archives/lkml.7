Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD61C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24E421D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="sPHgpqOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbfKGIj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:39:56 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:37651 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbfKGIjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:39:55 -0500
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B744A23E3F;
        Thu,  7 Nov 2019 09:39:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
        s=mail2016061301; t=1573115994;
        bh=QuQhB8wdh0x1ZHWe+cSTPwQhfauMSRqdlq6VCg3+s9E=;
        h=From:To:Cc:Subject:Date:From;
        b=sPHgpqOjexeZ0JcU8wzRcdq/7XmBVgvpvXe8birl1x107C6pzWyLVWzo+UTVl/nOZ
         C28YjU6GGeAsp/LxudF3AcRO8iZMJsqmUhj8+Zs+nMwQrB55KKI7sRInln+xMFSKHy
         /Fh4rGIOQZZhhy0v3TjCPpNs85PRQSD+5c9o1fh8=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Claudiu Manoil <claudiu.manoil@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] enetc: add ioctl() support for PHY-related ops
Date:   Thu,  7 Nov 2019 09:39:37 +0100
Message-Id: <20191107083937.18228-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.101.4 at web
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is an attached PHY try to handle the requested ioctl with its
handler, which allows the userspace to access PHY registers, for
example. This will make mii-diag and similar tools work.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index b6ff89307409..25af207f1962 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1599,7 +1599,10 @@ int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 	if (cmd == SIOCGHWTSTAMP)
 		return enetc_hwtstamp_get(ndev, rq);
 #endif
-	return -EINVAL;
+
+	if (!ndev->phydev)
+		return -EINVAL;
+	return phy_mii_ioctl(ndev->phydev, rq, cmd);
 }
 
 int enetc_alloc_msix(struct enetc_ndev_priv *priv)
-- 
2.20.1

