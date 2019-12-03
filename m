Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45537C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159792053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413646;
	bh=xsYVwr7Zh3Sl5HxMv2r9Twf7jo7heLrCDCLKr2yFn9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZYs335gVBmpnc3r46ZaypxJ3hv/pR6YNAUoPHnx8Lmgg7FSL5ouRcb59Us9x3Vo+i
	 3L4uVmYgfbVETfMF+hzSVt8+7saFPLhUXC4G6wCHBfrba91QVqgF1sD4y8Z5ptroe3
	 lOlp4m4G5PLL8K/rQH+CY25dYG+smp8iN7WspUsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbfLCWyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:54:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730104AbfLCWyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:54:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B19320863;
        Tue,  3 Dec 2019 22:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413642;
        bh=xsYVwr7Zh3Sl5HxMv2r9Twf7jo7heLrCDCLKr2yFn9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMi+vXBYlhbpdtFduyKL9KuDM5Pc4DRFrBi6kiNdkCNOvzWIXe276HKHFS3OPfYbo
         jsqzsyCIwDA7a+erv1JwxhB8l727U5PvlQZJeCA3xUIKDV6siUl+AGnEak80u2nrMc
         7gD5KxlGltCUhrEJlldkcpFmOZK/SLKpqTx0HM9c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 205/321] infiniband/qedr: Potential null ptr dereference of qp
Date:   Tue,  3 Dec 2019 23:34:31 +0100
Message-Id: <20191203223437.785719304@linuxfoundation.org>
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

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 9c6260de505b63638dd86fcc33849b17f6146d94 ]

idr_find() may fail and return a NULL pointer. The fix checks the return
value of the function and returns an error in case of NULL.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Acked-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/qedr/qedr_iw_cm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
index 505fa36487629..93b16237b7677 100644
--- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
@@ -492,6 +492,8 @@ int qedr_iw_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 	int i;
 
 	qp = idr_find(&dev->qpidr.idr, conn_param->qpn);
+	if (unlikely(!qp))
+		return -EINVAL;
 
 	laddr = (struct sockaddr_in *)&cm_id->m_local_addr;
 	raddr = (struct sockaddr_in *)&cm_id->m_remote_addr;
-- 
2.20.1



