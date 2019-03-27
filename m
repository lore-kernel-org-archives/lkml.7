Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6276DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B92B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663966;
	bh=Qm1J3hQdh8hbtCdz7JBEovBMGMR2rj21peI4YGLrrss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GZ7cOnIZNFYv98pYwKP2oR6K1GQkjJzxmNTvglRpc0Wr5alfcv359E/WBg8MBsucd
	 eb++PHFHe9VoMxxHCXdwI47MEvBXjE3I2sMKPiiuOdzM6iywqGAGcmIMUfx18syVqr
	 oZaBNjHAHZiyvWior0hPk48UTFv8m1n/gnrwS3H8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbfC0FTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:19:24 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48127 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733150AbfC0FTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:19:23 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AF80821F37;
        Wed, 27 Mar 2019 01:19:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=O3IkRZrdZNfUvoMQYcfGBizE/yp9wp3yrnKIkiYXnFc=; b=6kAvjWDv
        IjUCgcWDGoL8/hfnNaeH9hKK+Dx4HWJmst7mPH4n48pbHbwPsYW92Md96+XnLKio
        k24GmuvMpySQ3Fc0I9tnXlSiMDU8IWKUCxikCJoM4WWBtLU0EUsH51rGdEYMTuGz
        k6QcHN4aQegkRyvnOZFE6Y4TYf81pWMcX2r16r8aqBCVbbtv95yJ0RpKt2AuXNbE
        wPfJudw/dmKp5j8OLoOKwxytH1iPPAz3xbr8mSXU2ehy8KYhXj+vBJ5VRpeFH78b
        ij0eRlVumwPBfYRQL9GQhxk5j/vuRaE0Q4WrFzjoJwcLXbWndTEWOawnDPZClq/J
        fhEqoyVLCREUBw==
X-ME-Sender: <xms:2QebXLKuq9FSrxAbEffDhUNd5ZLZuY1juk9zNm2tcQeFm1WVxmVLqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepudef
X-ME-Proxy: <xmx:2QebXKS2mDGHMjQ9rhu2TbEP2Ty0IFfRCx-KTrOONGvTNUJN5pGz4A>
    <xmx:2QebXKHC-nus7DLD1YX3cEIOMNNlkhZKyyPmg2AeFtpTH7qDQmIiqg>
    <xmx:2QebXPV0oGFvyNkZdGD8L_jygEOoT3UjRG_ektYAW8cey1VdhNcrbg>
    <xmx:2QebXGfCW7Uq3XxgNXzd3FBl65DDxWnkUlr1eIkzrb306tCT2_OaGw>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2191CE415C;
        Wed, 27 Mar 2019 01:19:17 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/24] dcache: Clean up function docstring members
Date:   Wed, 27 Mar 2019 16:17:07 +1100
Message-Id: <20190327051717.23225-15-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We just cleaned up the function docstrings, we omitted while doing that
clean up the member descriptions.  This was done to ease the cognitive
load required for review.  Seeing what has changed in a line with an
added period can be taxing on the patch reader, if we do all these
changes as a separate patch its easier to review.

Clean up function docstring member descriptions:n
 - Capitalise the initial character.
 - Add period (full stop) to end of string.
 - iff required flesh out the description.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/dcache.c | 90 ++++++++++++++++++++++++++---------------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7acf94290b66..4ed26a7e0ec8 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -814,7 +814,7 @@ static inline bool fast_dput(struct dentry *dentry)
 
 /**
  * dput() - Release a dentry.
- * @dentry: dentry to release
+ * @dentry: The dentry to release.
  *
  * Release a dentry. This will drop the usage count and if appropriate
  * call the dentry unlink method as well as removing it from the queues and
@@ -910,7 +910,7 @@ static struct dentry * __d_find_any_alias(struct inode *inode)
 
 /**
  * d_find_any_alias() - Find any alias for a given inode.
- * @inode: inode to find an alias for
+ * @inode: The inode to find an alias for.
  *
  * If any aliases exist for the given inode, take and return a
  * reference for one of them.
@@ -949,7 +949,7 @@ static struct dentry *__d_find_alias(struct inode *inode)
 
 /**
  * d_find_alias() - Grab a hashed alias of inode.
- * @inode: inode in question
+ * @inode: The inode in question.
  *
  * If inode has a hashed alias, or is a directory and has any alias,
  * acquire the reference to alias.  Notice that if inode is a directory
@@ -1156,7 +1156,7 @@ static enum lru_status dentry_lru_isolate(struct list_head *item,
 
 /**
  * prune_dcache_sb() - Shrink the dcache.
- * @sb: superblock
+ * @sb: The superblock to shrink.
  * @sc: shrink control, passed to list_lru_shrink_walk()
  *
  * Attempt to shrink the superblock dcache LRU by @sc->nr_to_scan entries. This
@@ -1372,7 +1372,7 @@ static enum d_walk_ret path_check_mount(void *data, struct dentry *dentry)
 
 /**
  * path_has_submounts() - Check current namespace for mounts over a dentry.
- * @parent: path to check.
+ * @parent: The path to check.
  *
  * Return: True if the parent or its subdirectories contain
  *         a mount point in the current namespace.
@@ -1481,7 +1481,7 @@ static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
 
 /**
  * shrink_dcache_parent() - Prune dcache.
- * @parent: parent of entries to prune
+ * @parent: The parent of entries to prune.
  *
  * Prune the dcache to remove unused children of the parent dentry.
  */
@@ -1576,7 +1576,7 @@ static enum d_walk_ret find_submount(void *_data, struct dentry *dentry)
 
 /**
  * d_invalidate() - Detach submounts, prune dcache, and drop.
- * @dentry: dentry to invalidate (aka detach, prune and drop)
+ * @dentry: The dentry to invalidate (aka detach, prune and drop).
  */
 void d_invalidate(struct dentry *dentry)
 {
@@ -1611,8 +1611,8 @@ EXPORT_SYMBOL(d_invalidate);
 
 /**
  * __d_alloc() - Allocate a dcache entry.
- * @sb: filesystem it will belong to
- * @name: qstr of the name
+ * @sb: The filesystem it will belong to.
+ * @name: The qstr of the name.
  *
  * @name is copied and may be reused after this call.
  *
@@ -1695,8 +1695,8 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 
 /**
  * d_alloc() - Allocate a dcache entry.
- * @parent: parent of entry to allocate
- * @name: qstr of the name
+ * @parent: The parent of entry to allocate.
+ * @name: The qstr of the name.
  *
  * Allocates a dentry and adds it to @parent.  See __d_alloc() for full
  * explanation of behaviour.
@@ -1743,8 +1743,8 @@ struct dentry *d_alloc_cursor(struct dentry * parent)
 
 /**
  * d_alloc_pseudo() - Allocate a dentry (for lookup-less filesystems).
- * @sb: the superblock
- * @name: qstr of the name
+ * @sb: The superblock.
+ * @name: The qstr of the name.
  *
  * For a filesystem that just pins its dentries in memory and never
  * performs lookups at all, return an unhashed IS_ROOT dentry.
@@ -1872,8 +1872,8 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 
 /**
  * d_instantiate() - Fill in inode information for a dentry.
- * @entry: dentry to complete
- * @inode: inode to attach to this dentry
+ * @entry: The dentry to complete.
+ * @inode: The inode to attach to this dentry.
  *
  * This turns negative dentries into productive full members
  * of society.
@@ -2012,7 +2012,7 @@ static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnected)
 
 /**
  * d_obtain_alias() - Find or allocate a DISCONNECTED dentry.
- * @inode: inode to allocate the dentry for
+ * @inode: The inode to allocate the dentry for.
  *
  * Obtain a dentry for an inode resulting from NFS filehandle conversion or
  * similar open by handle operations.  The returned dentry may be anonymous,
@@ -2036,7 +2036,7 @@ EXPORT_SYMBOL(d_obtain_alias);
 
 /**
  * d_obtain_root() - Find or allocate a dentry for a given inode.
- * @inode: inode to allocate the dentry for
+ * @inode: The inode to allocate the dentry for.
  *
  * Obtain an IS_ROOT dentry for the root of a filesystem.
  *
@@ -2057,9 +2057,9 @@ EXPORT_SYMBOL(d_obtain_root);
 
 /**
  * d_add_ci() - Lookup or allocate new dentry with case-exact name.
- * @inode:  the inode case-insensitive lookup has found
- * @dentry: the negative dentry that was passed to the parent's lookup func
- * @name:   the case-exact name to be associated with the returned dentry
+ * @inode: The inode case-insensitive lookup has found.
+ * @dentry: The negative dentry that was passed to the parent's lookup func.
+ * @name: The case-exact name to be associated with the returned dentry.
  *
  * This is to avoid filling the dcache with case-insensitive names to the
  * same inode, only the actual correct case is stored in the dcache for
@@ -2125,9 +2125,9 @@ static inline bool d_same_name(const struct dentry *dentry,
 
 /**
  * __d_lookup_rcu() - Search for a dentry (racy, store-free).
- * @parent: parent dentry
- * @name: qstr of name we wish to find
- * @seqp: returns d_seq value at the point where the dentry was found
+ * @parent: The parent dentry.
+ * @name: The qstr of name we wish to find.
+ * @seqp: Returns d_seq value at the point where the dentry was found.
  *
  * __d_lookup_rcu is the dcache lookup function for rcu-walk name
  * resolution (store-free path walking) design described in
@@ -2241,8 +2241,8 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
 
 /**
  * d_lookup() - Search for a dentry.
- * @parent: parent dentry
- * @name: qstr of name we wish to find
+ * @parent: The parent dentry.
+ * @name: The qstr of name we wish to find.
  *
  * d_lookup() searches the children of the parent dentry for the name in
  * question. If the dentry is found its reference count is incremented and the
@@ -2268,8 +2268,8 @@ EXPORT_SYMBOL(d_lookup);
 
 /**
  * __d_lookup() - Search for a dentry (racy).
- * @parent: parent dentry
- * @name: qstr of name we wish to find
+ * @parent: The parent dentry.
+ * @name: The qstr of name we wish to find.
  *
  * __d_lookup() is like d_lookup(), however it may (rarely) return a
  * false-negative result due to unrelated rename activity.
@@ -2340,8 +2340,8 @@ struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 
 /**
  * d_hash_and_lookup() - Hash the qstr then search for a dentry.
- * @dir: Directory to search in
- * @name: qstr of name we wish to find
+ * @dir: Directory to search in.
+ * @name: The qstr of name we wish to find.
  *
  * Return: The dentry if found, %NULL on lookup failure, ERR_PTR(-error)
  *         on bad name.
@@ -2378,7 +2378,7 @@ EXPORT_SYMBOL(d_hash_and_lookup);
 
 /**
  * d_delete() - Delete a dentry.
- * @dentry: The dentry to delete
+ * @dentry: The dentry to delete.
  *
  * Turn the dentry into a negative dentry if possible, otherwise
  * remove it from the hash queues so it can be deleted later.
@@ -2416,7 +2416,7 @@ static void __d_rehash(struct dentry *entry)
 
 /**
  * d_rehash() - Add an entry back to the hash.
- * @entry: dentry to add to the hash
+ * @entry: The dentry to add to the hash.
  *
  * Adds a dentry to the hash according to its name.
  */
@@ -2613,8 +2613,8 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 
 /**
  * d_add() - Add dentry to hash queues.
- * @entry: dentry to add
- * @inode: The inode to attach to this dentry
+ * @entry: The dentry to add.
+ * @inode: The inode to attach to this dentry.
  *
  * This adds the entry to the hash queues and initializes @inode.
  * The entry was actually filled in earlier during d_alloc().
@@ -2632,8 +2632,8 @@ EXPORT_SYMBOL(d_add);
 
 /**
  * d_exact_alias() - Find and hash an exact unhashed alias.
- * @entry: dentry to add
- * @inode: The inode to go with this dentry
+ * @entry: The dentry to add.
+ * @inode: The inode to go with this dentry.
  *
  * Context: Parent directory should be locked.
  * Return: If an unhashed dentry with the same name/parent and desired
@@ -2831,8 +2831,8 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 
 /**
  * d_move() - Move a dentry.
- * @dentry: entry to move
- * @target: new dentry
+ * @dentry: The dentry to move.
+ * @target: The new dentry.
  *
  * Update the dcache to reflect the move of a file name. Negative
  * dcache entries should not be moved in this way.
@@ -2851,8 +2851,8 @@ EXPORT_SYMBOL(d_move);
 
 /**
  * d_exchange() - Exchange two dentries.
- * @dentry1: first dentry
- * @dentry2: second dentry
+ * @dentry1: The first dentry.
+ * @dentry2: The second dentry.
  */
 void d_exchange(struct dentry *dentry1, struct dentry *dentry2)
 {
@@ -2870,8 +2870,8 @@ void d_exchange(struct dentry *dentry1, struct dentry *dentry2)
 
 /**
  * d_ancestor() - Search for an ancestor.
- * @p1: ancestor dentry
- * @p2: child dentry
+ * @p1: The ancestor dentry.
+ * @p2: The child dentry.
  *
  * Return: The ancestor dentry of p2 which is a child of p1, if p1 is
  *         an ancestor of p2, else %NULL.
@@ -2927,8 +2927,8 @@ static int __d_unalias(struct inode *inode,
 
 /**
  * d_splice_alias() - Splice a disconnected dentry into the tree if one exists.
- * @inode:  the inode which may have a disconnected dentry
- * @dentry: a negative dentry which we want to point to the inode.
+ * @inode: The inode which may have a disconnected dentry.
+ * @dentry: A negative dentry which we want to point to the inode.
  *
  * If inode is a directory and has an IS_ROOT alias, then d_move() that in
  * place of the given dentry and return it, else simply d_add() the inode
@@ -3007,8 +3007,8 @@ EXPORT_SYMBOL(d_splice_alias);
 
 /**
  * is_subdir - is new dentry a subdirectory of old_dentry
- * @new_dentry: new dentry
- * @old_dentry: old dentry
+ * @new_dentry: The new dentry.
+ * @old_dentry: The old dentry.
  *
  * Return: True if new_dentry is a subdirectory of the parent (at any
  *         depth).  False otherwise.
-- 
2.21.0

