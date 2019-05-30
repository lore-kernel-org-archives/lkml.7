Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEFBC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1A525E9D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559192064;
	bh=XomZtjFDqLgRp2xBixwxsRoaZT+KXZ7SNXWy6aXFFXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cAIA33ohkuo9Yp5zEj8DSkJnr3Qx70YtHnNN7UIqjd0PDUkJsEDmW20hdQ0fcVC60
	 wn+HSDsd1qQn4aVQNaB8AZT3UMcfFQil+BReUcvjSNxgy49WJb1x7cbBbQSBUpunvx
	 tS8wOt9MuZG9hordbOnGpWzW9akN9zzjmp3yluC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388798AbfE3EyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728089AbfE3DK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:10:26 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8BB824481;
        Thu, 30 May 2019 03:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185825;
        bh=XomZtjFDqLgRp2xBixwxsRoaZT+KXZ7SNXWy6aXFFXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KQ25fm5rqI9wEzh7nbH7sfTKmqdHMxZ+bFlPBleMijgn1nSqvNni3YtQmFOfCOgsk
         iCzGcsSWv1gmDs1dE6StqlcH4gnRNGXjIKOPU8Q7TwNDS87tM24E10AJcr79lBJpqU
         NHp/L9obFGIeDMe3i7OLjAjBq4n1OgWOxiO2oH2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 125/405] nvme: set 0 capacity if namespace block size exceeds PAGE_SIZE
Date:   Wed, 29 May 2019 20:02:03 -0700
Message-Id: <20190530030547.356126129@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 2c43e12b70afc..8782d86a8ca38 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1591,6 +1591,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	sector_t capacity = le64_to_cpup(&id->nsze) << (ns->lba_shift - 9);
 	unsigned short bs = 1 << ns->lba_shift;
 
+	if (ns->lba_shift > PAGE_SHIFT) {
+		/* unsupported block size, set capacity to 0 later */
+		bs = (1 << 9);
+	}
 	blk_mq_freeze_queue(disk->queue);
 	blk_integrity_unregister(disk);
 
@@ -1601,7 +1605,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
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



