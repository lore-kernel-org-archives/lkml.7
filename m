Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E540CC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8882087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329153;
	bh=ZfP2TMa7kvJtTP2fFhbC5LKAcue4ZDyPmf4k3VaIYIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZgnAaP4JsW6sN9mefry/TbJ2+J3WbGczGNnXdXImXoBqXIDxNMSqzEers1lwlHRvp
	 iw/MRJ4oz7CD/XH4vBg9C2F4ptPvU8uMqFK9gJcpWMzdB7yJxTr7j2kEli29RkSwma
	 6iJSyh2eG8ttlnB2lidVJxWFg6FRUuZ+LA7nUdpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfD0BjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbfD0BjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A77AE208CA;
        Sat, 27 Apr 2019 01:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329150;
        bh=ZfP2TMa7kvJtTP2fFhbC5LKAcue4ZDyPmf4k3VaIYIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tdWjhgOL9T1vghitvNqNgKNqi9Quclrnizamc4WGkH6r5xvhNfjtYaWxJKZ3Gpxl7
         dZ/ad3lVdauH3Cm19W+2ij59KvzRVkqZR07Xw2YqHdg1bi2haf+pE9bwYbu8NwYd9p
         fvVHK6hP0ZsqTT9/0uRLegVI5TmdIUN97vqXRYx8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kaike Wan <kaike.wan@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 25/79] IB/hfi1: Eliminate opcode tests on mr deref
Date:   Fri, 26 Apr 2019 21:37:44 -0400
Message-Id: <20190427013838.6596-25-sashal@kernel.org>
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

From: Kaike Wan <kaike.wan@intel.com>

[ Upstream commit a8639a79e85c18c16c10089edd589c7948f19bbd ]

When an old ack_queue entry is used to store an incoming request, it may
need to clean up the old entry if it is still referencing the
MR. Originally only RDMA READ request needed to reference MR on the
responder side and therefore the opcode was tested when cleaning up the
old entry. The introduction of tid rdma specific operations in the
ack_queue makes the specific opcode tests wrong.  Multiple opcodes (RDMA
READ, TID RDMA READ, and TID RDMA WRITE) may need MR ref cleanup.

Remove the opcode specific tests associated with the ack_queue.

Fixes: f48ad614c100 ("IB/hfi1: Move driver out of staging")
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/rc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
index be603f35d7e4..cfde43b1df96 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -2302,7 +2302,7 @@ send_last:
 			update_ack_queue(qp, next);
 		}
 		e = &qp->s_ack_queue[qp->r_head_ack_queue];
-		if (e->opcode == OP(RDMA_READ_REQUEST) && e->rdma_sge.mr) {
+		if (e->rdma_sge.mr) {
 			rvt_put_mr(e->rdma_sge.mr);
 			e->rdma_sge.mr = NULL;
 		}
@@ -2376,7 +2376,7 @@ send_last:
 			update_ack_queue(qp, next);
 		}
 		e = &qp->s_ack_queue[qp->r_head_ack_queue];
-		if (e->opcode == OP(RDMA_READ_REQUEST) && e->rdma_sge.mr) {
+		if (e->rdma_sge.mr) {
 			rvt_put_mr(e->rdma_sge.mr);
 			e->rdma_sge.mr = NULL;
 		}
-- 
2.19.1

