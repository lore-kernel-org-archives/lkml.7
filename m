Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BB1C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64E020637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014136;
	bh=dpw+An5gttVv6+XYF5TNT6KIUmVBKrlCC8WcCZ+QxbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RU0DyvED9LdqYJMWA4a9nmKOtZYsSrw5P4MIwOpPkDd55tD5R7ffUy6ctR7jEA1tY
	 pSYaQyDSzZz4YQMX60GKPww53zzPfKwkk+52JZLcjeQrjPnv6nzPPOYMfujEzVYeOL
	 fqDz66U0/eg/WEfdWlfbKu4yrtjJVsVnznjbPm5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfLJVmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:42:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729916AbfLJVeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:34:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11FCE2073B;
        Tue, 10 Dec 2019 21:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013643;
        bh=dpw+An5gttVv6+XYF5TNT6KIUmVBKrlCC8WcCZ+QxbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nyzf8T3Wn0WwkOYLvMvS+vuITDuEat92Kyjwz+vHJMgp4Vua8+4SIfglOg08uGCRt
         dII/FVTxGyZQ9eqRD09hSi2Dp44wjbXhzEe/Xa1DSPcp/LM0i6Ida+iFtI23r2yAcu
         U2wbde1Y/O8M2zV2qcUL1umO7BSdy5xIa46Tq/wM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <ariel.elior@marvell.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 083/177] RDMA/qedr: Fix memory leak in user qp and mr
Date:   Tue, 10 Dec 2019 16:30:47 -0500
Message-Id: <20191210213221.11921-83-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kalderon <michal.kalderon@marvell.com>

[ Upstream commit 24e412c1e00ebfe73619e6b88cbc26c2c7d41b85 ]

User QPs pbl's weren't freed properly.
MR pbls weren't freed properly.

Fixes: e0290cce6ac0 ("qedr: Add support for memory registeration verbs")
Link: https://lore.kernel.org/r/20191027200451.28187-5-michal.kalderon@marvell.com
Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/qedr/verbs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 8cc3df24e04e4..9167a1c40bcf5 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1701,6 +1701,14 @@ static void qedr_cleanup_user(struct qedr_dev *dev, struct qedr_qp *qp)
 	if (qp->urq.umem)
 		ib_umem_release(qp->urq.umem);
 	qp->urq.umem = NULL;
+
+	if (rdma_protocol_roce(&dev->ibdev, 1)) {
+		qedr_free_pbl(dev, &qp->usq.pbl_info, qp->usq.pbl_tbl);
+		qedr_free_pbl(dev, &qp->urq.pbl_info, qp->urq.pbl_tbl);
+	} else {
+		kfree(qp->usq.pbl_tbl);
+		kfree(qp->urq.pbl_tbl);
+	}
 }
 
 static int qedr_create_user_qp(struct qedr_dev *dev,
@@ -2809,8 +2817,8 @@ int qedr_dereg_mr(struct ib_mr *ib_mr)
 
 	dev->ops->rdma_free_tid(dev->rdma_ctx, mr->hw_mr.itid);
 
-	if ((mr->type != QEDR_MR_DMA) && (mr->type != QEDR_MR_FRMR))
-		qedr_free_pbl(dev, &mr->info.pbl_info, mr->info.pbl_table);
+	if (mr->type != QEDR_MR_DMA)
+		free_mr_info(dev, &mr->info);
 
 	/* it could be user registered memory. */
 	if (mr->umem)
-- 
2.20.1

