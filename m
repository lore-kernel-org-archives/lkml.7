Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3219EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1075B20818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfDLPeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:34:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLPeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:34:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62ABA30AA3AD;
        Fri, 12 Apr 2019 15:34:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81A106014E;
        Fri, 12 Apr 2019 15:34:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 4/6] afs: Check for rxrpc call completion in wait loop
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 12 Apr 2019 16:34:02 +0100
Message-ID: <155508324270.11035.16646383498388576094.stgit@warthog.procyon.org.uk>
In-Reply-To: <155508321298.11035.7196100250886302901.stgit@warthog.procyon.org.uk>
References: <155508321298.11035.7196100250886302901.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 12 Apr 2019 15:34:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Dionne <marc.dionne@auristor.com>

Check the state of the rxrpc call backing an afs call in each iteration of
the call wait loop in case the rxrpc call has already been terminated at
the rxrpc layer.

Interrupt the wait loop and mark the afs call as complete if the rxrpc
layer call is complete.

There were cases where rxrpc errors were not passed up to afs, which could
result in this loop waiting forever for an afs call to transition to
AFS_CALL_COMPLETE while the rx call was already complete.

Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/rxrpc.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 5cb11aff9298..c14001b42d20 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -610,6 +610,7 @@ static long afs_wait_for_call_to_complete(struct afs_call *call,
 	bool stalled = false;
 	u64 rtt;
 	u32 life, last_life;
+	bool rxrpc_complete = false;
 
 	DECLARE_WAITQUEUE(myself, current);
 
@@ -639,7 +640,12 @@ static long afs_wait_for_call_to_complete(struct afs_call *call,
 		if (afs_check_call_state(call, AFS_CALL_COMPLETE))
 			break;
 
-		rxrpc_kernel_check_life(call->net->socket, call->rxcall, &life);
+		if (!rxrpc_kernel_check_life(call->net->socket, call->rxcall, &life)) {
+			/* rxrpc terminated the call. */
+			rxrpc_complete = true;
+			break;
+		}
+
 		if (timeout == 0 &&
 		    life == last_life && signal_pending(current)) {
 			if (stalled)
@@ -663,12 +669,16 @@ static long afs_wait_for_call_to_complete(struct afs_call *call,
 	remove_wait_queue(&call->waitq, &myself);
 	__set_current_state(TASK_RUNNING);
 
-	/* Kill off the call if it's still live. */
 	if (!afs_check_call_state(call, AFS_CALL_COMPLETE)) {
-		_debug("call interrupted");
-		if (rxrpc_kernel_abort_call(call->net->socket, call->rxcall,
-					    RX_USER_ABORT, -EINTR, "KWI"))
-			afs_set_call_complete(call, -EINTR, 0);
+		if (rxrpc_complete) {
+			afs_set_call_complete(call, call->error, call->abort_code);
+		} else {
+			/* Kill off the call if it's still live. */
+			_debug("call interrupted");
+			if (rxrpc_kernel_abort_call(call->net->socket, call->rxcall,
+						    RX_USER_ABORT, -EINTR, "KWI"))
+				afs_set_call_complete(call, -EINTR, 0);
+		}
 	}
 
 	spin_lock_bh(&call->state_lock);

