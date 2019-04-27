Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF68C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B4F216F4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329230;
	bh=HgEgMcjufjqFB/Tjby9lXUBFDiJAZAWStGPSlkCAXio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vfhVN18JOdCGs30w4L0UBAWH6mRh5ETHADkJVdbVHRcbNzre0+dc8KEJjZ+ngXb3z
	 GiifQs7Ng2IyOMchThDk7Qjpkmon2CIY/kr5U33dbSKWDkMWwD8VTqwakU/3RJf3Yt
	 SXD3O/xj6wdfaTbU8/q8A21GOOfrpwAhQx0DdFws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfD0Bk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfD0Bk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:40:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6166F20C01;
        Sat, 27 Apr 2019 01:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329226;
        bh=HgEgMcjufjqFB/Tjby9lXUBFDiJAZAWStGPSlkCAXio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWKjSB43kMfhwlpG1XzsQhqQoX5ddbJGROSPsG2ZI2YeWzczlDISyJjUsB0DndmEp
         vgcZor3Lj84N5pS4r/5QA6ThYCHrjXkMiGvHjIZB51jCgi5c1dokYQiqZeUMb8d0P9
         E0Z5eIBSNoSv96wVP7lMAKzACHEKZZCsW+e6dkP4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 67/79] nvme: cancel request synchronously
Date:   Fri, 26 Apr 2019 21:38:26 -0400
Message-Id: <20190427013838.6596-67-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit eb3afb75b57c28599af0dfa03a99579d410749e9 ]

nvme_cancel_request() is used in error handler, and it is always
reliable to cancel request synchronously, and avoids possible race
in which request may be completed after real hw queue is destroyed.

One issue is reported by our customer on NVMe RDMA, in which freed ib
queue pair may be used in nvme_rdma_complete_rq().

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6a9dd68c0f4f..4c4413ad3ceb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -291,7 +291,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 				"Cancelling I/O %d", req->tag);
 
 	nvme_req(req)->status = NVME_SC_ABORT_REQ;
-	blk_mq_complete_request(req);
+	blk_mq_complete_request_sync(req);
 	return true;
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_request);
-- 
2.19.1

