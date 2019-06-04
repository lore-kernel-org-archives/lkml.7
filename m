Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D9BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA86206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559690996;
	bh=hqVgwEnF/9RsMcxRBozyd21dMgt3XTHl5Cq/n5kGfDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f2wiWr9+PXcjz9XOBTmhOqJB45xSDYmpuort6j7MBxcfVeqNuJLTigW/w6xLTut98
	 ByeO99nrgFcmis5cdWMgavQjLrtr7XbREIElvlPq/ggLzWPUPuW2UwBioklhtxuna0
	 ZDLaydMxY517URlumkecE9RRu6ONz1DR7nfWA528=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfFDX3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727472AbfFDXYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:24:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2464C20859;
        Tue,  4 Jun 2019 23:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690643;
        bh=hqVgwEnF/9RsMcxRBozyd21dMgt3XTHl5Cq/n5kGfDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ev0dgmvv909VGq/R6HetjAySnU0toKsmyB2luIcgrvTVpTuIM7uBHsazMxijLD01
         e3yapQfRehslNpz0pTPH+atfrhgV9ZiiqHwGKFkZgBVCiGHjWGc+/GIOJ24rSP3NQw
         XxMtBDgX0k+/8wzncY1fKFuEUo025x5TmtuFvulQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 17/36] nvme: fix srcu locking on error return in nvme_get_ns_from_disk
Date:   Tue,  4 Jun 2019 19:23:12 -0400
Message-Id: <20190604232333.7185-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232333.7185-1-sashal@kernel.org>
References: <20190604232333.7185-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 100c815cbd56480b3e31518475b04719c363614a ]

If we can't get a namespace don't leak the SRCU lock.  nvme_ioctl was
working around this, but nvme_pr_command wasn't handling this properly.
Just do what callers would usually expect.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index abfb46378cc1..44d8077fbe95 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1277,9 +1277,14 @@ static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
 {
 #ifdef CONFIG_NVME_MULTIPATH
 	if (disk->fops == &nvme_ns_head_ops) {
+		struct nvme_ns *ns;
+
 		*head = disk->private_data;
 		*srcu_idx = srcu_read_lock(&(*head)->srcu);
-		return nvme_find_path(*head);
+		ns = nvme_find_path(*head);
+		if (!ns)
+			srcu_read_unlock(&(*head)->srcu, *srcu_idx);
+		return ns;
 	}
 #endif
 	*head = NULL;
@@ -1326,9 +1331,9 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 
 	ns = nvme_get_ns_from_disk(bdev->bd_disk, &head, &srcu_idx);
 	if (unlikely(!ns))
-		ret = -EWOULDBLOCK;
-	else
-		ret = nvme_ns_ioctl(ns, cmd, arg);
+		return -EWOULDBLOCK;
+
+	ret = nvme_ns_ioctl(ns, cmd, arg);
 	nvme_put_ns_from_disk(head, srcu_idx);
 	return ret;
 }
-- 
2.20.1

