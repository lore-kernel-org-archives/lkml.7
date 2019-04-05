Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8470C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985D021850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbfDELW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:22:58 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:7010 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730642AbfDELW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:22:58 -0400
X-IronPort-AV: E=Sophos;i="5.60,312,1549909800"; 
   d="scan'208";a="405517"
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Apr 2019 16:51:10 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9217"; a="8432704"
Received: from gkohli-linux.qualcomm.com ([10.204.78.26])
  by ironmsg01-blr.qualcomm.com with ESMTP; 05 Apr 2019 16:51:10 +0530
Received: by gkohli-linux.qualcomm.com (Postfix, from userid 427023)
        id EC9AE3BB0; Fri,  5 Apr 2019 16:51:08 +0530 (IST)
From:   Gaurav Kohli <gkohli@codeaurora.org>
To:     gregkh@linuxfoundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Gaurav Kohli <gkohli@codeaurora.org>,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH v0] kernfs: Skip kernfs_put of parent from child node
Date:   Fri,  5 Apr 2019 16:51:07 +0530
Message-Id: <1554463267-30841-1-git-send-email-gkohli@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While adding kernfs node for child to the parent kernfs
node and when child node founds that parent kn count is
zero, then below comes like:

WARNING: fs/kernfs/dir.c:494 kernfs_get+0x64/0x88

This indicates that parent is in kernfs_put path/ or already
freed, and if the child node keeps continue to
make new kernfs node, then there is chance of
below race for parent node:

CPU0				         CPU1
//Parent node			         //child node
kernfs_put
atomic_dec_and_test(&kn->count)
//count is 0, so continue
					  kernfs_new_node(child)
					  kernfs_get(parent);
					  //increment parent count to 1
					  //warning come as parent count is 0
					  /* link in */
					  kernfs_add_one(kn);
					  // this should fail as parent is
					  //in free path.
					  kernfs_put(child)
kmem_cache_free(parent)
					  kmem_cache_free(child)
					  kn = parent
					  atomic_dec_and_test(&kn->count))
					  //this is 0 now, so release will
					  continue for parent.
					  kmem_cache_free(parent)

To prevent this race, child simply has to decrement count of parent
kernfs node and keep continue the free path for itself.

Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index b84d635..d5a36e8 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -515,7 +515,6 @@ void kernfs_put(struct kernfs_node *kn)
 	if (!kn || !atomic_dec_and_test(&kn->count))
 		return;
 	root = kernfs_root(kn);
- repeat:
 	/*
 	 * Moving/renaming is always done while holding reference.
 	 * kn->parent won't change beneath us.
@@ -545,8 +544,8 @@ void kernfs_put(struct kernfs_node *kn)
 
 	kn = parent;
 	if (kn) {
-		if (atomic_dec_and_test(&kn->count))
-			goto repeat;
+	/* Parent may be on free path, so simply decrement the count */
+		atomic_dec_and_test(&kn->count);
 	} else {
 		/* just released the root kn, free @root too */
 		idr_destroy(&root->ino_idr);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

