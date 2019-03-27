Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67906C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5A82082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663958;
	bh=uG2Zd58+EgSWNvS5hbxw92UawGpojzmFNXB4edq50Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZRvYIMn8MvO+E+u87V/w6YLL2qSKPkyAghLo1fNkOVuOmCcLH+f0RX0056K+gYzd7
	 tralHIvtzU3WIW10NDFfcN+AfSuTcpUsrhUfTNuybVV4f3k3GqwXHkAyvhbtcsRjRD
	 AvefgLKzIu87ElEQa3/j1FsnX8Z8CrVkVVn//gtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbfC0FTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:19:16 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60247 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbfC0FTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:19:14 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DA663208A4;
        Wed, 27 Mar 2019 01:19:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=HlJ/FV4IHI3PoQ4zbyTxARuJuMrxr+x/Wau9vLRF7qU=; b=av7zF0qy
        187CoE0nLClaRVqsvmIc3Zb0Uu4yb1gR7+ebCtC1xkp50V93e8N+y9GoG3Kzfnhv
        eMFWJqVDdTOMx5PCFQ/ahyFWuRkntmkOa6NH/1kujEqNdYbAMvGp7CO4GiijhCe1
        jV7arxuM3NpKR43iqRLFoXaKQfqOMrHWV0O6CG3IG2ToG79ZHU4QgrA1UpHQ/pF9
        gSdxJvOkXWTlVsSYg4Ileq6CpKxwz6GKxlKuNd+gL53v6+8tqe+py9EJcTB063MY
        Kz4MWEmGOCAamaOOXlCVxbAPzSQy2DqD6tWVQH0B1h75xGrGUo4UOeYx2yYgrHEC
        bk+OIHn4AlMY3A==
X-ME-Sender: <xms:0AebXLowmV3ZK5FG66ch6dFsa1nr9QznSwj7WaR8vAaRK4842hCszA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepuddu
X-ME-Proxy: <xmx:0AebXNp67JTmDi84e6EaBv7tYFEv3v7Wr6RqRMx5xhQvyvtirty52g>
    <xmx:0AebXI0AxV1hsgV4Rat2laei-8SzlSWRfFfmjZV07xY-UH7ANsGo4A>
    <xmx:0AebXOccSVCyuTGVFA6ynE0Kz2Lt3ewQVPqcFwg5a-1RkRG8ApEgiw>
    <xmx:0AebXKF0YcEZNyj2lGkwe1fx2btrxVR8zBh2IupxLEEzD6QvQmPm8Q>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id 67E6FE415C;
        Wed, 27 Mar 2019 01:19:09 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/24] dcache: Fix non-docstring comments
Date:   Wed, 27 Mar 2019 16:17:05 +1100
Message-Id: <20190327051717.23225-13-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While cleaning up the docstrings for dcache lets fix any errors of
content and/or formatting in non-docstring comments also.  This arguably
makes the code cleaner.

Fix non-docstring comments i.e. all the other comments excluding
function docstrings.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/dcache.c            | 39 +++++++++++++++++------------------
 include/linux/dcache.h | 46 ++++++++++++++++++------------------------
 2 files changed, 39 insertions(+), 46 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 8094ae9c2d1b..e513a9e9e418 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -169,7 +169,7 @@ int proc_nr_dentry(struct ctl_table *table, int write, void __user *buffer,
 
 #include <asm/word-at-a-time.h>
 /*
- * NOTE! 'cs' and 'scount' come from a dentry, so it has a
+ * NOTE! 'cs' and 'scount' come from a dentry, so it has an
  * aligned allocation for this particular component. We don't
  * strictly need the load_unaligned_zeropad() safety, but it
  * doesn't hurt either.
@@ -500,7 +500,7 @@ static inline void dentry_unlist(struct dentry *dentry, struct dentry *parent)
 	struct dentry *next;
 	/*
 	 * Inform d_walk() and shrink_dentry_list() that we are no longer
-	 * attached to the dentry tree
+	 * attached to the dentry tree.
 	 */
 	dentry->d_flags |= DCACHE_DENTRY_KILLED;
 	if (unlikely(list_empty(&dentry->d_child)))
@@ -540,13 +540,11 @@ static void __dentry_kill(struct dentry *dentry)
 	if (!IS_ROOT(dentry))
 		parent = dentry->d_parent;
 
-	/*
-	 * The dentry is now unrecoverably dead to the world.
-	 */
+	/* The dentry is now unrecoverably dead to the world. */
 	lockref_mark_dead(&dentry->d_lockref);
 
 	/*
-	 * inform the fs via d_prune that this dentry is about to be
+	 * Inform the fs via d_prune that this dentry is about to be
 	 * unhashed and destroyed.
 	 */
 	if (dentry->d_flags & DCACHE_OP_PRUNE)
@@ -1048,6 +1046,7 @@ static bool shrink_lock_dentry(struct dentry *dentry)
 		return true;
 	spin_unlock(&parent->d_lock);
 out:
+
 	if (inode)
 		spin_unlock(&inode->i_lock);
 	return false;
@@ -1129,7 +1128,7 @@ static enum lru_status dentry_lru_isolate(struct list_head *item,
 		 * This is guaranteed by the fact that all LRU management
 		 * functions are intermediated by the LRU API calls like
 		 * list_lru_add and list_lru_del. List movement in this file
-		 * only ever occur through this functions or through callbacks
+		 * only ever occurs through this functions or through callbacks
 		 * like this one, that are called from the LRU API.
 		 *
 		 * The only exceptions to this are functions like
@@ -1617,7 +1616,7 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	 * We guarantee that the inline name is always NUL-terminated.
 	 * This way the memcpy() done by the name switching in rename
 	 * will still always have a NUL at the end, even if we might
-	 * be overwriting an internal NUL character
+	 * be overwriting an internal NUL character.
 	 */
 	dentry->d_iname[DNAME_INLINE_LEN-1] = 0;
 	if (unlikely(!name)) {
@@ -1694,8 +1693,8 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 	dentry->d_flags |= DCACHE_RCUACCESS;
 	spin_lock(&parent->d_lock);
 	/*
-	 * don't need child lock because it is not subject
-	 * to concurrency here
+	 * Do not need child lock because it is not subject
+	 * to concurrency here.
 	 */
 	__dget_dlock(parent);
 	dentry->d_parent = parent;
@@ -1923,7 +1922,7 @@ static struct dentry *__d_instantiate_anon(struct dentry *dentry,
 		goto out_iput;
 	}
 
-	/* attach a disconnected dentry */
+	/* Attach a disconnected dentry. */
 	add_flags = d_flags_for_inode(inode);
 
 	if (disconnected)
@@ -2496,8 +2495,8 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 
 		rcu_read_unlock();
 		/*
-		 * somebody is likely to be still doing lookup for it;
-		 * wait for them to finish
+		 * Somebody is likely to be still doing lookup for it;
+		 * wait for them to finish.
 		 */
 		spin_lock(&dentry->d_lock);
 		d_wait_lookup(dentry);
@@ -2521,7 +2520,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		return dentry;
 	}
 	rcu_read_unlock();
-	/* we can't take ->d_lock here; it's OK, though. */
+	/* We can't take ->d_lock here; it's OK, though. */
 	new->d_flags |= DCACHE_PAR_LOOKUP;
 	new->d_wait = wq;
 	hlist_bl_add_head_rcu(&new->d_u.d_in_lookup_hash, b);
@@ -2549,8 +2548,7 @@ void __d_lookup_done(struct dentry *dentry)
 }
 EXPORT_SYMBOL(__d_lookup_done);
 
-/* inode->i_lock held if inode is non-NULL */
-
+/* Caller holds inode->i_lock if inode is non-NULL */
 static inline void __d_add(struct dentry *dentry, struct inode *inode)
 {
 	struct inode *dir = NULL;
@@ -2732,7 +2730,7 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 		BUG_ON(p);
 		spin_lock(&target->d_parent->d_lock);
 	} else if (!p) {
-		/* target is not a descendent of dentry->d_parent */
+		/* Target is not a descendent of dentry->d_parent. */
 		spin_lock(&target->d_parent->d_lock);
 		spin_lock_nested(&old_parent->d_lock, DENTRY_D_LOCK_NESTED);
 	} else {
@@ -2926,7 +2924,7 @@ struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
 	if (S_ISDIR(inode->i_mode)) {
 		struct dentry *new = __d_find_any_alias(inode);
 		if (unlikely(new)) {
-			/* The reference to new ensures it remains an alias */
+			/* The reference to new ensures it remains an alias. */
 			spin_unlock(&inode->i_lock);
 			write_seqlock(&rename_lock);
 			if (unlikely(d_ancestor(new, dentry))) {
@@ -3055,7 +3053,8 @@ __setup("dhash_entries=", set_dhash_entries);
 
 static void __init dcache_init_early(void)
 {
-	/* If hashes are distributed across NUMA nodes, defer
+	/*
+	 * If hashes are distributed across NUMA nodes, defer
 	 * hash allocation until vmalloc space is available.
 	 */
 	if (hashdist)
@@ -3085,7 +3084,7 @@ static void __init dcache_init(void)
 		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_MEM_SPREAD|SLAB_ACCOUNT,
 		d_iname);
 
-	/* Hash may have been set up in dcache_init_early */
+	/* Hash may have been set up in dcache_init_early. */
 	if (!hashdist)
 		return;
 
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 2fc9fc59adb1..862aefe5a10a 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -92,8 +92,7 @@ struct dentry {
 	struct hlist_bl_node d_hash;	/* lookup hash list */
 	struct dentry *d_parent;	/* parent directory */
 	struct qstr d_name;
-	struct inode *d_inode;		/* Where the name belongs to - NULL is
-					 * negative */
+	struct inode *d_inode;		/* inode for name - NULL is negative */
 	unsigned char d_iname[DNAME_INLINE_LEN];	/* small names */
 
 	/* Ref lookup also touches following */
@@ -152,7 +151,7 @@ struct dentry_operations {
  * Locking rules for dentry_operations callbacks are to be found in
  * Documentation/filesystems/Locking. Keep it updated!
  *
- * FUrther descriptions are found in Documentation/filesystems/vfs.txt.
+ * Further descriptions are found in Documentation/filesystems/vfs.txt.
  * Keep it updated too!
  */
 
@@ -162,17 +161,18 @@ struct dentry_operations {
 #define DCACHE_OP_REVALIDATE		0x00000004
 #define DCACHE_OP_DELETE		0x00000008
 #define DCACHE_OP_PRUNE			0x00000010
-
+/*
+ * This dentry is possibly not currently connected to the dcache tree,
+ * in which case its parent will either be itself, or will have this
+ * flag as well.  nfsd will not use a dentry with this bit set, but will
+ * first endeavour to clear the bit either by discovering that it is
+ * connected, or by performing lookup operations.  Any filesystem which
+ * supports nfsd_operations MUST have a lookup function which, if it
+ * finds a directory inode with a DCACHE_DISCONNECTED dentry, will
+ * d_move that dentry into place and return that dentry rather than the
+ * passed one, typically using d_splice_alias.
+ */
 #define	DCACHE_DISCONNECTED		0x00000020
-     /* This dentry is possibly not currently connected to the dcache tree, in
-      * which case its parent will either be itself, or will have this flag as
-      * well.  nfsd will not use a dentry with this bit set, but will first
-      * endeavour to clear the bit either by discovering that it is connected,
-      * or by performing lookup operations.   Any filesystem which supports
-      * nfsd_operations MUST have a lookup function which, if it finds a
-      * directory inode with a DCACHE_DISCONNECTED dentry, will d_move that
-      * dentry into place and return that dentry rather than the passed one,
-      * typically using d_splice_alias. */
 
 #define DCACHE_REFERENCED		0x00000040 /* Recently used, don't discard. */
 #define DCACHE_RCUACCESS		0x00000080 /* Entry has ever been RCU-visible */
@@ -182,19 +182,17 @@ struct dentry_operations {
 #define DCACHE_SHRINK_LIST		0x00000400
 
 #define DCACHE_OP_WEAK_REVALIDATE	0x00000800
-
+/* This dentry has been "silly renamed" and has to be deleted on the last dput(). */
 #define DCACHE_NFSFS_RENAMED		0x00001000
-     /* this dentry has been "silly renamed" and has to be deleted on the last
-      * dput() */
 #define DCACHE_COOKIE			0x00002000 /* For use by dcookie subsystem */
+/* Parent inode is watched by some fsnotify listener. */
 #define DCACHE_FSNOTIFY_PARENT_WATCHED	0x00004000
-     /* Parent inode is watched by some fsnotify listener */
 
 #define DCACHE_DENTRY_KILLED		0x00008000
 
-#define DCACHE_MOUNTED			0x00010000 /* is a mountpoint */
-#define DCACHE_NEED_AUTOMOUNT		0x00020000 /* handle automount on this dir */
-#define DCACHE_MANAGE_TRANSIT		0x00040000 /* manage transit from this dirent */
+#define DCACHE_MOUNTED			0x00010000 /* Is a mountpoint */
+#define DCACHE_NEED_AUTOMOUNT		0x00020000 /* Handle automount on this dir */
+#define DCACHE_MANAGE_TRANSIT		0x00040000 /* Manage transit from this dirent */
 #define DCACHE_MANAGED_DENTRY \
 	(DCACHE_MOUNTED|DCACHE_NEED_AUTOMOUNT|DCACHE_MANAGE_TRANSIT)
 
@@ -262,9 +260,7 @@ extern void d_prune_aliases(struct inode *);
 /* test whether we have any submounts in a subdir tree */
 extern int path_has_submounts(const struct path *);
 
-/*
- * This adds the entry to the hash queues.
- */
+/* This adds the entry to the hash queues. */
 extern void d_rehash(struct dentry *);
 
 extern void d_add(struct dentry *, struct inode *);
@@ -286,9 +282,7 @@ static inline unsigned d_count(const struct dentry *dentry)
 	return dentry->d_lockref.count;
 }
 
-/*
- * helper function for dentry_operations.d_dname() members
- */
+/* Helper function for dentry_operations.d_dname() members. */
 extern __printf(4, 5)
 char *dynamic_dname(struct dentry *, char *, int, const char *, ...);
 extern char *simple_dname(struct dentry *, char *, int);
-- 
2.21.0

