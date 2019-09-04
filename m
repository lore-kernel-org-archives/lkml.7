Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82498C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC8E23402
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620367;
	bh=awKC4Bz62hBmNN8GYGsbiOOk001llEw8zxKsLuVc8Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s9c/B6hW6awCiAxL9z3NL5UsKA+FzFPjr0rRZK6bLSvZd/JOxxiQtiH4Ig8rW/e2c
	 Ycq0tPGx2cJTQ8KCQAu/urs5LFKkP6kxHl9b2HnO4Q2FSTCbftVLTR/H+M2ufzpMGv
	 D/Itz59mY2LLhc9mqLzOTeW5frnuZ6jTfwzbI8WU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389384AbfIDSGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389007AbfIDSGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:06:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71D52208E4;
        Wed,  4 Sep 2019 18:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620364;
        bh=awKC4Bz62hBmNN8GYGsbiOOk001llEw8zxKsLuVc8Pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIkUXu//LOCuhBChLqOCYozJcFmUOkU+yGcNAqmJVsPkCHWfHOTzPGC/BUHdsRQ52
         +1ltd5rXtlcBB/ccZT/G46lG1jSCyKHki8jSwTItBokINTdpXcu48W5ML/qUJmc65W
         V84HdavP73TvRjEJwQjbwafsS6WXJfpunKxMecsg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 03/93] afs: Fix the CB.ProbeUuid service handler to reply correctly
Date:   Wed,  4 Sep 2019 19:53:05 +0200
Message-Id: <20190904175303.213488999@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2067b2b3f4846402a040286135f98f46f8919939 ]

Fix the service handler function for the CB.ProbeUuid RPC call so that it
replies in the correct manner - that is an empty reply for success and an
abort of 1 for failure.

Putting 0 or 1 in an integer in the body of the reply should result in the
fileserver throwing an RX_PROTOCOL_ERROR abort and discarding its record of
the client; older servers, however, don't necessarily check that all the
data got consumed, and so might incorrectly think that they got a positive
response and associate the client with the wrong host record.

If the client is incorrectly associated, this will result in callbacks
intended for a different client being delivered to this one and then, when
the other client connects and responds positively, all of the callback
promises meant for the client that issued the improper response will be
lost and it won't receive any further change notifications.

Fixes: 9396d496d745 ("afs: support the CB.ProbeUuid RPC op")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/cmservice.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 9e51d6fe7e8f9..40c6860d4c632 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -423,18 +423,14 @@ static void SRXAFSCB_ProbeUuid(struct work_struct *work)
 	struct afs_call *call = container_of(work, struct afs_call, work);
 	struct afs_uuid *r = call->request;
 
-	struct {
-		__be32	match;
-	} reply;
-
 	_enter("");
 
 	if (memcmp(r, &call->net->uuid, sizeof(call->net->uuid)) == 0)
-		reply.match = htonl(0);
+		afs_send_empty_reply(call);
 	else
-		reply.match = htonl(1);
+		rxrpc_kernel_abort_call(call->net->socket, call->rxcall,
+					1, 1, "K-1");
 
-	afs_send_simple_reply(call, &reply, sizeof(reply));
 	afs_put_call(call);
 	_leave("");
 }
-- 
2.20.1



