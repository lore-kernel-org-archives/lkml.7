Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5D9C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC587206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998214;
	bh=hHoy37aCFdmmPLY5kqzFHCwHE1tIq9qSaOS1bN6/aj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lxSJzHvTv2IvvHQ/HiWuOZNiagc+SyL7r8opIjdm1p6GVBkXbNSaCHNOPqvBNcnK8
	 e4q2nlKd9tZDBVyOC0A3UEVnlslWn2fmQo3V80ZxQntpmuR1aJY0cXZTt3f8/GyCxY
	 MRhgfTSycr8Yzd9dUkpb7cA5yZP4JHr18u1Xng5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404714AbfGXT4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404706AbfGXT4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:56:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F7CE205C9;
        Wed, 24 Jul 2019 19:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998204;
        bh=hHoy37aCFdmmPLY5kqzFHCwHE1tIq9qSaOS1bN6/aj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ou7vLlD71VDBIJv8Yhwze2L+FnylZlQr0RKt74y7XSEfbJseW2paaS5EPmqThWeN3
         PND7C/lkapKeZbu5YqnSHfSYM9Nw9u2+qLHEppFBrd/ecKVbJyQnhythCXNPfN8M9z
         1VysL8fR6GBXoqn/bctyiXrOvhtgxyTjjl198pGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.1 282/371] SUNRPC: Ensure the bvecs are reset when we re-encode the RPC request
Date:   Wed, 24 Jul 2019 21:20:34 +0200
Message-Id: <20190724191745.495058345@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 75369089820473eac45e9ddd970081901a373c08 upstream.

The bvec tracks the list of pages, so if the number of pages changes
due to a re-encode, we need to reset the bvec as well.

Fixes: 277e4ab7d530 ("SUNRPC: Simplify TCP receive code by switching...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.20+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/clnt.c     |    3 +--
 net/sunrpc/xprt.c     |    2 ++
 net/sunrpc/xprtsock.c |    1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1767,6 +1767,7 @@ rpc_xdr_encode(struct rpc_task *task)
 	req->rq_snd_buf.head[0].iov_len = 0;
 	xdr_init_encode(&xdr, &req->rq_snd_buf,
 			req->rq_snd_buf.head[0].iov_base, req);
+	xdr_free_bvec(&req->rq_snd_buf);
 	if (rpc_encode_header(task, &xdr))
 		return;
 
@@ -1799,8 +1800,6 @@ call_encode(struct rpc_task *task)
 			rpc_exit(task, task->tk_status);
 		}
 		return;
-	} else {
-		xprt_request_prepare(task->tk_rqstp);
 	}
 
 	/* Add task to reply queue before transmission to avoid races */
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1006,6 +1006,8 @@ xprt_request_enqueue_receive(struct rpc_
 
 	if (!xprt_request_need_enqueue_receive(task, req))
 		return;
+
+	xprt_request_prepare(task->tk_rqstp);
 	spin_lock(&xprt->queue_lock);
 
 	/* Update the softirq receive buffer */
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -909,6 +909,7 @@ static int xs_nospace(struct rpc_rqst *r
 static void
 xs_stream_prepare_request(struct rpc_rqst *req)
 {
+	xdr_free_bvec(&req->rq_rcv_buf);
 	req->rq_task->tk_status = xdr_alloc_bvec(&req->rq_rcv_buf, GFP_KERNEL);
 }
 


