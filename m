Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E82C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E2C20645
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfB1Wix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:38:53 -0500
Received: from rio.cs.utah.edu ([155.98.64.241]:34773 "EHLO
        mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfB1Wix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:38:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail-svr1.cs.utah.edu (Postfix) with ESMTP id 3F2006500C6;
        Thu, 28 Feb 2019 15:38:52 -0700 (MST)
Received: from mail-svr1.cs.utah.edu ([127.0.0.1])
        by localhost (mail-svr1.cs.utah.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PtqDExzs9JsC; Thu, 28 Feb 2019 15:38:51 -0700 (MST)
Received: from node-10.av-cluster.smack.emulab.net (pc845.emulab.net [155.98.36.145])
        by smtps.cs.utah.edu (Postfix) with ESMTPSA id BE01F6500C0;
        Thu, 28 Feb 2019 15:38:51 -0700 (MST)
From:   Shaobo He <shaobo@cs.utah.edu>
To:     linux-rdma@vger.kernel.org
Cc:     shaobo@cs.utah.edu, Steve Wise <swise@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] cxgb4: fix undefined behavior in mem.c
Date:   Thu, 28 Feb 2019 15:38:38 -0700
Message-Id: <1551393519-96595-1-git-send-email-shaobo@cs.utah.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function `c4iw_dealloc_mw`, variable mhp's value is printed after
freed, which triggers undefined behavior according to this post:
https://trust-in-soft.com/dangling-pointer-indeterminate/.

This commit fixes it by swapping the order of `kfree` and `pr_debug`.

Signed-off-by: Shaobo He <shaobo@cs.utah.edu>
---
 drivers/infiniband/hw/cxgb4/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index 7b76e6f..bb8e0bc 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -684,8 +684,8 @@ int c4iw_dealloc_mw(struct ib_mw *mw)
 			  mhp->wr_waitp);
 	kfree_skb(mhp->dereg_skb);
 	c4iw_put_wr_wait(mhp->wr_waitp);
-	kfree(mhp);
 	pr_debug("ib_mw %p mmid 0x%x ptr %p\n", mw, mmid, mhp);
+	kfree(mhp);
 	return 0;
 }
 
-- 
2.7.4

