Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4917FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9BB21903
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887878;
	bh=l6iiVA3E9iGMZdpQYcBruEKsw7d0YFm93jzD7sppr0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=giI+JU91MH4XQhWoOJkSUPbPo3NN4RQRgsEBctlhVXG3xK0ydYEC5fNsc95bwy6nW
	 HAXyEkiEXA9angSHR6/qVDrkMQrTmrII3P4WIRMPgtM3qgvXMsRwgMLy7RnrGbqxRc
	 YQb69/h2Cv9q13/lvYoD4/oiupuuKBz1iFeUdcN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfK0UvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:51:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730443AbfK0UvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:51:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C4D2192C;
        Wed, 27 Nov 2019 20:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887872;
        bh=l6iiVA3E9iGMZdpQYcBruEKsw7d0YFm93jzD7sppr0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gIPiYkkxUlp7NtM6v5vYV2AQ0h2ldLaHbybZnV/otfbFEp9p2Mj4Jn++7fHHL6vTh
         oSTD6h+LWxSLEbNKk2RPueIf51I3cyQefATW3StYGzhJO9bobA1UPJFIW79tZhTFs4
         y9qG72/dxXBzlvNpjMlZRFtJYPp5j2ghNPx9aeps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 126/211] net: do not abort bulk send on BQL status
Date:   Wed, 27 Nov 2019 21:30:59 +0100
Message-Id: <20191127203106.019810447@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit fe60faa5063822f2d555f4f326c7dd72a60929bf ]

Before calling dev_hard_start_xmit(), upper layers tried
to cook optimal skb list based on BQL budget.

Problem is that GSO packets can end up comsuming more than
the BQL budget.

Breaking the loop is not useful, since requeued packets
are ahead of any packets still in the qdisc.

It is also more expensive, since next TX completion will
push these packets later, while skbs are not in cpu caches.

It is also a behavior difference with TSO packets, that can
break the BQL limit by a large amount.

Note that drivers should use __netdev_tx_sent_queue()
in order to have optimal xmit_more support, and avoid
useless atomic operations as shown in the following patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9d6beb9de924b..3ce68484ed5aa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3029,7 +3029,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *first, struct net_device *de
 		}
 
 		skb = next;
-		if (netif_xmit_stopped(txq) && skb) {
+		if (netif_tx_queue_stopped(txq) && skb) {
 			rc = NETDEV_TX_BUSY;
 			break;
 		}
-- 
2.20.1



