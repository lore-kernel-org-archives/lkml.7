Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D5AC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C792190B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962487;
	bh=eDzTu68rJHGJO3H1F7zs7T/EVC4ro39alIzLBjCeRUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gjd2GIE5Ma3ZRfDQRh7UdCJrrH2L/gCijxa8XJWrrqypzGDigA4QEQ14X0sMk8WIB
	 QWS5/TxEjBDwa2sNfTo1l5uQUdx6UeEM0R02awrQhkAg25AfUjkZJ6WXw2rqe/4Jha
	 mKcWOw0c1v3uJWRBc3f6Yadx5RXibXEbdL6A8NgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbfDVTsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbfDVTsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:48:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D172121906;
        Mon, 22 Apr 2019 19:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962481;
        bh=eDzTu68rJHGJO3H1F7zs7T/EVC4ro39alIzLBjCeRUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bmAUYHjwWLx5h/athpfunAELPsRBrnN4qHo20tvo2gNmV/dR4Hc/ycvPd0EuTj0Gw
         PkJ21e0MNxqPaYemPIjoSUPnwOH2dACYhgKutvsOrI+MB5Xd5yT8uUSG/2W40LUZjn
         NTKMOnZHJZRfTP7CHKNNV+6pc/baaEUUnwpV8UWA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>, Frank Pavlic <f.pavlic@kunbus.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Tristram Ha <Tristram.Ha@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 17/43] net: ks8851: Set initial carrier state to down
Date:   Mon, 22 Apr 2019 15:47:01 -0400
Message-Id: <20190422194727.12495-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 9624bafa5f6418b9ca5b3f66d1f6a6a2e8bf6d4c ]

The ks8851 chip's initial carrier state is down. A Link Change Interrupt
is signaled once interrupts are enabled if the carrier is up.

The ks8851 driver has it backwards by assuming that the initial carrier
state is up. The state is therefore misrepresented if the interface is
opened with no cable attached. Fix it.

The Link Change interrupt is sometimes not signaled unless the P1MBSR
register (which contains the Link Status bit) is read on ->ndo_open().
This might be a hardware erratum. Read the register by calling
mii_check_link(), which has the desirable side effect of setting the
carrier state to down if the cable was detached while the interface was
closed.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Frank Pavlic <f.pavlic@kunbus.de>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Tristram Ha <Tristram.Ha@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/micrel/ks8851.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/micrel/ks8851.c b/drivers/net/ethernet/micrel/ks8851.c
index b8f20aa2b7ad..7ddaa7d88f1d 100644
--- a/drivers/net/ethernet/micrel/ks8851.c
+++ b/drivers/net/ethernet/micrel/ks8851.c
@@ -849,6 +849,7 @@ static int ks8851_net_open(struct net_device *dev)
 	netif_dbg(ks, ifup, ks->netdev, "network device up\n");
 
 	mutex_unlock(&ks->lock);
+	mii_check_link(&ks->mii);
 	return 0;
 }
 
@@ -1510,6 +1511,7 @@ static int ks8851_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, ks);
 
+	netif_carrier_off(ks->netdev);
 	ndev->if_port = IF_PORT_100BASET;
 	ndev->netdev_ops = &ks8851_netdev_ops;
 	ndev->irq = spi->irq;
-- 
2.19.1

