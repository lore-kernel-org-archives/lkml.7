Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E121C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8722087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049578;
	bh=w0iN4wDwamrTUw78mJAFmWECyMvD0itWX/9VK8SAQdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uQU4tp1RwHne0L6sUL5XEmioaUc1/3eK2zXmtZ8sn64ahkqMElRRj4XliMeECR29T
	 RJYvD820RnAZT1p4wXhFBEPn8+wjgPnLqy2oMULg7af2ZzvqqXyVJI7k1uvuz9iAXL
	 AL840q/fl9ctGTp2GMRX7VSCbUDR0cTqUjPY9cYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfCHMw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:52:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbfCHMwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:52:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F6622087C;
        Fri,  8 Mar 2019 12:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049573;
        bh=w0iN4wDwamrTUw78mJAFmWECyMvD0itWX/9VK8SAQdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOigNHgIEr4FbfLYqcwR4mKW4CjaGE8Y1Nr6+8OVvYAZ79Hi4yaDwF1rMla2Kjr4S
         n6sG0UAwpzAlZhZOrfrk16udQKG1j6dwjAaqyyPJDzgT1p1CnQR5emywB15cd3Ld7s
         rS1jVLgzJOdAtKcAlp6JNr9wkXqdpqSuqbEKQL7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 5.0 45/46] Bluetooth: Fix locking in bt_accept_enqueue() for BH context
Date:   Fri,  8 Mar 2019 13:50:18 +0100
Message-Id: <20190308124905.135064074@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit c4f5627f7eeecde1bb6b646d8c0907b96dc2b2a6 upstream.

With commit e16337622016 ("Bluetooth: Handle bt_accept_enqueue() socket
atomically") lock_sock[_nested]() is used to acquire the socket lock
before manipulating the socket. lock_sock[_nested]() may block, which
is problematic since bt_accept_enqueue() can be called in bottom half
context (e.g. from rfcomm_connect_ind()):

[<ffffff80080d81ec>] __might_sleep+0x4c/0x80
[<ffffff800876c7b0>] lock_sock_nested+0x24/0x58
[<ffffff8000d7c27c>] bt_accept_enqueue+0x48/0xd4 [bluetooth]
[<ffffff8000e67d8c>] rfcomm_connect_ind+0x190/0x218 [rfcomm]

Add a parameter to bt_accept_enqueue() to indicate whether the
function is called from BH context, and acquire the socket lock
with bh_lock_sock_nested() if that's the case.

Also adapt all callers of bt_accept_enqueue() to pass the new
parameter:

- l2cap_sock_new_connection_cb()
  - uses lock_sock() to lock the parent socket => process context

- rfcomm_connect_ind()
  - acquires the parent socket lock with bh_lock_sock() => BH
    context

- __sco_chan_add()
  - called from sco_chan_add(), which is called from sco_connect().
    parent is NULL, hence bt_accept_enqueue() isn't called in this
    code path and we can ignore it
  - also called from sco_conn_ready(). uses bh_lock_sock() to acquire
    the parent lock => BH context

Fixes: e16337622016 ("Bluetooth: Handle bt_accept_enqueue() socket atomically")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/bluetooth/bluetooth.h |    2 +-
 net/bluetooth/af_bluetooth.c      |   16 +++++++++++++---
 net/bluetooth/l2cap_sock.c        |    2 +-
 net/bluetooth/rfcomm/sock.c       |    2 +-
 net/bluetooth/sco.c               |    2 +-
 5 files changed, 17 insertions(+), 7 deletions(-)

--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -276,7 +276,7 @@ int  bt_sock_ioctl(struct socket *sock,
 int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
 int  bt_sock_wait_ready(struct sock *sk, unsigned long flags);
 
-void bt_accept_enqueue(struct sock *parent, struct sock *sk);
+void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh);
 void bt_accept_unlink(struct sock *sk);
 struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock);
 
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -154,15 +154,25 @@ void bt_sock_unlink(struct bt_sock_list
 }
 EXPORT_SYMBOL(bt_sock_unlink);
 
-void bt_accept_enqueue(struct sock *parent, struct sock *sk)
+void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 {
 	BT_DBG("parent %p, sk %p", parent, sk);
 
 	sock_hold(sk);
-	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+
+	if (bh)
+		bh_lock_sock_nested(sk);
+	else
+		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+
 	list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
 	bt_sk(sk)->parent = parent;
-	release_sock(sk);
+
+	if (bh)
+		bh_unlock_sock(sk);
+	else
+		release_sock(sk);
+
 	parent->sk_ack_backlog++;
 }
 EXPORT_SYMBOL(bt_accept_enqueue);
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1252,7 +1252,7 @@ static struct l2cap_chan *l2cap_sock_new
 
 	l2cap_sock_init(sk, parent);
 
-	bt_accept_enqueue(parent, sk);
+	bt_accept_enqueue(parent, sk, false);
 
 	release_sock(parent);
 
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -988,7 +988,7 @@ int rfcomm_connect_ind(struct rfcomm_ses
 	rfcomm_pi(sk)->channel = channel;
 
 	sk->sk_state = BT_CONFIG;
-	bt_accept_enqueue(parent, sk);
+	bt_accept_enqueue(parent, sk, true);
 
 	/* Accept connection and return socket DLC */
 	*d = rfcomm_pi(sk)->dlc;
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -193,7 +193,7 @@ static void __sco_chan_add(struct sco_co
 	conn->sk = sk;
 
 	if (parent)
-		bt_accept_enqueue(parent, sk);
+		bt_accept_enqueue(parent, sk, true);
 }
 
 static int sco_chan_add(struct sco_conn *conn, struct sock *sk,


