Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C25C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7F7229F3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MENHCNXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfGZVBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:01:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfGZVBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6TrgjAhO6ZAK/fo21aoT5+j5KScnfYl+8cYDqaqsMh4=; b=MENHCNXh0hqrsob3hlt+d00qB
        nfM0JF+kMfPyZ5JVbURsrT+IVJrWngwU2T0bzJzlBAOmHpmNPhPDLGxVieIunJ8eThrCQgvz/CwFN
        M/yUNGYh+qJ5uT2fUnW4/tKEhBcdLdw1/o93sEeLu8SJChCmiIiTvvKKVCqq13qEaEvrYt4rQbgy9
        7UXzudt5YD493nTF0gKFsJi9oreMJonw3YEv0guLzQAPpv7sSGVoqkb/E6lktGyYuNPpmvhFFgEWk
        uapStiHDA/YuvnuIX40VmND7sse71J+dVQo1Swg6gkVmhhNDuZIfjjipfwaJhvgPkt3GGXZuEGlZa
        Ygd4oHFBg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hr7LT-0006HR-3X; Fri, 26 Jul 2019 21:01:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Henriques <lhenriques@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH] mm: Make kvfree safe to call
Date:   Fri, 26 Jul 2019 14:01:37 -0700
Message-Id: <20190726210137.23395-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Since vfree() can sleep, calling kvfree() from contexts where sleeping
is not permitted (eg holding a spinlock) is a bit of a lottery whether
it'll work.  Introduce kvfree_safe() for situations where we know we can
sleep, but make kvfree() safe by default.

Reported-by: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Luis Henriques <lhenriques@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/util.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index bab284d69c8c..992f0332dced 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -470,6 +470,28 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 }
 EXPORT_SYMBOL(kvmalloc_node);
 
+/**
+ * kvfree_fast() - Free memory.
+ * @addr: Pointer to allocated memory.
+ *
+ * kvfree_fast frees memory allocated by any of vmalloc(), kmalloc() or
+ * kvmalloc().  It is slightly more efficient to use kfree() or vfree() if
+ * you are certain that you know which one to use.
+ *
+ * Context: Either preemptible task context or not-NMI interrupt.  Must not
+ * hold a spinlock as it can sleep.
+ */
+void kvfree_fast(const void *addr)
+{
+	might_sleep();
+
+	if (is_vmalloc_addr(addr))
+		vfree(addr);
+	else
+		kfree(addr);
+}
+EXPORT_SYMBOL(kvfree_fast);
+
 /**
  * kvfree() - Free memory.
  * @addr: Pointer to allocated memory.
@@ -478,12 +500,12 @@ EXPORT_SYMBOL(kvmalloc_node);
  * It is slightly more efficient to use kfree() or vfree() if you are certain
  * that you know which one to use.
  *
- * Context: Either preemptible task context or not-NMI interrupt.
+ * Context: Any context except NMI.
  */
 void kvfree(const void *addr)
 {
 	if (is_vmalloc_addr(addr))
-		vfree(addr);
+		vfree_atomic(addr);
 	else
 		kfree(addr);
 }
-- 
2.20.1

