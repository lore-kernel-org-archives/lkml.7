Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA72C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BA1222C6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qkanVcvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfKMK3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:29:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfKMK3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pONM7cILh09xb8KK+gG+83j1ceD5f21mRvuAt07HrSU=; b=qkanVcvYhKHigtSqJH7CCiR021
        5XenurwUslNodu3A96mTPt37PnwZvO7BNiF62vwtaObKlryZg5890lB6mdZcAOFQrbF0P1t7zdPoW
        biu8P6ULpopKOou/Pol760nNhz6Ry14LbMWXxZ6Wcq9RNZQYcEo6Wv418gDsazapaCGRn8tgHRfbM
        s8a+XJYQO+wW8ufTvlstdGcvUsfaP6j7uHMfYqtYLr7pe1T+cGbti/+44JBVQbUv4hcHnW3tGoocR
        9fLSfLP2kC0qSWHBe6KNAg3LepaLVVfGllOgLK+msngDZQR6NB0PycwamDIP9YgJWq3hGdbHsxIuE
        6WRBU+Zw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUptj-00073y-6m; Wed, 13 Nov 2019 10:29:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6DDB330018B;
        Wed, 13 Nov 2019 11:28:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9BC3828B93F88; Wed, 13 Nov 2019 11:29:08 +0100 (CET)
Message-Id: <20191113102855.811146018@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 11:21:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org, mingo@kernel.org, will@kernel.org
Cc:     oleg@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com
Subject: [PATCH 3/5] locking/percpu-rwsem: Move __this_cpu_inc() into the slowpath
References: <20191113102115.116470462@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As preparation to rework __percpu_down_read() move the
__this_cpu_inc() into it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/percpu-rwsem.h  |   10 ++++++----
 kernel/locking/percpu-rwsem.c |    2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -59,8 +59,9 @@ static inline void percpu_down_read(stru
 	 * and that once the synchronize_rcu() is done, the writer will see
 	 * anything we did within this RCU-sched read-size critical section.
 	 */
-	__this_cpu_inc(*sem->read_count);
-	if (unlikely(!rcu_sync_is_idle(&sem->rss)))
+	if (likely(rcu_sync_is_idle(&sem->rss)))
+		__this_cpu_inc(*sem->read_count);
+	else
 		__percpu_down_read(sem, false); /* Unconditional memory barrier */
 	/*
 	 * The preempt_enable() prevents the compiler from
@@ -77,8 +78,9 @@ static inline bool percpu_down_read_tryl
 	/*
 	 * Same as in percpu_down_read().
 	 */
-	__this_cpu_inc(*sem->read_count);
-	if (unlikely(!rcu_sync_is_idle(&sem->rss)))
+	if (likely(rcu_sync_is_idle(&sem->rss)))
+		__this_cpu_inc(*sem->read_count);
+	else
 		ret = __percpu_down_read(sem, true); /* Unconditional memory barrier */
 	preempt_enable();
 	/*
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -47,6 +47,8 @@ EXPORT_SYMBOL_GPL(percpu_free_rwsem);
 
 bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 {
+	__this_cpu_inc(*sem->read_count);
+
 	/*
 	 * Due to having preemption disabled the decrement happens on
 	 * the same CPU as the increment, avoiding the


