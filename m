Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C89C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B278320873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510919;
	bh=WnRs12+q0ocPyqCZ7djJyleRZcDXafyOhPyDCWFslTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NdUuO5zHjCLtmcHPtiwOJCa0V9Js5MsZvqwwG3kR/Fx+dpwdq0DIojf07+UDC/oDI
	 VqXqGC0jf1ZW/bHhXzbE0Ypz5pbdNIknuhFiZfyr8eW1i7e6xVRVPBoE659NF6YqaY
	 Se/zeBODnKo6IY3Bb8O6tWLl9wHElNqrhoMjHYHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbfGSEfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbfGSEB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:01:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E88E92189F;
        Fri, 19 Jul 2019 04:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508888;
        bh=WnRs12+q0ocPyqCZ7djJyleRZcDXafyOhPyDCWFslTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJpuQHAJQPkPG5e4+hOGDIDvhYht1re4p1nSNn/alAGC3+PuB0X2lvxhTJzagqYJA
         WfpIkrVWnqYay1/ovHSS1vKmOhO6rv7o43fTeDylJx63YqCihlsvH1H7rlQj9wwoVd
         zZHH2tJ9PJmjnbre7bGm9Du2Y9XDzHGxOAoCMr+o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
        Mike Playle <mplayle@solarflare.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.2 139/171] nvme-tcp: set the STABLE_WRITES flag when data digests are enabled
Date:   Thu, 18 Jul 2019 23:56:10 -0400
Message-Id: <20190719035643.14300-139-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>

[ Upstream commit 958f2a0f8121ae36a5cbff383ab94fadf1fba5eb ]

There was a few false alarms sighted on target side about wrong data
digest while performing high throughput load to XFS filesystem shared
through NVMoF TCP.

This flag tells the rest of the kernel to ensure that the data buffer
does not change while the write is in flight.  It incurs a performance
penalty, so only enable it when it is actually needed, i.e. when we are
calculating data digests.

Although even with this change in place, ext2 users can steel experience
false positives, as ext2 is not respecting this flag. This may be apply
to vfat as well.

Signed-off-by: Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>
Signed-off-by: Mike Playle <mplayle@solarflare.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 120fb593d1da..b4048748551e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -11,6 +11,7 @@
 #include <linux/hdreg.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/backing-dev.h>
 #include <linux/list_sort.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -3256,6 +3257,10 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		goto out_free_ns;
 	}
 
+	if (ctrl->opts->data_digest)
+		ns->queue->backing_dev_info->capabilities
+			|= BDI_CAP_STABLE_WRITES;
+
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
 	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
 		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
-- 
2.20.1

