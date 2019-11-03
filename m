Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E401CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 11:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05D521744
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 11:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Avnfl6fi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfKCLkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 06:40:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfKCLkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 06:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QZwbIl32wtdb1hDy/RfILml4N68pdoZTulXrSI8X8Dc=; b=Avnfl6fiqTFPsByn0fcSNgCfwN
        uSS6E5387BSOiQc6fLoxHOgmWl8fq170+6g410ZiHSh7bvW00eOsTiv9JHwfd63gHj6RCgkHpHmLp
        GXf5O8v+in5r53xK4ITIx1MvSNE0ImAxkxXrlwOdnmx5tyVWtclVokMU1UY7zl4pLc0yIlDyb4GNu
        6LymXMmbchsWjPYmkvdokwisQqO4MX5CHtmmSH+uH6l+/wcSGBG1mURWfOz+2wG86cRCbOiVJTHqt
        GnyNB1CCjTcP1pjmt4zrG4rmjCvvU5tJMTOI20FTW/8XmELPnM8yVrHN4/mDsq46JFILtHcCYqYDX
        9C7YyYmA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iREEz-0007qC-Mr; Sun, 03 Nov 2019 11:40:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 3/5] radix tree: Remove radix_tree_iter_find
Date:   Sun,  3 Nov 2019 03:40:09 -0800
Message-Id: <20191103114012.30027-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191103114012.30027-1-willy@infradead.org>
References: <20191103114012.30027-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This API is unsafe to use under the RCU lock.  With no in-tree users
remaining, remove it to prevent future bugs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/radix-tree.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index b5116013f27e..63e62372443a 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -315,24 +315,6 @@ radix_tree_iter_lookup(const struct radix_tree_root *root,
 	return radix_tree_next_chunk(root, iter, RADIX_TREE_ITER_CONTIG);
 }
 
-/**
- * radix_tree_iter_find - find a present entry
- * @root: radix tree root
- * @iter: iterator state
- * @index: start location
- *
- * This function returns the slot containing the entry with the lowest index
- * which is at least @index.  If @index is larger than any present entry, this
- * function returns NULL.  The @iter is updated to describe the entry found.
- */
-static inline void __rcu **
-radix_tree_iter_find(const struct radix_tree_root *root,
-			struct radix_tree_iter *iter, unsigned long index)
-{
-	radix_tree_iter_init(iter, index);
-	return radix_tree_next_chunk(root, iter, 0);
-}
-
 /**
  * radix_tree_iter_retry - retry this chunk of the iteration
  * @iter:	iterator state
-- 
2.24.0.rc1

