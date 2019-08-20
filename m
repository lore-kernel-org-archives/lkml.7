Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A96EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B4D22DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566308902;
	bh=Ojf029T/GINdDfJhgOlTarSq5bSruD2ny86RKaBuS60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yyDDMRg4HDhD75c73EIuVYlRcSFYTzV8QueIvBeqc6CeUmW9pTaTFTyeRQqvCq2U3
	 pxmhPXC2Dci4W440e1iH/gzweyrmUai3WtIatJcdu+Vp/l9w8VmJtvMCem7NsY41e7
	 Tpu1DAx3Q/O6hHpagkS7V6n0D6NoV9OHrWM3kmag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfHTNke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729858AbfHTNkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:40:32 -0400
Received: from sasha-vm.mshome.net (unknown [12.236.144.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE48422DD3;
        Tue, 20 Aug 2019 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308431;
        bh=Ojf029T/GINdDfJhgOlTarSq5bSruD2ny86RKaBuS60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O3iIHskuxQbrSitGI1/KHpzh3mjV8DnhVIEQfkzYRXueovHtC7jODnvhGdC6/v/Kv
         vudAMxVTmcZeTpUZd1Q3NE3wpAjgrIZ7kfjkDIlsE0u/EB9+nUnzeIrnY/25DmpBWb
         rSzM9uyOnRpO24KKnc0xqd6SWZ+rvxx+o+f/Ij24=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anthony Iliopoulos <ailiopoulos@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.2 02/44] nvme-multipath: revalidate nvme_ns_head gendisk in nvme_validate_ns
Date:   Tue, 20 Aug 2019 09:39:46 -0400
Message-Id: <20190820134028.10829-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820134028.10829-1-sashal@kernel.org>
References: <20190820134028.10829-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anthony Iliopoulos <ailiopoulos@suse.com>

[ Upstream commit fab7772bfbcfe8fb8e3e352a6a8fcaf044cded17 ]

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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5deb4deb38209..ab1a2b1ec3637 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1668,6 +1668,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->head->disk) {
 		nvme_update_disk_info(ns->head->disk, ns, id);
 		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
+		revalidate_disk(ns->head->disk);
 	}
 #endif
 }
-- 
2.20.1

