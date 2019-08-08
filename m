Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B648DC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BF821743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291459;
	bh=5O/qCdf5EeoEXV+hINy4coar5n+yKm8x+R7wXINU+U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CQVPdlkhtEAlbDCetMz2WiQ7Ad74NfhJyIlt91XAbRjYQiO9cPYxlkf4i4eOwuJ/9
	 bcU2uMPOo+RVvhUqA8JuO5J7kD+AK4dn2kMgvQ8rq38gxaStI1XCFr1gl7k8mwQ2hy
	 Sl40KGnIYq0OmgYlZjSp4+LkfHc3/TOH0vhOb9L0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405402AbfHHTK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404754AbfHHTKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:10:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A26822189D;
        Thu,  8 Aug 2019 19:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291455;
        bh=5O/qCdf5EeoEXV+hINy4coar5n+yKm8x+R7wXINU+U8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=owTfvqy37j/VGSzZ9iZ15QEDbyVJsDB1Oyu+OXQtBZk13qgHg8GHoOkoe2fm8TgF2
         PRMp4HwlPXC+uvlJ5ThlaYlLKH6IimPV+mpykc1pxx7A18ABykOCCzVhwHmg+N60wR
         7UEv7fELj5t3nWKjF9frg7cJhyi2SKgmCGQTdwAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 20/33] net: sched: Fix a possible null-pointer dereference in dequeue_func()
Date:   Thu,  8 Aug 2019 21:05:27 +0200
Message-Id: <20190808190454.615932841@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190453.582417307@linuxfoundation.org>
References: <20190808190453.582417307@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 051c7b39be4a91f6b7d8c4548444e4b850f1f56c ]

In dequeue_func(), there is an if statement on line 74 to check whether
skb is NULL:
    if (skb)

When skb is NULL, it is used on line 77:
    prefetch(&skb->end);

Thus, a possible null-pointer dereference may occur.

To fix this bug, skb->end is used when skb is not NULL.

This bug is found by a static analysis tool STCheck written by us.

Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_codel.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -71,10 +71,10 @@ static struct sk_buff *dequeue_func(stru
 	struct Qdisc *sch = ctx;
 	struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
 
-	if (skb)
+	if (skb) {
 		sch->qstats.backlog -= qdisc_pkt_len(skb);
-
-	prefetch(&skb->end); /* we'll need skb_shinfo() */
+		prefetch(&skb->end); /* we'll need skb_shinfo() */
+	}
 	return skb;
 }
 


