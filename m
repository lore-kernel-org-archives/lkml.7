Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6355EC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F13220882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554265894;
	bh=VBD0SjkTRkpBu5W4nzIQQC7F3LLgUKrAQLvv4o3cFes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q4qtdP5uIwxthD0s16qqBTiN9UXW0mtp3NIFmOD34NJE39LMesZgBR3Usr3nboHP9
	 jSdqVnXLQ+9I3ti09jtF5You0vsR6RQipNQU1C/DhaWNj1kaNyu0IexqpQqZsxY919
	 87tNn1lyaeIomsI90srX1s37/LsJnUm7UBc52bFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfDCEbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:31:12 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36957 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728671AbfDCEbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:31:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 79D1021F93;
        Wed,  3 Apr 2019 00:24:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 00:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=bbV+w3gF2LYD1FivN0kmZexmR5wyxe6wR2gkjGxFRYI=; b=A2qei93U
        HU48t5f6nD+xKkxRcoxHrLa8FeTIc145hRYP6nIdf5yeW5Zh1r9KqwlDsYVUWOg0
        wSndlC0Vr0TaWNSFGBsHApW+etgX/1SU/sgVCBjNp+JmkFvfLouRJ0hXN6DN1XXj
        cyiPzg1vPdxP6JhKQUnxEMMwJoJJCZa+YTEJQGaQaoB3J8eQ6Ghlx2PVy6Oi+lKI
        Jan3g6XBb0xIBNe1y9V6kSiajNCgmekjCpmw2E4+7S9L5AJQOXoI8xp9QQLrs1st
        bbj3mmvbN36dWYpHFUCPnY8100JoI/4MMxfQlz6CR2rqRfQHD7VbaDLR1uZASy2i
        oIB3q1xqQ7hy2w==
X-ME-Sender: <xms:djWkXNYl4V-tXMjSxPgkCb9vE92NzxxC-S7vTpM-I-D7GsuuiDLNLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugdektdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrh
    hnvghlrdhorhhgqeenucfkphepuddvgedrudeiledrvdejrddvtdeknecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpeduvd
X-ME-Proxy: <xmx:djWkXAQzCIfbRRgLj9ibmclaRc4KcPsFh2s6GgfbMB53slSRW2Y_GA>
    <xmx:djWkXM9rzitkUfHrXV69NA0J_KGyZFzMKkJsVkEMBFNTBEuX98mJmA>
    <xmx:djWkXAhMxb1Fwy_EoE5JAFyEQakVlppE5UOnEHYhCz0avxAnJC9Ouw>
    <xmx:djWkXFjDb3dhBwbdUJMGq_wxasP-aJaOWtbCJsiGdZXUedbbsxZMEA>
Received: from eros.localdomain (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8369E1030F;
        Wed,  3 Apr 2019 00:24:15 -0400 (EDT)
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
Subject: [RFC PATCH v2 13/14] dcache: Provide a dentry constructor
Date:   Wed,  3 Apr 2019 15:21:26 +1100
Message-Id: <20190403042127.18755-14-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190403042127.18755-1-tobin@kernel.org>
References: <20190403042127.18755-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support object migration on the dentry cache we need to have
a determined object state at all times. Without a constructor the object
would have a random state after allocation.

Provide a dentry constructor.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/dcache.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index aac41adf4743..606844ad5171 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1603,6 +1603,22 @@ void d_invalidate(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_invalidate);
 
+static void dcache_ctor(void *p)
+{
+	struct dentry *dentry = p;
+
+	dentry->d_lockref.count = 0;
+	dentry->d_inode = NULL;
+
+	spin_lock_init(&dentry->d_lock);
+
+	INIT_HLIST_BL_NODE(&dentry->d_hash);
+	INIT_LIST_HEAD(&dentry->d_lru);
+	INIT_LIST_HEAD(&dentry->d_subdirs);
+	INIT_HLIST_NODE(&dentry->d_u.d_alias);
+	INIT_LIST_HEAD(&dentry->d_child);
+}
+
 /**
  * __d_alloc	-	allocate a dcache entry
  * @sb: filesystem it will belong to
@@ -1658,7 +1674,7 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 
 	dentry->d_lockref.count = 1;
 	dentry->d_flags = 0;
-	spin_lock_init(&dentry->d_lock);
+
 	seqcount_init(&dentry->d_seq);
 	dentry->d_inode = NULL;
 	dentry->d_parent = dentry;
@@ -3091,14 +3107,17 @@ static void __init dcache_init_early(void)
 
 static void __init dcache_init(void)
 {
-	/*
-	 * A constructor could be added for stable state like the lists,
-	 * but it is probably not worth it because of the cache nature
-	 * of the dcache.
-	 */
-	dentry_cache = KMEM_CACHE_USERCOPY(dentry,
-		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_MEM_SPREAD|SLAB_ACCOUNT,
-		d_iname);
+	slab_flags_t flags =
+		SLAB_RECLAIM_ACCOUNT | SLAB_PANIC | SLAB_MEM_SPREAD | SLAB_ACCOUNT;
+
+	dentry_cache =
+		kmem_cache_create_usercopy("dentry",
+					   sizeof(struct dentry),
+					   __alignof__(struct dentry),
+					   flags,
+					   offsetof(struct dentry, d_iname),
+					   sizeof_field(struct dentry, d_iname),
+					   dcache_ctor);
 
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
-- 
2.21.0

