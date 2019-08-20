Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88340C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0F52332A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566308436;
	bh=LzCW5ZLU9vvodqH8UFDmSBv/SKHCUYOMIc5f1xBiPuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f8Oh0ELoHWvaja+5J2fP6MYZ5VVSJt4WMw6kQT8a+Co3iBdhWRAf1FZx/mdP85CEN
	 dYH5Ib6lTPlKGaF0UAgMCwCejYERi228qHWiMlEb4iL5BbFrFQTP7rbCXeJCG+r7bP
	 o1fwolsodajU46Qw6+qO7d5DpggZOkVTzPGqKZyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbfHTNkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbfHTNkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:40:32 -0400
Received: from sasha-vm.mshome.net (unknown [12.236.144.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5D5D22DBF;
        Tue, 20 Aug 2019 13:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308432;
        bh=LzCW5ZLU9vvodqH8UFDmSBv/SKHCUYOMIc5f1xBiPuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2nnGqge3zek/gblNJFz+M+layM8SZqaWyqB5OZT5v/gT7P0HDpq0SN3PZfUnp3lux
         FKMw1upQL2hJZiR7KgHApz+UkLicagOYztMv/YZRYnh0iL6qKMZ+zTknMc44a74+ng
         XNuYz3zn3EKxdqpHkEbzlKddcnUhv7QZzCuGaebQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 5.2 03/44] afs: Fix the CB.ProbeUuid service handler to reply correctly
Date:   Tue, 20 Aug 2019 09:39:47 -0400
Message-Id: <20190820134028.10829-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820134028.10829-1-sashal@kernel.org>
References: <20190820134028.10829-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

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
index 3451be03667f0..00033a481ba05 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -502,18 +502,14 @@ static void SRXAFSCB_ProbeUuid(struct work_struct *work)
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

