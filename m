Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2775C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C901A20679
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbfH0UDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:03:37 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:43928 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfH0UDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:03:37 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 825F8785AF5; Tue, 27 Aug 2019 22:03:35 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     trivial@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] trivial: Fix typos "emptry" -> "emptry" and "emtry" -> "entry"
Date:   Tue, 27 Aug 2019 22:03:20 +0200
Message-Id: <20190827200320.14737-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found one when reading through spi.c. Then grepped for other instances
and mistyped the pattern at first. So it's one logical change to fix
them all in one go :-)

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
Hello,

If this should go via the respective maintainer trees, I can
also split to increase my patch count.

Best regards
Uwe
---
 drivers/infiniband/hw/cxgb3/cxio_resource.c        | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 2 +-
 drivers/spi/spi.c                                  | 2 +-
 fs/xfs/xfs_dquot.c                                 | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb3/cxio_resource.c b/drivers/infiniband/hw/cxgb3/cxio_resource.c
index c6e7bc4420b6..844fa3cdd7a7 100644
--- a/drivers/infiniband/hw/cxgb3/cxio_resource.c
+++ b/drivers/infiniband/hw/cxgb3/cxio_resource.c
@@ -184,7 +184,7 @@ static u32 cxio_hal_get_resource(struct kfifo *fifo, spinlock_t * lock)
 	if (kfifo_out_locked(fifo, (unsigned char *) &entry, sizeof(u32), lock))
 		return entry;
 	else
-		return 0;	/* fifo emptry */
+		return 0;	/* fifo empty */
 }
 
 static void cxio_hal_put_resource(struct kfifo *fifo, spinlock_t * lock,
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index c1eba421ba82..1ac1e49c89ea 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -1891,7 +1891,7 @@ int hns_dsaf_del_mac_entry(struct dsaf_device *dsaf_dev, u16 vlan_id,
 	/*do del opt*/
 	hns_dsaf_tcam_mc_invld(dsaf_dev, entry_index);
 
-	/*del soft emtry */
+	/*del soft entry */
 	soft_mac_entry += entry_index;
 	soft_mac_entry->index = DSAF_INVALID_ENTRY_IDX;
 
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 75ac046cae52..ec9d3588659a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -92,7 +92,7 @@ static ssize_t driver_override_store(struct device *dev,
 	if (len) {
 		spi->driver_override = driver_override;
 	} else {
-		/* Emptry string, disable driver override */
+		/* Empty string, disable driver override */
 		spi->driver_override = NULL;
 		kfree(driver_override);
 	}
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index fb1ad4483081..78a5a8109644 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -1089,7 +1089,7 @@ xfs_qm_dqflush(
 	 * to disk, because the log record didn't make it to disk.
 	 *
 	 * We also have to remove the log item from the AIL in this case,
-	 * as we wait for an emptry AIL as part of the unmount process.
+	 * as we wait for an empty AIL as part of the unmount process.
 	 */
 	if (XFS_FORCED_SHUTDOWN(mp)) {
 		struct xfs_log_item	*lip = &dqp->q_logitem.qli_item;
-- 
2.23.0

