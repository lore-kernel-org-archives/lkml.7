Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D90DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AB1208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142902;
	bh=gjsQgDA0Yi/U7t3UzquNBahrZVVvipDwiouj+8LHZNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=duMyi5itBruCSkRUdLkzeajmZQJji2IIUGE2zJOcuZCiZ1rV2Y5vGdNrFEfXaVU9Y
	 WemPYm3XJuSxydjYAUn2/gS+993cCxGBd2m2Uk6ga7oMBbxIdRuXiBDnZYehVO24Qo
	 1oZTKcnFcydTUolzJwv7VKuRMwch394dLOJvGbYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbfKSFzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:55:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732208AbfKSFyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:54:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD52D208C3;
        Tue, 19 Nov 2019 05:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142894;
        bh=gjsQgDA0Yi/U7t3UzquNBahrZVVvipDwiouj+8LHZNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D9iNbw9rCb+GViCLLwqsAYyd9DzEwd1vVXaar2fTGZl6K4/ejQO+cUeTOqzgie12s
         8Kzkq6CDgPXSIQYBTpf1rkPq3G7clMWfct8mINXyPaaoACaYYuoI5lUGh4ouQE0dgU
         GyAuM9GmmYXKACFCLNhGhZvUqlTwMcB1gwuzP6EM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Israel Rukshin <israelr@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 237/239] IB/iser: Fix possible NULL deref at iser_inv_desc()
Date:   Tue, 19 Nov 2019 06:20:37 +0100
Message-Id: <20191119051342.699396217@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

[ Upstream commit 65f07f5a09dacf3b60619f196f096ea3671a5eda ]

In case target remote invalidates bogus rkey and signature is not used,
pi_ctx is NULL deref.

The commit also fails the connection on bogus remote invalidation.

Fixes: 59caaed7a72a ("IB/iser: Support the remote invalidation exception")
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/iser/iser_initiator.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index 2a07692007bdd..a126750b65a92 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -592,13 +592,19 @@ void iser_login_rsp(struct ib_cq *cq, struct ib_wc *wc)
 	ib_conn->post_recv_buf_count--;
 }
 
-static inline void
+static inline int
 iser_inv_desc(struct iser_fr_desc *desc, u32 rkey)
 {
-	if (likely(rkey == desc->rsc.mr->rkey))
+	if (likely(rkey == desc->rsc.mr->rkey)) {
 		desc->rsc.mr_valid = 0;
-	else if (likely(rkey == desc->pi_ctx->sig_mr->rkey))
+	} else if (likely(desc->pi_ctx && rkey == desc->pi_ctx->sig_mr->rkey)) {
 		desc->pi_ctx->sig_mr_valid = 0;
+	} else {
+		iser_err("Bogus remote invalidation for rkey %#x\n", rkey);
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
 static int
@@ -626,12 +632,14 @@ iser_check_remote_inv(struct iser_conn *iser_conn,
 
 			if (iser_task->dir[ISER_DIR_IN]) {
 				desc = iser_task->rdma_reg[ISER_DIR_IN].mem_h;
-				iser_inv_desc(desc, rkey);
+				if (unlikely(iser_inv_desc(desc, rkey)))
+					return -EINVAL;
 			}
 
 			if (iser_task->dir[ISER_DIR_OUT]) {
 				desc = iser_task->rdma_reg[ISER_DIR_OUT].mem_h;
-				iser_inv_desc(desc, rkey);
+				if (unlikely(iser_inv_desc(desc, rkey)))
+					return -EINVAL;
 			}
 		} else {
 			iser_err("failed to get task for itt=%d\n", hdr->itt);
-- 
2.20.1



