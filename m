Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D7BC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4710204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963532;
	bh=UytssJfRBkXYXepko0kAW1vqYVzWmkQxsdI/Ufod58U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EHdBAuWchfdVtKnUFUfICg3zOqxXLN1HZ/82xfYYY7NveQ+lZdmErs/SYIouyfSEC
	 z+DnIURXMJE8zp3w/C+6cV7wCPqNdcdHGwJRw3kAarQyWjaRK0CeDPBIc0orRqF7oj
	 xX/fHLGfmmaTepib7b6lAZ7v/J0r2DPME5AiyRrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbfDVUFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729628AbfDVTo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F81E21902;
        Mon, 22 Apr 2019 19:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962297;
        bh=UytssJfRBkXYXepko0kAW1vqYVzWmkQxsdI/Ufod58U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQPYH59hFRNfCd9RLLcraytVYbMKnrGNixHOvlkPoG7US7rc5NNaCa7NljYCF23hF
         ePM3hX7PCM8PwyiF1Q4BVUEbEc/mQdwiDc0SN1H7pPifRzBSpY5/UuU9tbl0Pg0Rv5
         bAgk1jvsHONwHl+RZQ/ZaaGYoZbTmNVZTOXoGO1c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.0 90/98] nvmet: fix error flow during ns enable
Date:   Mon, 22 Apr 2019 15:41:57 -0400
Message-Id: <20190422194205.10404-90-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Gurtovoy <maxg@mellanox.com>

[ Upstream commit a536b49785759bf99465fdf6e248d34322123fcd ]

In case we fail to enable p2pmem on the current namespace, disable the
backing store device before exiting.

Cc: Stephen Bates <sbates@raithlin.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/nvme/target/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 02c63c463222..7bad21a2283f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -517,7 +517,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 
 	ret = nvmet_p2pmem_ns_enable(ns);
 	if (ret)
-		goto out_unlock;
+		goto out_dev_disable;
 
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		nvmet_p2pmem_ns_add_p2p(ctrl, ns);
@@ -558,7 +558,7 @@ out_unlock:
 out_dev_put:
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		pci_dev_put(radix_tree_delete(&ctrl->p2p_ns_map, ns->nsid));
-
+out_dev_disable:
 	nvmet_ns_dev_disable(ns);
 	goto out_unlock;
 }
-- 
2.19.1

