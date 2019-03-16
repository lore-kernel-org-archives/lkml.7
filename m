Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562B0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 23:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CEBC2186A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 23:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfCPXFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 19:05:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40076 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfCPXFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 19:05:19 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h5IMb-0008Nf-1V; Sat, 16 Mar 2019 23:05:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IB/iser: remove uninitialized variable len
Date:   Sat, 16 Mar 2019 23:05:12 +0000
Message-Id: <20190316230512.8933-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable len is not being inintialized and the uninitialized
value is being returned. However, this return path is never reached
because the default case in the switch statement returns -ENOSYS.
Clean up the code by replacing the return -ENOSYS with a break
for the default case and returning -ENOSYS at the end of the
function.  This allows len to be removed.  Also remove redundant
break that follows a return statement.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 8c707accd148..9c185a8dabd3 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -763,7 +763,6 @@ static int iscsi_iser_get_ep_param(struct iscsi_endpoint *ep,
 				   enum iscsi_param param, char *buf)
 {
 	struct iser_conn *iser_conn = ep->dd_data;
-	int len;
 
 	switch (param) {
 	case ISCSI_PARAM_CONN_PORT:
@@ -774,12 +773,10 @@ static int iscsi_iser_get_ep_param(struct iscsi_endpoint *ep,
 		return iscsi_conn_get_addr_param((struct sockaddr_storage *)
 				&iser_conn->ib_conn.cma_id->route.addr.dst_addr,
 				param, buf);
-		break;
 	default:
-		return -ENOSYS;
+		break;
 	}
-
-	return len;
+	return -ENOSYS;
 }
 
 /**
-- 
2.20.1

