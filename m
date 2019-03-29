Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308F2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AC3218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfC2P1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:27:31 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.40]:32754 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728910AbfC2P1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:27:31 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 642AA1026D24
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 10:27:30 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9tPmhPl3EYTGM9tPmhajfB; Fri, 29 Mar 2019 10:27:30 -0500
X-Authority-Reason: nr=8
Received: from [189.250.126.17] (port=51972 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1h9tPj-002heF-Gp; Fri, 29 Mar 2019 10:27:29 -0500
Date:   Fri, 29 Mar 2019 10:27:26 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Vishal Kulkarni <vishal@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Neil Horman <nhorman@tuxdriver.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 1/2 net-next] cxgb3/l2t: Fix undefined behaviour
Message-ID: <0d7b7e61aa857ea5273f8fd5fc98242b5d2a39b2.1553872521.git.gustavo@embeddedor.com>
References: <cover.1553872521.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553872521.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.126.17
X-Source-L: No
X-Exim-ID: 1h9tPj-002heF-Gp
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.126.17]:51972
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of zero-sized array causes undefined behaviour when it is not
the last member in a structure. As it happens to be in this case.

Also, the current code makes use of a language extension to the C90
standard, but the preferred mechanism to declare variable-length
types such as this one is a flexible array member, introduced in
C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last. Which is beneficial
to cultivate a high-quality code.

Fixes: e48f129c2f20 ("[SCSI] cxgb3i: convert cdev->l2opt to use rcu to prevent NULL dereference")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/chelsio/cxgb3/l2t.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/l2t.h b/drivers/net/ethernet/chelsio/cxgb3/l2t.h
index c2fd323c4078..ea75f275023f 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/l2t.h
+++ b/drivers/net/ethernet/chelsio/cxgb3/l2t.h
@@ -75,8 +75,8 @@ struct l2t_data {
 	struct l2t_entry *rover;	/* starting point for next allocation */
 	atomic_t nfree;		/* number of free entries */
 	rwlock_t lock;
-	struct l2t_entry l2tab[0];
 	struct rcu_head rcu_head;	/* to handle rcu cleanup */
+	struct l2t_entry l2tab[];
 };
 
 typedef void (*arp_failure_handler_func)(struct t3cdev * dev,
-- 
2.21.0

