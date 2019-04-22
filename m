Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3172C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29A320643
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963374;
	bh=fIhX/tNaCof+lPJyKim+YQEZAb2IukfLs34A9hCcUOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=azTNm17WUsVReIwG2RXtoTpL46VCpnx3VChEg/uLsAZLU5UhlY8DW4RFh5Cl2EZ3W
	 we+nYTgVf+eH/aZEPUy5CYrl87CQOzKb3hV9elta3lw1IACcNtc8g7qGOptqogwsZP
	 nww5pqIqGxc0/GEP9nDJG+cG0Av9B6bOvUGOz6D0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbfDVUCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729935AbfDVTqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:46:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7570218FC;
        Mon, 22 Apr 2019 19:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962379;
        bh=fIhX/tNaCof+lPJyKim+YQEZAb2IukfLs34A9hCcUOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTTP5DID3bhdp4Bv29+4CZXgdfJNbVKuOqNXHD0huLFXzFuAwMzhkAidbd1DGOM/5
         k3HtffcrxJ0LQmm1fqGJuMfIv21qkhEfwFJnihUqON2RXztDiHBSFwsA3fyw5XFEqc
         KWfvJckoGFa7kdOoWT9pOZhi+8UzmCM2QUocFij4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>, Frank Pavlic <f.pavlic@kunbus.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Tristram Ha <Tristram.Ha@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 30/68] net: ks8851: Set initial carrier state to down
Date:   Mon, 22 Apr 2019 15:44:38 -0400
Message-Id: <20190422194516.11634-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
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
index c9faec4c5b25..b83b070a9eec 100644
--- a/drivers/net/ethernet/micrel/ks8851.c
+++ b/drivers/net/ethernet/micrel/ks8851.c
@@ -858,6 +858,7 @@ static int ks8851_net_open(struct net_device *dev)
 	netif_dbg(ks, ifup, ks->netdev, "network device up\n");
 
 	mutex_unlock(&ks->lock);
+	mii_check_link(&ks->mii);
 	return 0;
 }
 
@@ -1519,6 +1520,7 @@ static int ks8851_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, ks);
 
+	netif_carrier_off(ks->netdev);
 	ndev->if_port = IF_PORT_100BASET;
 	ndev->netdev_ops = &ks8851_netdev_ops;
 	ndev->irq = spi->irq;
-- 
2.19.1

