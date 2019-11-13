Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0845EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A33222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wcc5PwO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfKMK3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:29:36 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36290 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfKMK3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BV2RdxDZi6CCqADazZj3sy8tXLQyYeg5avi/J03ZBRs=; b=wcc5PwO8cFcVoxDwtWTaTppzyW
        uBBthhkVlacTpQEvF0vmavE+m3esH3Pm0Uss9otHStpUddC1Fr1+9DMRw0jbzTSdhNwDM3aDq+wt+
        IZwHe8NmoW/6WmPpLJQ2JSx517oL5Q8ffEmmTxQ0MGC8n1xcsQkUf9WHiNWO8gyE/cLHiJhb/DXiW
        HWwDWVnrsy08DINkJ7VgCBdow58AtaqGihHu9GXv/jp10PauKkY4B9sb7z0+cT/1NX2FMZCt6zlin
        BsKVSTvEgAHnvPaTYd/VmwTA3NcreE/NCiIetb+35LdIkp3IEeCYhSCKnTUroduyaY1iQOF9HSw27
        OSg5MwSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUpte-0000X2-KP; Wed, 13 Nov 2019 10:29:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6CCD2305ED5;
        Wed, 13 Nov 2019 11:28:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 991EB28B7CC8E; Wed, 13 Nov 2019 11:29:08 +0100 (CET)
Message-Id: <20191113102855.754194109@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 11:21:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org, mingo@kernel.org, will@kernel.org
Cc:     oleg@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com
Subject: [PATCH 2/5] locking/percpu-rwsem: Convert to bool
References: <20191113102115.116470462@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bool where possible.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/percpu-rwsem.h  |    6 +++---
 kernel/locking/percpu-rwsem.c |    8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -41,7 +41,7 @@ is_static struct percpu_rw_semaphore nam
 #define DEFINE_STATIC_PERCPU_RWSEM(name)	\
 	__DEFINE_PERCPU_RWSEM(name, static)
 
-extern int __percpu_down_read(struct percpu_rw_semaphore *, int);
+extern bool __percpu_down_read(struct percpu_rw_semaphore *, bool);
 extern void __percpu_up_read(struct percpu_rw_semaphore *);
 
 static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
@@ -69,9 +69,9 @@ static inline void percpu_down_read(stru
 	preempt_enable();
 }
 
-static inline int percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
+static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 {
-	int ret = 1;
+	bool ret = true;
 
 	preempt_disable();
 	/*
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -45,7 +45,7 @@ void percpu_free_rwsem(struct percpu_rw_
 }
 EXPORT_SYMBOL_GPL(percpu_free_rwsem);
 
-int __percpu_down_read(struct percpu_rw_semaphore *sem, int try)
+bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 {
 	/*
 	 * Due to having preemption disabled the decrement happens on
@@ -69,7 +69,7 @@ int __percpu_down_read(struct percpu_rw_
 	 * release in percpu_up_write().
 	 */
 	if (likely(!smp_load_acquire(&sem->readers_block)))
-		return 1;
+		return true;
 
 	/*
 	 * Per the above comment; we still have preemption disabled and
@@ -78,7 +78,7 @@ int __percpu_down_read(struct percpu_rw_
 	__percpu_up_read(sem);
 
 	if (try)
-		return 0;
+		return false;
 
 	/*
 	 * We either call schedule() in the wait, or we'll fall through
@@ -94,7 +94,7 @@ int __percpu_down_read(struct percpu_rw_
 	__up_read(&sem->rw_sem);
 
 	preempt_disable();
-	return 1;
+	return true;
 }
 EXPORT_SYMBOL_GPL(__percpu_down_read);
 


