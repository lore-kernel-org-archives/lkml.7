Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011E1C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE14A21479
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383907;
	bh=P4C5TgzQeK/LMa/rSvPHjHzKt72/DZvI9t4iIN0eWyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ok3hKdds+e4s8ugO/NleQOYvsYqEB/2Ujo7ouU1zCEb7bhd3C8+l4fLxdGPB6vdju
	 K9Sh53Fp8TR9p7BQvlmNjqEoNxJUOLmQo4peosbXsMkd2dlsnU7W5GlAX7p6fqasEz
	 H2UJlp7dN3lwPf3Ci2FNUYvLiecJo9xZTv5ROPwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbfJFRpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731864AbfJFRpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:45:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5A8B20862;
        Sun,  6 Oct 2019 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383903;
        bh=P4C5TgzQeK/LMa/rSvPHjHzKt72/DZvI9t4iIN0eWyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uL5rTkeTXEI5s0rTKAfLF2cIhkX2u5WR7qfaBJZISp2RlhyTN2ufjo43HH3rz+A7O
         G42fzjgLEL1bQD83hgpGxuYFIjSMk6vMI2hjdrMsJJQ8Bw+A3410iMN2LwZMLbvQA5
         VBaISawdBhvtcZR1s0gaL2dA/g5dp0Na5L4UjGvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 139/166] rxrpc: Fix rxrpc_recvmsg tracepoint
Date:   Sun,  6 Oct 2019 19:21:45 +0200
Message-Id: <20191006171224.787251103@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit db9b2e0af605e7c994784527abfd9276cabd718a ]

Fix the rxrpc_recvmsg tracepoint to handle being called with a NULL call
parameter.

Fixes: a25e21f0bcd2 ("rxrpc, afs: Use debug_ids rather than pointers in traces")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/trace/events/rxrpc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -1068,7 +1068,7 @@ TRACE_EVENT(rxrpc_recvmsg,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call->debug_id;
+		    __entry->call = call ? call->debug_id : 0;
 		    __entry->why = why;
 		    __entry->seq = seq;
 		    __entry->offset = offset;


