Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FE7C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D4B20675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482462;
	bh=qwhmJel4Tb9FEkQb9Oal0KryGLoWB97vNL8j3CVZKys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sEt1PgqEiX84O21aOd5oCPpB2EZ6o9pH1/0bQn4bHauYvpc45nbxH08FPXjuxpSX5
	 tqB7yvOs4A/1kO2DOnhpyGcRP+srNJsfc4va30KiSSTpjN+kP/dsJ3BOQNfjiVanyy
	 1jnyF8kPjzDkflufM9YiV9b8qriKdyBTiGaPDq8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfLDSBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729459AbfLDSA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:00:58 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42D7B20659;
        Wed,  4 Dec 2019 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482457;
        bh=qwhmJel4Tb9FEkQb9Oal0KryGLoWB97vNL8j3CVZKys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2OC8i5b99EWyfJyODxjBnLDkYeZ0kM+BzOzIgFlNrarZlzWsLG4Km1xRRbcM0xX0
         jnBw+3oqNZeoXVqEpTEOz3xLmpHLHpaBnHZjuKq6zKAbx8fIjQk6cSdEbvp3spYYjf
         DB8/VFNakdS5SQ1cthM4LEyzALEYCE7ENRMnTVco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dust Li <dust.li@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 89/92] net: sched: fix `tc -s class show` no bstats on class with nolock subqueues
Date:   Wed,  4 Dec 2019 18:50:29 +0100
Message-Id: <20191204174335.511244512@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dust Li <dust.li@linux.alibaba.com>

[ Upstream commit 14e54ab9143fa60794d13ea0a66c792a2046a8f3 ]

When a classful qdisc's child qdisc has set the flag
TCQ_F_CPUSTATS (pfifo_fast for example), the child qdisc's
cpu_bstats should be passed to gnet_stats_copy_basic(),
but many classful qdisc didn't do that. As a result,
`tc -s class show dev DEV` always return 0 for bytes and
packets in this case.

Pass the child qdisc's cpu_bstats to gnet_stats_copy_basic()
to fix this issue.

The qstats also has this problem, but it has been fixed
in 5dd431b6b9 ("net: sched: introduce and use qstats read...")
and bstats still remains buggy.

Fixes: 22e0f8b9322c ("net: sched: make bstats per cpu and estimator RCU safe")
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_mq.c     |    2 +-
 net/sched/sch_mqprio.c |    3 ++-
 net/sched/sch_multiq.c |    2 +-
 net/sched/sch_prio.c   |    2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -195,7 +195,7 @@ static int mq_dump_class_stats(struct Qd
 	struct netdev_queue *dev_queue = mq_queue_get(sch, cl);
 
 	sch = dev_queue->qdisc_sleeping;
-	if (gnet_stats_copy_basic(d, NULL, &sch->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, sch->cpu_bstats, &sch->bstats) < 0 ||
 	    gnet_stats_copy_queue(d, NULL, &sch->qstats, sch->q.qlen) < 0)
 		return -1;
 	return 0;
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -355,7 +355,8 @@ static int mqprio_dump_class_stats(struc
 		struct netdev_queue *dev_queue = mqprio_queue_get(sch, cl);
 
 		sch = dev_queue->qdisc_sleeping;
-		if (gnet_stats_copy_basic(d, NULL, &sch->bstats) < 0 ||
+		if (gnet_stats_copy_basic(d, sch->cpu_bstats,
+					  &sch->bstats) < 0 ||
 		    gnet_stats_copy_queue(d, NULL,
 					  &sch->qstats, sch->q.qlen) < 0)
 			return -1;
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -351,7 +351,7 @@ static int multiq_dump_class_stats(struc
 	struct Qdisc *cl_q;
 
 	cl_q = q->queues[cl - 1];
-	if (gnet_stats_copy_basic(d, NULL, &cl_q->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, cl_q->cpu_bstats, &cl_q->bstats) < 0 ||
 	    gnet_stats_copy_queue(d, NULL, &cl_q->qstats, cl_q->q.qlen) < 0)
 		return -1;
 
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -319,7 +319,7 @@ static int prio_dump_class_stats(struct
 	struct Qdisc *cl_q;
 
 	cl_q = q->queues[cl - 1];
-	if (gnet_stats_copy_basic(d, NULL, &cl_q->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, cl_q->cpu_bstats, &cl_q->bstats) < 0 ||
 	    gnet_stats_copy_queue(d, NULL, &cl_q->qstats, cl_q->q.qlen) < 0)
 		return -1;
 


