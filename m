Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3202C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA89D2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OQRHNtWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390635AbfGRNxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:53:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43922 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390581AbfGRNxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nvBiFnv5cRW6rhCVluedIbBY8Hl/DjC3Uttl91M1iAE=; b=OQRHNtWAPWYediKV/Q6pa6uFxK
        9mMlesxee04ckJbpUo2miwGGdgZ7KpGLZBj/L1+OspRWrj5bGkqvqFIT3p4Jn5lMMUe850W2f+HbU
        OroS32fs1VNmbwyWpR9WnYrNAcOz2srDJi7EaMh4VtwPtx2T2edK4SoMePkk7BAFSxdJyTSmTZycO
        6C4TZQYUWVY0xXamexag4cAGCITwe1kptB29wAaQL5hN43mQ4WBRT38YqxPzZ/gbRr26mcNA5CjET
        SMBlYe/6+/M+Ji+F6VyVSlr/+WMTiT205Yplro6hgeWEFpTlZ2D+AINc+4OfA+vg8Mm49bVgnscdO
        eGqTd9jg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ho6qb-0003u5-GC; Thu, 18 Jul 2019 13:53:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C3A30201C12E4; Thu, 18 Jul 2019 15:53:22 +0200 (CEST)
Message-Id: <20190718135205.916241783@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 18 Jul 2019 15:49:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jan Stancek <jstancek@redhat.com>,
        Waiman Long <longman@redhat.com>, dbueso@suse.de,
        mingo@redhat.com, jade.alglave@arm.com, paulmck@linux.vnet.ibm.com
Subject: [PATCH 1/4] locking/rwsem: Add missing ACQUIRE to read_slowpath exit when queue is empty
References: <20190718134954.496297975@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Stancek <jstancek@redhat.com>

LTP mtest06 has been observed to occasionally hit "still mapped when
deleted" and following BUG_ON on arm64.

The extra mapcount originated from pagefault handler, which handled
pagefault for vma that has already been detached. vma is detached
under mmap_sem write lock by detach_vmas_to_be_unmapped(), which
also invalidates vmacache.

When the pagefault handler (under mmap_sem read lock) calls
find_vma(), vmacache_valid() wrongly reports vmacache as valid.

After rwsem down_read() returns via 'queue empty' path (as of v5.2),
it does so without an ACQUIRE on sem->count:

  down_read()
    __down_read()
      rwsem_down_read_failed()
        __rwsem_down_read_failed_common()
          raw_spin_lock_irq(&sem->wait_lock);
          if (list_empty(&sem->wait_list)) {
            if (atomic_long_read(&sem->count) >= 0) {
              raw_spin_unlock_irq(&sem->wait_lock);
              return sem;

The problem can be reproduced by running LTP mtest06 in a loop and
building the kernel (-j $NCPUS) in parallel. It does reproduces since
v4.20 on arm64 HPE Apollo 70 (224 CPUs, 256GB RAM, 2 nodes). It
triggers reliably in about an hour.

The patched kernel ran fine for 10+ hours.

Cc: dbueso@suse.de
Cc: mingo@redhat.com
Fixes: 4b486b535c33 ("locking/rwsem: Exit read lock slowpath if queue empty & no writer")
Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Will Deacon <will@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/50b8914e20d1d62bb2dee42d342836c2c16ebee7.1563438048.git.jstancek@redhat.com
---
 kernel/locking/rwsem.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1032,6 +1032,8 @@ rwsem_down_read_slowpath(struct rw_semap
 		 */
 		if (adjustment && !(atomic_long_read(&sem->count) &
 		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
+			/* Provide lock ACQUIRE */
+			smp_acquire__after_ctrl_dep();
 			raw_spin_unlock_irq(&sem->wait_lock);
 			rwsem_set_reader_owned(sem);
 			lockevent_inc(rwsem_rlock_fast);


