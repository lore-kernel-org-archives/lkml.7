Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5676C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA79A21848
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427885;
	bh=DLBaHWJ8etHMqED68yOHHGboeI4028t2Fw312XqA0pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kxapZwO4FQChjuW/iPMNXuGYnWo0K2M9ofuxvxx4xn9ImF8GAu5X3YSK83ydWA8hO
	 9OvZcew6cbOWZInMCTr56VnYoGVFHiSVcS8c61n5+Fp2xy4JHOhhD82RIXg9zrxOjf
	 CzXGNml0dpQVJUYG6uNwUtlFTxOg+8WHCNctinPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfEISvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfEISvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:51:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37F3F20578;
        Thu,  9 May 2019 18:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427877;
        bh=DLBaHWJ8etHMqED68yOHHGboeI4028t2Fw312XqA0pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D29CJDxpFIDDw/RjFeylPAkiH2HmwUqxMEzYrCqJBuidu4KGpmG5aKs4anHAMBBRE
         7++h1vDpLcOMLycnylIZmvxvF0U7oDWi5Z4AXYNWBNb44q81YDHXdHl9hK1YmSyTCy
         YdsLyG4ear+U6N2WrHzI/TFY0rgWJwvV67A/6GCQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Alex Estrin <alex.estrin@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 30/95] IB/hfi1: Clear the IOWAIT pending bits when QP is put into error state
Date:   Thu,  9 May 2019 20:41:47 +0200
Message-Id: <20190509181311.409753392@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181309.180685671@linuxfoundation.org>
References: <20190509181309.180685671@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 93b289b9aff66eca7575b09f36f5abbeca8e6167 ]

When a QP is put into error state, it may be waiting for send engine
resources. In this case, the QP will be removed from the send engine's
waiting list, but its IOWAIT pending bits are not cleared. This will
normally not have any major impact as the QP is being destroyed.  However,
the QP still needs to wind down its operations, such as draining the send
queue by scheduling the send engine. Clearing the pending bits will avoid
any potential complications. In addition, if the QP will eventually hang,
clearing the pending bits can help debugging by presenting a consistent
picture if the user dumps the qp_stats.

This patch clears a QP's IOWAIT_PENDING_IB and IO_PENDING_TID bits in
priv->s_iowait.flags in this case.

Fixes: 5da0fc9dbf89 ("IB/hfi1: Prepare resource waits for dual leg")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Alex Estrin <alex.estrin@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/qp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/qp.c b/drivers/infiniband/hw/hfi1/qp.c
index 5866f358ea044..df8e812804b34 100644
--- a/drivers/infiniband/hw/hfi1/qp.c
+++ b/drivers/infiniband/hw/hfi1/qp.c
@@ -834,6 +834,8 @@ void notify_error_qp(struct rvt_qp *qp)
 		if (!list_empty(&priv->s_iowait.list) &&
 		    !(qp->s_flags & RVT_S_BUSY)) {
 			qp->s_flags &= ~HFI1_S_ANY_WAIT_IO;
+			iowait_clear_flag(&priv->s_iowait, IOWAIT_PENDING_IB);
+			iowait_clear_flag(&priv->s_iowait, IOWAIT_PENDING_TID);
 			list_del_init(&priv->s_iowait.list);
 			priv->s_iowait.lock = NULL;
 			rvt_put_qp(qp);
-- 
2.20.1



