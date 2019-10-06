Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A050C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50037214D9
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383190;
	bh=1GXRpsymtWB9hZXLq9qatKt70j1f7y51F2Xh7rviJZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jvpxHtmvxnnA2idpsI1/XevM+EMXrP/CbjKZGeOCM3B15eLWS9UkXMBZW2PbGt23t
	 B2vFxCJhdAuQpefz17W+QdAv6lEOXGldE8HZH+DNzJpGSCU/TdKVc9ntGeCqSa9SzU
	 0KqbHNxfKXgLyU+Sl2P4j/T30Kbk8Umm4Su3HOcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfJFRdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728971AbfJFRdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:33:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52BD92087E;
        Sun,  6 Oct 2019 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383186;
        bh=1GXRpsymtWB9hZXLq9qatKt70j1f7y51F2Xh7rviJZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjIi25iM+b2eniJKdftrNlbdASiCZ+l6o6TzTMwbxvYmLW2CMZZ1LYTDu5ihmMkTP
         zcoZ7RakRFj9MbWWkX9hfXsK2u2ittOhYJ1I9wJUPoY3t4QxU7PiOPBvpKdRzaG4HF
         OFGjv8Nvd0xOqXEQV4PVeyspF04aVP+RuZzDzIOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 012/137] rxrpc: Fix rxrpc_recvmsg tracepoint
Date:   Sun,  6 Oct 2019 19:19:56 +0200
Message-Id: <20191006171210.521976424@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
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
@@ -1071,7 +1071,7 @@ TRACE_EVENT(rxrpc_recvmsg,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call->debug_id;
+		    __entry->call = call ? call->debug_id : 0;
 		    __entry->why = why;
 		    __entry->seq = seq;
 		    __entry->offset = offset;


