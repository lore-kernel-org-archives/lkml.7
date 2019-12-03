Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1C3C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76452053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413847;
	bh=6l1wOmolfxD+j5KIMvG2dSSOaGeCOOsN1zc9qmVWZzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sjA6dTwoENxMV+MbdFBBnLrWkG/MddCYsNEaJfQv6/xQsmTcZHulS8d1n3YTKoZGn
	 UG89Yl50doOlCjNrY99VCU/qib+cTxM0O6TiytWslXHdlIcmI+cth56PwSeX6aW/JW
	 Cex/zjJDyrPN1QUcOVCrw7g3npTPrPVHuPGa3dx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbfLCW50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:57:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbfLCW5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:57:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4678B20803;
        Tue,  3 Dec 2019 22:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413842;
        bh=6l1wOmolfxD+j5KIMvG2dSSOaGeCOOsN1zc9qmVWZzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SLTrLfQ71lOQsViVlt+YdEhye4RjsPnqa/R5ox+cNoBDzFkTlyylq1KeonA6Rqnap
         wzQqAXYzDAaqoLySbyTu7sQ+PSHcZVnkWjxHJ/nYMh0zUblOb8CC4fOT1LAc39sHaV
         xW6HGXrA4H7kqzhqkTQXzq3TnGZ9Tuc4qZXEFjac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lijun Ou <oulijun@huawei.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 256/321] RDMA/hns: Bugfix for the scene without receiver queue
Date:   Tue,  3 Dec 2019 23:35:22 +0100
Message-Id: <20191203223440.452689729@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

[ Upstream commit 4d103905eb1e4f14cb62fcf962c9d35da7005dea ]

In some application scenario, the user could not have receive queue when
run rdma write or read operation.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 54d22868ffba5..af24698ff2262 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -522,7 +522,8 @@ static int hns_roce_qp_has_sq(struct ib_qp_init_attr *attr)
 static int hns_roce_qp_has_rq(struct ib_qp_init_attr *attr)
 {
 	if (attr->qp_type == IB_QPT_XRC_INI ||
-	    attr->qp_type == IB_QPT_XRC_TGT || attr->srq)
+	    attr->qp_type == IB_QPT_XRC_TGT || attr->srq ||
+	    !attr->cap.max_recv_wr)
 		return 0;
 
 	return 1;
-- 
2.20.1



