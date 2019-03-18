Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8773AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D90214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901347;
	bh=q+rztsWH+IacQFsnmGrmXwqJSGtzJItBrN5o5C7IeW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UtDUwOQGOP4EHRC5YyobxmmQeOQre6Gx7RByoYoAaD53WNo48gl/DpY0c+QaB9UpZ
	 YfMY0YfjA0XI2pdnH/0tP1p4jKmgEEsrAuit7A8VdF5/wl4hHhzHIsnw76EP1tDIvn
	 w7PFfnYqhj4dK7PD0qXXVG+10v6iGyn5Pe2/qRBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfCRJ3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbfCRJ3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:29:02 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D04B2075C;
        Mon, 18 Mar 2019 09:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901342;
        bh=q+rztsWH+IacQFsnmGrmXwqJSGtzJItBrN5o5C7IeW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUL1FLMDcq9Ot5rRyfJoeEHHMwwicsUios0Tw90NzdsWvPlLwZVSP0KaoqRWnQmM7
         KiLEyfVbYUfPx7Kwy3uH6L1F6PQeqUnAQaqatPD7fBLateS2eBHVC/H5JuX5NfIyh7
         UAgsP8W4krI9F5RELBbNr6h3jT1ZMHe35v7xFEeM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 16/52] rxrpc: Fix client call queueing, waiting for channel
Date:   Mon, 18 Mar 2019 10:25:03 +0100
Message-Id: <20190318083845.369418065@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083843.398913295@linuxfoundation.org>
References: <20190318083843.398913295@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 69ffaebb90369ce08657b5aea4896777b9d6e8fc ]

rxrpc_get_client_conn() adds a new call to the front of the waiting_calls
queue if the connection it's going to use already exists.  This is bad as
it allows calls to get starved out.

Fix this by adding to the tail instead.

Also change the other enqueue point in the same function to put it on the
front (ie. when we have a new connection).  This makes the point that in
the case of a new connection the new call goes at the front (though it
doesn't actually matter since the queue should be unoccupied).

Fixes: 45025bceef17 ("rxrpc: Improve management and caching of client connection objects")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/conn_client.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -353,7 +353,7 @@ static int rxrpc_get_client_conn(struct
 	 * normally have to take channel_lock but we do this before anyone else
 	 * can see the connection.
 	 */
-	list_add_tail(&call->chan_wait_link, &candidate->waiting_calls);
+	list_add(&call->chan_wait_link, &candidate->waiting_calls);
 
 	if (cp->exclusive) {
 		call->conn = candidate;
@@ -432,7 +432,7 @@ found_extant_conn:
 	call->conn = conn;
 	call->security_ix = conn->security_ix;
 	call->service_id = conn->service_id;
-	list_add(&call->chan_wait_link, &conn->waiting_calls);
+	list_add_tail(&call->chan_wait_link, &conn->waiting_calls);
 	spin_unlock(&conn->channel_lock);
 	_leave(" = 0 [extant %d]", conn->debug_id);
 	return 0;


