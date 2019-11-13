Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CA5C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0214222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TTy1nVtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfKMK3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:29:25 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36280 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfKMK3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W0XG3ww6gZLvv2d/pinyx4OB+e9u6hzYaxWeYREhbw8=; b=TTy1nVtGpIkIdk9+MkixSWWOXp
        2kDnPtge8CFMUKDvKFY1fzuHYJdNVE6pPpbQd2xsto/BSH2QMPz0JMYH83Ln3Oi669eap2r1SpiCF
        VCRESx2m0gjgjcVIkVH2kXbhX99gvA9SDDCZ1/uNJ0cpYCSmM/b45u9ebkgIPjh6uZ9MOB/LPy6LY
        KN7LGVLOwz1HnN8nm6ANd3RETz5jcQ/M/CiA3FU15C9f0mE86Td0zkdFh6aksKXXtwUZomXsSy/+Q
        txS4sutxTNvBTG+pDMnf8saphMfbyf02a7VtTJeioEy1AUpnL8iiS1rxvfhHfkDuY1S6kaSyDSUvd
        wqoqLJvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUptf-0000X5-Fs; Wed, 13 Nov 2019 10:29:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 71B47305FC2;
        Wed, 13 Nov 2019 11:28:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A14A329CF51EE; Wed, 13 Nov 2019 11:29:08 +0100 (CET)
Message-Id: <20191113102855.868390100@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 11:21:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org, mingo@kernel.org, will@kernel.org
Cc:     oleg@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com
Subject: [PATCH 4/5] locking/percpu-rwsem: Extract __percpu_down_read_trylock()
References: <20191113102115.116470462@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing the embedded rwsem and building a custom
lock, extract the read-trylock primitive.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/percpu-rwsem.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -45,7 +45,7 @@ void percpu_free_rwsem(struct percpu_rw_
 }
 EXPORT_SYMBOL_GPL(percpu_free_rwsem);
 
-bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
+static bool __percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 {
 	__this_cpu_inc(*sem->read_count);
 
@@ -70,14 +70,21 @@ bool __percpu_down_read(struct percpu_rw
 	 * If !readers_block the critical section starts here, matched by the
 	 * release in percpu_up_write().
 	 */
-	if (likely(!smp_load_acquire(&sem->readers_block)))
+	if (likely(!atomic_read_acquire(&sem->readers_block)))
 		return true;
 
-	/*
-	 * Per the above comment; we still have preemption disabled and
-	 * will thus decrement on the same CPU as we incremented.
-	 */
-	__percpu_up_read(sem);
+	__this_cpu_dec(*sem->read_count);
+
+	/* Prod writer to re-evaluate readers_active_check() */
+	rcuwait_wake_up(&sem->writer);
+
+	return false;
+}
+
+bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
+{
+	if (__percpu_down_read_trylock(sem))
+		return true;
 
 	if (try)
 		return false;


