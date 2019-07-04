Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823AAC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 19:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49499218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 19:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2HAOPTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfGDToB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 15:44:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44231 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfGDToB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 15:44:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id 44so5172716qtg.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 12:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4k1JJAxuW0xSdkxYVgOvG46pDW1wYSXDdRlbitJyoY0=;
        b=r2HAOPTcHzRKIuQLa/n6YIeC2+xW80gQYjL0HFrEX0yu8Qzp154lUZiBrI5WPzIcK2
         MJSRPDs77f61Y9g6dZuXR7vpOh/J9mYq2Frk4Vvz/q0PoVsG/WkVxBgLUMAHEpCSqgBB
         bVoLZ15qTgmTKo+0s7c+NIPcqfTYUWQ5AD6YQnQxiNZYqgcuROxn5StVbXcgRiIREWog
         hNIwmqw51hbeRtkXJe3IHu5ACs27Lde+4yfudk8nJyrXoUo0mPQnTWkClVTke2OP7LKv
         F0+Zl3ACBe4VknOtRx++Cu9OC9dc7BFwaPQqNAbP2HObQaUJyugP8hDiFjIrCr4Q1Emj
         W8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4k1JJAxuW0xSdkxYVgOvG46pDW1wYSXDdRlbitJyoY0=;
        b=fcUqGMAfCKJX1ZW1W+S9mMzLqaEM3JSELq/MaXxSeR+horBVHfR8z6YDHIy55o8Run
         3ZYu9zot8vEXD271h4fGH3JUCwecv6q9D0px0CWe3p+g9vPU4lPhjifxIYyN7rPuDoyc
         UA/yiMJewoPujzjjA0MCLN35L9cx0SY9mVcIoEYRVl8tNlGhHb2/cKjPJNO3OVtIo2pG
         tCD6LXxPbIVJHsLSE5jk+Ep1sKuwjuFZzTux1cRLt7GBE5zgTWwo6AWlisJhrE7g6mLm
         Fy/Qp4CUZAS4+b1io3xD1hpiqLIqUSoLoVdnwk7jH5JsHgb6fZaYH35beCFirKCHhlWt
         N0Gw==
X-Gm-Message-State: APjAAAUMMX9NrYv6MYddRAy42KDG/pWsOsBr2Q/Y2jBbizuKQsCRSFQk
        xhp2TMRs+zBdiBsZMcUmtkP0W1wK
X-Google-Smtp-Source: APXvYqyRiVSypsRNrndBLTzhJSZ0hloTVW1aHQNJy3mIFIgmpB3H77Iq5d0uVNjbfuXSg3OEUvboOQ==
X-Received: by 2002:a0c:89b2:: with SMTP id 47mr38466443qvr.203.1562269439919;
        Thu, 04 Jul 2019 12:43:59 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.214.144])
        by smtp.gmail.com with ESMTPSA id g54sm3207455qtc.61.2019.07.04.12.43.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 12:43:58 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4455940E7E; Thu,  4 Jul 2019 16:43:55 -0300 (-03)
Date:   Thu, 4 Jul 2019 16:43:55 -0300
To:     "liwei (GF)" <liwei391@huawei.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, xiezhipeng1@huawei.com
Subject: Re: [PATCH v2] fix use-after-free in perf_sched__lat
Message-ID: <20190704194355.GI10740@kernel.org>
References: <20190508143648.8153-1-liwei391@huawei.com>
 <20190522065555.GA206606@google.com>
 <20190522110823.GR8945@kernel.org>
 <20190523025011.GC196218@google.com>
 <d14c02f2-4962-ad42-697e-224ddb599f43@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d14c02f2-4962-ad42-697e-224ddb599f43@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 04, 2019 at 07:21:28PM +0800, liwei (GF) escreveu:
> Hi Arnaldo,
> I found this issue has not been fixed in mainline now, please take a glance at this.

See below.
 
> On 2019/5/23 10:50, Namhyung Kim wrote:
> > On Wed, May 22, 2019 at 08:08:23AM -0300, Arnaldo Carvalho de Melo wrote:
> >> I'll try to analyse this one soon, but my first impression was that we
> >> should just grab reference counts when keeping a pointer to those
> >> threads instead of keeping _all_ threads alive when supposedly we could
> >> trow away unreferenced data structures.

> >> But this is just a first impression from just reading the patch
> >> description, probably I'm missing something.

> > No, thread refcounting is fine.  We already did it and threads with the
> > refcount will be accessed only.

> > But the problem is the head of the list.  After using the thread, the
> > refcount is gone and thread is removed from the list and destroyed.
> > However the head of list is in a struct machine which was freed with
> > session already.

I see, and sorry for the delay, thanks for bringing this up again, how
about the following instead? I tested it with 'perf top' that exercises
this code in a multithreaded fashion as well with the set of steps in
your patch commit log, seems to work.

- Arnaldo

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 86fede2b7507..cf826eca3aaf 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -210,6 +210,18 @@ void machine__exit(struct machine *machine)
 
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
@@ -1759,9 +1771,11 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
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
@@ -1771,9 +1785,16 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
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
index 4db8cd2a33ae..873ab505ca80 100644
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
