Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944EDC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697262238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BCgUAiiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389784AbfGYQAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:00:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48059 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387874AbfGYQAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:00:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PG0Uue1070667
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:00:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PG0Uue1070667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564070431;
        bh=7XiOeA/D+HawhTDttdbmLI0yx6Nrxaq+KSSWvCxRWsI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BCgUAiiOFaDyryfeRzBoERMpc9En7sTFhMxa7RG4713YChFFbnfYb3SBHEV7QYRe/
         UCWTq8ao7Ni/FPyFjIR1hoR3Pl5NnIQG23ENT+JxgyNuyDq8FIsUCEgU0kVRLtMt4K
         rnGvQdTCCgb+2VcsuNcfnyCgz8IYllqW5rlSENAAg9NNnaA0DhafBY1KrZS3CW4d2+
         z3+Dgw+wQNxe7cuxSy8EX/uYNZChiBhH9Ie2/3l11e2aHYEvVm7UdCzbZJw4oUBsKr
         4JBimxHL8GfBONAWT0ZJDR+Y9iN9QalolouwHPl+jFSg4wyeqroP5GuiI8jJ8QeL7/
         ikPpgl6e3pe2w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PG0TqZ1070661;
        Thu, 25 Jul 2019 09:00:29 -0700
Date:   Thu, 25 Jul 2019 09:00:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jan Stancek <tipbot@zytor.com>
Message-ID: <tip-e1b98fa316648420d0434d9ff5b92ad6609ba6c3@git.kernel.org>
Cc:     longman@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, will@kernel.org, peterz@infradead.org,
        jstancek@redhat.com, tglx@linutronix.de,
        torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de,
          jstancek@redhat.com, peterz@infradead.org, will@kernel.org,
          hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          longman@redhat.com
In-Reply-To: <50b8914e20d1d62bb2dee42d342836c2c16ebee7.1563438048.git.jstancek@redhat.com>
References: <50b8914e20d1d62bb2dee42d342836c2c16ebee7.1563438048.git.jstancek@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Add missing ACQUIRE to
 read_slowpath exit when queue is empty
Git-Commit-ID: e1b98fa316648420d0434d9ff5b92ad6609ba6c3
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

Commit-ID:  e1b98fa316648420d0434d9ff5b92ad6609ba6c3
Gitweb:     https://git.kernel.org/tip/e1b98fa316648420d0434d9ff5b92ad6609ba6c3
Author:     Jan Stancek <jstancek@redhat.com>
AuthorDate: Thu, 18 Jul 2019 10:51:25 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:39:23 +0200

locking/rwsem: Add missing ACQUIRE to read_slowpath exit when queue is empty

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

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Will Deacon <will@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dbueso@suse.de
Fixes: 4b486b535c33 ("locking/rwsem: Exit read lock slowpath if queue empty & no writer")
Link: https://lkml.kernel.org/r/50b8914e20d1d62bb2dee42d342836c2c16ebee7.1563438048.git.jstancek@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index bc91aacaab58..d3ce7c6c42a6 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1036,6 +1036,8 @@ queue:
 		 */
 		if (adjustment && !(atomic_long_read(&sem->count) &
 		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
+			/* Provide lock ACQUIRE */
+			smp_acquire__after_ctrl_dep();
 			raw_spin_unlock_irq(&sem->wait_lock);
 			rwsem_set_reader_owned(sem);
 			lockevent_inc(rwsem_rlock_fast);
