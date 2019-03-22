Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF1FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AC62054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257456;
	bh=ZTmHbU968+1y7+TdMRCDn3vHlqnKM7SmwCX54KU330M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mcoHxuL5QzUuRLRcp1xmNuay692z1EWbkrum6sb8pAO1OAXj4gHqGgkq+jYrcT6fc
	 C575NdjIziIjYgl9csVoTSKZKd4goSgD9NFWiQcku8p5oof+7aqAy4y8CZ+8UECfyq
	 Gi8OwrSwbze9TjTps3RSLwaogAuw66ZIgDyWK20c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391252AbfCVMYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391242AbfCVMYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:24:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3BF42054F;
        Fri, 22 Mar 2019 12:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257452;
        bh=ZTmHbU968+1y7+TdMRCDn3vHlqnKM7SmwCX54KU330M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/CCvgq4pxn+eVCf9UHsTO/J3L8zWKa3A70N4FiqQ6xzqv254m45ptMquS+gg8UOQ
         +6E4tLHn5svik3jzj3J3u+Fa+J2IF/fqFAWA66DS1TB8nmx9DxmhXanLrqYmxKjYng
         WsHM47Z8t2nRXZhxkCN3Gv4Xn3bzBeSop+mZKTwY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.0 237/238] SUNRPC: Fix up RPC back channel transmission
Date:   Fri, 22 Mar 2019 12:17:36 +0100
Message-Id: <20190322111312.487141535@linuxfoundation.org>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 477687e1116ad16180caf8633dd830b296a5ce73 upstream.

Now that transmissions happen through a queue, we require the RPC tasks
to handle error conditions that may have been set while they were
sleeping. The back channel does not currently do this, but assumes
that any error condition happens during its own call to xprt_transmit().

The solution is to ensure that the back channel splits out the
error handling just like the forward channel does.

Fixes: 89f90fe1ad8b ("SUNRPC: Allow calls to xprt_transmit() to drain...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/clnt.c |   61 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -66,9 +66,6 @@ static void	call_decode(struct rpc_task
 static void	call_bind(struct rpc_task *task);
 static void	call_bind_status(struct rpc_task *task);
 static void	call_transmit(struct rpc_task *task);
-#if defined(CONFIG_SUNRPC_BACKCHANNEL)
-static void	call_bc_transmit(struct rpc_task *task);
-#endif /* CONFIG_SUNRPC_BACKCHANNEL */
 static void	call_status(struct rpc_task *task);
 static void	call_transmit_status(struct rpc_task *task);
 static void	call_refresh(struct rpc_task *task);
@@ -1131,6 +1128,8 @@ rpc_call_async(struct rpc_clnt *clnt, co
 EXPORT_SYMBOL_GPL(rpc_call_async);
 
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
+static void call_bc_encode(struct rpc_task *task);
+
 /**
  * rpc_run_bc_task - Allocate a new RPC task for backchannel use, then run
  * rpc_execute against it
@@ -1152,7 +1151,7 @@ struct rpc_task *rpc_run_bc_task(struct
 	task = rpc_new_task(&task_setup_data);
 	xprt_init_bc_request(req, task);
 
-	task->tk_action = call_bc_transmit;
+	task->tk_action = call_bc_encode;
 	atomic_inc(&task->tk_count);
 	WARN_ON_ONCE(atomic_read(&task->tk_count) != 2);
 	rpc_execute(task);
@@ -2064,6 +2063,16 @@ call_transmit_status(struct rpc_task *ta
 }
 
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
+static void call_bc_transmit(struct rpc_task *task);
+static void call_bc_transmit_status(struct rpc_task *task);
+
+static void
+call_bc_encode(struct rpc_task *task)
+{
+	xprt_request_enqueue_transmit(task);
+	task->tk_action = call_bc_transmit;
+}
+
 /*
  * 5b.	Send the backchannel RPC reply.  On error, drop the reply.  In
  * addition, disconnect on connectivity errors.
@@ -2071,26 +2080,23 @@ call_transmit_status(struct rpc_task *ta
 static void
 call_bc_transmit(struct rpc_task *task)
 {
-	struct rpc_rqst *req = task->tk_rqstp;
-
-	if (rpc_task_need_encode(task))
-		xprt_request_enqueue_transmit(task);
-	if (!test_bit(RPC_TASK_NEED_XMIT, &task->tk_runstate))
-		goto out_wakeup;
-
-	if (!xprt_prepare_transmit(task))
-		goto out_retry;
-
-	if (task->tk_status < 0) {
-		printk(KERN_NOTICE "RPC: Could not send backchannel reply "
-			"error: %d\n", task->tk_status);
-		goto out_done;
+	task->tk_action = call_bc_transmit_status;
+	if (test_bit(RPC_TASK_NEED_XMIT, &task->tk_runstate)) {
+		if (!xprt_prepare_transmit(task))
+			return;
+		task->tk_status = 0;
+		xprt_transmit(task);
 	}
+	xprt_end_transmit(task);
+}
 
-	xprt_transmit(task);
+static void
+call_bc_transmit_status(struct rpc_task *task)
+{
+	struct rpc_rqst *req = task->tk_rqstp;
 
-	xprt_end_transmit(task);
 	dprint_status(task);
+
 	switch (task->tk_status) {
 	case 0:
 		/* Success */
@@ -2104,8 +2110,14 @@ call_bc_transmit(struct rpc_task *task)
 	case -ENOTCONN:
 	case -EPIPE:
 		break;
+	case -ENOBUFS:
+		rpc_delay(task, HZ>>2);
+		/* fall through */
+	case -EBADSLT:
 	case -EAGAIN:
-		goto out_retry;
+		task->tk_status = 0;
+		task->tk_action = call_bc_transmit;
+		return;
 	case -ETIMEDOUT:
 		/*
 		 * Problem reaching the server.  Disconnect and let the
@@ -2124,18 +2136,11 @@ call_bc_transmit(struct rpc_task *task)
 		 * We were unable to reply and will have to drop the
 		 * request.  The server should reconnect and retransmit.
 		 */
-		WARN_ON_ONCE(task->tk_status == -EAGAIN);
 		printk(KERN_NOTICE "RPC: Could not send backchannel reply "
 			"error: %d\n", task->tk_status);
 		break;
 	}
-out_wakeup:
-	rpc_wake_up_queued_task(&req->rq_xprt->pending, task);
-out_done:
 	task->tk_action = rpc_exit_task;
-	return;
-out_retry:
-	task->tk_status = 0;
 }
 #endif /* CONFIG_SUNRPC_BACKCHANNEL */
 


