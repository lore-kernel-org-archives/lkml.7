Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C66BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6091C214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901816;
	bh=jZ5q1h2jAax77BXoxN9DVPCT3gU0zmBQbhS7Ph7hEac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zNnMdy7lfnRQLQvyzzUUay/K9Qga7iKWbHV40nxuck70NY7pAWK4bOgULnPBUnQyL
	 lXRSxpuqlDF6+EVIzEcMFO3IbpYI03mOm/FzgQszVAMnvGYFtA18WUgZ8/43JHx01y
	 G2jAy2wggOHjwbJ2vw53YxY5vYCId/GI66gCxvhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbfCRJgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbfCRJgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:36:52 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65DDB2075C;
        Mon, 18 Mar 2019 09:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901810;
        bh=jZ5q1h2jAax77BXoxN9DVPCT3gU0zmBQbhS7Ph7hEac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1JmisGabm1vtUFpmqmci6h3ubetFLPC263nS0dYUesXfsU01WXbKmN7IQ01CO+PC9
         xEVhpJvxEgBCUFFGnxrWkoyp2VsNSiP250EQDkH+dm5MWRSuVIm2Q8CguEawsGapsb
         auBjmZ/RJqzy1K/Iq5kXF2SuY9ZyTCtrVFL9Hl9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH 4.9 20/31] missing barriers in some of unix_sock ->addr and ->path accesses
Date:   Mon, 18 Mar 2019 10:25:55 +0100
Message-Id: <20190318084211.215549694@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084210.397476003@linuxfoundation.org>
References: <20190318084210.397476003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit ae3b564179bfd06f32d051b9e5d72ce4b2a07c37 ]

Several u->addr and u->path users are not holding any locks in
common with unix_bind().  unix_state_lock() is useless for those
purposes.

u->addr is assign-once and *(u->addr) is fully set up by the time
we set u->addr (all under unix_table_lock).  u->path is also
set in the same critical area, also before setting u->addr, and
any unix_sock with ->path filled will have non-NULL ->addr.

So setting ->addr with smp_store_release() is all we need for those
"lockless" users - just have them fetch ->addr with smp_load_acquire()
and don't even bother looking at ->path if they see NULL ->addr.

Users of ->addr and ->path fall into several classes now:
    1) ones that do smp_load_acquire(u->addr) and access *(u->addr)
and u->path only if smp_load_acquire() has returned non-NULL.
    2) places holding unix_table_lock.  These are guaranteed that
*(u->addr) is seen fully initialized.  If unix_sock is in one of the
"bound" chains, so's ->path.
    3) unix_sock_destructor() using ->addr is safe.  All places
that set u->addr are guaranteed to have seen all stores *(u->addr)
while holding a reference to u and unix_sock_destructor() is called
when (atomic) refcount hits zero.
    4) unix_release_sock() using ->path is safe.  unix_bind()
is serialized wrt unix_release() (normally - by struct file
refcount), and for the instances that had ->path set by unix_bind()
unix_release_sock() comes from unix_release(), so they are fine.
Instances that had it set in unix_stream_connect() either end up
attached to a socket (in unix_accept()), in which case the call
chain to unix_release_sock() and serialization are the same as in
the previous case, or they never get accept'ed and unix_release_sock()
is called when the listener is shut down and its queue gets purged.
In that case the listener's queue lock provides the barriers needed -
unix_stream_connect() shoves our unix_sock into listener's queue
under that lock right after having set ->path and eventual
unix_release_sock() caller picks them from that queue under the
same lock right before calling unix_release_sock().
    5) unix_find_other() use of ->path is pointless, but safe -
it happens with successful lookup by (abstract) name, so ->path.dentry
is guaranteed to be NULL there.

earlier-variant-reviewed-by: "Paul E. McKenney" <paulmck@linux.ibm.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/unix/af_unix.c   |   48 +++++++++++++++++++++++++++++-------------------
 net/unix/diag.c      |    3 ++-
 security/lsm_audit.c |   10 ++++++----
 3 files changed, 37 insertions(+), 24 deletions(-)

--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -891,7 +891,7 @@ retry:
 	addr->hash ^= sk->sk_type;
 
 	__unix_remove_socket(sk);
-	u->addr = addr;
+	smp_store_release(&u->addr, addr);
 	__unix_insert_socket(&unix_socket_table[addr->hash], sk);
 	spin_unlock(&unix_table_lock);
 	err = 0;
@@ -1061,7 +1061,7 @@ static int unix_bind(struct socket *sock
 
 	err = 0;
 	__unix_remove_socket(sk);
-	u->addr = addr;
+	smp_store_release(&u->addr, addr);
 	__unix_insert_socket(list, sk);
 
 out_unlock:
@@ -1332,15 +1332,29 @@ restart:
 	RCU_INIT_POINTER(newsk->sk_wq, &newu->peer_wq);
 	otheru = unix_sk(other);
 
-	/* copy address information from listening to new sock*/
-	if (otheru->addr) {
-		atomic_inc(&otheru->addr->refcnt);
-		newu->addr = otheru->addr;
-	}
+	/* copy address information from listening to new sock
+	 *
+	 * The contents of *(otheru->addr) and otheru->path
+	 * are seen fully set up here, since we have found
+	 * otheru in hash under unix_table_lock.  Insertion
+	 * into the hash chain we'd found it in had been done
+	 * in an earlier critical area protected by unix_table_lock,
+	 * the same one where we'd set *(otheru->addr) contents,
+	 * as well as otheru->path and otheru->addr itself.
+	 *
+	 * Using smp_store_release() here to set newu->addr
+	 * is enough to make those stores, as well as stores
+	 * to newu->path visible to anyone who gets newu->addr
+	 * by smp_load_acquire().  IOW, the same warranties
+	 * as for unix_sock instances bound in unix_bind() or
+	 * in unix_autobind().
+	 */
 	if (otheru->path.dentry) {
 		path_get(&otheru->path);
 		newu->path = otheru->path;
 	}
+	atomic_inc(&otheru->addr->refcnt);
+	smp_store_release(&newu->addr, otheru->addr);
 
 	/* Set credentials */
 	copy_peercred(sk, other);
@@ -1453,7 +1467,7 @@ out:
 static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int *uaddr_len, int peer)
 {
 	struct sock *sk = sock->sk;
-	struct unix_sock *u;
+	struct unix_address *addr;
 	DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr, uaddr);
 	int err = 0;
 
@@ -1468,19 +1482,15 @@ static int unix_getname(struct socket *s
 		sock_hold(sk);
 	}
 
-	u = unix_sk(sk);
-	unix_state_lock(sk);
-	if (!u->addr) {
+	addr = smp_load_acquire(&unix_sk(sk)->addr);
+	if (!addr) {
 		sunaddr->sun_family = AF_UNIX;
 		sunaddr->sun_path[0] = 0;
 		*uaddr_len = sizeof(short);
 	} else {
-		struct unix_address *addr = u->addr;
-
 		*uaddr_len = addr->len;
 		memcpy(sunaddr, addr->name, *uaddr_len);
 	}
-	unix_state_unlock(sk);
 	sock_put(sk);
 out:
 	return err;
@@ -2094,11 +2104,11 @@ static int unix_seqpacket_recvmsg(struct
 
 static void unix_copy_addr(struct msghdr *msg, struct sock *sk)
 {
-	struct unix_sock *u = unix_sk(sk);
+	struct unix_address *addr = smp_load_acquire(&unix_sk(sk)->addr);
 
-	if (u->addr) {
-		msg->msg_namelen = u->addr->len;
-		memcpy(msg->msg_name, u->addr->name, u->addr->len);
+	if (addr) {
+		msg->msg_namelen = addr->len;
+		memcpy(msg->msg_name, addr->name, addr->len);
 	}
 }
 
@@ -2814,7 +2824,7 @@ static int unix_seq_show(struct seq_file
 			(s->sk_state == TCP_ESTABLISHED ? SS_CONNECTING : SS_DISCONNECTING),
 			sock_i_ino(s));
 
-		if (u->addr) {
+		if (u->addr) {	// under unix_table_lock here
 			int i, len;
 			seq_putc(seq, ' ');
 
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -10,7 +10,8 @@
 
 static int sk_diag_dump_name(struct sock *sk, struct sk_buff *nlskb)
 {
-	struct unix_address *addr = unix_sk(sk)->addr;
+	/* might or might not have unix_table_lock */
+	struct unix_address *addr = smp_load_acquire(&unix_sk(sk)->addr);
 
 	if (!addr)
 		return 0;
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -321,6 +321,7 @@ static void dump_common_audit_data(struc
 		if (a->u.net->sk) {
 			struct sock *sk = a->u.net->sk;
 			struct unix_sock *u;
+			struct unix_address *addr;
 			int len = 0;
 			char *p = NULL;
 
@@ -351,14 +352,15 @@ static void dump_common_audit_data(struc
 #endif
 			case AF_UNIX:
 				u = unix_sk(sk);
+				addr = smp_load_acquire(&u->addr);
+				if (!addr)
+					break;
 				if (u->path.dentry) {
 					audit_log_d_path(ab, " path=", &u->path);
 					break;
 				}
-				if (!u->addr)
-					break;
-				len = u->addr->len-sizeof(short);
-				p = &u->addr->name->sun_path[0];
+				len = addr->len-sizeof(short);
+				p = &addr->name->sun_path[0];
 				audit_log_format(ab, " path=");
 				if (*p)
 					audit_log_untrustedstring(ab, p);


