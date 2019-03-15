Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A736C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1802085A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfCOXFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:05:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfCOXFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:05:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5A7EC053B34;
        Fri, 15 Mar 2019 22:59:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D49D81001DC9;
        Fri, 15 Mar 2019 22:59:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/10] afs: Calculate lock extend timer from set/extend
 reply reception
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 15 Mar 2019 22:59:35 +0000
Message-ID: <155269077509.8537.7253042058551926064.stgit@warthog.procyon.org.uk>
In-Reply-To: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
References: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 15 Mar 2019 22:59:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record the timestamp on the first reply DATA packet received in response to
a set- or extend-lock operation, then use this to calculate the time
remaining till the lock expires rather than using whatever time the
requesting process wakes up and finishes processing the operation as a
base.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/flock.c     |   30 ++++++++++++++++++++++++++++--
 fs/afs/fsclient.c  |    4 ++++
 fs/afs/internal.h  |    2 ++
 fs/afs/yfsclient.c |    4 ++++
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index e432bd27a2e7..8b02f0056d54 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -40,8 +40,34 @@ void afs_lock_may_be_available(struct afs_vnode *vnode)
  */
 static void afs_schedule_lock_extension(struct afs_vnode *vnode)
 {
-	queue_delayed_work(afs_lock_manager, &vnode->lock_work,
-			   AFS_LOCKWAIT * HZ / 2);
+	ktime_t expires_at, now, duration;
+	u64 duration_j;
+
+	expires_at = ktime_add_ms(vnode->locked_at, AFS_LOCKWAIT * 1000 / 2);
+	now = ktime_get_real();
+	duration = ktime_sub(expires_at, now);
+	if (duration <= 0)
+		duration_j = 0;
+	else
+		duration_j = nsecs_to_jiffies(ktime_to_ns(duration));
+
+	queue_delayed_work(afs_lock_manager, &vnode->lock_work, duration_j);
+}
+
+/*
+ * In the case of successful completion of a lock operation, record the time
+ * the reply appeared and start the lock extension timer.
+ */
+void afs_lock_op_done(struct afs_call *call)
+{
+	struct afs_vnode *vnode = call->reply[0];
+
+	if (call->error == 0) {
+		spin_lock(&vnode->lock);
+		vnode->locked_at = call->reply_time;
+		afs_schedule_lock_extension(vnode);
+		spin_unlock(&vnode->lock);
+	}
 }
 
 /*
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 2ff19ebda666..b9cf9dc1a9b7 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -1845,6 +1845,7 @@ static const struct afs_call_type afs_RXFSSetLock = {
 	.name		= "FS.SetLock",
 	.op		= afs_FS_SetLock,
 	.deliver	= afs_deliver_fs_xxxx_lock,
+	.done		= afs_lock_op_done,
 	.destructor	= afs_flat_call_destructor,
 };
 
@@ -1855,6 +1856,7 @@ static const struct afs_call_type afs_RXFSExtendLock = {
 	.name		= "FS.ExtendLock",
 	.op		= afs_FS_ExtendLock,
 	.deliver	= afs_deliver_fs_xxxx_lock,
+	.done		= afs_lock_op_done,
 	.destructor	= afs_flat_call_destructor,
 };
 
@@ -1889,6 +1891,7 @@ int afs_fs_set_lock(struct afs_fs_cursor *fc, afs_lock_type_t type)
 
 	call->key = fc->key;
 	call->reply[0] = vnode;
+	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1925,6 +1928,7 @@ int afs_fs_extend_lock(struct afs_fs_cursor *fc)
 
 	call->key = fc->key;
 	call->reply[0] = vnode;
+	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 1530d7e9e7a9..37a5ba550846 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -639,6 +639,7 @@ struct afs_vnode {
 	struct list_head	granted_locks;	/* locks granted on this file */
 	struct delayed_work	lock_work;	/* work to be done in locking */
 	struct key		*lock_key;	/* Key to be used in lock ops */
+	ktime_t			locked_at;	/* Time at which lock obtained */
 	enum afs_lock_state	lock_state : 8;
 	afs_lock_type_t		lock_type : 8;
 
@@ -907,6 +908,7 @@ extern void afs_put_read(struct afs_read *);
  */
 extern struct workqueue_struct *afs_lock_manager;
 
+extern void afs_lock_op_done(struct afs_call *);
 extern void afs_lock_work(struct work_struct *);
 extern void afs_lock_may_be_available(struct afs_vnode *);
 extern int afs_lock(struct file *, int, struct file_lock *);
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 40b1f19d1018..41afc53a7df7 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -1801,6 +1801,7 @@ static const struct afs_call_type yfs_RXYFSSetLock = {
 	.name		= "YFS.SetLock",
 	.op		= yfs_FS_SetLock,
 	.deliver	= yfs_deliver_fs_xxxx_lock,
+	.done		= afs_lock_op_done,
 	.destructor	= afs_flat_call_destructor,
 };
 
@@ -1811,6 +1812,7 @@ static const struct afs_call_type yfs_RXYFSExtendLock = {
 	.name		= "YFS.ExtendLock",
 	.op		= yfs_FS_ExtendLock,
 	.deliver	= yfs_deliver_fs_xxxx_lock,
+	.done		= afs_lock_op_done,
 	.destructor	= afs_flat_call_destructor,
 };
 
@@ -1847,6 +1849,7 @@ int yfs_fs_set_lock(struct afs_fs_cursor *fc, afs_lock_type_t type)
 
 	call->key = fc->key;
 	call->reply[0] = vnode;
+	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1884,6 +1887,7 @@ int yfs_fs_extend_lock(struct afs_fs_cursor *fc)
 
 	call->key = fc->key;
 	call->reply[0] = vnode;
+	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;

