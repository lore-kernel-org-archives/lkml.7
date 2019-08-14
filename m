Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033F9C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24CD20842
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749008;
	bh=OPSiXxS4swt0ozoxU8qLxZd2FnOGMLU53bDmra08Nqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0WQA+gxd0X8B1rSXjGRmnKFqxlwDCBzwnNYCX8C+uQnGsOrlOy8UqgRw4RzRVvpMb
	 cgYt9CtVdI6GJNqe0C9UzjAeeJ3hvygiiINVcfZytQksSvl+CmAkMFYgbI+Mf2HbVm
	 hzyfk+GXj6kp3nyXLSVuwfV/czskK++d4lWQszpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfHNCQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729174AbfHNCQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:16:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8533E208C2;
        Wed, 14 Aug 2019 02:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749003;
        bh=OPSiXxS4swt0ozoxU8qLxZd2FnOGMLU53bDmra08Nqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yIM0o/SVM009u8vLeJrsFxxPFM8Gstn39hxqlltnefyEYMECtozST/HTyBDlmKw2v
         3b8i2UTR2nAixFJsMEV1pvn8pGLceVe8TkDMW2sEzhKcth4zcqrxS7hnxRUS02YXJ1
         Zd9RSICi6yQ59D0pFwibalFNbKtb7PJsxPsfaFk0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 30/68] rxrpc: Fix the lack of notification when sendmsg() fails on a DATA packet
Date:   Tue, 13 Aug 2019 22:15:08 -0400
Message-Id: <20190814021548.16001-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021548.16001-1-sashal@kernel.org>
References: <20190814021548.16001-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit c69565ee6681e151e2bb80502930a16e04b553d1 ]

Fix the fact that a notification isn't sent to the recvmsg side to indicate
a call failed when sendmsg() fails to transmit a DATA packet with the error
ENETUNREACH, EHOSTUNREACH or ECONNREFUSED.

Without this notification, the afs client just sits there waiting for the
call to complete in some manner (which it's not now going to do), which
also pins the rxrpc call in place.

This can be seen if the client has a scope-level IPv6 address, but not a
global-level IPv6 address, and we try and transmit an operation to a
server's IPv6 address.

Looking in /proc/net/rxrpc/calls shows completed calls just sat there with
an abort code of RX_USER_ABORT and an error code of -ENETUNREACH.

Fixes: c54e43d752c7 ("rxrpc: Fix missing start of call timeout")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/sendmsg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index be01f9c5d963d..5d6ab4f6fd7ab 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -230,6 +230,7 @@ static void rxrpc_queue_packet(struct rxrpc_sock *rx, struct rxrpc_call *call,
 			rxrpc_set_call_completion(call,
 						  RXRPC_CALL_LOCAL_ERROR,
 						  0, ret);
+			rxrpc_notify_socket(call);
 			goto out;
 		}
 		_debug("need instant resend %d", ret);
-- 
2.20.1

