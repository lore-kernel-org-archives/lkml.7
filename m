Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ECCC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F2A206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387911AbfG2Ml1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:41:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:60298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726986AbfG2Ml1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:41:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7383ADCB;
        Mon, 29 Jul 2019 12:41:25 +0000 (UTC)
From:   Anthony Iliopoulos <ailiopoulos@suse.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Anthony Iliopoulos <ailiopoulos@suse.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme/multipath: revalidate nvme_ns_head gendisk in nvme_validate_ns
Date:   Mon, 29 Jul 2019 14:40:40 +0200
Message-Id: <20190729124040.16581-1-ailiopoulos@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_NVME_MULTIPATH is set, only the hidden gendisk associated
with the per-controller ns is run through revalidate_disk when a
rescan is triggered, while the visible blockdev never gets its size
(bdev->bd_inode->i_size) updated to reflect any capacity changes that
may have occurred.

This prevents online resizing of nvme block devices and in extension of
any filesystems atop that will are unable to expand while mounted, as
userspace relies on the blockdev size for obtaining the disk capacity
(via BLKGETSIZE/64 ioctls).

Fix this by explicitly revalidating the actual namespace gendisk in
addition to the per-controller gendisk, when multipath is enabled.

Signed-off-by: Anthony Iliopoulos <ailiopoulos@suse.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8f3fbe5ca937..80c7a7ee240b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1715,6 +1715,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->head->disk) {
 		nvme_update_disk_info(ns->head->disk, ns, id);
 		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
+		revalidate_disk(ns->head->disk);
 	}
 #endif
 }
-- 
2.16.4

