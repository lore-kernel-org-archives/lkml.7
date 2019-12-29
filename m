Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09753C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6401207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640694;
	bh=Bu4lcPanlaQ03j9eLoDmRMHWnon/HkXSHW9ftFMv4cI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n61uATKdEVTuJyaW3Rtm4xA2HjEeArDnhzIE1j5v9Pw4xX7YmpQGqrxLjjj2fevqK
	 facNZyh3dJY4KixBcRQ9cMs2m0NbwsDgzpzZjDFlqSkb+qHdk7L/lSNcFm6c/+iK6E
	 /R8L6lQ/viXHTluKar0LUCZHJNLLUuXi81wnUhbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfL2Rbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:31:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbfL2Rba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:31:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B408207FD;
        Sun, 29 Dec 2019 17:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640689;
        bh=Bu4lcPanlaQ03j9eLoDmRMHWnon/HkXSHW9ftFMv4cI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lrmmh0bj0+6AMThd0hnBkrMQfJqu3Rhf0T9A1S6bGrpWoBuiw6k5lmUI96itHOKIw
         GMxieO2NyjGTuZd3xjHTsb5GkWbyMfll0sRifhMLgkT3cPEuIw7bZXZrmBgpOAAlmp
         wvmMjVQy3+W3JyFUR2PdLJb+RN5UiblgQFirJS4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ariel Elior <ariel.elior@marvell.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 099/219] RDMA/qedr: Fix memory leak in user qp and mr
Date:   Sun, 29 Dec 2019 18:18:21 +0100
Message-Id: <20191229162522.975897510@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 8cc3df24e04e..9167a1c40bcf 100644
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



