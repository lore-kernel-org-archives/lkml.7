Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82FDC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96B221D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfJBTLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:11:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35596 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729202AbfJBTIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:08:12 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iFjyr-00035v-D5; Wed, 02 Oct 2019 20:08:09 +0100
Received: from ben by deadeye with local (Exim 4.92.1)
        (envelope-from <ben@decadent.org.uk>)
        id 1iFjyo-0003dd-Ey; Wed, 02 Oct 2019 20:08:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Santosh Shilimkar" <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Zhu Yanjun" <yanjun.zhu@oracle.com>
Date:   Wed, 02 Oct 2019 20:06:51 +0100
Message-ID: <lsq.1570043211.436412731@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 47/87] net: rds: fix memory leak in rds_ib_flush_mr_pool
In-Reply-To: <lsq.1570043210.379046399@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.75-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Zhu Yanjun <yanjun.zhu@oracle.com>

commit 85cb928787eab6a2f4ca9d2a798b6f3bed53ced1 upstream.

When the following tests last for several hours, the problem will occur.

Server:
    rds-stress -r 1.1.1.16 -D 1M
Client:
    rds-stress -r 1.1.1.14 -s 1.1.1.16 -D 1M -T 30

The following will occur.

"
Starting up....
tsks   tx/s   rx/s  tx+rx K/s    mbi K/s    mbo K/s tx us/c   rtt us cpu
%
  1      0      0       0.00       0.00       0.00    0.00 0.00 -1.00
  1      0      0       0.00       0.00       0.00    0.00 0.00 -1.00
  1      0      0       0.00       0.00       0.00    0.00 0.00 -1.00
  1      0      0       0.00       0.00       0.00    0.00 0.00 -1.00
"
>From vmcore, we can find that clean_list is NULL.

>From the source code, rds_mr_flushd calls rds_ib_mr_pool_flush_worker.
Then rds_ib_mr_pool_flush_worker calls
"
 rds_ib_flush_mr_pool(pool, 0, NULL);
"
Then in function
"
int rds_ib_flush_mr_pool(struct rds_ib_mr_pool *pool,
                         int free_all, struct rds_ib_mr **ibmr_ret)
"
ibmr_ret is NULL.

In the source code,
"
...
list_to_llist_nodes(pool, &unmap_list, &clean_nodes, &clean_tail);
if (ibmr_ret)
        *ibmr_ret = llist_entry(clean_nodes, struct rds_ib_mr, llnode);

/* more than one entry in llist nodes */
if (clean_nodes->next)
        llist_add_batch(clean_nodes->next, clean_tail, &pool->clean_list);
...
"
When ibmr_ret is NULL, llist_entry is not executed. clean_nodes->next
instead of clean_nodes is added in clean_list.
So clean_nodes is discarded. It can not be used again.
The workqueue is executed periodically. So more and more clean_nodes are
discarded. Finally the clean_list is NULL.
Then this problem will occur.

Fixes: 1bc144b62524 ("net, rds, Replace xlist in net/rds/xlist.h with llist")
Signed-off-by: Zhu Yanjun <yanjun.zhu@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/rds/ib_rdma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/net/rds/ib_rdma.c
+++ b/net/rds/ib_rdma.c
@@ -663,12 +663,14 @@ static int rds_ib_flush_mr_pool(struct r
 		wait_clean_list_grace();
 
 		list_to_llist_nodes(pool, &unmap_list, &clean_nodes, &clean_tail);
-		if (ibmr_ret)
+		if (ibmr_ret) {
 			*ibmr_ret = llist_entry(clean_nodes, struct rds_ib_mr, llnode);
-
+			clean_nodes = clean_nodes->next;
+		}
 		/* more than one entry in llist nodes */
-		if (clean_nodes->next)
-			llist_add_batch(clean_nodes->next, clean_tail, &pool->clean_list);
+		if (clean_nodes)
+			llist_add_batch(clean_nodes, clean_tail,
+					&pool->clean_list);
 
 	}
 

