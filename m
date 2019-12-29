Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7951EC2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB6321744
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642206;
	bh=ZMqCIdRgmDagksk5OjgQOF9UYnHcAGns2/yanPaNiiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rAk8DdnUgCMWz/xwTT+ZBsJ1YRF28qvrY16i4wj/8ZUFeo9xF31p18Eo7xbEhxakA
	 WEIx/FDG+QKNu3LVIuNjIZONjrnUojjp3Y8h6mVMv3Z17loebbSIbwT5zKF18gj2Qx
	 +fxu/vNlzdsF0lYQ7Wfji0YdIYENEsxSML9aXVDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbfL2R4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:56:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733101AbfL2R4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:56:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96794206DB;
        Sun, 29 Dec 2019 17:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642199;
        bh=ZMqCIdRgmDagksk5OjgQOF9UYnHcAGns2/yanPaNiiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YY21ce567GaPhYPgRBlnig+s3A3OMD6OGKrGsyZgp0oNok8kbDKZuouNNjEfQAo3w
         q9JL5AKaQRroPwW9T05T/48y3SnRUrWc0FrSzY0EuWnt2rUDHdnbFXSwefGC2qnQhE
         wnFoBa348p3W8pqtQAOZI+ZaNhqyvTc6Fv0EnhPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 384/434] RDMA/siw: Fix post_recv QP state locking
Date:   Sun, 29 Dec 2019 18:27:17 +0100
Message-Id: <20191229172727.687648782@linuxfoundation.org>
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

From: Bernard Metzler <bmt@zurich.ibm.com>

[ Upstream commit 0edefddbae396e50eb7887d279d0c4bb4d7a6384 ]

Do not release qp state lock if not previously acquired.

Fixes: cf049bb31f71 ("RDMA/siw: Fix SQ/RQ drain logic")
Link: https://lore.kernel.org/r/20191025142903.20625-1-bmt@zurich.ibm.com
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/siw/siw_verbs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 7d0a7edc533d..1b1a40db529c 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -988,7 +988,6 @@ int siw_post_receive(struct ib_qp *base_qp, const struct ib_recv_wr *wr,
 	}
 	if (!qp->kernel_verbs) {
 		siw_dbg_qp(qp, "no kernel post_recv for user mapped sq\n");
-		up_read(&qp->state_lock);
 		*bad_wr = wr;
 		return -EINVAL;
 	}
-- 
2.20.1



