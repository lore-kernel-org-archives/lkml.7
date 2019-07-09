Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8E3C004EF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C1921537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DYcpdz3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfGILag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:30:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58787 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGILaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:30:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x69BTvVv1892699
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 9 Jul 2019 04:29:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x69BTvVv1892699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562671798;
        bh=9XEjvf7D8AKMvGlBsDGLsfHmYXQEXJKbwjUjP80HEis=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=DYcpdz3y2iZnkv5xlnHRZ/zizgJ7TlacMQJbpMvV2fSEhowPaHwX3Nq6BHlp4OEML
         qdXS8s7mGoiUjgUfvxYnBXXCKxsoBHFsgwzExhryqTRVTN3NNq/x2lOwvvs/o8jCg5
         AL4iGCMYAxVwcaZSngoGNs9xqe7rlrCEOlBCzDyCRZfBIh+VWov/MqzyrAcPYZfHs8
         Y6gvHT1HuXcF1+TCUGpVD6qlAeXSIcT3L2i0d1+pIm3pk560oOlvLP/X59x5DKNo1L
         /YSb8VpSUJAPzi2eayPxc/FYU5TqhlEaTzW1GDVX0g+T7VQkioyR/euBxnYGTrPR0o
         pucUOhplHCSuQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x69BTuV71892693;
        Tue, 9 Jul 2019 04:29:56 -0700
Date:   Tue, 9 Jul 2019 04:29:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-4c00af0e94cd01b8c5a5e6b3323d34677b04e192@git.kernel.org>
Cc:     jolsa@kernel.org, liwei391@huawei.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, acme@redhat.com, xiezhipeng1@huawei.com,
        namhyung@kernel.org
Reply-To: hpa@zytor.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@kernel.org,
          liwei391@huawei.com, xiezhipeng1@huawei.com, acme@redhat.com,
          tglx@linutronix.de, namhyung@kernel.org, adrian.hunter@intel.com,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20190704194355.GI10740@kernel.org>
References: <20190508143648.8153-1-liwei391@huawei.com>
        <20190704194355.GI10740@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf thread: Allow references to thread objects
 after machine__exit()
Git-Commit-ID: 4c00af0e94cd01b8c5a5e6b3323d34677b04e192
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

Commit-ID:  4c00af0e94cd01b8c5a5e6b3323d34677b04e192
Gitweb:     https://git.kernel.org/tip/4c00af0e94cd01b8c5a5e6b3323d34677b04e192
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 5 Jul 2019 12:11:35 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Sat, 6 Jul 2019 14:29:32 -0300

perf thread: Allow references to thread objects after machine__exit()

Threads are created when we either synthesize PERF_RECORD_FORK events
for pre-existing threads or when we receive PERF_RECORD_FORK events from
the kernel as new threads get created.

We then keep them in machine->threads[].entries rb trees till when we
receive a PERF_RECORD_EXIT, i.e. that thread terminated.

The thread object has a reference count that is grabbed when, for
instance, we keep that thread referenced in struct hist_entry, in 'perf
report' and 'perf top'.

When we receive a PERF_RECORD_EXIT we remove the thread object from the
rb tree and move it to the corresponding machine->threads[].dead list,
then we do a thread__put(), dropping the reference we had for keeping it
in the rb tree.

In thread__put() we were assuming that when the reference count hit zero
we should remove it from the dead list by simply doing a
list_del_init(&thread->node).

That works well when all the thread lifetime is during the machine that
has the list heads lifetime, since we know that we can do the
list_del_init() and it will update the 'dead' list_head.

But in 'perf sched lat' we were doing:

    machine__new() (via perf_session__new)

    process events, grabbing refcounts to keep those thread objects
    in 'perf sched' local data structures.

    machine__exit() (via perf_session__delete) which would delete the
    'dead' list heads.

    And then doing the final thread__put() for the refcounts 'perf sched'
    rightfully obtained for keeping those thread object references.

    b00m, since thread__put() would do the list_del_init() touching
    a dead dead list head.

Fix it by removing all the dead threads from machine->threads[].dead at
machine__exit(), since whatever is there should have refcounts taken by
things like 'perf sched lat', and make thread__put() check if the thread
is in a linked list before removing it from that list.

Reported-by: Wei Li <liwei391@huawei.com>
Link: https://lkml.kernel.org/r/20190508143648.8153-1-liwei391@huawei.com
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Zhipeng Xie <xiezhipeng1@huawei.com>
Link: https://lkml.kernel.org/r/20190704194355.GI10740@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 25 +++++++++++++++++++++++--
 tools/perf/util/thread.c  | 23 ++++++++++++++++++++---
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index dc7aafe45a2b..e00dc413652d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -209,6 +209,18 @@ void machine__exit(struct machine *machine)
 
 	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads *threads = &machine->threads[i];
+		struct thread *thread, *n;
+		/*
+		 * Forget about the dead, at this point whatever threads were
+		 * left in the dead lists better have a reference count taken
+		 * by who is using them, and then, when they drop those references
+		 * and it finally hits zero, thread__put() will check and see that
+		 * its not in the dead threads list and will not try to remove it
+		 * from there, just calling thread__delete() straight away.
+		 */
+		list_for_each_entry_safe(thread, n, &threads->dead, node)
+			list_del_init(&thread->node);
+
 		exit_rwsem(&threads->lock);
 	}
 }
@@ -1758,9 +1770,11 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
 	if (threads->last_match == th)
 		threads__set_last_match(threads, NULL);
 
-	BUG_ON(refcount_read(&th->refcnt) == 0);
 	if (lock)
 		down_write(&threads->lock);
+
+	BUG_ON(refcount_read(&th->refcnt) == 0);
+
 	rb_erase_cached(&th->rb_node, &threads->entries);
 	RB_CLEAR_NODE(&th->rb_node);
 	--threads->nr;
@@ -1770,9 +1784,16 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
 	 * will be called and we will remove it from the dead_threads list.
 	 */
 	list_add_tail(&th->node, &threads->dead);
+
+	/*
+	 * We need to do the put here because if this is the last refcount,
+	 * then we will be touching the threads->dead head when removing the
+	 * thread.
+	 */
+	thread__put(th);
+
 	if (lock)
 		up_write(&threads->lock);
-	thread__put(th);
 }
 
 void machine__remove_thread(struct machine *machine, struct thread *th)
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index b413ba5b9835..7bfb740d2ede 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -125,10 +125,27 @@ void thread__put(struct thread *thread)
 {
 	if (thread && refcount_dec_and_test(&thread->refcnt)) {
 		/*
-		 * Remove it from the dead_threads list, as last reference
-		 * is gone.
+		 * Remove it from the dead threads list, as last reference is
+		 * gone, if it is in a dead threads list.
+		 *
+		 * We may not be there anymore if say, the machine where it was
+		 * stored was already deleted, so we already removed it from
+		 * the dead threads and some other piece of code still keeps a
+		 * reference.
+		 *
+		 * This is what 'perf sched' does and finally drops it in
+		 * perf_sched__lat(), where it calls perf_sched__read_events(),
+		 * that processes the events by creating a session and deleting
+		 * it, which ends up destroying the list heads for the dead
+		 * threads, but before it does that it removes all threads from
+		 * it using list_del_init().
+		 *
+		 * So we need to check here if it is in a dead threads list and
+		 * if so, remove it before finally deleting the thread, to avoid
+		 * an use after free situation.
 		 */
-		list_del_init(&thread->node);
+		if (!list_empty(&thread->node))
+			list_del_init(&thread->node);
 		thread__delete(thread);
 	}
 }
