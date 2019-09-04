Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE683C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BCE21726
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="jvz/s0tN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfIDU1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 16:27:15 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:14966 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729278AbfIDU1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:27:15 -0400
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id x84KGfBM000506;
        Wed, 4 Sep 2019 21:27:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id; s=jan2016.eng;
 bh=sTScJ+MvoLbTasFi50pyfuSYYe8RA8+16LS/ygjXpJs=;
 b=jvz/s0tNxBSCyorI3Os1dfcxteIVgNBaARHQxxyrBQz80jNB7agCHpo6if6NfHNqt1To
 e8N5Q5gFPu8CwubkdpDqZQtW1+4M6SJcDNvZoSDAe2TU+xjq2l7/lqXOtfjCNAEmkBwa
 MillZk16v3X4EzjrThTdLJXdXiwocJpt5fVxd96LQUC/nk59bIqazfVJhiD/bSI3HqCr
 Tl3sjz0eW12Z5HBBy6qbMOK77ME/nfRnUrK1vsbEcqV5j/3Ute7NpxRvfOX6MA26WoOy
 ybtTyCKqbwQUHrj3yAYyxIrwazPgn8OKtcuMr2uqGHe840HgXr6pIFuKl6CiTdHf7nQs uA== 
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 2uqg5nvndq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Sep 2019 21:27:05 +0100
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
        by prod-mail-ppoint5.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x84KHC3X028761;
        Wed, 4 Sep 2019 13:27:04 -0700
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint5.akamai.com with ESMTP id 2uqpv8f67m-1;
        Wed, 04 Sep 2019 13:27:04 -0700
Received: from bos-lpjec.kendall.corp.akamai.com (bos-lpjec.kendall.corp.akamai.com [172.29.170.83])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 702CB1FC6F;
        Wed,  4 Sep 2019 20:27:04 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Roman Penyaev <rpenyaev@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] epoll: simplify ep_poll_safewake() for CONFIG_DEBUG_LOCK_ALLOC
Date:   Wed,  4 Sep 2019 16:22:29 -0400
Message-Id: <1567628549-11501-1-git-send-email-jbaron@akamai.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909040203
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-04_05:2019-09-04,2019-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=1 bulkscore=0 phishscore=0
 spamscore=0 clxscore=1011 mlxscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909040203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, ep_poll_safewake() in the CONFIG_DEBUG_LOCK_ALLOC case uses
ep_call_nested() in order to pass the correct subclass argument to
spin_lock_irqsave_nested(). However, ep_call_nested() adds unnecessary
checks for epoll depth and loops that are already verified when doing
EPOLL_CTL_ADD. This mirrors a conversion that was done for
!CONFIG_DEBUG_LOCK_ALLOC in: commit 37b5e5212a44 ("epoll: remove
ep_call_nested() from ep_eventpoll_poll()")

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Roman Penyaev <rpenyaev@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Eric Wong <normalperson@yhbt.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/eventpoll.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index d7f1f50..a9b2737 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -551,28 +551,23 @@ static int ep_call_nested(struct nested_calls *ncalls,
  */
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
-static struct nested_calls poll_safewake_ncalls;
-
-static int ep_poll_wakeup_proc(void *priv, void *cookie, int call_nests)
-{
-	unsigned long flags;
-	wait_queue_head_t *wqueue = (wait_queue_head_t *)cookie;
-
-	spin_lock_irqsave_nested(&wqueue->lock, flags, call_nests + 1);
-	wake_up_locked_poll(wqueue, EPOLLIN);
-	spin_unlock_irqrestore(&wqueue->lock, flags);
-
-	return 0;
-}
+static DEFINE_PER_CPU(int, wakeup_nest);
 
 static void ep_poll_safewake(wait_queue_head_t *wq)
 {
-	int this_cpu = get_cpu();
-
-	ep_call_nested(&poll_safewake_ncalls,
-		       ep_poll_wakeup_proc, NULL, wq, (void *) (long) this_cpu);
+	unsigned long flags;
+	int subclass;
 
-	put_cpu();
+	local_irq_save(flags);
+	preempt_disable();
+	subclass = __this_cpu_read(wakeup_nest);
+	spin_lock_nested(&wq->lock, subclass + 1);
+	__this_cpu_inc(wakeup_nest);
+	wake_up_locked_poll(wq, POLLIN);
+	__this_cpu_dec(wakeup_nest);
+	spin_unlock(&wq->lock);
+	local_irq_restore(flags);
+	preempt_enable();
 }
 
 #else
@@ -2370,11 +2365,6 @@ static int __init eventpoll_init(void)
 	 */
 	ep_nested_calls_init(&poll_loop_ncalls);
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	/* Initialize the structure used to perform safe poll wait head wake ups */
-	ep_nested_calls_init(&poll_safewake_ncalls);
-#endif
-
 	/*
 	 * We can have many thousands of epitems, so prevent this from
 	 * using an extra cache line on 64-bit (and smaller) CPUs
-- 
2.7.4

