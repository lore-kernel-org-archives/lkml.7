Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D43BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B9E2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504751;
	bh=qHds196RDAXTiiTTkZ0zFr7U4cHrfbsGnajPjo39wUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y49NwXqWbghjIIjt6KzA0Gk77yVYWencLRj0RQDAes+gNLxTLeYfGfAaFhFUejMAx
	 FMFM0fyAaU4h1WLdGqbrUKEiUBxkDzEKjlsKg38vuXv45zhl0Xt3WYslPLJ7iMb3pj
	 2D2M8amy/OGq46LEVpJ7KkEL9GdyySo5jpxYQfis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfCMTTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbfCMTTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:19:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24FA42177E;
        Wed, 13 Mar 2019 19:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504745;
        bh=qHds196RDAXTiiTTkZ0zFr7U4cHrfbsGnajPjo39wUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ih+vckbXqxFFNUn7yIxEy+wlMu9D9vc5XptIUnFDq/qzL2Z1tkT3oUbNTq8aVz9MW
         lmSms34vHtJeqauQGiIm3sofeEgt8u5VgHvYQyfuPYqonUDydU2PouYqEBUWE4KEui
         ORCuiz/XAos2/VhxdhgzHW+5pfsEElXFP3xvjz80=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 07/10] net: marvell: mvneta: fix DMA debug warning
Date:   Wed, 13 Mar 2019 15:18:43 -0400
Message-Id: <20190313191847.160801-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191847.160801-1-sashal@kernel.org>
References: <20190313191847.160801-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit a8fef9ba58c9966ddb1fec916d8d8137c9d8bc89 ]

Booting 4.20 on SolidRun Clearfog issues this warning with DMA API
debug enabled:

WARNING: CPU: 0 PID: 555 at kernel/dma/debug.c:1230 check_sync+0x514/0x5bc
mvneta f1070000.ethernet: DMA-API: device driver tries to sync DMA memory it has not allocated [device address=0x000000002dd7dc00] [size=240 bytes]
Modules linked in: ahci mv88e6xxx dsa_core xhci_plat_hcd xhci_hcd devlink armada_thermal marvell_cesa des_generic ehci_orion phy_armada38x_comphy mcp3021 spi_orion evbug sfp mdio_i2c ip_tables x_tables
CPU: 0 PID: 555 Comm: bridge-network- Not tainted 4.20.0+ #291
Hardware name: Marvell Armada 380/385 (Device Tree)
[<c0019638>] (unwind_backtrace) from [<c0014888>] (show_stack+0x10/0x14)
[<c0014888>] (show_stack) from [<c07f54e0>] (dump_stack+0x9c/0xd4)
[<c07f54e0>] (dump_stack) from [<c00312bc>] (__warn+0xf8/0x124)
[<c00312bc>] (__warn) from [<c00313b0>] (warn_slowpath_fmt+0x38/0x48)
[<c00313b0>] (warn_slowpath_fmt) from [<c00b0370>] (check_sync+0x514/0x5bc)
[<c00b0370>] (check_sync) from [<c00b04f8>] (debug_dma_sync_single_range_for_cpu+0x6c/0x74)
[<c00b04f8>] (debug_dma_sync_single_range_for_cpu) from [<c051bd14>] (mvneta_poll+0x298/0xf58)
[<c051bd14>] (mvneta_poll) from [<c0656194>] (net_rx_action+0x128/0x424)
[<c0656194>] (net_rx_action) from [<c000a230>] (__do_softirq+0xf0/0x540)
[<c000a230>] (__do_softirq) from [<c00386e0>] (irq_exit+0x124/0x144)
[<c00386e0>] (irq_exit) from [<c009b5e0>] (__handle_domain_irq+0x58/0xb0)
[<c009b5e0>] (__handle_domain_irq) from [<c03a63c4>] (gic_handle_irq+0x48/0x98)
[<c03a63c4>] (gic_handle_irq) from [<c0009a10>] (__irq_svc+0x70/0x98)
...

This appears to be caused by mvneta_rx_hwbm() calling
dma_sync_single_range_for_cpu() with the wrong struct device pointer,
as the buffer manager device pointer is used to map and unmap the
buffer.  Fix this.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 6212177781d5..922c4afc767b 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1482,7 +1482,7 @@ static int mvneta_rx(struct mvneta_port *pp, int rx_todo,
 			if (unlikely(!skb))
 				goto err_drop_frame;
 
-			dma_sync_single_range_for_cpu(dev->dev.parent,
+			dma_sync_single_range_for_cpu(&pp->bm_priv->pdev->dev,
 			                              rx_desc->buf_phys_addr,
 			                              MVNETA_MH_SIZE + NET_SKB_PAD,
 			                              rx_bytes,
-- 
2.19.1

