Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073ADC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E952054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257490;
	bh=ZnHAij9gG4Hk3sBecLQ9HLx75XVOT1v67/qlEBoLm1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eIlK8OCaL72GCx7Yg5cflYhJL2vRDhX4qdi4KVBmq/PzI3hwd//6QDw7Mra4ne+fI
	 UVxYVnc+wCSVV0LSAHcnnIdKqq7oi+tinJmREa0kHjQxQiJoGLcqPqaL6thIfZWFEe
	 wV9zcCr/vezjQT0WCF352CquwiHUthQ3iFlPE/xQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390953AbfCVMYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403804AbfCVMYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:24:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E51DC21917;
        Fri, 22 Mar 2019 12:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257481;
        bh=ZnHAij9gG4Hk3sBecLQ9HLx75XVOT1v67/qlEBoLm1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1NBRqimB5Q2mfzEY2ZBosA4x0C0tIe69SgRv02tbhuBDgcqxQt7zSxSNHjOTzPv2
         jyjq+IjzP4ftkuUKgRHL/gpO70TMaMyHIa4u1+JMFMAYKlsBIF59Gm2MDbWcNmZJS+
         2f1i9MmNdQuqz2kucTwcd7/H/1W6QC688G2HHcZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.0 236/238] SUNRPC: Prevent thundering herd when the socket is not connected
Date:   Fri, 22 Mar 2019 12:17:35 +0100
Message-Id: <20190322111312.358290131@linuxfoundation.org>
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

commit ed7dc973bd91da234d93aff6d033a5206a6c9885 upstream.

If the socket is not connected, then we want to initiate a reconnect
rather that trying to transmit requests. If there is a large number
of requests queued and waiting for the lock in call_transmit(),
then it can take a while for one of the to loop back and retake
the lock in call_connect.

Fixes: 89f90fe1ad8b ("SUNRPC: Allow calls to xprt_transmit() to drain...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/clnt.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1786,7 +1786,12 @@ call_encode(struct rpc_task *task)
 		xprt_request_enqueue_receive(task);
 	xprt_request_enqueue_transmit(task);
 out:
-	task->tk_action = call_bind;
+	task->tk_action = call_transmit;
+	/* Check that the connection is OK */
+	if (!xprt_bound(task->tk_xprt))
+		task->tk_action = call_bind;
+	else if (!xprt_connected(task->tk_xprt))
+		task->tk_action = call_connect;
 }
 
 /*
@@ -1978,13 +1983,19 @@ call_transmit(struct rpc_task *task)
 {
 	dprint_status(task);
 
-	task->tk_status = 0;
+	task->tk_action = call_transmit_status;
 	if (test_bit(RPC_TASK_NEED_XMIT, &task->tk_runstate)) {
 		if (!xprt_prepare_transmit(task))
 			return;
-		xprt_transmit(task);
+		task->tk_status = 0;
+		if (test_bit(RPC_TASK_NEED_XMIT, &task->tk_runstate)) {
+			if (!xprt_connected(task->tk_xprt)) {
+				task->tk_status = -ENOTCONN;
+				return;
+			}
+			xprt_transmit(task);
+		}
 	}
-	task->tk_action = call_transmit_status;
 	xprt_end_transmit(task);
 }
 
@@ -2046,6 +2057,8 @@ call_transmit_status(struct rpc_task *ta
 	case -EADDRINUSE:
 	case -ENOTCONN:
 	case -EPIPE:
+		task->tk_action = call_bind;
+		task->tk_status = 0;
 		break;
 	}
 }


