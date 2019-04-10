Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21140C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8232229F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfDJLJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:09:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58768 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbfDJLFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:05:42 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hEB2y-00053Y-7a; Wed, 10 Apr 2019 13:05:40 +0200
Message-Id: <20190410103644.574058244@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 10 Apr 2019 12:28:05 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>
Subject: [RFC patch 11/41] mm/slub: Remove the ULONG_MAX stack trace hackery
References: <20190410102754.387743324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No architecture terminates the stack trace with ULONG_MAX anymore. Remove
the cruft.

While at it remove the pointless loop of clearing the stack array
completely. It's sufficient to clear the last entry as the consumers break
out on the first zeroed entry anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: linux-mm@kvack.org
Cc: David Rientjes <rientjes@google.com>
Cc: Christoph Lameter <cl@linux.com>
---
 mm/slub.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -553,7 +553,6 @@ static void set_track(struct kmem_cache
 	if (addr) {
 #ifdef CONFIG_STACKTRACE
 		struct stack_trace trace;
-		int i;
 
 		trace.nr_entries = 0;
 		trace.max_entries = TRACK_ADDRS_COUNT;
@@ -563,20 +562,16 @@ static void set_track(struct kmem_cache
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


