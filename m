Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A7CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D7F2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255409;
	bh=B+kr4jyJp5rpShGJ1Een3ExMRP6XvOOwtqzeOqstL/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NQTiNfA/Bpe/Jz4SleaPyu9wpRBdbxozepVQxVoFUrBsz0rCwGyPuSiGWSEvwtqZQ
	 JUDMDo2ay0GdE/fxj2sEajwsKfhI7OQmQ6DbIQ4UQU/y6Uo+TWftkv08tibFxItbR/
	 uZ8+KC6Vr01J96S3nStohJOWmeWgS/10VKMLyxOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbfCVLuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728700AbfCVLuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:50:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FD542082C;
        Fri, 22 Mar 2019 11:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255405;
        bh=B+kr4jyJp5rpShGJ1Een3ExMRP6XvOOwtqzeOqstL/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yxWAr8jOMEo6FJ7lX35HmtDREro+GpXmLvonC3NIvzyU6yA+BXlZ8bzDQCCuObjms
         CWkSKcF+jbnMRp4zULNhd3Bz02I8pOWH8fM8nhPh7rKk7Tw62htn2VClfKSIVH/xAg
         t3ytK/3VB8Z/kZdE2p5RNyDgHKyf8oWmRdtEkssU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 053/183] net: marvell: mvneta: fix DMA debug warning
Date:   Fri, 22 Mar 2019 12:14:41 +0100
Message-Id: <20190322111245.544536109@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 074a5b79d691..f76cbefeb3c7 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2102,7 +2102,7 @@ err_drop_frame:
 			if (unlikely(!skb))
 				goto err_drop_frame_ret_pool;
 
-			dma_sync_single_range_for_cpu(dev->dev.parent,
+			dma_sync_single_range_for_cpu(&pp->bm_priv->pdev->dev,
 			                              rx_desc->buf_phys_addr,
 			                              MVNETA_MH_SIZE + NET_SKB_PAD,
 			                              rx_bytes,
-- 
2.19.1



