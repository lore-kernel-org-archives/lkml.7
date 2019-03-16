Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0C5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC26620857
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfCPW5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:57:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39987 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfCPW5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 18:57:14 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h5IEn-000841-Jv; Sat, 16 Mar 2019 22:57:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        David Ahern <dsahern@gmail.com>, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: libcxgbi: remove uninitialized variable len
Date:   Sat, 16 Mar 2019 22:57:09 +0000
Message-Id: <20190316225709.8630-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
function.  This allows len to be removed.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/cxgbi/libcxgbi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
index 006372b3fba2..1d9115484503 100644
--- a/drivers/scsi/cxgbi/libcxgbi.c
+++ b/drivers/scsi/cxgbi/libcxgbi.c
@@ -2310,7 +2310,6 @@ int cxgbi_get_ep_param(struct iscsi_endpoint *ep, enum iscsi_param param,
 {
 	struct cxgbi_endpoint *cep = ep->dd_data;
 	struct cxgbi_sock *csk;
-	int len;
 
 	log_debug(1 << CXGBI_DBG_ISCSI,
 		"cls_conn 0x%p, param %d.\n", ep, param);
@@ -2328,9 +2327,9 @@ int cxgbi_get_ep_param(struct iscsi_endpoint *ep, enum iscsi_param param,
 		return iscsi_conn_get_addr_param((struct sockaddr_storage *)
 						 &csk->daddr, param, buf);
 	default:
-		return -ENOSYS;
+		break;
 	}
-	return len;
+	return -ENOSYS;
 }
 EXPORT_SYMBOL_GPL(cxgbi_get_ep_param);
 
-- 
2.20.1

