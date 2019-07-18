Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E81C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE102173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yGZ9f+yo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390604AbfGRNxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:53:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43912 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390573AbfGRNxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JZ17Zwq5nKyQodcnNqDyBJEdJKZbn+GdcZVs6/zKV5c=; b=yGZ9f+yoUMo8rKGQPxzUrMmHjX
        kqiaOpwggFt+yaDlnd8y5nQdysmSTxmU63VvSy9M55BN56Dj2m+o4jOlLKuvmcj1mKmNfDFCMsZab
        PSyvS4o2c0UxkOl14vvE4AM4CyFVdyO7pI2/Oejubq9LpgC6xtVpT6UMklX2uxzc0L2AB0o1ctK1D
        elDnYqIIL++oiz2p8VBdTEjer+joq/E+KX8qc5PpNzeBwMBE8NVzHXWoC0NFmdBidVDRzX3QbhGLT
        I0FC3M9OxzOlOgPnJ9MQyzzCoq8o+6fY02unxTvR5bYEPKqZP9AhZiNMfGxZpGJcZLOwbSM5ciUs9
        2Ch/JlZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ho6qb-0003u7-GR; Thu, 18 Jul 2019 13:53:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CEBB120B979A5; Thu, 18 Jul 2019 15:53:22 +0200 (CEST)
Message-Id: <20190718135206.123357505@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 18 Jul 2019 15:49:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jan Stancek <jstancek@redhat.com>,
        Waiman Long <longman@redhat.com>, dbueso@suse.de,
        mingo@redhat.com, jade.alglave@arm.com, paulmck@linux.vnet.ibm.com,
        Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 3/4] tty/ldsem: Add missing ACQUIRE to read_failed sleep loop
References: <20190718134954.496297975@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reviewing rwsem down_slowpath, Will noticed ldsem had a copy of
a bug we just found for rwsem.

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

Cc: Peter Hurley <peter@hurleysoftware.com>
Fixes: 4898e640caf0 ("tty: Add timed, writer-prioritized rw semaphore")
Reported-by: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/tty/tty_ldsem.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -93,8 +93,7 @@ static void __ldsem_wake_readers(struct
 
 	list_for_each_entry_safe(waiter, next, &sem->read_wait, list) {
 		tsk = waiter->task;
-		smp_mb();
-		waiter->task = NULL;
+		smp_store_release(&waiter->task, NULL);
 		wake_up_process(tsk);
 		put_task_struct(tsk);
 	}
@@ -194,7 +193,7 @@ down_read_failed(struct ld_semaphore *se
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 
-		if (!waiter.task)
+		if (!smp_load_acquire(&waiter.task))
 			break;
 		if (!timeout)
 			break;


