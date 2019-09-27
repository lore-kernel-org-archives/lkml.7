Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB70AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 10:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99853217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 10:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfI0KPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 06:15:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:57850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727635AbfI0KPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 06:15:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6ECA6B0BD;
        Fri, 27 Sep 2019 10:15:41 +0000 (UTC)
From:   Benjamin Poirier <bpoirier@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/17] staging: qlge: Refill rx buffers up to multiple of 16
Date:   Fri, 27 Sep 2019 19:12:10 +0900
Message-Id: <20190927101210.23856-17-bpoirier@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190927101210.23856-1-bpoirier@suse.com>
References: <20190927101210.23856-1-bpoirier@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading the {s,l}bq_prod_idx registers on a running device, it appears that
the adapter will only use buffers up to prod_idx & 0xfff0. The driver
currently uses fixed-size guard zones (16 for sbq, 32 for lbq - don't know
why this difference). After the previous patch, this approach no longer
guarantees prod_idx values aligned on multiples of 16. While it appears
that we can write unaligned values to prod_idx without ill effects on
device operation, it makes more sense to change qlge_refill_bq() to refill
up to a limit that corresponds with the device's behavior.

Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
---
 drivers/staging/qlge/qlge.h      |  8 ++++++++
 drivers/staging/qlge/qlge_main.c | 29 +++++++++++------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/qlge/qlge.h b/drivers/staging/qlge/qlge.h
index 7c48e333d29b..e5a352df8228 100644
--- a/drivers/staging/qlge/qlge.h
+++ b/drivers/staging/qlge/qlge.h
@@ -1423,6 +1423,9 @@ struct qlge_bq {
 	__le64 *base_indirect;
 	dma_addr_t base_indirect_dma;
 	struct qlge_bq_desc *queue;
+	/* prod_idx is the index of the first buffer that may NOT be used by
+	 * hw, ie. one after the last. Advanced by sw.
+	 */
 	void __iomem *prod_idx_db_reg;
 	/* next index where sw should refill a buffer for hw */
 	u16 next_to_use;
@@ -1442,6 +1445,11 @@ struct qlge_bq {
 					  offsetof(struct rx_ring, lbq))); \
 })
 
+/* Experience shows that the device ignores the low 4 bits of the tail index.
+ * Refill up to a x16 multiple.
+ */
+#define QLGE_BQ_ALIGN(index) ALIGN_DOWN(index, 16)
+
 #define QLGE_BQ_WRAP(index) ((index) & (QLGE_BQ_LEN - 1))
 
 struct rx_ring {
diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
index 83e75005688a..02ad0cdf4856 100644
--- a/drivers/staging/qlge/qlge_main.c
+++ b/drivers/staging/qlge/qlge_main.c
@@ -1114,22 +1114,12 @@ static void qlge_refill_bq(struct qlge_bq *bq)
 	struct rx_ring *rx_ring = QLGE_BQ_CONTAINER(bq);
 	struct ql_adapter *qdev = rx_ring->qdev;
 	struct qlge_bq_desc *bq_desc;
-	int free_count, refill_count;
-	unsigned int reserved_count;
+	int refill_count;
 	int i;
 
-	if (bq->type == QLGE_SB)
-		reserved_count = 16;
-	else
-		reserved_count = 32;
-
-	free_count = bq->next_to_clean - bq->next_to_use;
-	if (free_count <= 0)
-		free_count += QLGE_BQ_LEN;
-
-	refill_count = free_count - reserved_count;
-	/* refill batch size */
-	if (refill_count < 16)
+	refill_count = QLGE_BQ_WRAP(QLGE_BQ_ALIGN(bq->next_to_clean - 1) -
+				    bq->next_to_use);
+	if (!refill_count)
 		return;
 
 	i = bq->next_to_use;
@@ -1164,11 +1154,14 @@ static void qlge_refill_bq(struct qlge_bq *bq)
 	i += QLGE_BQ_LEN;
 
 	if (bq->next_to_use != i) {
-		netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
-			     "ring %u %s: updating prod idx = %d.\n",
-			     rx_ring->cq_id, bq_type_name[bq->type], i);
+		if (QLGE_BQ_ALIGN(bq->next_to_use) != QLGE_BQ_ALIGN(i)) {
+			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
+				     "ring %u %s: updating prod idx = %d.\n",
+				     rx_ring->cq_id, bq_type_name[bq->type],
+				     i);
+			ql_write_db_reg(i, bq->prod_idx_db_reg);
+		}
 		bq->next_to_use = i;
-		ql_write_db_reg(bq->next_to_use, bq->prod_idx_db_reg);
 	}
 }
 
-- 
2.23.0

