Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396B2C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053D22070D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfDINi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:38:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56062 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDINi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:38:27 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hDqx9-0000Jq-Et; Tue, 09 Apr 2019 13:38:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Karen Xie <kxie@chelsio.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: cxgbi: remove redundant __kfree_skb call on skb
Date:   Tue,  9 Apr 2019 14:38:19 +0100
Message-Id: <20190409133819.21127-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The error return path via label rel_resource checks for a non-null
skb before free'ing it.  However, skb is always null at this exit
path, so the null check and the free are redundant and can be removed.
Removing this allows the original goto's to rel_resource to be cleaned
up; the first can be replaced by a return of -EINVAL, the second can
be replaced by a more appropriate -ENOMEM return since allow_wr has
failed go allocate some memory.

Addresses-Coverity: ("Logically Dead Code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
index 75e1273a44b3..5a4387f437d5 100644
--- a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
+++ b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
@@ -979,14 +979,14 @@ static int init_act_open(struct cxgbi_sock *csk)
 	csk->atid = cxgb3_alloc_atid(t3dev, &t3_client, csk);
 	if (csk->atid < 0) {
 		pr_err("NO atid available.\n");
-		goto rel_resource;
+		return -EINVAL;
 	}
 	cxgbi_sock_set_flag(csk, CTPF_HAS_ATID);
 	cxgbi_sock_get(csk);
 
 	skb = alloc_wr(sizeof(struct cpl_act_open_req), 0, GFP_KERNEL);
 	if (!skb)
-		goto rel_resource;
+		return -ENOMEM;
 	skb->sk = (struct sock *)csk;
 	set_arp_failure_handler(skb, act_open_arp_failure);
 	csk->snd_win = cxgb3i_snd_win;
@@ -1007,11 +1007,6 @@ static int init_act_open(struct cxgbi_sock *csk)
 	cxgbi_sock_set_state(csk, CTP_ACTIVE_OPEN);
 	send_act_open_req(csk, skb, csk->l2t);
 	return 0;
-
-rel_resource:
-	if (skb)
-		__kfree_skb(skb);
-	return -EINVAL;
 }
 
 cxgb3_cpl_handler_func cxgb3i_cpl_handlers[NUM_CPL_CMDS] = {
-- 
2.20.1

