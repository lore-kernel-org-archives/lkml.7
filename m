Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31F5C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8896B206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610881;
	bh=l51evxqU8zJCOrGtKLHrLz9etFFXDJe12qIraGCuN0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0pTKN7d4Mze/9aClMUR50DqTgYqlAOQ1PgccUDzU2k2v2vqOmjQ/su8u8wpAJJqfK
	 tIG5O++tFz/rOKuUYvm6HDqciYSPvJbnY16yelyDmUgYcV0bBS8fr4+KE+qtthYIX/
	 efzqpBS6qjH80HWA6jisCnNtRNUVheKn1AcNzpLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfKMCH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:07:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:55318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730443AbfKMCAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:00:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5622922469;
        Wed, 13 Nov 2019 02:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610413;
        bh=l51evxqU8zJCOrGtKLHrLz9etFFXDJe12qIraGCuN0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IP+6Ya2xSANg9jwqiCf6aqA3hhx0PuT3m8Guk3vMx+FxNjovIsB2fDY5X9wsIRPUc
         v9euERtQYlXKhBxjvG0uNcH3trZ1ZsA5c8RsfYdhdQj3bnGgeESU9Ln3vTvHKP2Rma
         xXhFkKWjWplJ+DzIIEUPqokGOA21XMnIi1JaFWR0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-ide@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.9 26/68] ata: ep93xx: Use proper enums for directions
Date:   Tue, 12 Nov 2019 20:58:50 -0500
Message-Id: <20191113015932.12655-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015932.12655-1-sashal@kernel.org>
References: <20191113015932.12655-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 6adde4a36f1b6a562a1057fbb1065007851050e7 ]

Clang warns when one enumerated type is implicitly converted to another.

drivers/ata/pata_ep93xx.c:662:36: warning: implicit conversion from
enumeration type 'enum dma_data_direction' to different enumeration type
'enum dma_transfer_direction' [-Wenum-conversion]
        drv_data->dma_rx_data.direction = DMA_FROM_DEVICE;
                                        ~ ^~~~~~~~~~~~~~~
drivers/ata/pata_ep93xx.c:670:36: warning: implicit conversion from
enumeration type 'enum dma_data_direction' to different enumeration type
'enum dma_transfer_direction' [-Wenum-conversion]
        drv_data->dma_tx_data.direction = DMA_TO_DEVICE;
                                        ~ ^~~~~~~~~~~~~
drivers/ata/pata_ep93xx.c:681:19: warning: implicit conversion from
enumeration type 'enum dma_data_direction' to different enumeration type
'enum dma_transfer_direction' [-Wenum-conversion]
        conf.direction = DMA_FROM_DEVICE;
                       ~ ^~~~~~~~~~~~~~~
drivers/ata/pata_ep93xx.c:692:19: warning: implicit conversion from
enumeration type 'enum dma_data_direction' to different enumeration type
'enum dma_transfer_direction' [-Wenum-conversion]
        conf.direction = DMA_TO_DEVICE;
                       ~ ^~~~~~~~~~~~~

Use the equivalent valued enums from the expected type so that Clang no
longer warns about a conversion.

DMA_TO_DEVICE = DMA_MEM_TO_DEV = 1
DMA_FROM_DEVICE = DMA_DEV_TO_MEM = 2

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/pata_ep93xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index bd6b089c67a3a..634c814cbeda4 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -659,7 +659,7 @@ static void ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	 * start of new transfer.
 	 */
 	drv_data->dma_rx_data.port = EP93XX_DMA_IDE;
-	drv_data->dma_rx_data.direction = DMA_FROM_DEVICE;
+	drv_data->dma_rx_data.direction = DMA_DEV_TO_MEM;
 	drv_data->dma_rx_data.name = "ep93xx-pata-rx";
 	drv_data->dma_rx_channel = dma_request_channel(mask,
 		ep93xx_pata_dma_filter, &drv_data->dma_rx_data);
@@ -667,7 +667,7 @@ static void ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 		return;
 
 	drv_data->dma_tx_data.port = EP93XX_DMA_IDE;
-	drv_data->dma_tx_data.direction = DMA_TO_DEVICE;
+	drv_data->dma_tx_data.direction = DMA_MEM_TO_DEV;
 	drv_data->dma_tx_data.name = "ep93xx-pata-tx";
 	drv_data->dma_tx_channel = dma_request_channel(mask,
 		ep93xx_pata_dma_filter, &drv_data->dma_tx_data);
@@ -678,7 +678,7 @@ static void ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 
 	/* Configure receive channel direction and source address */
 	memset(&conf, 0, sizeof(conf));
-	conf.direction = DMA_FROM_DEVICE;
+	conf.direction = DMA_DEV_TO_MEM;
 	conf.src_addr = drv_data->udma_in_phys;
 	conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	if (dmaengine_slave_config(drv_data->dma_rx_channel, &conf)) {
@@ -689,7 +689,7 @@ static void ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 
 	/* Configure transmit channel direction and destination address */
 	memset(&conf, 0, sizeof(conf));
-	conf.direction = DMA_TO_DEVICE;
+	conf.direction = DMA_MEM_TO_DEV;
 	conf.dst_addr = drv_data->udma_out_phys;
 	conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	if (dmaengine_slave_config(drv_data->dma_tx_channel, &conf)) {
-- 
2.20.1

