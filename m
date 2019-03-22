Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAF1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1FA2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257461;
	bh=cDP7EFgk1CQQMMMK2rwt+zfYHI1goK/2zA1WHcTbpKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mbpDxVtH3u5KXuabA/eNdUvcbxEOC71MsJvJF1muTEvzcCMBJuhbqnDJEcyBP79oF
	 zUaCs9aCXhqaIFq9LZ8PL2dft1sKORVyYK2aeQumv8cTJfrplEeQOXzzcqIxKfQATY
	 bAs/uE1HcDm2tROOpLfO6K60G1FJv1QIjxAl6KCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403765AbfCVMYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390168AbfCVMYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:24:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 940DC218B0;
        Fri, 22 Mar 2019 12:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257456;
        bh=cDP7EFgk1CQQMMMK2rwt+zfYHI1goK/2zA1WHcTbpKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=acDVKEDvf9sESnO5tLydL62e1w2LM1BECJE0yt9VAbO78QevvA3XIJEjfxL5q3fMO
         AFd98PdfVXVTJUQrkETvUCBkreIMQEh0S/NemXh9F6mUWaIQ0uMqJX69BXNVr/zGV0
         eU55QOg8JxuBQbVHp/qM+SlDHQRzzgQxrYIIgBcc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.0 238/238] SUNRPC: Respect RPC call timeouts when retrying transmission
Date:   Fri, 22 Mar 2019 12:17:37 +0100
Message-Id: <20190322111312.584244848@linuxfoundation.org>
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

commit 7b3fef8e4157ed424bcde039a60a730aa0dfb0eb upstream.

Fix a regression where soft and softconn requests are not timing out
as expected.

Fixes: 89f90fe1ad8b ("SUNRPC: Allow calls to xprt_transmit() to drain...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/clnt.c |   42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -77,6 +77,7 @@ static void	call_connect_status(struct r
 static __be32	*rpc_encode_header(struct rpc_task *task);
 static __be32	*rpc_verify_header(struct rpc_task *task);
 static int	rpc_ping(struct rpc_clnt *clnt);
+static void	rpc_check_timeout(struct rpc_task *task);
 
 static void rpc_register_client(struct rpc_clnt *clnt)
 {
@@ -1941,8 +1942,7 @@ call_connect_status(struct rpc_task *tas
 			break;
 		if (clnt->cl_autobind) {
 			rpc_force_rebind(clnt);
-			task->tk_action = call_bind;
-			return;
+			goto out_retry;
 		}
 		/* fall through */
 	case -ECONNRESET:
@@ -1962,16 +1962,19 @@ call_connect_status(struct rpc_task *tas
 		/* fall through */
 	case -ENOTCONN:
 	case -EAGAIN:
-		/* Check for timeouts before looping back to call_bind */
 	case -ETIMEDOUT:
-		task->tk_action = call_timeout;
-		return;
+		goto out_retry;
 	case 0:
 		clnt->cl_stats->netreconn++;
 		task->tk_action = call_transmit;
 		return;
 	}
 	rpc_exit(task, status);
+	return;
+out_retry:
+	/* Check for timeouts before looping back to call_bind */
+	task->tk_action = call_bind;
+	rpc_check_timeout(task);
 }
 
 /*
@@ -2048,7 +2051,7 @@ call_transmit_status(struct rpc_task *ta
 				trace_xprt_ping(task->tk_xprt,
 						task->tk_status);
 			rpc_exit(task, task->tk_status);
-			break;
+			return;
 		}
 		/* fall through */
 	case -ECONNRESET:
@@ -2060,6 +2063,7 @@ call_transmit_status(struct rpc_task *ta
 		task->tk_status = 0;
 		break;
 	}
+	rpc_check_timeout(task);
 }
 
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
@@ -2196,7 +2200,7 @@ call_status(struct rpc_task *task)
 	case -EPIPE:
 	case -ENOTCONN:
 	case -EAGAIN:
-		task->tk_action = call_encode;
+		task->tk_action = call_timeout;
 		break;
 	case -EIO:
 		/* shutdown or soft timeout */
@@ -2210,20 +2214,13 @@ call_status(struct rpc_task *task)
 	}
 }
 
-/*
- * 6a.	Handle RPC timeout
- * 	We do not release the request slot, so we keep using the
- *	same XID for all retransmits.
- */
 static void
-call_timeout(struct rpc_task *task)
+rpc_check_timeout(struct rpc_task *task)
 {
 	struct rpc_clnt	*clnt = task->tk_client;
 
-	if (xprt_adjust_timeout(task->tk_rqstp) == 0) {
-		dprintk("RPC: %5u call_timeout (minor)\n", task->tk_pid);
-		goto retry;
-	}
+	if (xprt_adjust_timeout(task->tk_rqstp) == 0)
+		return;
 
 	dprintk("RPC: %5u call_timeout (major)\n", task->tk_pid);
 	task->tk_timeouts++;
@@ -2259,10 +2256,19 @@ call_timeout(struct rpc_task *task)
 	 * event? RFC2203 requires the server to drop all such requests.
 	 */
 	rpcauth_invalcred(task);
+}
 
-retry:
+/*
+ * 6a.	Handle RPC timeout
+ * 	We do not release the request slot, so we keep using the
+ *	same XID for all retransmits.
+ */
+static void
+call_timeout(struct rpc_task *task)
+{
 	task->tk_action = call_encode;
 	task->tk_status = 0;
+	rpc_check_timeout(task);
 }
 
 /*


