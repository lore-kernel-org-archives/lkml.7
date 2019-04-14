Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B80EC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B5420850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfDNUle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:41:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40939 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfDNUld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:41:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3EKerXG2689742
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 14 Apr 2019 13:40:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3EKeqJZ2689739;
        Sun, 14 Apr 2019 13:40:52 -0700
Date:   Sun, 14 Apr 2019 13:40:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-b8ca7ff7731f57b256fcc13a9b7d4913f5282e5c@git.kernel.org>
Cc:     cl@linux.com, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        penberg@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        peterz@infradead.org, glider@google.com, hpa@zytor.com,
        tglx@linutronix.de, jpoimboe@redhat.com, mingo@kernel.org,
        rientjes@google.com
Reply-To: peterz@infradead.org, glider@google.com, luto@kernel.org,
          akpm@linux-foundation.org, penberg@kernel.org,
          linux-kernel@vger.kernel.org, rostedt@goodmis.org, cl@linux.com,
          rientjes@google.com, mingo@kernel.org, jpoimboe@redhat.com,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190410103644.574058244@linutronix.de>
References: <20190410103644.574058244@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] mm/slub: Remove the ULONG_MAX stack trace
 hackery
Git-Commit-ID: b8ca7ff7731f57b256fcc13a9b7d4913f5282e5c
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

Commit-ID:  b8ca7ff7731f57b256fcc13a9b7d4913f5282e5c
Gitweb:     https://git.kernel.org/tip/b8ca7ff7731f57b256fcc13a9b7d4913f5282e5c
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 10 Apr 2019 12:28:05 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Apr 2019 19:58:30 +0200

mm/slub: Remove the ULONG_MAX stack trace hackery

No architecture terminates the stack trace with ULONG_MAX anymore. Remove
the cruft.

While at it remove the pointless loop of clearing the stack array
completely. It's sufficient to clear the last entry as the consumers break
out on the first zeroed entry anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: linux-mm@kvack.org
Cc: David Rientjes <rientjes@google.com>
Cc: Christoph Lameter <cl@linux.com>
Link: https://lkml.kernel.org/r/20190410103644.574058244@linutronix.de

---
 mm/slub.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index d30ede89f4a6..e2ccd12b6faa 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -553,7 +553,6 @@ static void set_track(struct kmem_cache *s, void *object,
 	if (addr) {
 #ifdef CONFIG_STACKTRACE
 		struct stack_trace trace;
-		int i;
 
 		trace.nr_entries = 0;
 		trace.max_entries = TRACK_ADDRS_COUNT;
@@ -563,20 +562,16 @@ static void set_track(struct kmem_cache *s, void *object,
 		save_stack_trace(&trace);
 		metadata_access_disable();
 
-		/* See rant in lockdep.c */
-		if (trace.nr_entries != 0 &&
-		    trace.entries[trace.nr_entries - 1] == ULONG_MAX)
-			trace.nr_entries--;
-
-		for (i = trace.nr_entries; i < TRACK_ADDRS_COUNT; i++)
-			p->addrs[i] = 0;
+		if (trace.nr_entries < TRACK_ADDRS_COUNT)
+			p->addrs[trace.nr_entries] = 0;
 #endif
 		p->addr = addr;
 		p->cpu = smp_processor_id();
 		p->pid = current->pid;
 		p->when = jiffies;
-	} else
+	} else {
 		memset(p, 0, sizeof(struct track));
+	}
 }
 
 static void init_tracking(struct kmem_cache *s, void *object)
