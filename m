Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7B0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCDC21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256558;
	bh=6pHXulUFSJakeey+kcXhdoeMm5ZD1fyE0gBf4SRyvdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cIi9On9zFYT6JUav75UsX0zzojgViC5aP2Kxg99c5hjI9EpKF6k05LstwaxMsCZAG
	 u6dQk3pY5ChBornY2adKmrAlYurDzKUSMTveW6lBjJfD/FtyF/yJKT5KllnrF54+0N
	 D8UpW+ZQzgoemSSvAn81QIR9wabzkWrLN63LDkWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389290AbfCVMJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:09:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388535AbfCVMJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:09:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6BA320830;
        Fri, 22 Mar 2019 12:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256555;
        bh=6pHXulUFSJakeey+kcXhdoeMm5ZD1fyE0gBf4SRyvdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ts7hu5ENmSLBBoDb0iNDaPre0Chj/4znDgU6JufRPmoo+uFPijk2b9aao7ESNptVN
         cf8da5r1OqMqNtJEEhRdKTgmkv7uLIZ+j3UmjzVsq47IlnaLghEXDLvA+B0I75ryr0
         EtL2Z4F6DwNFA7CFB8uPd+ZFG54LalOhE0jS+9z8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Pearson <jcpearson@gmail.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.19 247/280] svcrpc: fix UDP on servers with lots of threads
Date:   Fri, 22 Mar 2019 12:16:40 +0100
Message-Id: <20190322111340.690270072@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: J. Bruce Fields <bfields@redhat.com>

commit b7e5034cbecf5a65b7bfdc2b20a8378039577706 upstream.

James Pearson found that an NFS server stopped responding to UDP
requests if started with more than 1017 threads.

sv_max_mesg is about 2^20, so that is probably where the calculation
performed by

	svc_sock_setbufsize(svsk->sk_sock,
                            (serv->sv_nrthreads+3) * serv->sv_max_mesg,
                            (serv->sv_nrthreads+3) * serv->sv_max_mesg);

starts to overflow an int.

Reported-by: James Pearson <jcpearson@gmail.com>
Tested-by: James Pearson <jcpearson@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/svcsock.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -381,12 +381,16 @@ static int svc_partial_recvfrom(struct s
 /*
  * Set socket snd and rcv buffer lengths
  */
-static void svc_sock_setbufsize(struct socket *sock, unsigned int snd,
-				unsigned int rcv)
+static void svc_sock_setbufsize(struct svc_sock *svsk, unsigned int nreqs)
 {
+	unsigned int max_mesg = svsk->sk_xprt.xpt_server->sv_max_mesg;
+	struct socket *sock = svsk->sk_sock;
+
+	nreqs = min(nreqs, INT_MAX / 2 / max_mesg);
+
 	lock_sock(sock->sk);
-	sock->sk->sk_sndbuf = snd * 2;
-	sock->sk->sk_rcvbuf = rcv * 2;
+	sock->sk->sk_sndbuf = nreqs * max_mesg * 2;
+	sock->sk->sk_rcvbuf = nreqs * max_mesg * 2;
 	sock->sk->sk_write_space(sock->sk);
 	release_sock(sock->sk);
 }
@@ -548,9 +552,7 @@ static int svc_udp_recvfrom(struct svc_r
 	     * provides an upper bound on the number of threads
 	     * which will access the socket.
 	     */
-	    svc_sock_setbufsize(svsk->sk_sock,
-				(serv->sv_nrthreads+3) * serv->sv_max_mesg,
-				(serv->sv_nrthreads+3) * serv->sv_max_mesg);
+	    svc_sock_setbufsize(svsk, serv->sv_nrthreads + 3);
 
 	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 	skb = NULL;
@@ -718,9 +720,7 @@ static void svc_udp_init(struct svc_sock
 	 * receive and respond to one request.
 	 * svc_udp_recvfrom will re-adjust if necessary
 	 */
-	svc_sock_setbufsize(svsk->sk_sock,
-			    3 * svsk->sk_xprt.xpt_server->sv_max_mesg,
-			    3 * svsk->sk_xprt.xpt_server->sv_max_mesg);
+	svc_sock_setbufsize(svsk, 3);
 
 	/* data might have come in before data_ready set up */
 	set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);


