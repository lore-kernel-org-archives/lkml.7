Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C503C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC7620856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139340;
	bh=56hPDBnDyY2rH2VEM/wtXuJLP55OmI2vEOO/nAmKKms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mt4t7P93mIdmwru72sKcM7Pw7d9fDGwf5+odGmoOYfNSDBKAjT5UFEcmmwyfs28FA
	 PSbuPvnkbhy0qOZV0ok4SKesJmEtjY5xNGK6lxg5Ep4ZXQwsDYd6BbbGLhnj0uTafZ
	 MPyas9lg9BnwoJvwFbpftDzOB8C0ObiynhLFYnfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbfDARWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:22:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731112AbfDARWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:22:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8069B20856;
        Mon,  1 Apr 2019 17:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139334;
        bh=56hPDBnDyY2rH2VEM/wtXuJLP55OmI2vEOO/nAmKKms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjMO5Jw0qV9Ay/ARMZ0qzTM/YjbotjbTAfP0+dVzGnu2H11Hv1Hp3m3JRkAnYSZ+E
         FmpUjJDXAXlnRw871b32Q9dQYScZh0mCtGMFiE9Satx4jJPZgDLQ2zD0gj3TXBrmqi
         IIpd9r9gm84ax5B24tVdzuQOMcMLwPe7DcQJo6NY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH 4.14 008/107] net: datagram: fix unbounded loop in __skb_try_recv_datagram()
Date:   Mon,  1 Apr 2019 19:01:23 +0200
Message-Id: <20190401170046.331227014@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 0b91bce1ebfc797ff3de60c8f4a1e6219a8a3187 ]

Christoph reported a stall while peeking datagram with an offset when
busy polling is enabled. __skb_try_recv_datagram() uses as the loop
termination condition 'queue empty'. When peeking, the socket
queue can be not empty, even when no additional packets are received.

Address the issue explicitly checking for receive queue changes,
as currently done by __skb_wait_for_more_packets().

Fixes: 2b5cd0dfa384 ("net: Change return type of sk_busy_loop from bool to void")
Reported-and-tested-by: Christoph Paasch <cpaasch@apple.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/datagram.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -281,7 +281,7 @@ struct sk_buff *__skb_try_recv_datagram(
 			break;
 
 		sk_busy_loop(sk, flags & MSG_DONTWAIT);
-	} while (!skb_queue_empty(&sk->sk_receive_queue));
+	} while (sk->sk_receive_queue.prev != *last);
 
 	error = -EAGAIN;
 


