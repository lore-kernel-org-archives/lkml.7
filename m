Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B69C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9BB20818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfEOU7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:59:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfEOU7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:59:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BDE03E2B7;
        Wed, 15 May 2019 20:59:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB17F1001DE1;
        Wed, 15 May 2019 20:59:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/12] afs: Make vnode->cb_interest RCU safe
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 21:59:18 +0100
Message-ID: <155795395854.28355.7689625786953818696.stgit@warthog.procyon.org.uk>
In-Reply-To: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
References: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 15 May 2019 20:59:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use RCU-based freeing for afs_cb_interest struct objects and use RCU on
vnode->cb_interest.  Use that change to allow afs_check_validity() to use
read_seqbegin_or_lock() instead of read_seqlock_excl().

This also requires the caller of afs_check_validity() to hold the RCU read
lock across the call.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/callback.c |   21 ++++++++------
 fs/afs/dir.c      |   15 +++++++---
 fs/afs/inode.c    |   81 +++++++++++++++++++++++++++++++++--------------------
 fs/afs/internal.h |   12 ++++++--
 fs/afs/rotate.c   |   18 ++++++++----
 fs/afs/security.c |    8 +++--
 fs/afs/super.c    |    4 +--
 7 files changed, 100 insertions(+), 59 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 4876079aa643..d441bef72163 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -94,15 +94,15 @@ int afs_register_server_cb_interest(struct afs_vnode *vnode,
 	struct afs_server *server = entry->server;
 
 again:
-	if (vnode->cb_interest &&
-	    likely(vnode->cb_interest == entry->cb_interest))
+	vcbi = rcu_dereference_protected(vnode->cb_interest,
+					 lockdep_is_held(&vnode->io_lock));
+	if (vcbi && likely(vcbi == entry->cb_interest))
 		return 0;
 
 	read_lock(&slist->lock);
 	cbi = afs_get_cb_interest(entry->cb_interest);
 	read_unlock(&slist->lock);
 
-	vcbi = vnode->cb_interest;
 	if (vcbi) {
 		if (vcbi == cbi) {
 			afs_put_cb_interest(afs_v2net(vnode), cbi);
@@ -114,8 +114,9 @@ int afs_register_server_cb_interest(struct afs_vnode *vnode,
 		 */
 		if (cbi && vcbi->server == cbi->server) {
 			write_seqlock(&vnode->cb_lock);
-			old = vnode->cb_interest;
-			vnode->cb_interest = cbi;
+			old = rcu_dereference_protected(vnode->cb_interest,
+							lockdep_is_held(&vnode->cb_lock.lock));
+			rcu_assign_pointer(vnode->cb_interest, cbi);
 			write_sequnlock(&vnode->cb_lock);
 			afs_put_cb_interest(afs_v2net(vnode), old);
 			return 0;
@@ -160,8 +161,9 @@ int afs_register_server_cb_interest(struct afs_vnode *vnode,
 	 */
 	write_seqlock(&vnode->cb_lock);
 
-	old = vnode->cb_interest;
-	vnode->cb_interest = cbi;
+	old = rcu_dereference_protected(vnode->cb_interest,
+					lockdep_is_held(&vnode->cb_lock.lock));
+	rcu_assign_pointer(vnode->cb_interest, cbi);
 	vnode->cb_s_break = cbi->server->cb_s_break;
 	vnode->cb_v_break = vnode->volume->cb_v_break;
 	clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
@@ -191,10 +193,11 @@ void afs_put_cb_interest(struct afs_net *net, struct afs_cb_interest *cbi)
 				vi = NULL;
 
 			write_unlock(&cbi->server->cb_break_lock);
-			kfree(vi);
+			if (vi)
+				kfree_rcu(vi, rcu);
 			afs_put_server(net, cbi->server);
 		}
-		kfree(cbi);
+		kfree_rcu(cbi, rcu);
 	}
 }
 
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index f7344b045799..338c2260b0a0 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -638,11 +638,12 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 				   struct key *key)
 {
 	struct afs_lookup_cookie *cookie;
-	struct afs_cb_interest *cbi = NULL;
+	struct afs_cb_interest *dcbi, *cbi = NULL;
 	struct afs_super_info *as = dir->i_sb->s_fs_info;
 	struct afs_status_cb *scb;
 	struct afs_iget_data data;
 	struct afs_fs_cursor fc;
+	struct afs_server *server;
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
 	struct inode *inode = NULL;
 	int ret, i;
@@ -658,10 +659,14 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 	cookie->nr_fids = 1; /* slot 0 is saved for the fid we actually want */
 
 	read_seqlock_excl(&dvnode->cb_lock);
-	if (dvnode->cb_interest &&
-	    dvnode->cb_interest->server &&
-	    test_bit(AFS_SERVER_FL_NO_IBULK, &dvnode->cb_interest->server->flags))
-		cookie->one_only = true;
+	dcbi = rcu_dereference_protected(dvnode->cb_interest,
+					 lockdep_is_held(&dvnode->cb_lock.lock));
+	if (dcbi) {
+		server = dcbi->server;
+		if (server &&
+		    test_bit(AFS_SERVER_FL_NO_IBULK, &server->flags))
+			cookie->one_only = true;
+	}
 	read_sequnlock_excl(&dvnode->cb_lock);
 
 	for (i = 0; i < 50; i++)
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index a89948a9dd0d..3633703dbc0c 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -139,9 +139,10 @@ static int afs_inode_init_from_status(struct afs_vnode *vnode, struct key *key,
 		vnode->cb_expires_at = ktime_get_real_seconds();
 	} else {
 		vnode->cb_expires_at = scb->callback.expires_at;
-		old_cbi = vnode->cb_interest;
+		old_cbi = rcu_dereference_protected(vnode->cb_interest,
+						    lockdep_is_held(&vnode->cb_lock.lock));
 		if (cbi != old_cbi)
-			vnode->cb_interest = afs_get_cb_interest(cbi);
+			rcu_assign_pointer(vnode->cb_interest, afs_get_cb_interest(cbi));
 		else
 			old_cbi = NULL;
 		set_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
@@ -245,9 +246,10 @@ static void afs_apply_callback(struct afs_fs_cursor *fc,
 
 	if (!afs_cb_is_broken(cb_break, vnode, fc->cbi)) {
 		vnode->cb_expires_at	= cb->expires_at;
-		old = vnode->cb_interest;
+		old = rcu_dereference_protected(vnode->cb_interest,
+						lockdep_is_held(&vnode->cb_lock.lock));
 		if (old != fc->cbi) {
-			vnode->cb_interest = afs_get_cb_interest(fc->cbi);
+			rcu_assign_pointer(vnode->cb_interest, afs_get_cb_interest(fc->cbi));
 			afs_put_cb_interest(afs_v2net(vnode), old);
 		}
 		set_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
@@ -564,36 +566,46 @@ void afs_zap_data(struct afs_vnode *vnode)
  */
 bool afs_check_validity(struct afs_vnode *vnode)
 {
+	struct afs_cb_interest *cbi;
+	struct afs_server *server;
+	struct afs_volume *volume = vnode->volume;
 	time64_t now = ktime_get_real_seconds();
 	bool valid;
+	unsigned int cb_break, cb_s_break, cb_v_break;
+	int seq = 0;
 
-	/* Quickly check the callback state.  Ideally, we'd use read_seqbegin
-	 * here, but we have no way to pass the net namespace to the RCU
-	 * cleanup for the server record.
-	 */
-	read_seqlock_excl(&vnode->cb_lock);
-
-	if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
-		if (vnode->cb_s_break != vnode->cb_interest->server->cb_s_break ||
-		    vnode->cb_v_break != vnode->volume->cb_v_break) {
-			vnode->cb_s_break = vnode->cb_interest->server->cb_s_break;
-			vnode->cb_v_break = vnode->volume->cb_v_break;
-			valid = false;
-		} else if (test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags)) {
-			valid = false;
-		} else if (vnode->cb_expires_at - 10 <= now) {
-			valid = false;
-		} else {
+	do {
+		read_seqbegin_or_lock(&vnode->cb_lock, &seq);
+		cb_v_break = READ_ONCE(volume->cb_v_break);
+		cb_break = vnode->cb_break;
+
+		if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
+			cbi = rcu_dereference(vnode->cb_interest);
+			server = rcu_dereference(cbi->server);
+			cb_s_break = READ_ONCE(server->cb_s_break);
+
+			if (vnode->cb_s_break != cb_s_break ||
+			    vnode->cb_v_break != cb_v_break) {
+				vnode->cb_s_break = cb_s_break;
+				vnode->cb_v_break = cb_v_break;
+				valid = false;
+			} else if (test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags)) {
+				valid = false;
+			} else if (vnode->cb_expires_at - 10 <= now) {
+				valid = false;
+			} else {
+				valid = true;
+			}
+		} else if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
 			valid = true;
+		} else {
+			vnode->cb_v_break = cb_v_break;
+			valid = false;
 		}
-	} else if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
-		valid = true;
-	} else {
-		vnode->cb_v_break = vnode->volume->cb_v_break;
-		valid = false;
-	}
 
-	read_sequnlock_excl(&vnode->cb_lock);
+	} while (need_seqretry(&vnode->cb_lock, seq));
+
+	done_seqretry(&vnode->cb_lock, seq);
 	return valid;
 }
 
@@ -615,7 +627,9 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 	       vnode->fid.vid, vnode->fid.vnode, vnode->flags,
 	       key_serial(key));
 
+	rcu_read_lock();
 	valid = afs_check_validity(vnode);
+	rcu_read_unlock();
 
 	if (test_bit(AFS_VNODE_DELETED, &vnode->flags))
 		clear_nlink(&vnode->vfs_inode);
@@ -702,6 +716,7 @@ int afs_drop_inode(struct inode *inode)
  */
 void afs_evict_inode(struct inode *inode)
 {
+	struct afs_cb_interest *cbi;
 	struct afs_vnode *vnode;
 
 	vnode = AFS_FS_I(inode);
@@ -718,10 +733,14 @@ void afs_evict_inode(struct inode *inode)
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 
-	if (vnode->cb_interest) {
-		afs_put_cb_interest(afs_i2net(inode), vnode->cb_interest);
-		vnode->cb_interest = NULL;
+	write_seqlock(&vnode->cb_lock);
+	cbi = rcu_dereference_protected(vnode->cb_interest,
+					lockdep_is_held(&vnode->cb_lock.lock));
+	if (cbi) {
+		afs_put_cb_interest(afs_i2net(inode), cbi);
+		rcu_assign_pointer(vnode->cb_interest, NULL);
 	}
+	write_sequnlock(&vnode->cb_lock);
 
 	while (!list_empty(&vnode->wb_keys)) {
 		struct afs_wb_key *wbk = list_entry(vnode->wb_keys.next,
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index d19182e9c15c..0a5a3a77ed9d 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -553,7 +553,10 @@ struct afs_server {
 struct afs_vol_interest {
 	struct hlist_node	srv_link;	/* Link in server->cb_volumes */
 	struct hlist_head	cb_interests;	/* List of callback interests on the server */
-	afs_volid_t		vid;		/* Volume ID to match */
+	union {
+		struct rcu_head	rcu;
+		afs_volid_t	vid;		/* Volume ID to match */
+	};
 	unsigned int		usage;
 };
 
@@ -565,7 +568,10 @@ struct afs_cb_interest {
 	struct afs_vol_interest	*vol_interest;
 	struct afs_server	*server;	/* Server on which this interest resides */
 	struct super_block	*sb;		/* Superblock on which inodes reside */
-	afs_volid_t		vid;		/* Volume ID to match */
+	union {
+		struct rcu_head	rcu;
+		afs_volid_t	vid;		/* Volume ID to match */
+	};
 	refcount_t		usage;
 };
 
@@ -675,7 +681,7 @@ struct afs_vnode {
 	afs_lock_type_t		lock_type : 8;
 
 	/* outstanding callback notification on this file */
-	struct afs_cb_interest	*cb_interest;	/* Server on which this resides */
+	struct afs_cb_interest __rcu *cb_interest; /* Server on which this resides */
 	unsigned int		cb_s_break;	/* Mass break counter on ->server */
 	unsigned int		cb_v_break;	/* Mass break counter on ->volume */
 	unsigned int		cb_break;	/* Break counter on vnode */
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index cb47f45c9681..641168a11071 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -66,7 +66,8 @@ static bool afs_start_fs_iteration(struct afs_fs_cursor *fc,
 	fc->untried = (1UL << fc->server_list->nr_servers) - 1;
 	fc->index = READ_ONCE(fc->server_list->preferred);
 
-	cbi = vnode->cb_interest;
+	cbi = rcu_dereference_protected(vnode->cb_interest,
+					lockdep_is_held(&vnode->io_lock));
 	if (cbi) {
 		/* See if the vnode's preferred record is still available */
 		for (i = 0; i < fc->server_list->nr_servers; i++) {
@@ -87,8 +88,8 @@ static bool afs_start_fs_iteration(struct afs_fs_cursor *fc,
 
 		/* Note that the callback promise is effectively broken */
 		write_seqlock(&vnode->cb_lock);
-		ASSERTCMP(cbi, ==, vnode->cb_interest);
-		vnode->cb_interest = NULL;
+		ASSERTCMP(cbi, ==, rcu_access_pointer(vnode->cb_interest));
+		rcu_assign_pointer(vnode->cb_interest, NULL);
 		if (test_and_clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags))
 			vnode->cb_break++;
 		write_sequnlock(&vnode->cb_lock);
@@ -417,7 +418,9 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	if (error < 0)
 		goto failed_set_error;
 
-	fc->cbi = afs_get_cb_interest(vnode->cb_interest);
+	fc->cbi = afs_get_cb_interest(
+		rcu_dereference_protected(vnode->cb_interest,
+					  lockdep_is_held(&vnode->io_lock)));
 
 	read_lock(&server->fs_lock);
 	alist = rcu_dereference_protected(server->addresses,
@@ -485,12 +488,15 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
 {
 	struct afs_vnode *vnode = fc->vnode;
-	struct afs_cb_interest *cbi = vnode->cb_interest;
+	struct afs_cb_interest *cbi;
 	struct afs_addr_list *alist;
 	int error = fc->ac.error;
 
 	_enter("");
 
+	cbi = rcu_dereference_protected(vnode->cb_interest,
+					lockdep_is_held(&vnode->io_lock));
+
 	switch (error) {
 	case SHRT_MAX:
 		if (!cbi) {
@@ -499,7 +505,7 @@ bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
 			return false;
 		}
 
-		fc->cbi = afs_get_cb_interest(vnode->cb_interest);
+		fc->cbi = afs_get_cb_interest(cbi);
 
 		read_lock(&cbi->server->fs_lock);
 		alist = rcu_dereference_protected(cbi->server->addresses,
diff --git a/fs/afs/security.c b/fs/afs/security.c
index 857f09d09ee9..5d8ece98561e 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -146,7 +146,7 @@ void afs_cache_permit(struct afs_vnode *vnode, struct key *key,
 				}
 
 				if (afs_cb_is_broken(cb_break, vnode,
-						     vnode->cb_interest)) {
+						     rcu_dereference(vnode->cb_interest))) {
 					changed = true;
 					break;
 				}
@@ -176,7 +176,7 @@ void afs_cache_permit(struct afs_vnode *vnode, struct key *key,
 		}
 	}
 
-	if (afs_cb_is_broken(cb_break, vnode, vnode->cb_interest))
+	if (afs_cb_is_broken(cb_break, vnode, rcu_dereference(vnode->cb_interest)))
 		goto someone_else_changed_it;
 
 	/* We need a ref on any permits list we want to copy as we'll have to
@@ -253,14 +253,16 @@ void afs_cache_permit(struct afs_vnode *vnode, struct key *key,
 
 	kfree(new);
 
+	rcu_read_lock();
 	spin_lock(&vnode->lock);
 	zap = rcu_access_pointer(vnode->permit_cache);
-	if (!afs_cb_is_broken(cb_break, vnode, vnode->cb_interest) &&
+	if (!afs_cb_is_broken(cb_break, vnode, rcu_dereference(vnode->cb_interest)) &&
 	    zap == permits)
 		rcu_assign_pointer(vnode->permit_cache, replacement);
 	else
 		zap = replacement;
 	spin_unlock(&vnode->lock);
+	rcu_read_unlock();
 	afs_put_permits(zap);
 out_put:
 	afs_put_permits(permits);
diff --git a/fs/afs/super.c b/fs/afs/super.c
index a81c235f8c57..f76473ad7bbb 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -677,7 +677,7 @@ static struct inode *afs_alloc_inode(struct super_block *sb)
 	vnode->volume		= NULL;
 	vnode->lock_key		= NULL;
 	vnode->permit_cache	= NULL;
-	vnode->cb_interest	= NULL;
+	RCU_INIT_POINTER(vnode->cb_interest, NULL);
 #ifdef CONFIG_AFS_FSCACHE
 	vnode->cache		= NULL;
 #endif
@@ -707,7 +707,7 @@ static void afs_destroy_inode(struct inode *inode)
 
 	_debug("DESTROY INODE %p", inode);
 
-	ASSERTCMP(vnode->cb_interest, ==, NULL);
+	ASSERTCMP(rcu_access_pointer(vnode->cb_interest), ==, NULL);
 
 	atomic_dec(&afs_count_active_inodes);
 }

