Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B611DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A6D2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390810AbfISO3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:29:51 -0400
Received: from mx1.emlix.com ([188.40.240.192]:58624 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390075AbfISO3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:29:48 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 1B51B60441;
        Thu, 19 Sep 2019 16:29:47 +0200 (CEST)
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
To:     linux-kernel@vger.kernel.org
Cc:     yibin.gong@nxp.com, fugang.duan@nxp.com, l.stach@pengutronix.de,
        dan.j.williams@intel.com, vkoul@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.or,
        linux-arm-kernel@lists.infradead.org,
        Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: [PATCH v4 3/3] dmaengine: imx-sdma: drop redundant variable
Date:   Thu, 19 Sep 2019 16:29:41 +0200
Message-Id: <20190919142942.12469-4-philipp.puschmann@emlix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919142942.12469-1-philipp.puschmann@emlix.com>
References: <20190919142942.12469-1-philipp.puschmann@emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sdma_prep_dma_cyclic buf is redundant. Drop it.

Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---

Changelog v3,v4:
 - no changes

Changelog v2:
 - add Reviewed-by tag

 drivers/dma/imx-sdma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index a32b5962630e..17961451941a 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1544,7 +1544,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	struct sdma_engine *sdma = sdmac->sdma;
 	int num_periods = buf_len / period_len;
 	int channel = sdmac->channel;
-	int i = 0, buf = 0;
+	int i;
 	struct sdma_desc *desc;
 
 	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
@@ -1565,7 +1565,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		goto err_bd_out;
 	}
 
-	while (buf < buf_len) {
+	for (i = 0; i < num_periods; i++) {
 		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
 
@@ -1592,9 +1592,6 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		bd->mode.status = param;
 
 		dma_addr += period_len;
-		buf += period_len;
-
-		i++;
 	}
 
 	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
-- 
2.23.0

