Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1729C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2F120679
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330134;
	bh=OCnH7WOWAgQ9SOfDI03xifZW0Gp9lxA6GJuyAqvUtKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=so58qMB5xGPqgBN7C1SGCTeYbWeQp3rLxuIjOnuXcHBs8BG4p5LLA3Vyow667xmf6
	 TbdWsNvHPD3E9zWpdYmk2lUE4HHi42YlVjv4S3hI+kbZi33CE/SA+fbqnt45wiwObw
	 CZnrCXJ2QHzyzMrXwsp4iNVREWS+AkZC66KMISNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfD0BjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbfD0BjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F3142087C;
        Sat, 27 Apr 2019 01:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329149;
        bh=OCnH7WOWAgQ9SOfDI03xifZW0Gp9lxA6GJuyAqvUtKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ubhTfIOiLiAYi6+3j8kwThZJ9yz0tbQ4fegqi6vfHMQGZ/Z7Lv5/vnz723gfuzVBe
         5xEl4GNE6W725/WCbOVwiAbDF7z6SHnyv/IIPWabeMQ8xkoA6xv+03+7fj+l6Mipnk
         ApRX+IjarcI5IriWKHANmAAEMPG407NoB4/Nwf8k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 24/79] IB/hfi1: Clear the IOWAIT pending bits when QP is put into error state
Date:   Fri, 26 Apr 2019 21:37:43 -0400
Message-Id: <20190427013838.6596-24-sashal@kernel.org>
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
index 5866f358ea04..df8e812804b3 100644
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
2.19.1

