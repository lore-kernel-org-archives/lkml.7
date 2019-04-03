Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C358C10F0C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FBE214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554265878;
	bh=dl0XbJb3kHtD0aJFJ4vIldCLadWBwplqsLzKqrJW3z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rXBZUg9JKXC9f2j3NpUW5KMDnVkxwBln+lKxJ+TjjGM0MA9mLLSF9P18wph7BpwU5
	 VA6yRrfrcwncMSHC7XJwknHxE++Q63MMgiSD5r0hkMmqUI03DqP9R2Q7dxDzjGIImq
	 A74XCyQhdwd1vs5ENEFXKlot87FWQECLzOXLGgYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfDCEbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:31:16 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38161 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728655AbfDCEbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:31:11 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E23B621FAE;
        Wed,  3 Apr 2019 00:24:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 00:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=3CgZchYLd16ww3/LiD/mAfG7GXA+RJSG10+pHsLIDks=; b=wY4kIaUF
        bKeyoZ1pX1nCWrBGHGHId2HQJ7fpODFRyw9W9hbVgEBM2F+znekZY9/Ya6bpkQLx
        g4bxXkC0jILJxfUFw+Xp/nP9yTQgozkM4b4uJR7dSeJn7Du55PXTCh12806jtLbw
        ZZtzaSMa5mrjyPZji51A8vd+/ku4ZVL5Qd4QTYWu6LVgY3XDelhAATeQIwGLJEeb
        QLOnXlctXLmYy9UVB2VQXXHy3Vce14hsYi8KLRqRXNOdpfUzNHOb/opiGiwyMH4x
        NkPSYl8X0PHNA6n6iOzmg96i85YHVOD3FW9jf9WsUSTJx9TKvaAriKhZyw0pb5db
        fRyyTYkfF5tEDg==
X-ME-Sender: <xms:fTWkXJ1HmSTc0NWQ09l2pitFB5VEPfcu0zy0mThfRuP5raBiya01rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugdektdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrh
    hnvghlrdhorhhgqeenucfkphepuddvgedrudeiledrvdejrddvtdeknecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedufe
X-ME-Proxy: <xmx:fTWkXEWBexcOAxb392Gqp6hyOG49Ztf-_U-rHA-Ki1tgG_EXiz3SFw>
    <xmx:fTWkXE71ALl-nmH_kBAHCYj0V9luUF7MdvkNuNAvN2vb3BaTTEJHgA>
    <xmx:fTWkXLKPs3hYiX2DVAR1NpMEGBeVt946yGWKOEB5mD5Fa_gWKvPFRA>
    <xmx:fTWkXOk_bHrx8S3koLe_9eTZGaPPkor3nTsEOKI-tg__FRSGz1lR4w>
Received: from eros.localdomain (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0A2BB10319;
        Wed,  3 Apr 2019 00:24:22 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>,
        "Theodore Ts'o" <tytso@mit.edu>, Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 14/14] dcache: Implement object migration
Date:   Wed,  3 Apr 2019 15:21:27 +1100
Message-Id: <20190403042127.18755-15-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190403042127.18755-1-tobin@kernel.org>
References: <20190403042127.18755-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dentry slab cache is susceptible to internal fragmentation.  Now
that we have Slab Movable Objects we can defragment the dcache.  Object
migration is only possible for dentry objects that are not currently
referenced by anyone, i.e. we are using the object migration
infrastructure to free unused dentries.

Implement isolate and migrate functions for the dentry slab cache.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/dcache.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 606844ad5171..4387715b7ebb 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -30,6 +30,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/backing-dev.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -3074,6 +3075,90 @@ void d_tmpfile(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(d_tmpfile);
 
+/*
+ * d_isolate() - Dentry isolation callback function.
+ * @s: The dentry cache.
+ * @v: Vector of pointers to the objects to migrate.
+ * @nr: Number of objects in @v.
+ *
+ * The slab allocator is holding off frees. We can safely examine
+ * the object without the danger of it vanishing from under us.
+ */
+static void *d_isolate(struct kmem_cache *s, void **v, int nr)
+{
+	struct dentry *dentry;
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		dentry = v[i];
+		spin_lock(&dentry->d_lock);
+		/*
+		 * Three sorts of dentries cannot be reclaimed:
+		 *
+		 * 1. dentries that are in the process of being allocated
+		 *    or being freed. In that case the dentry is neither
+		 *    on the LRU nor hashed.
+		 *
+		 * 2. Fake hashed entries as used for anonymous dentries
+		 *    and pipe I/O. The fake hashed entries have d_flags
+		 *    set to indicate a hashed entry. However, the
+		 *    d_hash field indicates that the entry is not hashed.
+		 *
+		 * 3. dentries that have a backing store that is not
+		 *    writable. This is true for tmpsfs and other in
+		 *    memory filesystems. Removing dentries from them
+		 *    would loose dentries for good.
+		 */
+		if ((d_unhashed(dentry) && list_empty(&dentry->d_lru)) ||
+		    (!d_unhashed(dentry) && hlist_bl_unhashed(&dentry->d_hash)) ||
+		    (dentry->d_inode &&
+		     !mapping_cap_writeback_dirty(dentry->d_inode->i_mapping))) {
+			/* Ignore this dentry */
+			v[i] = NULL;
+		} else {
+			__dget_dlock(dentry);
+		}
+		spin_unlock(&dentry->d_lock);
+	}
+	return NULL;		/* No need for private data */
+}
+
+/*
+ * d_migrate() - Dentry migration callback function.
+ * @s: The dentry cache.
+ * @v: Vector of pointers to the objects to migrate.
+ * @nr: Number of objects in @v.
+ * @node: The NUMA node where new object should be allocated.
+ * @private: Returned by d_isolate() (currently %NULL).
+ *
+ * Slab has dropped all the locks. Get rid of the refcount obtained
+ * earlier and also free the object.
+ */
+static void d_migrate(struct kmem_cache *s, void **v, int nr,
+		      int node, void *_unused)
+{
+	struct dentry *dentry;
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		dentry = v[i];
+		if (dentry)
+			d_invalidate(dentry);
+	}
+
+	for (i = 0; i < nr; i++) {
+		dentry = v[i];
+		if (dentry)
+			dput(dentry);
+	}
+
+	/*
+	 * dentries are freed using RCU so we need to wait until RCU
+	 * operations are complete.
+	 */
+	synchronize_rcu();
+}
+
 static __initdata unsigned long dhash_entries;
 static int __init set_dhash_entries(char *str)
 {
@@ -3119,6 +3204,8 @@ static void __init dcache_init(void)
 					   sizeof_field(struct dentry, d_iname),
 					   dcache_ctor);
 
+	kmem_cache_setup_mobility(dentry_cache, d_isolate, d_migrate);
+
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
 		return;
-- 
2.21.0

