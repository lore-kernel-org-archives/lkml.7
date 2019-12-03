Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99B1C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6DD2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413872;
	bh=azEjHxdobVpLrBuVON+RqhQ/vyeDDx3B/0LmTtUsjdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o2/H56jVqMr3dFbH/wpWA3w9DeQ/wnvwIoTCaFAoyAr6tS2QVASJw8od2V2oSO/KH
	 0eDb1YloZqLED9Ma+qgUd6ObvSazvQSXDCBaPUoWP2LQE3BfunJEDPnbdjQP//tTCN
	 nSzLOz1ttKPcuDkra4g6NMzUq+4kFcnw1fNgTnT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfLCW5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:57:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:53756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730135AbfLCW5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:57:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B78892053B;
        Tue,  3 Dec 2019 22:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413868;
        bh=azEjHxdobVpLrBuVON+RqhQ/vyeDDx3B/0LmTtUsjdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PNRv0IDaLZ/4Ts0FNkQepM2Rdflt+0437kb0LbX+kIyVhq+8OagRvPfjA7OElvGLb
         cz6KQFJY8d/MndMrc4OO3U1px1N5r8CLyApyoYwRxGYsYO2uG2pp82sCb/PrZ84bjt
         misk4YllVgOUGA/2T+Pl2MpbirbYleD8vVrV9v/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dust Li <dust.li@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 292/321] net: sched: fix `tc -s class show` no bstats on class with nolock subqueues
Date:   Tue,  3 Dec 2019 23:35:58 +0100
Message-Id: <20191203223442.336193717@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
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
 net/sched/sch_mq.c     |    3 ++-
 net/sched/sch_mqprio.c |    4 ++--
 net/sched/sch_multiq.c |    2 +-
 net/sched/sch_prio.c   |    2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -242,7 +242,8 @@ static int mq_dump_class_stats(struct Qd
 	struct netdev_queue *dev_queue = mq_queue_get(sch, cl);
 
 	sch = dev_queue->qdisc_sleeping;
-	if (gnet_stats_copy_basic(&sch->running, d, NULL, &sch->bstats) < 0 ||
+	if (gnet_stats_copy_basic(&sch->running, d, sch->cpu_bstats,
+				  &sch->bstats) < 0 ||
 	    gnet_stats_copy_queue(d, NULL, &sch->qstats, sch->q.qlen) < 0)
 		return -1;
 	return 0;
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -559,8 +559,8 @@ static int mqprio_dump_class_stats(struc
 		struct netdev_queue *dev_queue = mqprio_queue_get(sch, cl);
 
 		sch = dev_queue->qdisc_sleeping;
-		if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-					  d, NULL, &sch->bstats) < 0 ||
+		if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch), d,
+					  sch->cpu_bstats, &sch->bstats) < 0 ||
 		    gnet_stats_copy_queue(d, NULL,
 					  &sch->qstats, sch->q.qlen) < 0)
 			return -1;
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -343,7 +343,7 @@ static int multiq_dump_class_stats(struc
 
 	cl_q = q->queues[cl - 1];
 	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &cl_q->bstats) < 0 ||
+				  d, cl_q->cpu_bstats, &cl_q->bstats) < 0 ||
 	    gnet_stats_copy_queue(d, NULL, &cl_q->qstats, cl_q->q.qlen) < 0)
 		return -1;
 
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -396,7 +396,7 @@ static int prio_dump_class_stats(struct
 
 	cl_q = q->queues[cl - 1];
 	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &cl_q->bstats) < 0 ||
+				  d, cl_q->cpu_bstats, &cl_q->bstats) < 0 ||
 	    gnet_stats_copy_queue(d, NULL, &cl_q->qstats, cl_q->q.qlen) < 0)
 		return -1;
 


