Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8ECC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5268B2166E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999896;
	bh=sSCbBY9onOkZJNP/mDXIjY0gRF+zB9DFt+Wo8eVglXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M1nWdiLlh1muygYGpU7xwJ5erUyPxDfxHlIrC2sZrZMTCXvi/JRkUh2TdaqCfJhJD
	 pa2rkBRbq26m9KAGwbgC7Uh8jvT5FlrkrUYN9FPv7vhadbhSBX0HHzcs3bbVFDEby3
	 d0m1LxIU/0jC0Z6y4CR98A/4kCRReavm1YlwYzrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390401AbfGXUYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389621AbfGXTkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:40:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90D4E214AF;
        Wed, 24 Jul 2019 19:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997218;
        bh=sSCbBY9onOkZJNP/mDXIjY0gRF+zB9DFt+Wo8eVglXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jqCQF3SYNjM7l5hIF1wPdbrFT6uOYSEr3cT5dBY5LokaOYbt81XfveFW3gXmQ63RJ
         Qyw0cir3jvAW+5rn1JL0qr0nOr3q+iSLCWHar2fc9EQMUIu16gxJtp3895qoPOmruc
         hckltKNWsZm/337/fzShTMDgLc9v0hNbo4NRnGLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 5.2 362/413] RDMA/odp: Fix missed unlock in non-blocking invalidate_start
Date:   Wed, 24 Jul 2019 21:20:53 +0200
Message-Id: <20190724191801.425499375@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

commit 7608bf40cf2480057ec0da31456cc428791c32ef upstream.

If invalidate_start returns with EAGAIN then the umem_rwsem needs to be
unlocked as no invalidate_end will be called.

Cc: <stable@vger.kernel.org>
Fixes: ca748c39ea3f ("RDMA/umem: Get rid of per_mm->notifier_count")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/umem_odp.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -151,6 +151,7 @@ static int ib_umem_notifier_invalidate_r
 {
 	struct ib_ucontext_per_mm *per_mm =
 		container_of(mn, struct ib_ucontext_per_mm, mn);
+	int rc;
 
 	if (mmu_notifier_range_blockable(range))
 		down_read(&per_mm->umem_rwsem);
@@ -167,11 +168,14 @@ static int ib_umem_notifier_invalidate_r
 		return 0;
 	}
 
-	return rbt_ib_umem_for_each_in_range(&per_mm->umem_tree, range->start,
-					     range->end,
-					     invalidate_range_start_trampoline,
-					     mmu_notifier_range_blockable(range),
-					     NULL);
+	rc = rbt_ib_umem_for_each_in_range(&per_mm->umem_tree, range->start,
+					   range->end,
+					   invalidate_range_start_trampoline,
+					   mmu_notifier_range_blockable(range),
+					   NULL);
+	if (rc)
+		up_read(&per_mm->umem_rwsem);
+	return rc;
 }
 
 static int invalidate_range_end_trampoline(struct ib_umem_odp *item, u64 start,


