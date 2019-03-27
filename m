Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC027C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8F92064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663940;
	bh=M8cxc49th/sF93ek4Y1f0opn8hhIknJbst0GRjzeZBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rQAHFMh78ndwFqVQ4HjiLDAH4W2LjoFdt7EdNNxRtJQP1HMqQ2EI6/ZtH9k/fYirZ
	 frLx8ne+kgMX6TyBCVkdVH4tom8QmmV2uGmY+gfQ+sgotv4BGgXlcLhky0i2zA0z8x
	 CeZ91ruanllARe7qTk5y+2hm1Fp/WbjzshIOZzaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbfC0FS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:18:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60645 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbfC0FS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:18:58 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 15D0F22182;
        Wed, 27 Mar 2019 01:18:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=FqyxCLe/wISnBAcGxX5AgS9mwT8j1bYo0bgbXhS32hE=; b=NDgQ8BWo
        za41wXLXv+r5SwptguOj/i2/m0SDHJ4ZZgkw5IGVEI2Yc6spCunLd1lhDaxn4J0M
        KbGVYfaUZJciXO+CzeF35Nuz6990FDhrXLYNfwsqSO7Yy2shi7HgKQMWy5xPeWrX
        A4L5UMppSq50VCXzJat7MAadDpjd8MDJIpdb14CkwEUDKYMCiHr+RYl6BEbqY+AN
        EXV+Vss6WIgH0eddO3d5ifkf3WIo4EF+SUWQOgbhk7rKJdsSv+eWOv54Qy+RXey3
        kcuzKQlvpfqr5+Z6B57NbPPxOSGM4lb7d2D1z2u3YoCGYkZn5zGHA9beljm4axZC
        jul9uFZ3zYT/0Q==
X-ME-Sender: <xms:wAebXMcoS_fsEy1zk0tDiN7ZiDVQeWb3KJf0E_VjFVwoMA_DBmtAoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepie
X-ME-Proxy: <xmx:wAebXAQtyCcE_wBHdjF00eOb6KuzaukrPLTWfF1I2uR-WfNeyhwP8A>
    <xmx:wAebXHkKyDOsXZ6YSIEInZGJsjv2LkVut9TRjGp5vLiXROzIFOEwVg>
    <xmx:wAebXMoWymD1gfOn47zb1TtMk1G5bL4QZ_dwKaEw0MVri5pPH05CQg>
    <xmx:wQebXL9ptU6ScdH1UEOg4TWocVAobQnem8uj4nnFZpgU-oHYTlbjKQ>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6AD75E40FF;
        Wed, 27 Mar 2019 01:18:53 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/24] dcache: Remove trailing whitespace
Date:   Wed, 27 Mar 2019 16:17:01 +1100
Message-Id: <20190327051717.23225-9-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File contains various instances of trailing whitespace. As initial stage
of working on dcache lets clean up the trailing whitespace.

Remove trailing whitespace.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/dcache.c            | 26 +++++++++++++-------------
 include/linux/dcache.h |  6 +++---
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2593153471cf..7bc7cf9b8962 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -254,7 +254,7 @@ static void __d_free(struct rcu_head *head)
 {
 	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
 
-	kmem_cache_free(dentry_cache, dentry); 
+	kmem_cache_free(dentry_cache, dentry);
 }
 
 static void __d_free_external(struct rcu_head *head)
@@ -784,7 +784,7 @@ static inline bool fast_dput(struct dentry *dentry)
 }
 
 
-/* 
+/*
  * This is dput
  *
  * This is complicated by the fact that we do not want to put
@@ -803,7 +803,7 @@ static inline bool fast_dput(struct dentry *dentry)
 
 /*
  * dput - release a dentry
- * @dentry: dentry to release 
+ * @dentry: dentry to release
  *
  * Release a dentry. This will drop the usage count and if appropriate
  * call the dentry unlink method as well as removing it from the queues and
@@ -1589,7 +1589,7 @@ EXPORT_SYMBOL(d_invalidate);
  * available. On a success the dentry is returned. The name passed in is
  * copied and the copy passed in may be reused after this call.
  */
- 
+
 struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 {
 	struct dentry *dentry;
@@ -1616,14 +1616,14 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 						  GFP_KERNEL_ACCOUNT |
 						  __GFP_RECLAIMABLE);
 		if (!p) {
-			kmem_cache_free(dentry_cache, dentry); 
+			kmem_cache_free(dentry_cache, dentry);
 			return NULL;
 		}
 		atomic_set(&p->u.count, 1);
 		dname = p->name;
 	} else  {
 		dname = dentry->d_iname;
-	}	
+	}
 
 	dentry->d_name.len = name->len;
 	dentry->d_name.hash = name->hash;
@@ -1842,7 +1842,7 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
  * (or otherwise set) by the caller to indicate that it is now
  * in use by the dcache.
  */
- 
+
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
@@ -2054,7 +2054,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		if (!found) {
 			iput(inode);
 			return ERR_PTR(-ENOMEM);
-		} 
+		}
 	}
 	res = d_splice_alias(inode, found);
 	if (res) {
@@ -2263,7 +2263,7 @@ struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 	 * See Documentation/filesystems/path-lookup.txt for more details.
 	 */
 	rcu_read_lock();
-	
+
 	hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
 
 		if (dentry->d_name.hash != hash)
@@ -2326,7 +2326,7 @@ EXPORT_SYMBOL(d_hash_and_lookup);
  * it from the hash queues and waiting for
  * it to be deleted later when it has no users
  */
- 
+
 /**
  * d_delete - delete a dentry
  * @dentry: The dentry to delete
@@ -2334,7 +2334,7 @@ EXPORT_SYMBOL(d_hash_and_lookup);
  * Turn the dentry into a negative dentry if possible, otherwise
  * remove it from the hash queues so it can be deleted later
  */
- 
+
 void d_delete(struct dentry * dentry)
 {
 	struct inode *inode = dentry->d_inode;
@@ -2372,7 +2372,7 @@ static void __d_rehash(struct dentry *entry)
  *
  * Adds a dentry to the hash according to its name.
  */
- 
+
 void d_rehash(struct dentry * entry)
 {
 	spin_lock(&entry->d_lock);
@@ -2964,7 +2964,7 @@ EXPORT_SYMBOL(d_splice_alias);
  * Returns false otherwise.
  * Caller must ensure that "new_dentry" is pinned before calling is_subdir()
  */
-  
+
 bool is_subdir(struct dentry *new_dentry, struct dentry *old_dentry)
 {
 	bool result;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index ef4b70f64f33..2fc9fc59adb1 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -266,7 +266,7 @@ extern int path_has_submounts(const struct path *);
  * This adds the entry to the hash queues.
  */
 extern void d_rehash(struct dentry *);
- 
+
 extern void d_add(struct dentry *, struct inode *);
 
 /* used for rename() and baskets */
@@ -306,7 +306,7 @@ extern char *dentry_path(struct dentry *, char *, int);
  *	@dentry: dentry to get a reference to
  *
  *	Given a dentry or %NULL pointer increment the reference count
- *	if appropriate and return the dentry. A dentry will not be 
+ *	if appropriate and return the dentry. A dentry will not be
  *	destroyed when it has references.
  */
 static inline struct dentry *dget_dlock(struct dentry *dentry)
@@ -331,7 +331,7 @@ extern struct dentry *dget_parent(struct dentry *dentry);
  *
  *	Returns true if the dentry passed is not currently hashed.
  */
- 
+
 static inline int d_unhashed(const struct dentry *dentry)
 {
 	return hlist_bl_unhashed(&dentry->d_hash);
-- 
2.21.0

