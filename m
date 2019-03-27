Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2928BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81F42087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663962;
	bh=SQM2VEa6UOgTf66UYMLYRWZbwEmYNFCm3wo+PAzWEow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fY/CCJfHdCV9KXvLbvjUi9gWWj7yxq/FSfS9xO+9B16vP0XmT60IuSpeTd8foh4CZ
	 YwA/UVVyzjXpbB+qKTly2ZPPMUoG6R6MKai6DWStcDwdmIGmYp2kcpRpcdmJK3pDoF
	 QnYkrVLoTuBrF2uJ756Uojuq29fN7/zOuB6ITHaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733146AbfC0FTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:19:20 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34495 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbfC0FTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:19:19 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 863C321C8E;
        Wed, 27 Mar 2019 01:19:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=5fMYvMuef/6Nimh3LFp+cUcvtrkcHACxlIcuh4C/VOc=; b=VPfdcwAR
        HAW/tqdDbnhfUHgNqzyTdXjspcvOmc+z8HCmXfW3yxRRv99zNgdxKuNttoopXXLm
        1d3C8pZsXY0xdOvzS/6TgTNhSMW1gQXWgJjJGJvz3H27HndfpYSiEiRNc34PbfKS
        SH+ZtZWgMYWHjtIDKelrkdH6gjT+rhpMA23TA3QWmu+SU5j6i+nHx4/88ggojeeI
        CD7hcW17WoPHVkbqf05htsQUL7l9Hk2LsZ14VpMj7nzmuHhKfuTnbu1FjiX3d7mm
        zlqYFkYNN9V1GIwZy6K8HsJ6YbM8L3MlPGqUnT9TZd96oRPYIQsz4r4jtNdcnZDL
        cx5a9oBUe8Axwg==
X-ME-Sender: <xms:1QebXLiPyGFTuXeI4FbfI7Jt8rrpK-0kem2K7s-7tygXkYQrwmy7CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepuddv
X-ME-Proxy: <xmx:1QebXO5nUfyzVb1Rw2Tx79ljG0I16rzZvTxoC3NA53f33Z6HRCva2Q>
    <xmx:1QebXDang2iWokyWDKm9QA-MODFj6pk42TaekXfOgpsCDuHKhyn0kg>
    <xmx:1QebXD7gsUfh5vRCv4MvTWQbxpC6F1Wr0RtYgbRMSxaxSjl1rGqaZg>
    <xmx:1QebXEajkPHwrR04V8tRUuJo6JLKfDiELmu7F7qasuEw9OY3kGWJ6A>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id A546EE4448;
        Wed, 27 Mar 2019 01:19:13 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/24] dcache: Clean up function docstrings
Date:   Wed, 27 Mar 2019 16:17:06 +1100
Message-Id: <20190327051717.23225-14-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function docstrings for dcache are currently not in the correct
form.  As part of an effort to update the documentation for the dcache
let's fix up the function docstrings to use the correct kernel
reStructuredText format.

Clean up function docstrings.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/dcache.c            | 281 +++++++++++++++++++++++------------------
 include/linux/dcache.h |  43 ++++---
 2 files changed, 187 insertions(+), 137 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index e513a9e9e418..7acf94290b66 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -812,8 +812,8 @@ static inline bool fast_dput(struct dentry *dentry)
  * Real recursion would eat up our stack space.
  */
 
-/*
- * dput - release a dentry
+/**
+ * dput() - Release a dentry.
  * @dentry: dentry to release
  *
  * Release a dentry. This will drop the usage count and if appropriate
@@ -909,11 +909,13 @@ static struct dentry * __d_find_any_alias(struct inode *inode)
 }
 
 /**
- * d_find_any_alias - find any alias for a given inode
+ * d_find_any_alias() - Find any alias for a given inode.
  * @inode: inode to find an alias for
  *
  * If any aliases exist for the given inode, take and return a
- * reference for one of them.  If no aliases exist, return %NULL.
+ * reference for one of them.
+ *
+ * Return: The found dentry reference or %NULL if no aliases exists.
  */
 struct dentry *d_find_any_alias(struct inode *inode)
 {
@@ -926,20 +928,6 @@ struct dentry *d_find_any_alias(struct inode *inode)
 }
 EXPORT_SYMBOL(d_find_any_alias);
 
-/**
- * d_find_alias - grab a hashed alias of inode
- * @inode: inode in question
- *
- * If inode has a hashed alias, or is a directory and has any alias,
- * acquire the reference to alias and return it. Otherwise return NULL.
- * Notice that if inode is a directory there can be only one alias and
- * it can be unhashed only if it has no children, or if it is the root
- * of a filesystem, or if the directory was renamed and d_revalidate
- * was the first vfs operation to notice.
- *
- * If the inode has an IS_ROOT, DCACHE_DISCONNECTED alias, then prefer
- * any other hashed alias over that one.
- */
 static struct dentry *__d_find_alias(struct inode *inode)
 {
 	struct dentry *alias;
@@ -959,6 +947,23 @@ static struct dentry *__d_find_alias(struct inode *inode)
 	return NULL;
 }
 
+/**
+ * d_find_alias() - Grab a hashed alias of inode.
+ * @inode: inode in question
+ *
+ * If inode has a hashed alias, or is a directory and has any alias,
+ * acquire the reference to alias.  Notice that if inode is a directory
+ * there can be only one alias and it can be unhashed only if it has no
+ * children, or if it is the root of a filesystem, or if the directory
+ * was renamed and d_revalidate was the first vfs operation to notice.
+ *
+ * If the inode has an IS_ROOT, DCACHE_DISCONNECTED alias, then prefer
+ * any other hashed alias over that one.
+ *
+ * Context: Takes the inode->i_lock and the dentry->d_lock for each
+ *          alias i.e. for each inode->i_dentry.
+ * Return: The found dentry reference or %NULL if no alias found.
+ */
 struct dentry *d_find_alias(struct inode *inode)
 {
 	struct dentry *de = NULL;
@@ -972,9 +977,11 @@ struct dentry *d_find_alias(struct inode *inode)
 }
 EXPORT_SYMBOL(d_find_alias);
 
-/*
- *	Try to kill dentries associated with this inode.
- * WARNING: you must own a reference to inode.
+/**
+ * d_prune_aliases() - Try to kill dentries associated with this inode.
+ * @inode: The inode we are working on.
+ *
+ * Context: Caller must own a reference to inode.
  */
 void d_prune_aliases(struct inode *inode)
 {
@@ -1148,7 +1155,7 @@ static enum lru_status dentry_lru_isolate(struct list_head *item,
 }
 
 /**
- * prune_dcache_sb - shrink the dcache
+ * prune_dcache_sb() - Shrink the dcache.
  * @sb: superblock
  * @sc: shrink control, passed to list_lru_shrink_walk()
  *
@@ -1158,6 +1165,8 @@ static enum lru_status dentry_lru_isolate(struct list_head *item,
  *
  * This function may fail to free any resources if all the dentries are in
  * use.
+ *
+ * Return: The number of dentries freed.
  */
 long prune_dcache_sb(struct super_block *sb, struct shrink_control *sc)
 {
@@ -1192,7 +1201,7 @@ static enum lru_status dentry_lru_isolate_shrink(struct list_head *item,
 
 
 /**
- * shrink_dcache_sb - shrink dcache for a superblock
+ * shrink_dcache_sb() - Shrink dcache for a superblock.
  * @sb: superblock
  *
  * Shrink the dcache for the specified super block. This is used to free
@@ -1229,10 +1238,10 @@ enum d_walk_ret {
 };
 
 /**
- * d_walk - walk the dentry tree
- * @parent:	start of walk
- * @data:	data passed to @enter() and @finish()
- * @enter:	callback when first entering the dentry
+ * d_walk() - Walk the dentry tree.
+ * @parent: Start of walk.
+ * @data: Data passed to @enter() and @finish().
+ * @enter: Callback when first entering the dentry.
  *
  * The @enter() callbacks are called with d_lock held.
  */
@@ -1362,12 +1371,11 @@ static enum d_walk_ret path_check_mount(void *data, struct dentry *dentry)
 }
 
 /**
- * path_has_submounts - check for mounts over a dentry in the
- *                      current namespace.
+ * path_has_submounts() - Check current namespace for mounts over a dentry.
  * @parent: path to check.
  *
- * Return true if the parent or its subdirectories contain
- * a mount point in the current namespace.
+ * Return: True if the parent or its subdirectories contain
+ *         a mount point in the current namespace.
  */
 int path_has_submounts(const struct path *parent)
 {
@@ -1381,13 +1389,17 @@ int path_has_submounts(const struct path *parent)
 }
 EXPORT_SYMBOL(path_has_submounts);
 
-/*
+/**
+ * d_set_mounted() - Set a mountpoint.
+ * @dentry: The dentry we are working on.
+ *
  * Called by mount code to set a mountpoint and check if the mountpoint is
  * reachable (e.g. NFS can unhash a directory dentry and then the complete
  * subtree can become unreachable).
  *
- * Only one of d_invalidate() and d_set_mounted() must succeed.  For
- * this reason take rename_lock and d_lock on dentry and ancestors.
+ * Only one of d_invalidate() and d_set_mounted() must succeed.
+ *
+ * Context: Take rename_lock and d_lock on dentry and ancestors.
  */
 int d_set_mounted(struct dentry *dentry)
 {
@@ -1468,7 +1480,7 @@ static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
 }
 
 /**
- * shrink_dcache_parent - prune dcache
+ * shrink_dcache_parent() - Prune dcache.
  * @parent: parent of entries to prune
  *
  * Prune the dcache to remove unused children of the parent dentry.
@@ -1527,8 +1539,13 @@ static void do_one_tree(struct dentry *dentry)
 	dput(dentry);
 }
 
-/*
- * destroy the dentries attached to a superblock on unmounting
+/**
+ * shrink_dcache_for_umount() - Destroy the dentries attached to a superblock.
+ * @sb: The superblock to shrink.
+ *
+ * Used when unmounting.  Shrinks (removes unused dentries) the sb root
+ * node then verifies tree does not contain any inuse dentries.  Printks
+ * a error message if any dentry is still inuse.
  */
 void shrink_dcache_for_umount(struct super_block *sb)
 {
@@ -1558,7 +1575,7 @@ static enum d_walk_ret find_submount(void *_data, struct dentry *dentry)
 }
 
 /**
- * d_invalidate - detach submounts, prune dcache, and drop
+ * d_invalidate() - Detach submounts, prune dcache, and drop.
  * @dentry: dentry to invalidate (aka detach, prune and drop)
  */
 void d_invalidate(struct dentry *dentry)
@@ -1593,15 +1610,15 @@ void d_invalidate(struct dentry *dentry)
 EXPORT_SYMBOL(d_invalidate);
 
 /**
- * __d_alloc	-	allocate a dcache entry
+ * __d_alloc() - Allocate a dcache entry.
  * @sb: filesystem it will belong to
  * @name: qstr of the name
  *
- * Allocates a dentry. It returns %NULL if there is insufficient memory
- * available. On a success the dentry is returned. The name passed in is
- * copied and the copy passed in may be reused after this call.
+ * @name is copied and may be reused after this call.
+ *
+ * Return: The newly allocated dentry on success. %NULL if there is
+ *         insufficient memory available or d_init() method fails.
  */
-
 struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 {
 	struct dentry *dentry;
@@ -1677,13 +1694,16 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 }
 
 /**
- * d_alloc	-	allocate a dcache entry
+ * d_alloc() - Allocate a dcache entry.
  * @parent: parent of entry to allocate
  * @name: qstr of the name
  *
- * Allocates a dentry. It returns %NULL if there is insufficient memory
- * available. On a success the dentry is returned. The name passed in is
- * copied and the copy passed in may be reused after this call.
+ * Allocates a dentry and adds it to @parent.  See __d_alloc() for full
+ * explanation of behaviour.
+ *
+ * @name is copied and may be reused after this call.
+ *
+ * Return: The newly allocated dentry or %NULL if __d_alloc() fails.
  */
 struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 {
@@ -1722,7 +1742,7 @@ struct dentry *d_alloc_cursor(struct dentry * parent)
 }
 
 /**
- * d_alloc_pseudo - allocate a dentry (for lookup-less filesystems)
+ * d_alloc_pseudo() - Allocate a dentry (for lookup-less filesystems).
  * @sb: the superblock
  * @name: qstr of the name
  *
@@ -1735,6 +1755,16 @@ struct dentry *d_alloc_pseudo(struct super_block *sb, const struct qstr *name)
 }
 EXPORT_SYMBOL(d_alloc_pseudo);
 
+/**
+ * d_alloc_name() - Allocate a dcache entry.
+ * @parent: The parent of entry to allocate.
+ * @name: The name to use in the allocation.
+ *
+ * Creates a qstring from @name then allocates a dentry, adding it to
+ * @parent.  See __d_alloc() for full explanation of behaviour.
+ *
+ * Return: The newly allocated dentry or %NULL if d_alloc() fails.
+ */
 struct dentry *d_alloc_name(struct dentry *parent, const char *name)
 {
 	struct qstr q;
@@ -1775,13 +1805,13 @@ void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
 }
 EXPORT_SYMBOL(d_set_d_op);
 
-
-/*
- * d_set_fallthru - Mark a dentry as falling through to a lower layer
- * @dentry - The dentry to mark
+/**
+ * d_set_fallthru() - Mark a dentry as falling through to a lower layer.
+ * @dentry: The dentry to mark.
  *
- * Mark a dentry as falling through to the lower layer (as set with
- * d_pin_lower()).  This flag may be recorded on the medium.
+ * Mark the dentry->d_flags to indicate that @dentry is falling through
+ * to the lower layer (as set with d_pin_lower()).  This flag may be
+ * recorded on the medium.
  */
 void d_set_fallthru(struct dentry *dentry)
 {
@@ -1841,12 +1871,10 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 
 /**
- * d_instantiate - fill in inode information for a dentry
+ * d_instantiate() - Fill in inode information for a dentry.
  * @entry: dentry to complete
  * @inode: inode to attach to this dentry
  *
- * Fill in inode information in the entry.
- *
  * This turns negative dentries into productive full members
  * of society.
  *
@@ -1854,7 +1882,6 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
  * (or otherwise set) by the caller to indicate that it is now
  * in use by the dcache.
  */
-
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
@@ -1867,7 +1894,11 @@ void d_instantiate(struct dentry *entry, struct inode * inode)
 }
 EXPORT_SYMBOL(d_instantiate);
 
-/*
+/**
+ * d_instantiate_new() - Instantiate dentry and unlock inode.
+ * @entry: The dentry to complete.
+ * @inode: The inode to attach to this dentry.
+ *
  * This should be equivalent to d_instantiate() + unlock_new_inode(),
  * with lockdep-related part of unlock_new_inode() done before
  * anything else.  Use that instead of open-coding d_instantiate()/
@@ -1980,7 +2011,7 @@ static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnected)
 }
 
 /**
- * d_obtain_alias - find or allocate a DISCONNECTED dentry for a given inode
+ * d_obtain_alias() - Find or allocate a DISCONNECTED dentry.
  * @inode: inode to allocate the dentry for
  *
  * Obtain a dentry for an inode resulting from NFS filehandle conversion or
@@ -2004,7 +2035,7 @@ struct dentry *d_obtain_alias(struct inode *inode)
 EXPORT_SYMBOL(d_obtain_alias);
 
 /**
- * d_obtain_root - find or allocate a dentry for a given inode
+ * d_obtain_root() - Find or allocate a dentry for a given inode.
  * @inode: inode to allocate the dentry for
  *
  * Obtain an IS_ROOT dentry for the root of a filesystem.
@@ -2025,7 +2056,7 @@ struct dentry *d_obtain_root(struct inode *inode)
 EXPORT_SYMBOL(d_obtain_root);
 
 /**
- * d_add_ci - lookup or allocate new dentry with case-exact name
+ * d_add_ci() - Lookup or allocate new dentry with case-exact name.
  * @inode:  the inode case-insensitive lookup has found
  * @dentry: the negative dentry that was passed to the parent's lookup func
  * @name:   the case-exact name to be associated with the returned dentry
@@ -2093,11 +2124,10 @@ static inline bool d_same_name(const struct dentry *dentry,
 }
 
 /**
- * __d_lookup_rcu - search for a dentry (racy, store-free)
+ * __d_lookup_rcu() - Search for a dentry (racy, store-free).
  * @parent: parent dentry
  * @name: qstr of name we wish to find
  * @seqp: returns d_seq value at the point where the dentry was found
- * Returns: dentry, or NULL
  *
  * __d_lookup_rcu is the dcache lookup function for rcu-walk name
  * resolution (store-free path walking) design described in
@@ -2105,21 +2135,25 @@ static inline bool d_same_name(const struct dentry *dentry,
  *
  * This is not to be used outside core vfs.
  *
- * __d_lookup_rcu must only be used in rcu-walk mode, ie. with vfsmount lock
- * held, and rcu_read_lock held. The returned dentry must not be stored into
- * without taking d_lock and checking d_seq sequence count against @seq
- * returned here.
+ * __d_lookup_rcu() must only be used in rcu-walk mode, i.e. with
+ * vfsmount lock held, and rcu_read_lock() held. The returned dentry
+ * must not be stored into without taking d_lock and checking d_seq
+ * sequence count against @seq returned here.
  *
- * A refcount may be taken on the found dentry with the d_rcu_to_refcount
- * function.
+ * A refcount may be taken on the found dentry with the
+ * d_rcu_to_refcount() function.
+ *
+ * Alternatively, __d_lookup_rcu() may be called again to look up the
+ * child of the returned dentry, so long as its parent's seqlock is
+ * checked after the child is looked up. Thus, an interlocking stepping
+ * of sequence lock checks is formed, giving integrity down the path
+ * walk.
  *
- * Alternatively, __d_lookup_rcu may be called again to look up the child of
- * the returned dentry, so long as its parent's seqlock is checked after the
- * child is looked up. Thus, an interlocking stepping of sequence lock checks
- * is formed, giving integrity down the path walk.
+ * NOTE! The caller *has* to check the resulting dentry against the
+ * sequence number we've returned before using any of the resulting
+ * dentry state!
  *
- * NOTE! The caller *has* to check the resulting dentry against the sequence
- * number we've returned before using any of the resulting dentry state!
+ * Return: dentry, or %NULL.
  */
 struct dentry *__d_lookup_rcu(const struct dentry *parent,
 				const struct qstr *name,
@@ -2206,15 +2240,16 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
 }
 
 /**
- * d_lookup - search for a dentry
+ * d_lookup() - Search for a dentry.
  * @parent: parent dentry
  * @name: qstr of name we wish to find
- * Returns: dentry, or NULL
  *
- * d_lookup searches the children of the parent dentry for the name in
+ * d_lookup() searches the children of the parent dentry for the name in
  * question. If the dentry is found its reference count is incremented and the
  * dentry is returned. The caller must use dput to free the entry when it has
- * finished using it. %NULL is returned if the dentry does not exist.
+ * finished using it.
+ *
+ * Return: dentry, or %NULL if the dentry does not exist.
  */
 struct dentry *d_lookup(const struct dentry *parent, const struct qstr *name)
 {
@@ -2232,19 +2267,20 @@ struct dentry *d_lookup(const struct dentry *parent, const struct qstr *name)
 EXPORT_SYMBOL(d_lookup);
 
 /**
- * __d_lookup - search for a dentry (racy)
+ * __d_lookup() - Search for a dentry (racy).
  * @parent: parent dentry
  * @name: qstr of name we wish to find
- * Returns: dentry, or NULL
  *
- * __d_lookup is like d_lookup, however it may (rarely) return a
+ * __d_lookup() is like d_lookup(), however it may (rarely) return a
  * false-negative result due to unrelated rename activity.
  *
- * __d_lookup is slightly faster by avoiding rename_lock read seqlock,
- * however it must be used carefully, e.g. with a following d_lookup in
+ * __d_lookup() is slightly faster by avoiding rename_lock read seqlock,
+ * however it must be used carefully, e.g. with a following d_lookup() in
  * the case of failure.
  *
- * __d_lookup callers must be commented.
+ * __d_lookup() callers must be commented.
+ *
+ * Return: dentry, or %NULL.
  */
 struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 {
@@ -2303,11 +2339,12 @@ struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 }
 
 /**
- * d_hash_and_lookup - hash the qstr then search for a dentry
+ * d_hash_and_lookup() - Hash the qstr then search for a dentry.
  * @dir: Directory to search in
  * @name: qstr of name we wish to find
  *
- * On lookup failure NULL is returned; on bad name - ERR_PTR(-error)
+ * Return: The dentry if found, %NULL on lookup failure, ERR_PTR(-error)
+ *         on bad name.
  */
 struct dentry *d_hash_and_lookup(struct dentry *dir, struct qstr *name)
 {
@@ -2340,13 +2377,12 @@ EXPORT_SYMBOL(d_hash_and_lookup);
  */
 
 /**
- * d_delete - delete a dentry
+ * d_delete() - Delete a dentry.
  * @dentry: The dentry to delete
  *
  * Turn the dentry into a negative dentry if possible, otherwise
- * remove it from the hash queues so it can be deleted later
+ * remove it from the hash queues so it can be deleted later.
  */
-
 void d_delete(struct dentry * dentry)
 {
 	struct inode *inode = dentry->d_inode;
@@ -2379,7 +2415,7 @@ static void __d_rehash(struct dentry *entry)
 }
 
 /**
- * d_rehash	- add an entry back to the hash
+ * d_rehash() - Add an entry back to the hash.
  * @entry: dentry to add to the hash
  *
  * Adds a dentry to the hash according to its name.
@@ -2576,7 +2612,7 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 }
 
 /**
- * d_add - add dentry to hash queues
+ * d_add() - Add dentry to hash queues.
  * @entry: dentry to add
  * @inode: The inode to attach to this dentry
  *
@@ -2595,15 +2631,13 @@ void d_add(struct dentry *entry, struct inode *inode)
 EXPORT_SYMBOL(d_add);
 
 /**
- * d_exact_alias - find and hash an exact unhashed alias
+ * d_exact_alias() - Find and hash an exact unhashed alias.
  * @entry: dentry to add
  * @inode: The inode to go with this dentry
  *
- * If an unhashed dentry with the same name/parent and desired
- * inode already exists, hash and return it.  Otherwise, return
- * NULL.
- *
- * Parent directory should be locked.
+ * Context: Parent directory should be locked.
+ * Return: If an unhashed dentry with the same name/parent and desired
+ *         inode already exists, hash and return it.  Otherwise %NULL.
  */
 struct dentry *d_exact_alias(struct dentry *entry, struct inode *inode)
 {
@@ -2702,15 +2736,17 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
 }
 
 /*
- * __d_move - move a dentry
+ * __d_move() - Move a dentry.
  * @dentry: entry to move
  * @target: new dentry
  * @exchange: exchange the two dentries
  *
  * Update the dcache to reflect the move of a file name. Negative
- * dcache entries should not be moved in this way. Caller must hold
- * rename_lock, the i_mutex of the source and target directories,
- * and the sb->s_vfs_rename_mutex if they differ. See lock_rename().
+ * dcache entries should not be moved in this way.
+ *
+ * Context: Caller must hold rename_lock, the i_mutex of the source and
+ *          target directories, and the sb->s_vfs_rename_mutex if they
+ *          differ. See lock_rename().
  */
 static void __d_move(struct dentry *dentry, struct dentry *target,
 		     bool exchange)
@@ -2793,14 +2829,17 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	spin_unlock(&dentry->d_lock);
 }
 
-/*
- * d_move - move a dentry
+/**
+ * d_move() - Move a dentry.
  * @dentry: entry to move
  * @target: new dentry
  *
  * Update the dcache to reflect the move of a file name. Negative
- * dcache entries should not be moved in this way. See the locking
- * requirements for __d_move.
+ * dcache entries should not be moved in this way.
+ *
+ * Context: Caller must hold rename_lock, the i_mutex of the source and
+ *          target directories, and the sb->s_vfs_rename_mutex if they
+ *          differ. See lock_rename().
  */
 void d_move(struct dentry *dentry, struct dentry *target)
 {
@@ -2810,8 +2849,8 @@ void d_move(struct dentry *dentry, struct dentry *target)
 }
 EXPORT_SYMBOL(d_move);
 
-/*
- * d_exchange - exchange two dentries
+/**
+ * d_exchange() - Exchange two dentries.
  * @dentry1: first dentry
  * @dentry2: second dentry
  */
@@ -2830,12 +2869,12 @@ void d_exchange(struct dentry *dentry1, struct dentry *dentry2)
 }
 
 /**
- * d_ancestor - search for an ancestor
+ * d_ancestor() - Search for an ancestor.
  * @p1: ancestor dentry
  * @p2: child dentry
  *
- * Returns the ancestor dentry of p2 which is a child of p1, if p1 is
- * an ancestor of p2, else NULL.
+ * Return: The ancestor dentry of p2 which is a child of p1, if p1 is
+ *         an ancestor of p2, else %NULL.
  */
 struct dentry *d_ancestor(struct dentry *p1, struct dentry *p2)
 {
@@ -2887,13 +2926,13 @@ static int __d_unalias(struct inode *inode,
 }
 
 /**
- * d_splice_alias - splice a disconnected dentry into the tree if one exists
+ * d_splice_alias() - Splice a disconnected dentry into the tree if one exists.
  * @inode:  the inode which may have a disconnected dentry
  * @dentry: a negative dentry which we want to point to the inode.
  *
- * If inode is a directory and has an IS_ROOT alias, then d_move that in
- * place of the given dentry and return it, else simply d_add the inode
- * to the dentry and return NULL.
+ * If inode is a directory and has an IS_ROOT alias, then d_move() that in
+ * place of the given dentry and return it, else simply d_add() the inode
+ * to the dentry and return %NULL.
  *
  * If a non-IS_ROOT directory is found, the filesystem is corrupt, and
  * we should error out: directories can't have multiple aliases.
@@ -2901,7 +2940,7 @@ static int __d_unalias(struct inode *inode,
  * This is needed in the lookup routine of any filesystem that is exportable
  * (via knfsd) so that we can build dcache paths to directories effectively.
  *
- * If a dentry was found and moved, then it is returned.  Otherwise NULL
+ * If a dentry was found and moved, then it is returned.  Otherwise %NULL
  * is returned.  This matches the expected return value of ->lookup.
  *
  * Cluster filesystems may call this function with a negative, hashed dentry.
@@ -2971,11 +3010,11 @@ EXPORT_SYMBOL(d_splice_alias);
  * @new_dentry: new dentry
  * @old_dentry: old dentry
  *
- * Returns true if new_dentry is a subdirectory of the parent (at any depth).
- * Returns false otherwise.
- * Caller must ensure that "new_dentry" is pinned before calling is_subdir()
+ * Return: True if new_dentry is a subdirectory of the parent (at any
+ *         depth).  False otherwise.
+ * Context: Caller must ensure that "new_dentry" is pinned before
+ *          calling is_subdir().
  */
-
 bool is_subdir(struct dentry *new_dentry, struct dentry *old_dentry)
 {
 	bool result;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 862aefe5a10a..0643c5127e1a 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -296,12 +296,14 @@ extern char *dentry_path(struct dentry *, char *, int);
 /* Allocation counts.. */
 
 /**
- *	dget, dget_dlock -	get a reference to a dentry
- *	@dentry: dentry to get a reference to
+ * dget_dlock() - Get a reference to a dentry.
+ * @dentry: The dentry to get a reference to.
  *
- *	Given a dentry or %NULL pointer increment the reference count
- *	if appropriate and return the dentry. A dentry will not be
- *	destroyed when it has references.
+ * Given a dentry or %NULL pointer increment the reference count if
+ * appropriate. A dentry will not be destroyed when it has references.
+ *
+ * Context: Caller must hold the dentry->d_lock.
+ * Return: The dentry.
  */
 static inline struct dentry *dget_dlock(struct dentry *dentry)
 {
@@ -310,6 +312,16 @@ static inline struct dentry *dget_dlock(struct dentry *dentry)
 	return dentry;
 }
 
+/**
+ * dget() - Get a reference to a dentry.
+ * @dentry: The dentry to get a reference to.
+ *
+ * Given a dentry or %NULL pointer increment the reference count if
+ * appropriate. A dentry will not be destroyed when it has references.
+ *
+ * Context: Takes the dentry->d_lock.
+ * Return: The dentry.
+ */
 static inline struct dentry *dget(struct dentry *dentry)
 {
 	if (dentry)
@@ -320,12 +332,11 @@ static inline struct dentry *dget(struct dentry *dentry)
 extern struct dentry *dget_parent(struct dentry *dentry);
 
 /**
- *	d_unhashed -	is dentry hashed
- *	@dentry: entry to check
+ * d_unhashed() - Is dentry unhashed.
+ * @dentry: The dentry to check.
  *
- *	Returns true if the dentry passed is not currently hashed.
+ * Return: True if the dentry passed is not currently hashed.
  */
-
 static inline int d_unhashed(const struct dentry *dentry)
 {
 	return hlist_bl_unhashed(&dentry->d_hash);
@@ -499,7 +510,7 @@ static inline unsigned long vfs_pressure_ratio(unsigned long val)
 }
 
 /**
- * d_inode - Get the actual inode of this dentry
+ * d_inode() - Get the actual inode of this dentry.
  * @dentry: The dentry to query
  *
  * This is the helper normal filesystems should use to get at their own inodes
@@ -511,7 +522,7 @@ static inline struct inode *d_inode(const struct dentry *dentry)
 }
 
 /**
- * d_inode_rcu - Get the actual inode of this dentry with READ_ONCE()
+ * d_inode_rcu() - Get the actual inode of this dentry with READ_ONCE().
  * @dentry: The dentry to query
  *
  * This is the helper normal filesystems should use to get at their own inodes
@@ -523,7 +534,7 @@ static inline struct inode *d_inode_rcu(const struct dentry *dentry)
 }
 
 /**
- * d_backing_inode - Get upper or lower inode we should be using
+ * d_backing_inode() - Get upper or lower inode we should be using.
  * @upper: The upper layer
  *
  * This is the helper that should be used to get at the inode that will be used
@@ -540,7 +551,7 @@ static inline struct inode *d_backing_inode(const struct dentry *upper)
 }
 
 /**
- * d_backing_dentry - Get upper or lower dentry we should be using
+ * d_backing_dentry() - Get upper or lower dentry we should be using.
  * @upper: The upper layer
  *
  * This is the helper that should be used to get the dentry of the inode that
@@ -555,9 +566,9 @@ static inline struct dentry *d_backing_dentry(struct dentry *upper)
 }
 
 /**
- * d_real - Return the real dentry
+ * d_real() - Return the real dentry.
  * @dentry: the dentry to query
- * @inode: inode to select the dentry from multiple layers (can be NULL)
+ * @inode: inode to select the dentry from multiple layers (can be %NULL)
  *
  * If dentry is on a union/overlay, then return the underlying, real dentry.
  * Otherwise return the dentry itself.
@@ -574,7 +585,7 @@ static inline struct dentry *d_real(struct dentry *dentry,
 }
 
 /**
- * d_real_inode - Return the real inode
+ * d_real_inode() - Return the real inode.
  * @dentry: The dentry to query
  *
  * If dentry is on a union/overlay, then return the underlying, real inode.
-- 
2.21.0

