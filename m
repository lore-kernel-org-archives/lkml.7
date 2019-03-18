Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A550AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E752087C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901222;
	bh=6HIXccoLgdiIK2LYqRaylhectKhrNBRmKtmTyiNsROU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gKkoob/hP6vsRZM+XYCI2ln1jXZG09yNi9fP7qE9DvJHFCp8MDAYhvf6kZ11xS003
	 VoEtA0kunygljbIA/K52sE7Y9RnAaaerQy/R3gPCfKLszjiWb5k+diKRb4rUOU/Vq8
	 e19XVe5SYX3RfbBcb32CjFvn8nEYAktu4BMpag28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfCRJ1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbfCRJ06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:26:58 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDFA72063F;
        Mon, 18 Mar 2019 09:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901217;
        bh=6HIXccoLgdiIK2LYqRaylhectKhrNBRmKtmTyiNsROU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eBnPLP0VoslJNtPc/JbTa4nt/ojKaGVvXvLTxP87a3/7h3SD4v2LK3Z+SciJq5gXz
         jlQsI0kVDtnjJSj8BJaikux3MAOHLJDgGTN6FyOvc4EJaDlurQOfhlRjoSKvYHwT6Q
         ITpKabxCuYvwCXDbVHS6ZAZbtIjV+jQO65HroLs4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <gnault@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 21/43] tcp: handle inet_csk_reqsk_queue_add() failures
Date:   Mon, 18 Mar 2019 10:24:13 +0100
Message-Id: <20190318083716.489083478@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083715.877441740@linuxfoundation.org>
References: <20190318083715.877441740@linuxfoundation.org>
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

From: Guillaume Nault <gnault@redhat.com>

[  Upstream commit 9d3e1368bb45893a75a5dfb7cd21fdebfa6b47af ]

Commit 7716682cc58e ("tcp/dccp: fix another race at listener
dismantle") let inet_csk_reqsk_queue_add() fail, and adjusted
{tcp,dccp}_check_req() accordingly. However, TFO and syncookies
weren't modified, thus leaking allocated resources on error.

Contrary to tcp_check_req(), in both syncookies and TFO cases,
we need to drop the request socket. Also, since the child socket is
created with inet_csk_clone_lock(), we have to unlock it and drop an
extra reference (->sk_refcount is initially set to 2 and
inet_csk_reqsk_queue_add() drops only one ref).

For TFO, we also need to revert the work done by tcp_try_fastopen()
(with reqsk_fastopen_remove()).

Fixes: 7716682cc58e ("tcp/dccp: fix another race at listener dismantle")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/syncookies.c |    7 ++++++-
 net/ipv4/tcp_input.c  |    8 +++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -216,7 +216,12 @@ struct sock *tcp_get_cookie_sock(struct
 		refcount_set(&req->rsk_refcnt, 1);
 		tcp_sk(child)->tsoffset = tsoff;
 		sock_rps_save_rxhash(child, skb);
-		inet_csk_reqsk_queue_add(sk, req, child);
+		if (!inet_csk_reqsk_queue_add(sk, req, child)) {
+			bh_unlock_sock(child);
+			sock_put(child);
+			child = NULL;
+			reqsk_put(req);
+		}
 	} else {
 		reqsk_free(req);
 	}
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6519,7 +6519,13 @@ int tcp_conn_request(struct request_sock
 		af_ops->send_synack(fastopen_sk, dst, &fl, req,
 				    &foc, TCP_SYNACK_FASTOPEN);
 		/* Add the child socket directly into the accept queue */
-		inet_csk_reqsk_queue_add(sk, req, fastopen_sk);
+		if (!inet_csk_reqsk_queue_add(sk, req, fastopen_sk)) {
+			reqsk_fastopen_remove(fastopen_sk, req, false);
+			bh_unlock_sock(fastopen_sk);
+			sock_put(fastopen_sk);
+			reqsk_put(req);
+			goto drop;
+		}
 		sk->sk_data_ready(sk);
 		bh_unlock_sock(fastopen_sk);
 		sock_put(fastopen_sk);


