Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33823C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF472064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553664019;
	bh=8OFUkpHLxl9foV+qSfrwfTR32o5VyFslwUCAmygrp+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CrVMkZoLuM9ZyTjYTj9yL+g4glNb66PmhWLaCnV6lFhB7zf7JibyO8FbM9Awy203Q
	 Tb68EQ1wp8AWUXlY/6PcQ+LON9F4lUHI4680Qjf0Z2+OF/3mxE3dLJhJjA5GEO3Byi
	 3uXcU1aPfsdDrck5E+/DTNw/L9nwKP57rGKNKw+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387425AbfC0FUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:20:07 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46157 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733302AbfC0FUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:20:01 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E1BB12211F;
        Wed, 27 Mar 2019 01:19:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=jazQxO5SDKeT5a7CAR1pGDVUogRM8xG3iLjFwCK9tiE=; b=kP7AqFbt
        ln89Pn5oiZQsmuP/0Ees9HiktPyZ7WCEXbxEqIENVGIkT11fyy/8DXtmLhFTuLmw
        s8DxGEMg2vCR/ON/MxjN1AlcpKQgzRSxxQ878aFkuRL2oZ/oZSB1MeMj7lpQEyKn
        JV51xgVWjOS8114XZVCRI1j49arVxOOR7Y2303KMvs7OsO9WX8PPIo0MHANTgDqz
        xflL7aHIjwN5DsK5/rsrlS67TyHWiIP0KV9sp6zLu8s+dK78MRPad9uPARkyru1y
        MNKfsmXEDdoHDPz7AsMNS2mWO0FVAKDQcSh4IN8MqkZ7JzQh3P9Mg/bW5jwKrGc9
        xVOdvioURo9syQ==
X-ME-Sender: <xms:_webXDBP4WhX55bn4D3vRammQ9PEZ2CauKSFHWTKqUKBgP9VS6zSJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepvddu
X-ME-Proxy: <xmx:_webXGeV4EgnKQPPgmlcDx6kPkBLpkIu5cJYPdUer3XDfsmOwbrFfw>
    <xmx:_webXKNEt09qrG2L3cMCyb4KyHwmleIeHNmDgderkxWaguxQFVlUjQ>
    <xmx:_webXOI5NWGTWzaa4UbIpq_AESHnw4ziXnO2rwIGTcBq2N6DoUztcQ>
    <xmx:_webXOXAnGt9mN9-TJvxvFy2F_rEBVvH_57tfPl92k1CTLHIIM5rjQ>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id 07072E40FF;
        Wed, 27 Mar 2019 01:19:55 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH v3 23/24] dcache: Copy documentation to struct declaration
Date:   Wed, 27 Mar 2019 16:17:16 +1100
Message-Id: <20190327051717.23225-24-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the documentation for the struct dentry is located
in Documentation/filesystems/vfs.txt.  Having documentation far away
from the code increases the chance of docs getting stale.  This is
exactly what has happened, currently docs reference the 2.6.22 kernel.

The kernel has a mechanism for documenting structures in the
source/header files, we should use it.  This makes reading arguable
easier because documentation is right there with the source and also
helps prevent the docs from getting stale.

Copy documentation for struct dentry from vfs.txt and locate it with
the struct declaration.  Use kernel docs in preparation for including
the struct docs into the soon to be created vfs.rst

To ease review this patch does not touch vfs.txt, this file will be
converted to RST format shortly.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/dcache.h | 177 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 0643c5127e1a..442bba9dcec8 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -130,20 +130,197 @@ enum dentry_d_lock_class
 	DENTRY_D_LOCK_NESTED
 };
 
+/**
+ * struct dentry_operations - Describe how a filesystem can overload the
+ * standard dentry operations.
+ *
+ * Dentries and the dcache are the domain of the VFS and the individual
+ * filesystem implementations.  Device drivers have no business here.
+ * These methods may be set to %NULL, as they are either optional or the
+ * VFS uses a default.
+ *
+ * Each dentry has a pointer to its parent dentry, as well as a hash
+ * list of child dentries.  Child dentries are basically like files in a
+ * directory.
+ */
 struct dentry_operations {
+	/**
+	 * @d_revalidate: Called when the VFS needs to revalidate a
+	 * dentry.  This is called whenever a name look-up finds a
+	 * dentry in the dcache.  Most local filesystems leave this as
+	 * %NULL, because all their dentries in the dcache are valid.
+	 * Network filesystems are different since things can change on
+	 * the server without the client necessarily being aware of it.
+	 *
+	 * This function should return a positive value if the dentry is
+	 * still valid, and zero or a negative error code if it isn't.
+	 *
+	 * d_revalidate may be called in rcu-walk mode (flags &
+	 * LOOKUP_RCU).  If in rcu-walk mode, the filesystem must
+	 * revalidate the dentry without blocking or storing to the
+	 * dentry, d_parent and d_inode should not be used without care
+	 * (because they can change and, in d_inode case, even become
+	 * %NULL under us).
+	 *
+	 * If a situation is encountered that rcu-walk
+	 * cannot handle, return -ECHILD and it will be called again
+	 * in ref-walk mode.
+	 */
 	int (*d_revalidate)(struct dentry *, unsigned int);
+
+	/**
+	 * @d_weak_revalidate: Called when the VFS needs to revalidate a
+	 * "jumped" dentry.  This is called when a path-walk ends at
+	 * dentry that was not acquired by doing a lookup in the parent
+	 * directory.  This includes "/", "." and "..", as well as
+	 * procfs-style symlinks and mountpoint traversal.
+	 *
+	 * In this case, we are less concerned with whether the dentry
+	 * is still fully correct, but rather that the inode is still
+	 * valid.  As with d_revalidate, most local filesystems will set
+	 * this to %NULL since their dcache entries are always valid.
+	 *
+	 * This function has the same return code semantics as
+	 * d_revalidate.
+	 *
+	 * d_weak_revalidate is only called after leaving rcu-walk mode.
+	 */
 	int (*d_weak_revalidate)(struct dentry *, unsigned int);
+
+	/**
+	 * @d_hash: Called when the VFS adds a dentry to the hash table.
+	 * The first dentry passed to d_hash is the parent directory
+	 * that the name is to be hashed into.
+	 *
+	 * Same locking and synchronisation rules as d_compare regarding
+	 * what is safe to dereference etc.
+	 */
 	int (*d_hash)(const struct dentry *, struct qstr *);
+
+	/**
+	 * @d_compare: Called to compare a dentry name with a given name.  The first
+	 * dentry is the parent of the dentry to be compared, the second is
+	 * the child dentry.  len and name string are properties of the dentry
+	 * to be compared.  qstr is the name to compare it with.
+	 *
+	 * Must be constant and idempotent, and should not take locks if
+	 * possible, and should not or store into the dentry.
+	 * Should not dereference pointers outside the dentry without
+	 * lots of care (eg.  d_parent, d_inode, d_name should not be used).
+	 *
+	 * However, our vfsmount is pinned, and RCU held, so the dentries and
+	 * inodes won't disappear, neither will our sb or filesystem module.
+	 * ->d_sb may be used.
+	 *
+	 * It is a tricky calling convention because it needs to be called under
+	 * "rcu-walk", ie. without any locks or references on things.
+	 */
 	int (*d_compare)(const struct dentry *,
 			unsigned int, const char *, const struct qstr *);
+
+	/**
+	 * @d_delete: Called when the last reference to a dentry is
+	 * dropped and the dcache is deciding whether or not to cache
+	 * it.  Return 1 to delete immediately, or 0 to cache the
+	 * dentry.  Default is %NULL which means to always cache a
+	 * reachable dentry.  d_delete() must be constant and idempotent.
+	 */
 	int (*d_delete)(const struct dentry *);
+
+	/**
+	 * @d_init: Called when a dentry is allocated.
+	 */
 	int (*d_init)(struct dentry *);
+
+	/**
+	 * @d_release: Called when a dentry is really deallocated.
+	 */
 	void (*d_release)(struct dentry *);
+
+	/**
+	 * @d_prune: Called by the VFS to inform the fs that this dentry
+	 * is about to be unhashed and destroyed.
+	 */
 	void (*d_prune)(struct dentry *);
+
+	/**
+	 * @d_iput: Called when a dentry loses its inode (just prior to
+	 * its being deallocated).  The default when this is %NULL is
+	 * that the VFS calls iput().  If you define this method, you
+	 * must call iput() yourself.
+	 */
 	void (*d_iput)(struct dentry *, struct inode *);
+
+	/**
+	 * @d_dname: Called when the pathname of a dentry should be
+	 * generated.  Useful for some pseudo filesystems (sockfs,
+	 * pipefs, ...) to delay pathname generation.  (Instead of doing
+	 * it when dentry is created, it's done only when the path is
+	 * needed.).  Real filesystems probably dont want to use it,
+	 * because their dentries are present in global dcache hash, so
+	 * their hash should be an invariant.  As no lock is held,
+	 * d_dname() should not try to modify the dentry itself, unless
+	 * appropriate SMP safety is used.  CAUTION : d_path() logic is
+	 * quite tricky.  The correct way to return for example "Hello"
+	 * is to put it at the end of the buffer, and returns a pointer
+	 * to the first char.  dynamic_dname() helper function is
+	 * provided to take care of this.  (See vfs.rst for an example.)
+	 */
 	char *(*d_dname)(struct dentry *, char *, int);
+
+	/**
+	 * @d_automount: Called when an automount dentry is to be
+	 * traversed (optional).  This should create a new VFS mount
+	 * record and return the record to the caller.  The caller is
+	 * supplied with a path parameter giving the automount directory
+	 * to describe the automount target and the parent VFS mount
+	 * record to provide inheritable mount parameters.  %NULL should
+	 * be returned if someone else managed to make the automount
+	 * first.  If the vfsmount creation failed, then an error code
+	 * should be returned.  If -EISDIR is returned, then the
+	 * directory will be treated as an ordinary directory and
+	 * returned to pathwalk to continue walking.  If a vfsmount is
+	 * returned, the caller will attempt to mount it on the
+	 * mountpoint and will remove the vfsmount from its expiration
+	 * list in the case of failure.  The vfsmount should be returned
+	 * with 2 refs on it to prevent automatic expiration - the
+	 * caller will clean up the additional ref.  This function is
+	 * only used if DCACHE_NEED_AUTOMOUNT is set on the dentry.
+	 * This is set by __d_instantiate() if S_AUTOMOUNT is set on the
+	 * inode being added.
+	 */
 	struct vfsmount *(*d_automount)(struct path *);
+
+	/**
+	 * @d_manage: Called to allow the filesystem to manage the
+	 * transition from a dentry (optional).  This allows autofs, for
+	 * example, to hold up clients waiting to explore behind a
+	 * 'mountpoint' while letting the daemon go past and construct
+	 * the subtree there.  0 should be returned to let the calling
+	 * process continue.  -EISDIR can be returned to tell pathwalk
+	 * to use this directory as an ordinary directory and to ignore
+	 * anything mounted on it and not to check the automount flag.
+	 * Any other error code will abort pathwalk completely.  If the
+	 * 'rcu_walk' parameter is true, then the caller is doing a
+	 * pathwalk in RCU-walk mode.  Sleeping is not permitted in this
+	 * mode, and the caller can be asked to leave it and call again
+	 * by returning -* ECHILD.  -EISDIR may also be returned to tell
+	 * pathwalk to ignore d_automount or any mounts.  This function
+	 * is only used if DCACHE_MANAGE_TRANSIT is set on the dentry
+	 * being transited from.
+	 */
 	int (*d_manage)(const struct path *, bool);
+
+	/**
+	 * @d_real: overlay/union type filesystems implement this method
+	 * to return one of the underlying dentries hidden by the
+	 * overlay.  It is used in two different modes: Called from
+	 * file_dentry() it returns the real dentry matching the inode
+	 * argument.  The real dentry may be from a lower layer already
+	 * copied up, but still referenced from the file.  This mode is
+	 * selected with a non-NULL inode argument.  With %NULL inode
+	 * the topmost real underlying dentry is returned.
+	 */
 	struct dentry *(*d_real)(struct dentry *, const struct inode *);
 } ____cacheline_aligned;
 
-- 
2.21.0

