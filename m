Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1458C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556A32085A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfCOXIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:08:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfCOXIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:08:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91FE7308FBA0;
        Fri, 15 Mar 2019 23:00:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 558A919C57;
        Fri, 15 Mar 2019 23:00:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/10] afs: Add file locking tracepoints
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 15 Mar 2019 22:59:57 +0000
Message-ID: <155269079759.8537.6038223847145005460.stgit@warthog.procyon.org.uk>
In-Reply-To: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
References: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 15 Mar 2019 23:00:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two tracepoints for monitoring AFS file locking.  Firstly, add one that
follows the operational part:

    echo 1 >/sys/kernel/debug/tracing/events/afs/afs_flock_op/enable

And add a second that more follows the event-driven part:

    echo 1 >/sys/kernel/debug/tracing/events/afs/afs_flock_ev/enable

Individual file_lock structs seen by afs are tagged with debugging IDs that
are displayed in the trace log to make it easier to see what's going on,
especially as setting the first lock always seems to involve copying the
file_lock twice.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/flock.c             |   72 +++++++++++++++++++---
 include/linux/fs.h         |    1 
 include/trace/events/afs.h |  146 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+), 10 deletions(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index c022a7bd3d29..2237ab4ea111 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -32,6 +32,8 @@ static inline void afs_set_lock_state(struct afs_vnode *vnode, enum afs_lock_sta
 	vnode->lock_state = state;
 }
 
+static atomic_t afs_file_lock_debug_id;
+
 /*
  * if the callback is broken on this vnode, then the lock may now be available
  */
@@ -45,6 +47,7 @@ void afs_lock_may_be_available(struct afs_vnode *vnode)
 	spin_lock(&vnode->lock);
 	if (vnode->lock_state == AFS_VNODE_LOCK_WAITING_FOR_CB)
 		afs_next_locker(vnode, 0);
+	trace_afs_flock_ev(vnode, NULL, afs_flock_callback_break, 0);
 	spin_unlock(&vnode->lock);
 }
 
@@ -78,6 +81,7 @@ void afs_lock_op_done(struct afs_call *call)
 
 	if (call->error == 0) {
 		spin_lock(&vnode->lock);
+		trace_afs_flock_ev(vnode, NULL, afs_flock_timestamp, 0);
 		vnode->locked_at = call->reply_time;
 		afs_schedule_lock_extension(vnode);
 		spin_unlock(&vnode->lock);
@@ -100,6 +104,7 @@ static void afs_grant_locks(struct afs_vnode *vnode)
 
 		list_move_tail(&p->fl_u.afs.link, &vnode->granted_locks);
 		p->fl_u.afs.state = AFS_LOCK_GRANTED;
+		trace_afs_flock_op(vnode, p, afs_flock_op_grant);
 		wake_up(&p->fl_wait);
 	}
 }
@@ -142,9 +147,11 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
 	if (next) {
 		afs_set_lock_state(vnode, AFS_VNODE_LOCK_SETTING);
 		next->fl_u.afs.state = AFS_LOCK_YOUR_TRY;
+		trace_afs_flock_op(vnode, next, afs_flock_op_wake);
 		wake_up(&next->fl_wait);
 	} else {
 		afs_set_lock_state(vnode, AFS_VNODE_LOCK_NONE);
+		trace_afs_flock_ev(vnode, NULL, afs_flock_no_lockers, 0);
 	}
 
 	_leave("");
@@ -264,8 +271,8 @@ void afs_lock_work(struct work_struct *work)
 	_debug("wstate %u for %p", vnode->lock_state, vnode);
 	switch (vnode->lock_state) {
 	case AFS_VNODE_LOCK_NEED_UNLOCK:
-		_debug("unlock");
 		afs_set_lock_state(vnode, AFS_VNODE_LOCK_UNLOCKING);
+		trace_afs_flock_ev(vnode, NULL, afs_flock_work_unlocking, 0);
 		spin_unlock(&vnode->lock);
 
 		/* attempt to release the server lock; if it fails, we just
@@ -291,6 +298,7 @@ void afs_lock_work(struct work_struct *work)
 
 		key = key_get(vnode->lock_key);
 		afs_set_lock_state(vnode, AFS_VNODE_LOCK_EXTENDING);
+		trace_afs_flock_ev(vnode, NULL, afs_flock_work_extending, 0);
 		spin_unlock(&vnode->lock);
 
 		ret = afs_extend_lock(vnode, key); /* RPC */
@@ -349,6 +357,7 @@ static void afs_defer_unlock(struct afs_vnode *vnode)
 		cancel_delayed_work(&vnode->lock_work);
 
 		afs_set_lock_state(vnode, AFS_VNODE_LOCK_NEED_UNLOCK);
+		trace_afs_flock_ev(vnode, NULL, afs_flock_defer_unlock, 0);
 		queue_delayed_work(afs_lock_manager, &vnode->lock_work, 0);
 	}
 }
@@ -421,6 +430,8 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	if (ret < 0)
 		return ret;
 
+	trace_afs_flock_op(vnode, fl, afs_flock_op_set_lock);
+
 	spin_lock(&vnode->lock);
 	list_add_tail(&fl->fl_u.afs.link, &vnode->pending_locks);
 
@@ -457,7 +468,7 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	 * though we don't wait for the reply (it's not too bad a problem - the
 	 * lock will expire in 5 mins anyway).
 	 */
-	_debug("not locked");
+	trace_afs_flock_ev(vnode, fl, afs_flock_try_to_lock, 0);
 	vnode->lock_key = key_get(key);
 	vnode->lock_type = type;
 	afs_set_lock_state(vnode, AFS_VNODE_LOCK_SETTING);
@@ -473,12 +484,14 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	case -EPERM:
 	case -EACCES:
 		fl->fl_u.afs.state = ret;
+		trace_afs_flock_ev(vnode, fl, afs_flock_fail_perm, ret);
 		list_del_init(&fl->fl_u.afs.link);
 		afs_next_locker(vnode, ret);
 		goto error_unlock;
 
 	default:
 		fl->fl_u.afs.state = ret;
+		trace_afs_flock_ev(vnode, fl, afs_flock_fail_other, ret);
 		list_del_init(&fl->fl_u.afs.link);
 		afs_next_locker(vnode, 0);
 		goto error_unlock;
@@ -488,14 +501,13 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 		 * will have to retry.  The server will break the outstanding
 		 * callbacks on a file when a lock is released.
 		 */
-		_debug("would block");
 		ASSERT(list_empty(&vnode->granted_locks));
 		ASSERTCMP(vnode->pending_locks.next, ==, &fl->fl_u.afs.link);
 		goto lock_is_contended;
 
 	case 0:
-		_debug("acquired");
 		afs_set_lock_state(vnode, AFS_VNODE_LOCK_GRANTED);
+		trace_afs_flock_ev(vnode, fl, afs_flock_acquired, type);
 		afs_grant_locks(vnode);
 		goto vnode_is_locked_u;
 	}
@@ -507,7 +519,9 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	ASSERTCMP(fl->fl_u.afs.state, ==, AFS_LOCK_GRANTED);
 
 	/* ... but the VFS still needs to distribute access on this client. */
+	trace_afs_flock_ev(vnode, fl, afs_flock_vfs_locking, 0);
 	ret = locks_lock_file_wait(file, fl);
+	trace_afs_flock_ev(vnode, fl, afs_flock_vfs_lock, ret);
 	if (ret < 0)
 		goto vfs_rejected_lock;
 
@@ -528,6 +542,7 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	}
 
 	afs_set_lock_state(vnode, AFS_VNODE_LOCK_WAITING_FOR_CB);
+	trace_afs_flock_ev(vnode, fl, afs_flock_would_block, ret);
 	queue_delayed_work(afs_lock_manager, &vnode->lock_work, HZ * 5);
 
 need_to_wait:
@@ -538,10 +553,10 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	 */
 	spin_unlock(&vnode->lock);
 
-	_debug("sleep");
+	trace_afs_flock_ev(vnode, fl, afs_flock_waiting, 0);
 	ret = wait_event_interruptible(fl->fl_wait,
 				       fl->fl_u.afs.state != AFS_LOCK_PENDING);
-	_debug("wait = %d", ret);
+	trace_afs_flock_ev(vnode, fl, afs_flock_waited, ret);
 
 	if (fl->fl_u.afs.state >= 0 && fl->fl_u.afs.state != AFS_LOCK_GRANTED) {
 		spin_lock(&vnode->lock);
@@ -602,6 +617,8 @@ static int afs_do_unlk(struct file *file, struct file_lock *fl)
 
 	_enter("{%llx:%llu},%u", vnode->fid.vid, vnode->fid.vnode, fl->fl_type);
 
+	trace_afs_flock_op(vnode, fl, afs_flock_op_unlock);
+
 	/* Flush all pending writes before doing anything with locks. */
 	vfs_fsync(file, 0);
 
@@ -655,6 +672,8 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
 int afs_lock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct afs_vnode *vnode = AFS_FS_I(locks_inode(file));
+	enum afs_flock_operation op;
+	int ret;
 
 	_enter("{%llx:%llu},%d,{t=%x,fl=%x,r=%Ld:%Ld}",
 	       vnode->fid.vid, vnode->fid.vnode, cmd,
@@ -667,9 +686,23 @@ int afs_lock(struct file *file, int cmd, struct file_lock *fl)
 
 	if (IS_GETLK(cmd))
 		return afs_do_getlk(file, fl);
+
+	fl->fl_u.afs.debug_id = atomic_inc_return(&afs_file_lock_debug_id);
+	trace_afs_flock_op(vnode, fl, afs_flock_op_lock);
+
 	if (fl->fl_type == F_UNLCK)
-		return afs_do_unlk(file, fl);
-	return afs_do_setlk(file, fl);
+		ret = afs_do_unlk(file, fl);
+	else
+		ret = afs_do_setlk(file, fl);
+
+	switch (ret) {
+	case 0:		op = afs_flock_op_return_ok; break;
+	case -EAGAIN:	op = afs_flock_op_return_eagain; break;
+	case -EDEADLK:	op = afs_flock_op_return_edeadlk; break;
+	default:	op = afs_flock_op_return_error; break;
+	}
+	trace_afs_flock_op(vnode, fl, op);
+	return ret;
 }
 
 /*
@@ -678,6 +711,8 @@ int afs_lock(struct file *file, int cmd, struct file_lock *fl)
 int afs_flock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct afs_vnode *vnode = AFS_FS_I(locks_inode(file));
+	enum afs_flock_operation op;
+	int ret;
 
 	_enter("{%llx:%llu},%d,{t=%x,fl=%x}",
 	       vnode->fid.vid, vnode->fid.vnode, cmd,
@@ -693,10 +728,23 @@ int afs_flock(struct file *file, int cmd, struct file_lock *fl)
 	if (!(fl->fl_flags & FL_FLOCK))
 		return -ENOLCK;
 
+	fl->fl_u.afs.debug_id = atomic_inc_return(&afs_file_lock_debug_id);
+	trace_afs_flock_op(vnode, fl, afs_flock_op_flock);
+
 	/* we're simulating flock() locks using posix locks on the server */
 	if (fl->fl_type == F_UNLCK)
-		return afs_do_unlk(file, fl);
-	return afs_do_setlk(file, fl);
+		ret = afs_do_unlk(file, fl);
+	else
+		ret = afs_do_setlk(file, fl);
+
+	switch (ret) {
+	case 0:		op = afs_flock_op_return_ok; break;
+	case -EAGAIN:	op = afs_flock_op_return_eagain; break;
+	case -EDEADLK:	op = afs_flock_op_return_edeadlk; break;
+	default:	op = afs_flock_op_return_error; break;
+	}
+	trace_afs_flock_op(vnode, fl, op);
+	return ret;
 }
 
 /*
@@ -711,7 +759,10 @@ static void afs_fl_copy_lock(struct file_lock *new, struct file_lock *fl)
 
 	_enter("");
 
+	new->fl_u.afs.debug_id = atomic_inc_return(&afs_file_lock_debug_id);
+
 	spin_lock(&vnode->lock);
+	trace_afs_flock_op(vnode, new, afs_flock_op_copy_lock);
 	list_add(&new->fl_u.afs.link, &fl->fl_u.afs.link);
 	spin_unlock(&vnode->lock);
 }
@@ -728,6 +779,7 @@ static void afs_fl_release_private(struct file_lock *fl)
 
 	spin_lock(&vnode->lock);
 
+	trace_afs_flock_op(vnode, fl, afs_flock_op_release_lock);
 	list_del_init(&fl->fl_u.afs.link);
 	if (list_empty(&vnode->granted_locks))
 		afs_defer_unlock(vnode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8b42df09b04c..7f00638e0012 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1090,6 +1090,7 @@ struct file_lock {
 		struct {
 			struct list_head link;	/* link in AFS vnode's pending_locks list */
 			int state;		/* state of grant or error if -ve */
+			unsigned int	debug_id;
 		} afs;
 	} fl_u;
 } __randomize_layout;
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index e3f005eae1f7..24c058a93e8f 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -152,6 +152,40 @@ enum afs_file_error {
 	afs_file_error_writeback_fail,
 };
 
+enum afs_flock_event {
+	afs_flock_acquired,
+	afs_flock_callback_break,
+	afs_flock_defer_unlock,
+	afs_flock_fail_other,
+	afs_flock_fail_perm,
+	afs_flock_no_lockers,
+	afs_flock_timestamp,
+	afs_flock_try_to_lock,
+	afs_flock_vfs_lock,
+	afs_flock_vfs_locking,
+	afs_flock_waited,
+	afs_flock_waiting,
+	afs_flock_work_extending,
+	afs_flock_work_retry,
+	afs_flock_work_unlocking,
+	afs_flock_would_block,
+};
+
+enum afs_flock_operation {
+	afs_flock_op_copy_lock,
+	afs_flock_op_flock,
+	afs_flock_op_grant,
+	afs_flock_op_lock,
+	afs_flock_op_release_lock,
+	afs_flock_op_return_ok,
+	afs_flock_op_return_eagain,
+	afs_flock_op_return_edeadlk,
+	afs_flock_op_return_error,
+	afs_flock_op_set_lock,
+	afs_flock_op_unlock,
+	afs_flock_op_wake,
+};
+
 #endif /* end __AFS_DECLARE_TRACE_ENUMS_ONCE_ONLY */
 
 /*
@@ -277,6 +311,52 @@ enum afs_file_error {
 	EM(afs_file_error_mntpt,		"MNTPT_READ_FAILED")	\
 	E_(afs_file_error_writeback_fail,	"WRITEBACK_FAILED")
 
+#define afs_flock_types							\
+	EM(F_RDLCK,				"RDLCK")		\
+	EM(F_WRLCK,				"WRLCK")		\
+	E_(F_UNLCK,				"UNLCK")
+
+#define afs_flock_states						\
+	EM(AFS_VNODE_LOCK_NONE,			"NONE")			\
+	EM(AFS_VNODE_LOCK_WAITING_FOR_CB,	"WAIT_FOR_CB")		\
+	EM(AFS_VNODE_LOCK_SETTING,		"SETTING")		\
+	EM(AFS_VNODE_LOCK_GRANTED,		"GRANTED")		\
+	EM(AFS_VNODE_LOCK_EXTENDING,		"EXTENDING")		\
+	EM(AFS_VNODE_LOCK_NEED_UNLOCK,		"NEED_UNLOCK")		\
+	E_(AFS_VNODE_LOCK_UNLOCKING,		"UNLOCKING")		\
+
+#define afs_flock_events						\
+	EM(afs_flock_acquired,			"Acquired")		\
+	EM(afs_flock_callback_break,		"Callback")		\
+	EM(afs_flock_defer_unlock,		"D-Unlock")		\
+	EM(afs_flock_fail_other,		"ErrOther")		\
+	EM(afs_flock_fail_perm,			"ErrPerm ")		\
+	EM(afs_flock_no_lockers,		"NoLocker")		\
+	EM(afs_flock_timestamp,			"Timestmp")		\
+	EM(afs_flock_try_to_lock,		"TryToLck")		\
+	EM(afs_flock_vfs_lock,			"VFSLock ")		\
+	EM(afs_flock_vfs_locking,		"VFSLking")		\
+	EM(afs_flock_waited,			"Waited  ")		\
+	EM(afs_flock_waiting,			"Waiting ")		\
+	EM(afs_flock_work_extending,		"Extendng")		\
+	EM(afs_flock_work_retry,		"Retry   ")		\
+	EM(afs_flock_work_unlocking,		"Unlcking")		\
+	E_(afs_flock_would_block,		"EWOULDBL")
+
+#define afs_flock_operations						\
+	EM(afs_flock_op_copy_lock,		"COPY    ")		\
+	EM(afs_flock_op_flock,			"->flock ")		\
+	EM(afs_flock_op_grant,			"GRANT   ")		\
+	EM(afs_flock_op_lock,			"->lock  ")		\
+	EM(afs_flock_op_release_lock,		"RELEASE ")		\
+	EM(afs_flock_op_return_ok,		"<-OK    ")		\
+	EM(afs_flock_op_return_edeadlk,		"<-EDEADL")		\
+	EM(afs_flock_op_return_eagain,		"<-EAGAIN")		\
+	EM(afs_flock_op_return_error,		"<-ERROR ")		\
+	EM(afs_flock_op_set_lock,		"SET     ")		\
+	EM(afs_flock_op_unlock,			"UNLOCK  ")		\
+	E_(afs_flock_op_wake,			"WAKE    ")
+
 /*
  * Export enum symbols via userspace.
  */
@@ -293,6 +373,8 @@ afs_edit_dir_reasons;
 afs_eproto_causes;
 afs_io_errors;
 afs_file_errors;
+afs_flock_types;
+afs_flock_operations;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -796,6 +878,70 @@ TRACE_EVENT(afs_cm_no_server_u,
 		      __entry->call, __entry->op_id, &__entry->uuid)
 	    );
 
+TRACE_EVENT(afs_flock_ev,
+	    TP_PROTO(struct afs_vnode *vnode, struct file_lock *fl,
+		     enum afs_flock_event event, int error),
+
+	    TP_ARGS(vnode, fl, event, error),
+
+	    TP_STRUCT__entry(
+		    __field_struct(struct afs_fid,	fid		)
+		    __field(enum afs_flock_event,	event		)
+		    __field(enum afs_lock_state,	state		)
+		    __field(int,			error		)
+		    __field(unsigned int,		debug_id	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->fid = vnode->fid;
+		    __entry->event = event;
+		    __entry->state = vnode->lock_state;
+		    __entry->error = error;
+		    __entry->debug_id = fl ? fl->fl_u.afs.debug_id : 0;
+			   ),
+
+	    TP_printk("%llx:%llx:%x %04x %s s=%s e=%d",
+		      __entry->fid.vid, __entry->fid.vnode, __entry->fid.unique,
+		      __entry->debug_id,
+		      __print_symbolic(__entry->event, afs_flock_events),
+		      __print_symbolic(__entry->state, afs_flock_states),
+		      __entry->error)
+	    );
+
+TRACE_EVENT(afs_flock_op,
+	    TP_PROTO(struct afs_vnode *vnode, struct file_lock *fl,
+		     enum afs_flock_operation op),
+
+	    TP_ARGS(vnode, fl, op),
+
+	    TP_STRUCT__entry(
+		    __field_struct(struct afs_fid,	fid		)
+		    __field(loff_t,			from		)
+		    __field(loff_t,			len		)
+		    __field(enum afs_flock_operation,	op		)
+		    __field(unsigned char,		type		)
+		    __field(unsigned int,		flags		)
+		    __field(unsigned int,		debug_id	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->fid = vnode->fid;
+		    __entry->from = fl->fl_start;
+		    __entry->len = fl->fl_end - fl->fl_start + 1;
+		    __entry->op = op;
+		    __entry->type = fl->fl_type;
+		    __entry->flags = fl->fl_flags;
+		    __entry->debug_id = fl->fl_u.afs.debug_id;
+			   ),
+
+	    TP_printk("%llx:%llx:%x %04x %s t=%s R=%llx/%llx f=%x",
+		      __entry->fid.vid, __entry->fid.vnode, __entry->fid.unique,
+		      __entry->debug_id,
+		      __print_symbolic(__entry->op, afs_flock_operations),
+		      __print_symbolic(__entry->type, afs_flock_types),
+		      __entry->from, __entry->len, __entry->flags)
+	    );
+
 #endif /* _TRACE_AFS_H */
 
 /* This part must be outside protection */

