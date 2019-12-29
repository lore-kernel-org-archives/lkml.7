Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BDCC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDD220718
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641689;
	bh=A8mS2g7mzak7J2IK5FmSJhmX/u36qzAIAVoO32dNVEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MSZni43Fb0gJCXpKw79vI2Z6NU+lkVbdvy/0tkzS8QqadowUQRgWhTtkpCjTJLKT3
	 P4+j4tP4FTy+R8hCTiiuOfQ0TIRYG4+qMiS8mqs1Tzalr3ebpXroL6e9Zo4s6rbuPk
	 6WioMqWpNHxHNq9raUUdraJC2lH0GWTr1FbC0hoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbfL2RsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:48:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730931AbfL2RsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:48:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86FB621D7E;
        Sun, 29 Dec 2019 17:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641680;
        bh=A8mS2g7mzak7J2IK5FmSJhmX/u36qzAIAVoO32dNVEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kY4F43K5F5+lXeSEbl0J1uxS1N7XCZ1H03p+KhtA2xdMolDEnbWqBWyLH2EL+intJ
         VMhKRunxoIYXdC0y3qMCnjqNeV1TZPGu9Nsg/hMiaGZHR0eeE+8AbO9mSOUIBBMnCC
         136SFRK/rOkeUSjhxtnUAD5hO2v0XQtXmZVukn80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Weihang Li <liweihang@hisilicon.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 166/434] RDMA/hns: Fix wrong parameters when initial mtt of srq->idx_que
Date:   Sun, 29 Dec 2019 18:23:39 +0100
Message-Id: <20191229172712.829729575@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weihang Li <liweihang@hisilicon.com>

[ Upstream commit e8a07de57ea4ca7c2d604871c52826e66899fc70 ]

The parameters npages used to initial mtt of srq->idx_que shouldn't be
same with srq's. And page_shift should be calculated from idx_buf_pg_sz.
This patch fixes above issues and use field named npage and page_shift
in hns_roce_buf instead of two temporary variables to let us use them
anywhere.

Fixes: 18df508c7970 ("RDMA/hns: Remove if-else judgment statements for creating srq")
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Link: https://lore.kernel.org/r/1567566885-23088-3-git-send-email-liweihang@hisilicon.com
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_srq.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 43ea2c13b212..108667ae6b14 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -180,8 +180,7 @@ static int create_user_srq(struct hns_roce_srq *srq, struct ib_udata *udata,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(srq->ibsrq.device);
 	struct hns_roce_ib_create_srq  ucmd;
-	u32 page_shift;
-	u32 npages;
+	struct hns_roce_buf *buf;
 	int ret;
 
 	if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd)))
@@ -191,11 +190,13 @@ static int create_user_srq(struct hns_roce_srq *srq, struct ib_udata *udata,
 	if (IS_ERR(srq->umem))
 		return PTR_ERR(srq->umem);
 
-	npages = (ib_umem_page_count(srq->umem) +
-		(1 << hr_dev->caps.srqwqe_buf_pg_sz) - 1) /
-		(1 << hr_dev->caps.srqwqe_buf_pg_sz);
-	page_shift = PAGE_SHIFT + hr_dev->caps.srqwqe_buf_pg_sz;
-	ret = hns_roce_mtt_init(hr_dev, npages, page_shift, &srq->mtt);
+	buf = &srq->buf;
+	buf->npages = (ib_umem_page_count(srq->umem) +
+		       (1 << hr_dev->caps.srqwqe_buf_pg_sz) - 1) /
+		      (1 << hr_dev->caps.srqwqe_buf_pg_sz);
+	buf->page_shift = PAGE_SHIFT + hr_dev->caps.srqwqe_buf_pg_sz;
+	ret = hns_roce_mtt_init(hr_dev, buf->npages, buf->page_shift,
+				&srq->mtt);
 	if (ret)
 		goto err_user_buf;
 
@@ -212,9 +213,12 @@ static int create_user_srq(struct hns_roce_srq *srq, struct ib_udata *udata,
 		goto err_user_srq_mtt;
 	}
 
-	ret = hns_roce_mtt_init(hr_dev, ib_umem_page_count(srq->idx_que.umem),
-				PAGE_SHIFT, &srq->idx_que.mtt);
-
+	buf = &srq->idx_que.idx_buf;
+	buf->npages = DIV_ROUND_UP(ib_umem_page_count(srq->idx_que.umem),
+				   1 << hr_dev->caps.idx_buf_pg_sz);
+	buf->page_shift = PAGE_SHIFT + hr_dev->caps.idx_buf_pg_sz;
+	ret = hns_roce_mtt_init(hr_dev, buf->npages, buf->page_shift,
+				&srq->idx_que.mtt);
 	if (ret) {
 		dev_err(hr_dev->dev, "hns_roce_mtt_init error for idx que\n");
 		goto err_user_idx_mtt;
-- 
2.20.1



