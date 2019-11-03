Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F4CCA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 11:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B908020679
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 11:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k2UFyBNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfKCLkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 06:40:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfKCLkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 06:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XkmRPUeClc7nYwmMTVch/YYfTYfzG+tL2jIbHBdAbug=; b=k2UFyBNO9lQmQ4PtZ2UmuS0oIa
        waVp7M57NalvnM06boakfBuF48Dlke19XeUxonB7qd/6mYtMSgl06r0xfmFDoaEl0mkF7VpBX0gpe
        b5eAJxNGLAFiANN8RcQ40207KGf5bdDgMWXhHavSU5kF+uQjlc0wFqaPAiyX8Y235awfwBMrR3SsB
        5r0/FVqH5HaNDfvQgJdmAOzIMVB1EDdiFbo7v7Z/6fkHQxd/70ZIRZk6tlH3GVi0FO+U+P3RaOGhG
        raJxplfEwD2UiDKjfmm19BiPyAO04Vv38XYh+WiT6IrIJ2To00WIGJvrVV611QeTq8hI+4YkTlxZK
        QXpvJMpg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iREEz-0007q5-Lf; Sun, 03 Nov 2019 11:40:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 2/5] idr: Fix idr_get_next_ul race with idr_remove
Date:   Sun,  3 Nov 2019 03:40:08 -0800
Message-Id: <20191103114012.30027-3-willy@infradead.org>
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

Commit 5c089fd0c734 ("idr: Fix idr_get_next race with idr_remove")
neglected to fix idr_get_next_ul().  As far as I can tell, nobody's
actually using this interface under the RCU read lock, but fix it now
before anybody decides to use it.

Fixes: 5c089fd0c734 ("idr: Fix idr_get_next race with idr_remove")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 lib/idr.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/lib/idr.c b/lib/idr.c
index 66a374892482..c2cf2c52bbde 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -215,7 +215,7 @@ int idr_for_each(const struct idr *idr,
 EXPORT_SYMBOL(idr_for_each);
 
 /**
- * idr_get_next() - Find next populated entry.
+ * idr_get_next_ul() - Find next populated entry.
  * @idr: IDR handle.
  * @nextid: Pointer to an ID.
  *
@@ -224,7 +224,7 @@ EXPORT_SYMBOL(idr_for_each);
  * to the ID of the found value.  To use in a loop, the value pointed to by
  * nextid must be incremented by the user.
  */
-void *idr_get_next(struct idr *idr, int *nextid)
+void *idr_get_next_ul(struct idr *idr, unsigned long *nextid)
 {
 	struct radix_tree_iter iter;
 	void __rcu **slot;
@@ -245,18 +245,14 @@ void *idr_get_next(struct idr *idr, int *nextid)
 	}
 	if (!slot)
 		return NULL;
-	id = iter.index + base;
-
-	if (WARN_ON_ONCE(id > INT_MAX))
-		return NULL;
 
-	*nextid = id;
+	*nextid = iter.index + base;
 	return entry;
 }
-EXPORT_SYMBOL(idr_get_next);
+EXPORT_SYMBOL(idr_get_next_ul);
 
 /**
- * idr_get_next_ul() - Find next populated entry.
+ * idr_get_next() - Find next populated entry.
  * @idr: IDR handle.
  * @nextid: Pointer to an ID.
  *
@@ -265,22 +261,17 @@ EXPORT_SYMBOL(idr_get_next);
  * to the ID of the found value.  To use in a loop, the value pointed to by
  * nextid must be incremented by the user.
  */
-void *idr_get_next_ul(struct idr *idr, unsigned long *nextid)
+void *idr_get_next(struct idr *idr, int *nextid)
 {
-	struct radix_tree_iter iter;
-	void __rcu **slot;
-	unsigned long base = idr->idr_base;
 	unsigned long id = *nextid;
+	void *entry = idr_get_next_ul(idr, &id);
 
-	id = (id < base) ? 0 : id - base;
-	slot = radix_tree_iter_find(&idr->idr_rt, &iter, id);
-	if (!slot)
+	if (WARN_ON_ONCE(id > INT_MAX))
 		return NULL;
-
-	*nextid = iter.index + base;
-	return rcu_dereference_raw(*slot);
+	*nextid = id;
+	return entry;
 }
-EXPORT_SYMBOL(idr_get_next_ul);
+EXPORT_SYMBOL(idr_get_next);
 
 /**
  * idr_replace() - replace pointer for given ID.
-- 
2.24.0.rc1

