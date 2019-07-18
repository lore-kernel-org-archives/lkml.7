Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF18C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A2321019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YSUYAiWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390529AbfGRNxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:53:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43900 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfGRNxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KL6fWBl+CLFFt4aWnjiO8B6w4bZAMG4MS2WQ/d3Yocs=; b=YSUYAiWqzr3DBTxBUoIHCVB9rg
        1l5UxWSMkH1h/NyNXxkVxOEBP13QgeXflotf//fBzpymWqjRzKYlyQbtYAJ0sEdenTljMTXBJoU5J
        dHQCFwtw+wAF3z9vBSYbpFdewzL/hcKwjrVHp/6aOhWxR0HSje30mnK7GqY0shlu2FuxJkVHeBznA
        Cuh244+8gWxUaDV2pmiwLQcIytasglWvs5AuqkiP8t847bXeXybls5t9tABs1OBcimU1Bjss70oGe
        OInyY2DJp2+rSAvvulh4fdxCDjMvMd/Mt2BsYmETi589WR2s2Vw0obDkk2Gi3LhTVQ0ScRDtOOux5
        Dlr/4nVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ho6qb-0003u4-GB; Thu, 18 Jul 2019 13:53:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C768320B979A4; Thu, 18 Jul 2019 15:53:22 +0200 (CEST)
Message-Id: <20190718135206.012378477@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 18 Jul 2019 15:49:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jan Stancek <jstancek@redhat.com>,
        Waiman Long <longman@redhat.com>, dbueso@suse.de,
        mingo@redhat.com, jade.alglave@arm.com, paulmck@linux.vnet.ibm.com
Subject: [PATCH 2/4] rwsem: Add missing ACQUIRE to read_slowpath sleep loop
References: <20190718134954.496297975@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reviewing another read_slowpath patch, both Will and I noticed
another missing ACQUIRE, namely:

  X = 0;

  CPU0			CPU1

  rwsem_down_read()
    for (;;) {
      set_current_state(TASK_UNINTERRUPTIBLE);

                        X = 1;
                        rwsem_up_write();
                          rwsem_mark_wake()
                            atomic_long_add(adjustment, &sem->count);
                            smp_store_release(&waiter->task, NULL);

      if (!waiter.task)
        break;

      ...
    }

  r = X;

Allows 'r == 0'.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rwsem.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1069,8 +1069,10 @@ rwsem_down_read_slowpath(struct rw_semap
 	/* wait to be given the lock */
 	while (true) {
 		set_current_state(state);
-		if (!waiter.task)
+		if (!smp_load_acquire(&waiter.task)) {
+			/* Orders against rwsem_mark_wake()'s smp_store_release() */
 			break;
+		}
 		if (signal_pending_state(state, current)) {
 			raw_spin_lock_irq(&sem->wait_lock);
 			if (waiter.task)


