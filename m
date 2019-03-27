Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E52C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7981D2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715270;
	bh=uz8mXD3eUvMMUfRjhnCAmYS1qH3cmWt174p6SZDTbzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gIcFbRvXNKuSnW85+smDawkZdlgyg47XgEbqEMSpiuhbSzfq+2IYnxsaM4vXAj167
	 h/gvz1wfLIYcia+mVkuabb84Wj99vajII3iod9qW1VNDcOXGM2iNRo5x1CG+FxmraM
	 Mij2sJfGWPQWoXBo2K7Swr2+S0HaUiyG/z1+YoW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfC0SCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbfC0SCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:02:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 724412087C;
        Wed, 27 Mar 2019 18:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709721;
        bh=uz8mXD3eUvMMUfRjhnCAmYS1qH3cmWt174p6SZDTbzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HRI3Z4PIVMGBjjGwxNyHdowIwmue30wqzo/fvcXfkUYWuYDnSKOmq7nLRnTeoB5jb
         93BTjxNtaMs1QOuv/nXzG5toj9qxei9082r5fFb85keuGuGFpq9xHhrNw09Th0lMJz
         eETwhDTX03UPRNjCUyfqfnU0rLh4D3lDVzjNOCl8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.0 002/262] nvme-fc: fix numa_node when dev is null
Date:   Wed, 27 Mar 2019 13:57:37 -0400
Message-Id: <20190327180158.10245-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 06f3d71ea071b70e62bcc146cd9ff7ed1f9d4e43 ]

A recent change added a numa_node field to the nvme controller
and has the transport assign the node using dev_to_node().
However, fcloop registers with a NULL device struct, so the
dev_to_node() call oops.

Revise the assignment to assign no node when device struct is null.

Fixes: 103e515efa89b ("nvme: add a numa_node field to struct nvme_ctrl")
Reported-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Mike Snitzer <snitzer@redhat.com>
[hch: small coding style fixup]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 89accc76d71c..c37d5bbd72ab 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3018,7 +3018,10 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ctrl->ctrl.opts = opts;
 	ctrl->ctrl.nr_reconnects = 0;
-	ctrl->ctrl.numa_node = dev_to_node(lport->dev);
+	if (lport->dev)
+		ctrl->ctrl.numa_node = dev_to_node(lport->dev);
+	else
+		ctrl->ctrl.numa_node = NUMA_NO_NODE;
 	INIT_LIST_HEAD(&ctrl->ctrl_list);
 	ctrl->lport = lport;
 	ctrl->rport = rport;
-- 
2.19.1

