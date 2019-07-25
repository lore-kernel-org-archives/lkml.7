Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5721C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8B22238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TMx+XxKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389730AbfGYQAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:00:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54399 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387874AbfGYQAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:00:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PFxk5k1070359
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 08:59:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PFxk5k1070359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564070386;
        bh=jhfU9wj6Hs/ErzJsIso1O+0GflAsk+BWmP6CZX4GQmE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TMx+XxKtmbkxfkoi7MXjspwhRDjwoaGrJUO8b1PM3bF7hBf38RTxv8sv+wmzxMTs3
         Z9BoQWahH8MH0kJHF4845lAXWpFgcC41SudAHldUrKs+NJICfo9CWXmKMzuK9YLto0
         w7G+9HcJZ5gPsO/hITwQAjdZOd4zju89oHH0q9Vqc9k3EVku2DBExnG9hxE/rH+zNa
         s1crhu+fulN5JkpvQS4HKDgjZK45GDzD9MRWp9tYS9w2o12s8xUQj137Sf7y0X5d59
         5pEWGKRTSqwJ7OYrruMcNgXDhNiFgqbGvm0nrAWnvKASNrcQJR5WCzpF/IsQJd5oG2
         EzfPkc79n6AKw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PFxj9A1070352;
        Thu, 25 Jul 2019 08:59:45 -0700
Date:   Thu, 25 Jul 2019 08:59:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-78134300579a45f527ca173ec8fdb4701b69f16e@git.kernel.org>
Cc:     tglx@linutronix.de, will.deacon@arm.com,
        tim.c.chen@linux.intel.com, huang.ying.caritas@gmail.com,
        linux-kernel@vger.kernel.org, lhenriques@suse.com, hpa@zytor.com,
        longman@redhat.com, jlayton@kernel.org, bp@alien8.de,
        peterz@infradead.org, mingo@kernel.org, dave@stgolabs.net,
        torvalds@linux-foundation.org
Reply-To: peterz@infradead.org, jlayton@kernel.org, bp@alien8.de,
          longman@redhat.com, lhenriques@suse.com, hpa@zytor.com,
          huang.ying.caritas@gmail.com, linux-kernel@vger.kernel.org,
          tim.c.chen@linux.intel.com, will.deacon@arm.com,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          mingo@kernel.org, dave@stgolabs.net
In-Reply-To: <81e82d5b-5074-77e8-7204-28479bbe0df0@redhat.com>
References: <81e82d5b-5074-77e8-7204-28479bbe0df0@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Don't call owner_on_cpu() on
 read-owner
Git-Commit-ID: 78134300579a45f527ca173ec8fdb4701b69f16e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  78134300579a45f527ca173ec8fdb4701b69f16e
Gitweb:     https://git.kernel.org/tip/78134300579a45f527ca173ec8fdb4701b69f16e
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Sat, 20 Jul 2019 11:04:10 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:39:22 +0200

locking/rwsem: Don't call owner_on_cpu() on read-owner

For writer, the owner value is cleared on unlock. For reader, it is
left intact on unlock for providing better debugging aid on crash dump
and the unlock of one reader may not mean the lock is free.

As a result, the owner_on_cpu() shouldn't be used on read-owner
as the task pointer value may not be valid and it might have
been freed. That is the case in rwsem_spin_on_owner(), but not in
rwsem_can_spin_on_owner(). This can lead to use-after-free error from
KASAN. For example,

  BUG: KASAN: use-after-free in rwsem_down_write_slowpath
  (/home/miguel/kernel/linux/kernel/locking/rwsem.c:669
  /home/miguel/kernel/linux/kernel/locking/rwsem.c:1125)

Fix this by checking for RWSEM_READER_OWNED flag before calling
owner_on_cpu().

Reported-by: Luis Henriques <lhenriques@suse.com>
Tested-by: Luis Henriques <lhenriques@suse.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: huang ying <huang.ying.caritas@gmail.com>
Fixes: 94a9717b3c40e ("locking/rwsem: Make rwsem->owner an atomic_long_t")
Link: https://lkml.kernel.org/r/81e82d5b-5074-77e8-7204-28479bbe0df0@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 37524a47f002..bc91aacaab58 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -666,7 +666,11 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
 	preempt_disable();
 	rcu_read_lock();
 	owner = rwsem_owner_flags(sem, &flags);
-	if ((flags & nonspinnable) || (owner && !owner_on_cpu(owner)))
+	/*
+	 * Don't check the read-owner as the entry may be stale.
+	 */
+	if ((flags & nonspinnable) ||
+	    (owner && !(flags & RWSEM_READER_OWNED) && !owner_on_cpu(owner)))
 		ret = false;
 	rcu_read_unlock();
 	preempt_enable();
