Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62340C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1BE2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbfDPRyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:54:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57730 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbfDPRxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHF-0005ah-8M; Tue, 16 Apr 2019 17:53:49 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 62/62] coallocate socket->wq with socket itself
Date:   Tue, 16 Apr 2019 18:53:40 +0100
Message-Id: <20190416175340.21068-62-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
References: <20190416174900.GT2217@ZenIV.linux.org.uk>
 <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

socket->wq is assign-once, set when we are initializing both
struct socket it's in and struct socket_wq it points to.  As the
matter of fact, the only reason for separate allocation was the
ability to RCU-delay freeing of socket_wq.  RCU-delaying the
freeing of socket itself gets rid of that need, so we can just
fold struct socket_wq into the end of struct socket and simplify
the life both for sock_alloc_inode() (one allocation instead of
two) and for tun/tap oddballs, where we used to embed struct socket
and struct socket_wq into the same structure (now - embedding just
the struct socket).

Note that reference to struct socket_wq in struct sock does remain
a reference - that's unchanged.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/net/tap.c      |  5 ++---
 drivers/net/tun.c      |  8 +++-----
 include/linux/if_tap.h |  1 -
 include/linux/net.h    |  4 ++--
 include/net/sock.h     |  4 ++--
 net/core/sock.c        |  2 +-
 net/socket.c           | 19 +++++--------------
 7 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 2ea9b4976f4a..249bfd85b65c 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -519,8 +519,7 @@ static int tap_open(struct inode *inode, struct file *file)
 		goto err;
 	}
 
-	RCU_INIT_POINTER(q->sock.wq, &q->wq);
-	init_waitqueue_head(&q->wq.wait);
+	init_waitqueue_head(&q->sock.wq.wait);
 	q->sock.type = SOCK_RAW;
 	q->sock.state = SS_CONNECTED;
 	q->sock.file = file;
@@ -578,7 +577,7 @@ static __poll_t tap_poll(struct file *file, poll_table *wait)
 		goto out;
 
 	mask = 0;
-	poll_wait(file, &q->wq.wait, wait);
+	poll_wait(file, &q->sock.wq.wait, wait);
 
 	if (!ptr_ring_empty(&q->ring))
 		mask |= EPOLLIN | EPOLLRDNORM;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e9ca1c088d0b..f404d1588e9c 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -169,7 +169,6 @@ struct tun_pcpu_stats {
 struct tun_file {
 	struct sock sk;
 	struct socket socket;
-	struct socket_wq wq;
 	struct tun_struct __rcu *tun;
 	struct fasync_struct *fasync;
 	/* only used for fasnyc */
@@ -2174,7 +2173,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
 		goto out;
 	}
 
-	add_wait_queue(&tfile->wq.wait, &wait);
+	add_wait_queue(&tfile->socket.wq.wait, &wait);
 
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -2194,7 +2193,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
 	}
 
 	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&tfile->wq.wait, &wait);
+	remove_wait_queue(&tfile->socket.wq.wait, &wait);
 
 out:
 	*err = error;
@@ -3417,8 +3416,7 @@ static int tun_chr_open(struct inode *inode, struct file * file)
 	tfile->flags = 0;
 	tfile->ifindex = 0;
 
-	init_waitqueue_head(&tfile->wq.wait);
-	RCU_INIT_POINTER(tfile->socket.wq, &tfile->wq);
+	init_waitqueue_head(&tfile->socket.wq.wait);
 
 	tfile->socket.file = file;
 	tfile->socket.ops = &tun_socket_ops;
diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
index 8e66866c11be..915a187cfabd 100644
--- a/include/linux/if_tap.h
+++ b/include/linux/if_tap.h
@@ -62,7 +62,6 @@ struct tap_dev {
 struct tap_queue {
 	struct sock sk;
 	struct socket sock;
-	struct socket_wq wq;
 	int vnet_hdr_sz;
 	struct tap_dev __rcu *tap;
 	struct file *file;
diff --git a/include/linux/net.h b/include/linux/net.h
index c606c72311d0..6979057c7c86 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -120,11 +120,11 @@ struct socket {
 
 	unsigned long		flags;
 
-	struct socket_wq	*wq;
-
 	struct file		*file;
 	struct sock		*sk;
 	const struct proto_ops	*ops;
+
+	struct socket_wq	wq;
 };
 
 struct vm_area_struct;
diff --git a/include/net/sock.h b/include/net/sock.h
index 8de5ee258b93..0e1975b6202f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1811,7 +1811,7 @@ static inline void sock_graft(struct sock *sk, struct socket *parent)
 {
 	WARN_ON(parent->sk);
 	write_lock_bh(&sk->sk_callback_lock);
-	rcu_assign_pointer(sk->sk_wq, parent->wq);
+	rcu_assign_pointer(sk->sk_wq, &parent->wq);
 	parent->sk = sk;
 	sk_set_socket(sk, parent);
 	sk->sk_uid = SOCK_INODE(parent)->i_uid;
@@ -2095,7 +2095,7 @@ static inline void sock_poll_wait(struct file *filp, struct socket *sock,
 				  poll_table *p)
 {
 	if (!poll_does_not_wait(p)) {
-		poll_wait(filp, &sock->wq->wait, p);
+		poll_wait(filp, &sock->wq.wait, p);
 		/* We need to be sure we are in sync with the
 		 * socket flags modification.
 		 *
diff --git a/net/core/sock.c b/net/core/sock.c
index 782343bb925b..11af1ee7d542 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2842,7 +2842,7 @@ void sock_init_data(struct socket *sock, struct sock *sk)
 
 	if (sock) {
 		sk->sk_type	=	sock->type;
-		RCU_INIT_POINTER(sk->sk_wq, sock->wq);
+		RCU_INIT_POINTER(sk->sk_wq, &sock->wq);
 		sock->sk	=	sk;
 		sk->sk_uid	=	SOCK_INODE(sock)->i_uid;
 	} else {
diff --git a/net/socket.c b/net/socket.c
index 6953a049fb82..7d3d043fc56f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -239,20 +239,13 @@ static struct kmem_cache *sock_inode_cachep __ro_after_init;
 static struct inode *sock_alloc_inode(struct super_block *sb)
 {
 	struct socket_alloc *ei;
-	struct socket_wq *wq;
 
 	ei = kmem_cache_alloc(sock_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
-	wq = kmalloc(sizeof(*wq), GFP_KERNEL);
-	if (!wq) {
-		kmem_cache_free(sock_inode_cachep, ei);
-		return NULL;
-	}
-	init_waitqueue_head(&wq->wait);
-	wq->fasync_list = NULL;
-	wq->flags = 0;
-	ei->socket.wq = wq;
+	init_waitqueue_head(&ei->socket.wq.wait);
+	ei->socket.wq.fasync_list = NULL;
+	ei->socket.wq.flags = 0;
 
 	ei->socket.state = SS_UNCONNECTED;
 	ei->socket.flags = 0;
@@ -268,7 +261,6 @@ static void sock_free_inode(struct inode *inode)
 	struct socket_alloc *ei;
 
 	ei = container_of(inode, struct socket_alloc, vfs_inode);
-	kfree(ei->socket.wq);
 	kmem_cache_free(sock_inode_cachep, ei);
 }
 
@@ -604,7 +596,7 @@ static void __sock_release(struct socket *sock, struct inode *inode)
 		module_put(owner);
 	}
 
-	if (sock->wq->fasync_list)
+	if (sock->wq.fasync_list)
 		pr_err("%s: fasync list not empty!\n", __func__);
 
 	if (!sock->file) {
@@ -1263,13 +1255,12 @@ static int sock_fasync(int fd, struct file *filp, int on)
 {
 	struct socket *sock = filp->private_data;
 	struct sock *sk = sock->sk;
-	struct socket_wq *wq;
+	struct socket_wq *wq = &sock->wq;
 
 	if (sk == NULL)
 		return -EINVAL;
 
 	lock_sock(sk);
-	wq = sock->wq;
 	fasync_helper(fd, filp, on, &wq->fasync_list);
 
 	if (!wq->fasync_list)
-- 
2.11.0

