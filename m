Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679A1C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A922177B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600573;
	bh=j+oqQirN2D0/MMoT8HzmuTxTAh2aYxZmkV6iMhS8hKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0UfnUiZaPvP/VWzJoPJY0kDwMGMeiz5Rkn2pbZ0GZ/4MUsrbMB0AsVMK095dL6Usb
	 6r41XoXxmJUTp0q9DYKVDSg52mIHZpG9RnV1IqfPUuI65YAHLhoJfdEQMi3ZqjDGGo
	 l6Xdl7Qs1YGoTmjGRod5SnggqOw2lFuGt7j6JsHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391117AbfGHPmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbfGHPmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:42:50 -0400
Received: from quaco.ghostprotocols.net (179-240-135-35.3g.claro.net.br [179.240.135.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 217BC21738;
        Mon,  8 Jul 2019 15:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562600569;
        bh=j+oqQirN2D0/MMoT8HzmuTxTAh2aYxZmkV6iMhS8hKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJkVJlIwdFlxqs1JM16Etw64XmynGwlaiA70Qcqnp3XxYSNCp8pVdOaKO6qeQfgiO
         DXlGvZ52OB5F18XDuL7wHQ6gqVC0wuG4DqOVrBaXm1aeRaU2KxMlQonaf+9MtVxP4v
         1JWmEG9IYIUs78yMBNwy0FyXbZMmX17eUKcKWheI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhipeng Xie <xiezhipeng1@huawei.com>
Subject: [PATCH 3/8] perf thread: Allow references to thread objects after machine__exit()
Date:   Mon,  8 Jul 2019 12:42:02 -0300
Message-Id: <20190708154207.11403-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190708154207.11403-1-acme@kernel.org>
References: <20190708154207.11403-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.20.1

