Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589AAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285C52075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901924;
	bh=oYoYZV8mqzlxaxx93XOfSMg83lepof+eqoLletY2qOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K/PrNkjxfpnrkCCPHGgGQGsb8G/HXOOpWoezoJcqQ44UnEX02lfZJj0d9oIJRG1nM
	 to0DTlc45hKgRALXWJkzTY7gXO+h2f4nifELxY5eaKzUh9ShfGfFWdq1Evbp3A+8N6
	 Ecp/jOjLr93KptRHwf+F+xdO5nYFmR+v/ECT8hUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387778AbfCRJhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387757AbfCRJhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:37:00 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 880B62075C;
        Mon, 18 Mar 2019 09:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901820;
        bh=oYoYZV8mqzlxaxx93XOfSMg83lepof+eqoLletY2qOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PcxdW74coIPwwfsawUxCwC7O8Q+K0vYtUoEmKxPKtOBCnVwP52f/fcLHkReK8u63W
         eFdXIPKhJe6mtDhGsy+0p+vOAFQbBob7sGRMI1xRmkO3TilwTvdACY6yazyvtFl0L2
         D7A6wm0O+/z9EjK8NfkFu6T2SlZDmiYN4trQK2TM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 23/31] rxrpc: Fix client call queueing, waiting for channel
Date:   Mon, 18 Mar 2019 10:25:58 +0100
Message-Id: <20190318084211.344832305@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084210.397476003@linuxfoundation.org>
References: <20190318084210.397476003@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -355,7 +355,7 @@ static int rxrpc_get_client_conn(struct
 	 * normally have to take channel_lock but we do this before anyone else
 	 * can see the connection.
 	 */
-	list_add_tail(&call->chan_wait_link, &candidate->waiting_calls);
+	list_add(&call->chan_wait_link, &candidate->waiting_calls);
 
 	if (cp->exclusive) {
 		call->conn = candidate;
@@ -430,7 +430,7 @@ found_extant_conn:
 	spin_lock(&conn->channel_lock);
 	call->conn = conn;
 	call->security_ix = conn->security_ix;
-	list_add(&call->chan_wait_link, &conn->waiting_calls);
+	list_add_tail(&call->chan_wait_link, &conn->waiting_calls);
 	spin_unlock(&conn->channel_lock);
 	_leave(" = 0 [extant %d]", conn->debug_id);
 	return 0;


