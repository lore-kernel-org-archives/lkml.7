Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B03C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1715218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390240AbfISO3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:29:48 -0400
Received: from mx1.emlix.com ([188.40.240.192]:58610 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfISO3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:29:47 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 8F0D66036C;
        Thu, 19 Sep 2019 16:29:46 +0200 (CEST)
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
To:     linux-kernel@vger.kernel.org
Cc:     yibin.gong@nxp.com, fugang.duan@nxp.com, l.stach@pengutronix.de,
        dan.j.williams@intel.com, vkoul@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.or,
        linux-arm-kernel@lists.infradead.org,
        Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: [PATCH v4 2/3] dmaengine: imx-sdma: fix dma freezes
Date:   Thu, 19 Sep 2019 16:29:40 +0200
Message-Id: <20190919142942.12469-3-philipp.puschmann@emlix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919142942.12469-1-philipp.puschmann@emlix.com>
References: <20190919142942.12469-1-philipp.puschmann@emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some years and since many kernel versions there are reports that the
RX UART SDMA channel stops working at some point. The workaround was to
disable DMA for RX. This commit tries to fix the problem itself.

Due to its license i wasn't able to debug the sdma script itself but it
somehow leads to blocking the scheduling of the channel script when a
running sdma script does not find any free descriptor in the ring to put
its data into.

If we detect such a potential case we manually restart the channel.

As sdmac->desc is constant we can move desc out of the loop.

Fixes: 1ec1e82f2510 ("dmaengine: Add Freescale i.MX SDMA support")
Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---

Changelog v4:
 - fixed the fixes tag
 
Changelog v3:
 - use correct dma_wmb() instead of dma_wb()
 - add fixes tag
 
Changelog v2:
 - clarify comment and commit description

 drivers/dma/imx-sdma.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index e029a2443cfc..a32b5962630e 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -775,21 +775,23 @@ static void sdma_start_desc(struct sdma_channel *sdmac)
 static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 {
 	struct sdma_buffer_descriptor *bd;
-	int error = 0;
-	enum dma_status	old_status = sdmac->status;
+	struct sdma_desc *desc = sdmac->desc;
+	int error = 0, cnt = 0;
+	enum dma_status old_status = sdmac->status;
 
 	/*
 	 * loop mode. Iterate over descriptors, re-setup them and
 	 * call callback function.
 	 */
-	while (sdmac->desc) {
-		struct sdma_desc *desc = sdmac->desc;
+	while (desc) {
 
 		bd = &desc->bd[desc->buf_tail];
 
 		if (bd->mode.status & BD_DONE)
 			break;
 
+		cnt++;
+
 		if (bd->mode.status & BD_RROR) {
 			bd->mode.status &= ~BD_RROR;
 			sdmac->status = DMA_ERROR;
@@ -822,6 +824,17 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		if (error)
 			sdmac->status = old_status;
 	}
+
+	/* In some situations it may happen that the sdma does not found any
+	 * usable descriptor in the ring to put data into. The channel is
+	 * stopped then. While there is no specific error condition we can
+	 * check for, a necessary condition is that all available buffers for
+	 * the current channel have been written to by the sdma script. In
+	 * this case and after we have made the buffers available again,
+	 * we restart the channel.
+	 */
+	if (cnt >= desc->num_bd)
+		sdma_enable_channel(sdmac->sdma, sdmac->channel);
 }
 
 static void mxc_sdma_handle_channel_normal(struct sdma_channel *data)
-- 
2.23.0

