Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CB3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8C42082F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfCXUUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 16:20:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51865 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfCXUUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 16:20:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2OKJjmD1615049
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 24 Mar 2019 13:19:45 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2OKJirs1615046;
        Sun, 24 Mar 2019 13:19:44 -0700
Date:   Sun, 24 Mar 2019 13:19:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Anna-Maria Gleixner <tipbot@zytor.com>
Message-ID: <tip-dc1e7dc5ac6254ba0502323381a7ec847e408f1d@git.kernel.org>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, anna-maria@linutronix.de,
        hpa@zytor.com
Reply-To: anna-maria@linutronix.de, hpa@zytor.com, rostedt@goodmis.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org
In-Reply-To: <20190321120921.16463-3-anna-maria@linutronix.de>
References: <20190321120921.16463-3-anna-maria@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timer: Move trace point to get proper index
Git-Commit-ID: dc1e7dc5ac6254ba0502323381a7ec847e408f1d
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

Commit-ID:  dc1e7dc5ac6254ba0502323381a7ec847e408f1d
Gitweb:     https://git.kernel.org/tip/dc1e7dc5ac6254ba0502323381a7ec847e408f1d
Author:     Anna-Maria Gleixner <anna-maria@linutronix.de>
AuthorDate: Thu, 21 Mar 2019 13:09:19 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 24 Mar 2019 20:29:32 +0100

timer: Move trace point to get proper index

When placing the timer_start trace point before the timer wheel bucket
index is calculated, the index information in the trace point is useless.

It is not possible to simply move the debug_activate() call after the index
calculation, because debug_object_activate() needs to be called before
touching the object.

Therefore split debug_activate() and move the trace point into
enqueue_timer() after the new index has been calculated. The
debug_object_activate() call remains at the original place.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fweisbec@gmail.com
Cc: peterz@infradead.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20190321120921.16463-3-anna-maria@linutronix.de

---
 kernel/time/timer.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 2fce056f8a49..8d7918ae4d0c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -536,6 +536,8 @@ static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
 	hlist_add_head(&timer->entry, base->vectors + idx);
 	__set_bit(idx, base->pending_map);
 	timer_set_idx(timer, idx);
+
+	trace_timer_start(timer, timer->expires, timer->flags);
 }
 
 static void
@@ -757,13 +759,6 @@ static inline void debug_init(struct timer_list *timer)
 	trace_timer_init(timer);
 }
 
-static inline void
-debug_activate(struct timer_list *timer, unsigned long expires)
-{
-	debug_timer_activate(timer);
-	trace_timer_start(timer, expires, timer->flags);
-}
-
 static inline void debug_deactivate(struct timer_list *timer)
 {
 	debug_timer_deactivate(timer);
@@ -1037,7 +1032,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 		}
 	}
 
-	debug_activate(timer, expires);
+	debug_timer_activate(timer);
 
 	timer->expires = expires;
 	/*
@@ -1171,7 +1166,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	}
 	forward_timer_base(base);
 
-	debug_activate(timer, timer->expires);
+	debug_timer_activate(timer);
 	internal_add_timer(base, timer);
 	raw_spin_unlock_irqrestore(&base->lock, flags);
 }
