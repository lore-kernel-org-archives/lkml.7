Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920D9C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EB72089E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558554781;
	bh=4zncFK8TGCgEH/vOY6DJh5XX+xKWltKiLhrd6D/Dun4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x7eZ8DqgaKXiVGXN5DzHxUWxgbABcfep2YpvtUGlUE2o9MTKshhGQtjcmUp39SlL8
	 GcefIiXVnCGl72mbdxJ5cCOltzU9lYSpEu4Hy7uCLX8kTXbWA8SK1xGEn9mVuCg5fM
	 6kSpemFTCd2ac2unRfPer3bWGQITDui0Yj/o5Pls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfEVTZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:25:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731756AbfEVTZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:25:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 221FC2173C;
        Wed, 22 May 2019 19:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553150;
        bh=4zncFK8TGCgEH/vOY6DJh5XX+xKWltKiLhrd6D/Dun4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cDalNuwkU3ZTXno6dUgQ1Q046NUZIPis54fYj9Vq4/VANaTrb9l7pCvDo9VJCUCO3
         1zFjoCY+eRdTUC22luJyzRWrythkKnXS86dSQTts/zRWvwU3kM2ItLS0qH077GlO0n
         ZFTkx2pApL+sQh5uF83prcTCYkiLMbQ0PilVQ5y0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.0 078/317] nvme: set 0 capacity if namespace block size exceeds PAGE_SIZE
Date:   Wed, 22 May 2019 15:19:39 -0400
Message-Id: <20190522192338.23715-78-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192338.23715-1-sashal@kernel.org>
References: <20190522192338.23715-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 01fa017484ad98fccdeaab32db0077c574b6bd6f ]

If our target exposed a namespace with a block size that is greater
than PAGE_SIZE, set 0 capacity on the namespace as we do not support it.

This issue encountered when the nvmet namespace was backed by a tempfile.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4c4413ad3ceb3..5b389fed6d54c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1551,6 +1551,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	sector_t capacity = le64_to_cpup(&id->nsze) << (ns->lba_shift - 9);
 	unsigned short bs = 1 << ns->lba_shift;
 
+	if (ns->lba_shift > PAGE_SHIFT) {
+		/* unsupported block size, set capacity to 0 later */
+		bs = (1 << 9);
+	}
 	blk_mq_freeze_queue(disk->queue);
 	blk_integrity_unregister(disk);
 
@@ -1561,7 +1565,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	if (ns->ms && !ns->ext &&
 	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		nvme_init_integrity(disk, ns->ms, ns->pi_type);
-	if (ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk))
+	if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
+	    ns->lba_shift > PAGE_SHIFT)
 		capacity = 0;
 
 	set_capacity(disk, capacity);
-- 
2.20.1

