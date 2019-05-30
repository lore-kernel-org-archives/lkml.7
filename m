Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EC4C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CBA2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191645;
	bh=dI0F82b5i+4o3HJUm9vdDFZnNx3jp5jYr9/1WIuPzj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iNAZWzIbT9FMSHPgBU3BE+waoyzHqs8DbviAe3Iwhc6bsZL22twMDWjv8lFbzUT2n
	 oSSstlfuD8aPNJ4r/GNGISsd2wAeDx5HFatCHpV45YWp5ncy8+0jNjyW+wz8jmJCeE
	 bv+CuxqM0P7Ir+srGwQi/jPmo2totL2o2gdL/vjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfE3DL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728099AbfE3DK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:10:27 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 004AE24490;
        Thu, 30 May 2019 03:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185827;
        bh=dI0F82b5i+4o3HJUm9vdDFZnNx3jp5jYr9/1WIuPzj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aE0ENn1MmWRZheQnzqbXqXBmem/RVoOJsxHrAqcnlfvNmZYRr2qCubORLsC+t82dW
         nyxVAG8yCayoTGdwT4BcD/0cQa/YTwEa2YO2lzxY606zVuNvhIQA8A89/MyLPGTHjV
         Y7K/tKyhNqD/v00UXgxu3tonQAr0bCN2Vs1U2ci4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 127/405] nvme-tcp: fix a NULL deref when an admin connect times out
Date:   Wed, 29 May 2019 20:02:05 -0700
Message-Id: <20190530030547.467230220@linuxfoundation.org>
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

[ Upstream commit 7a42589654ae79e1177f0d74306a02d6cef7bddf ]

If we timeout the admin startup sequence we might not yet have
an I/O tagset allocated which causes the teardown sequence to crash.
Make nvme_tcp_teardown_io_queues safe by not iterating inflight tags
if the tagset wasn't allocated.

Fixes: 39d57757467b ("nvme-tcp: fix timeout handler")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 68c49dd672104..aae5374d2b93f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1710,7 +1710,9 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 {
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
-	blk_mq_tagset_busy_iter(ctrl->admin_tagset, nvme_cancel_request, ctrl);
+	if (ctrl->admin_tagset)
+		blk_mq_tagset_busy_iter(ctrl->admin_tagset,
+			nvme_cancel_request, ctrl);
 	blk_mq_unquiesce_queue(ctrl->admin_q);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
 }
@@ -1722,7 +1724,9 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 		return;
 	nvme_stop_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-	blk_mq_tagset_busy_iter(ctrl->tagset, nvme_cancel_request, ctrl);
+	if (ctrl->tagset)
+		blk_mq_tagset_busy_iter(ctrl->tagset,
+			nvme_cancel_request, ctrl);
 	if (remove)
 		nvme_start_queues(ctrl);
 	nvme_tcp_destroy_io_queues(ctrl, remove);
-- 
2.20.1



