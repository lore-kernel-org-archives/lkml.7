Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E971C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC11205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429307;
	bh=aXTNYNIyaT6qWmrNe0sCrE7qPboJ4pAnGLUhMH6uORQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cgrj5u6+PUdyP0aX3sc0/RDpKYTgYx2D7knHquCqBfK9w7VcIEZXAVVTB4hwS5Iav
	 Bz5G9qWrgPOGpL17NqdRrEcnvpjtvJbo5uj/9XArN6iPRZuta8zU4ThYLbVncmM7L1
	 qXVsFR8G82bNTlnJzE+bdsu1vygcjjneCyL9Qc+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389410AbfG2Tlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388898AbfG2Tlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:41:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 230152054F;
        Mon, 29 Jul 2019 19:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429303;
        bh=aXTNYNIyaT6qWmrNe0sCrE7qPboJ4pAnGLUhMH6uORQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fUdnrC5gg+IKPCTeG8XeIfS5BMPp2M+ei+CwDhaxecVmzkzFUhUL1jClu8TtEPBA7
         QF0AhXiUyU6IM6KFsljkFT1+3eMU/oQSuuETJEVfG1Xck2e9SWTjYXVttbe31oQxXj
         xQxeFKS+8HQXOM9jMdpAMYXGcx+Of+Ffg0SB2eiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Changcheng Liu <changcheng.liu@aliyun.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 055/113] RDMA/i40iw: Set queue pair state when being queried
Date:   Mon, 29 Jul 2019 21:22:22 +0200
Message-Id: <20190729190708.653913965@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2e67e775845373905d2c2aecb9062c2c4352a535 ]

The API for ib_query_qp requires the driver to set qp_state and
cur_qp_state on return, add the missing sets.

Fixes: d37498417947 ("i40iw: add files for iwarp interface")
Signed-off-by: Changcheng Liu <changcheng.liu@aliyun.com>
Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index e2e6c74a7452..a5e3349b8a7c 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -806,6 +806,8 @@ static int i40iw_query_qp(struct ib_qp *ibqp,
 	struct i40iw_qp *iwqp = to_iwqp(ibqp);
 	struct i40iw_sc_qp *qp = &iwqp->sc_qp;
 
+	attr->qp_state = iwqp->ibqp_state;
+	attr->cur_qp_state = attr->qp_state;
 	attr->qp_access_flags = 0;
 	attr->cap.max_send_wr = qp->qp_uk.sq_size;
 	attr->cap.max_recv_wr = qp->qp_uk.rq_size;
-- 
2.20.1



