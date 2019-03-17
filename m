Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EECC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 00:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253742186A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 00:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfCQAfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 20:35:33 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:49051 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726828AbfCQAfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 20:35:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04392;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TMuH0Ub_1552782930;
Received: from localhost(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TMuH0Ub_1552782930)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 17 Mar 2019 08:35:31 +0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH] virtio-fs: fix multiple tag support
Date:   Sun, 17 Mar 2019 08:35:21 +0800
Message-Id: <20190317003521.69366-1-bo.liu@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.2.gb21ebb6
In-Reply-To: <20181210171318.16998-19-vgoyal@redhat.com>
References: <20181210171318.16998-19-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While doing memremap from pci_dev's system bus address to kernel virtual
address, we assign a wrong value to the %end of pgmap.res, which ends up
with a wrong resource size in the process of memremap, and that further
prevent the second virtiofs pci device from being probed successfully.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 fs/fuse/virtio_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 88b00055589b..7abf2187d85f 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -713,7 +713,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 	pgmap->res = (struct resource){
 		.name = "virtio-fs dax window",
 		.start = phys_addr,
-		.end = phys_addr + cache_len,
+		.end = phys_addr + cache_len - 1,
 	};
 
 	fs->window_kaddr = devm_memremap_pages(&pci_dev->dev, pgmap);
-- 
2.20.1.2.gb21ebb6

