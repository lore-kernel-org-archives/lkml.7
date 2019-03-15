Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD7DC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD72218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfCOXJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:09:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfCOXJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:09:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7EA6E308CFB9;
        Fri, 15 Mar 2019 23:00:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F6BE600C4;
        Fri, 15 Mar 2019 23:00:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/10] afs: Handle lock rpc ops failing on a file that got
 deleted
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Jonathan Billings <jsbillin@umich.edu>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 15 Mar 2019 23:00:14 +0000
Message-ID: <155269081456.8537.5454244654980801039.stgit@warthog.procyon.org.uk>
In-Reply-To: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
References: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 15 Mar 2019 23:00:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Holding a file lock on an AFS file does not prevent it from being deleted
on the server, so we need to handle an error resulting from that when we
try setting, extending or releasing a lock.

Fix this by adding a "deleted" lock state and cancelling the lock extension
process for that file and aborting all waiters for the lock.

Fixes: 0fafdc9f888b ("afs: Fix file locking")
Reported-by: Jonathan Billings <jsbillin@umich.edu>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/flock.c             |   62 ++++++++++++++++++++++++++++++++++++++++++--
 fs/afs/internal.h          |    1 +
 include/trace/events/afs.h |    7 ++++-
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 2237ab4ea111..08b06f53a375 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -157,6 +157,28 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
 	_leave("");
 }
 
+/*
+ * Kill off all waiters in the the pending lock queue due to the vnode being
+ * deleted.
+ */
+static void afs_kill_lockers_enoent(struct afs_vnode *vnode)
+{
+	struct file_lock *p;
+
+	afs_set_lock_state(vnode, AFS_VNODE_LOCK_DELETED);
+
+	while (!list_empty(&vnode->pending_locks)) {
+		p = list_entry(vnode->pending_locks.next,
+			       struct file_lock, fl_u.afs.link);
+		list_del_init(&p->fl_u.afs.link);
+		p->fl_u.afs.state = -ENOENT;
+		wake_up(&p->fl_wait);
+	}
+
+	key_put(vnode->lock_key);
+	vnode->lock_key = NULL;
+}
+
 /*
  * Get a lock on a file
  */
@@ -278,13 +300,19 @@ void afs_lock_work(struct work_struct *work)
 		/* attempt to release the server lock; if it fails, we just
 		 * wait 5 minutes and it'll expire anyway */
 		ret = afs_release_lock(vnode, vnode->lock_key);
-		if (ret < 0)
+		if (ret < 0) {
+			trace_afs_flock_ev(vnode, NULL, afs_flock_release_fail,
+					   ret);
 			printk(KERN_WARNING "AFS:"
 			       " Failed to release lock on {%llx:%llx} error %d\n",
 			       vnode->fid.vid, vnode->fid.vnode, ret);
+		}
 
 		spin_lock(&vnode->lock);
-		afs_next_locker(vnode, 0);
+		if (ret == -ENOENT)
+			afs_kill_lockers_enoent(vnode);
+		else
+			afs_next_locker(vnode, 0);
 		spin_unlock(&vnode->lock);
 		return;
 
@@ -304,12 +332,21 @@ void afs_lock_work(struct work_struct *work)
 		ret = afs_extend_lock(vnode, key); /* RPC */
 		key_put(key);
 
-		if (ret < 0)
+		if (ret < 0) {
+			trace_afs_flock_ev(vnode, NULL, afs_flock_extend_fail,
+					   ret);
 			pr_warning("AFS: Failed to extend lock on {%llx:%llx} error %d\n",
 				   vnode->fid.vid, vnode->fid.vnode, ret);
+		}
 
 		spin_lock(&vnode->lock);
 
+		if (ret == -ENOENT) {
+			afs_kill_lockers_enoent(vnode);
+			spin_unlock(&vnode->lock);
+			return;
+		}
+
 		if (vnode->lock_state != AFS_VNODE_LOCK_EXTENDING)
 			goto again;
 		afs_set_lock_state(vnode, AFS_VNODE_LOCK_GRANTED);
@@ -333,6 +370,11 @@ void afs_lock_work(struct work_struct *work)
 		spin_unlock(&vnode->lock);
 		return;
 
+	case AFS_VNODE_LOCK_DELETED:
+		afs_kill_lockers_enoent(vnode);
+		spin_unlock(&vnode->lock);
+		return;
+
 	default:
 		/* Looks like a lock request was withdrawn. */
 		spin_unlock(&vnode->lock);
@@ -435,6 +477,10 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	spin_lock(&vnode->lock);
 	list_add_tail(&fl->fl_u.afs.link, &vnode->pending_locks);
 
+	ret = -ENOENT;
+	if (vnode->lock_state == AFS_VNODE_LOCK_DELETED)
+		goto error_unlock;
+
 	/* If we've already got a lock on the server then try to move to having
 	 * the VFS grant the requested lock.  Note that this means that other
 	 * clients may get starved out.
@@ -489,6 +535,13 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 		afs_next_locker(vnode, ret);
 		goto error_unlock;
 
+	case -ENOENT:
+		fl->fl_u.afs.state = ret;
+		trace_afs_flock_ev(vnode, fl, afs_flock_fail_other, ret);
+		list_del_init(&fl->fl_u.afs.link);
+		afs_kill_lockers_enoent(vnode);
+		goto error_unlock;
+
 	default:
 		fl->fl_u.afs.state = ret;
 		trace_afs_flock_ev(vnode, fl, afs_flock_fail_other, ret);
@@ -638,6 +691,9 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
 
 	_enter("");
 
+	if (vnode->lock_state == AFS_VNODE_LOCK_DELETED)
+		return -ENOENT;
+
 	fl->fl_type = F_UNLCK;
 
 	/* check local lock records first */
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 37a5ba550846..d6763e59952d 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -600,6 +600,7 @@ enum afs_lock_state {
 	AFS_VNODE_LOCK_EXTENDING,	/* We're extending a lock on the server */
 	AFS_VNODE_LOCK_NEED_UNLOCK,	/* We need to unlock on the server */
 	AFS_VNODE_LOCK_UNLOCKING,	/* We're telling the server to unlock */
+	AFS_VNODE_LOCK_DELETED,		/* The vnode has been deleted whilst we have a lock */
 };
 
 /*
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 24c058a93e8f..21b896fabb2f 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -156,9 +156,11 @@ enum afs_flock_event {
 	afs_flock_acquired,
 	afs_flock_callback_break,
 	afs_flock_defer_unlock,
+	afs_flock_extend_fail,
 	afs_flock_fail_other,
 	afs_flock_fail_perm,
 	afs_flock_no_lockers,
+	afs_flock_release_fail,
 	afs_flock_timestamp,
 	afs_flock_try_to_lock,
 	afs_flock_vfs_lock,
@@ -323,15 +325,18 @@ enum afs_flock_operation {
 	EM(AFS_VNODE_LOCK_GRANTED,		"GRANTED")		\
 	EM(AFS_VNODE_LOCK_EXTENDING,		"EXTENDING")		\
 	EM(AFS_VNODE_LOCK_NEED_UNLOCK,		"NEED_UNLOCK")		\
-	E_(AFS_VNODE_LOCK_UNLOCKING,		"UNLOCKING")		\
+	EM(AFS_VNODE_LOCK_UNLOCKING,		"UNLOCKING")		\
+	E_(AFS_VNODE_LOCK_DELETED,		"DELETED")
 
 #define afs_flock_events						\
 	EM(afs_flock_acquired,			"Acquired")		\
 	EM(afs_flock_callback_break,		"Callback")		\
 	EM(afs_flock_defer_unlock,		"D-Unlock")		\
+	EM(afs_flock_extend_fail,		"Ext_Fail")		\
 	EM(afs_flock_fail_other,		"ErrOther")		\
 	EM(afs_flock_fail_perm,			"ErrPerm ")		\
 	EM(afs_flock_no_lockers,		"NoLocker")		\
+	EM(afs_flock_release_fail,		"Rel_Fail")		\
 	EM(afs_flock_timestamp,			"Timestmp")		\
 	EM(afs_flock_try_to_lock,		"TryToLck")		\
 	EM(afs_flock_vfs_lock,			"VFSLock ")		\

