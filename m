Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18987C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE5B2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257450;
	bh=rRFDhO6/osI/i2WvAr/Hm1Nvwwi5Ep1TzT5bDvZayPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x7FKzpOFIKQYw1JgHtqDMZKf5dBf+8VkoflxmCGTZUpaS/zn1xOwBuzRXVSFxS7EF
	 LduSaM6FfmCPIYeeK4VjFN6QHI07ItyX5DhsEaecZspuqfTDnHUuw1aY5E7nQgbOo7
	 Y1cRDWwkXVpAmnfWbOkBEpQ/LpardAPRX1CqueyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391238AbfCVMYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391230AbfCVMYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:24:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2581D218A1;
        Fri, 22 Mar 2019 12:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257445;
        bh=rRFDhO6/osI/i2WvAr/Hm1Nvwwi5Ep1TzT5bDvZayPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JC7cKfIPUqyhq1NEkUL7Qnnn08o4FDK8fYUG1hP/1AbUdHfYVDrGBybuQVkHktFyk
         DIgNMk/uPd6c+8aCsyyh9SKrvskWNGGRdMmfxiZJzP3BUBuS6GIu9Km/5eYJF+2lZ6
         CzxG5OVpaVQLUBY7ufVRtT+//518Zx9djvOwpEAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Pearson <jcpearson@gmail.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 5.0 191/238] svcrpc: fix UDP on servers with lots of threads
Date:   Fri, 22 Mar 2019 12:16:50 +0100
Message-Id: <20190322111309.483760539@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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
@@ -349,12 +349,16 @@ static ssize_t svc_recvfrom(struct svc_r
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
@@ -516,9 +520,7 @@ static int svc_udp_recvfrom(struct svc_r
 	     * provides an upper bound on the number of threads
 	     * which will access the socket.
 	     */
-	    svc_sock_setbufsize(svsk->sk_sock,
-				(serv->sv_nrthreads+3) * serv->sv_max_mesg,
-				(serv->sv_nrthreads+3) * serv->sv_max_mesg);
+	    svc_sock_setbufsize(svsk, serv->sv_nrthreads + 3);
 
 	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 	skb = NULL;
@@ -681,9 +683,7 @@ static void svc_udp_init(struct svc_sock
 	 * receive and respond to one request.
 	 * svc_udp_recvfrom will re-adjust if necessary
 	 */
-	svc_sock_setbufsize(svsk->sk_sock,
-			    3 * svsk->sk_xprt.xpt_server->sv_max_mesg,
-			    3 * svsk->sk_xprt.xpt_server->sv_max_mesg);
+	svc_sock_setbufsize(svsk, 3);
 
 	/* data might have come in before data_ready set up */
 	set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);


