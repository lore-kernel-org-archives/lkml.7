Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E230C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D312082F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfCXUU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 16:20:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45439 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfCXUU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 16:20:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2OKKQFM1615214
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 24 Mar 2019 13:20:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2OKKQgN1615209;
        Sun, 24 Mar 2019 13:20:26 -0700
Date:   Sun, 24 Mar 2019 13:20:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Anna-Maria Gleixner <tipbot@zytor.com>
Message-ID: <tip-6849cbb0f9a8dbc1ba56e9abc6955613103e01e3@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de, anna-maria@linutronix.de
Reply-To: anna-maria@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, rostedt@goodmis.org, hpa@zytor.com,
          tglx@linutronix.de
In-Reply-To: <20190321120921.16463-4-anna-maria@linutronix.de>
References: <20190321120921.16463-4-anna-maria@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timer/trace: Replace deprecated vsprintf pointer
 extension %pf by %ps
Git-Commit-ID: 6849cbb0f9a8dbc1ba56e9abc6955613103e01e3
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

Commit-ID:  6849cbb0f9a8dbc1ba56e9abc6955613103e01e3
Gitweb:     https://git.kernel.org/tip/6849cbb0f9a8dbc1ba56e9abc6955613103e01e3
Author:     Anna-Maria Gleixner <anna-maria@linutronix.de>
AuthorDate: Thu, 21 Mar 2019 13:09:20 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 24 Mar 2019 20:29:33 +0100

timer/trace: Replace deprecated vsprintf pointer extension %pf by %ps

Since commit 04b8eb7a4ccd ("symbol lookup: introduce
dereference_symbol_descriptor()") %pf is deprecated, because %ps is smart
enough to handle function pointer dereference on platforms where such a
dereference is required.

While at it add proper line breaks to stay in the 80 character limit.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fweisbec@gmail.com
Cc: peterz@infradead.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20190321120921.16463-4-anna-maria@linutronix.de

---
 include/trace/events/timer.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index a57e4ee989d6..da975d69c453 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -73,7 +73,7 @@ TRACE_EVENT(timer_start,
 		__entry->flags		= flags;
 	),
 
-	TP_printk("timer=%p function=%pf expires=%lu [timeout=%ld] cpu=%u idx=%u flags=%s",
+	TP_printk("timer=%p function=%ps expires=%lu [timeout=%ld] cpu=%u idx=%u flags=%s",
 		  __entry->timer, __entry->function, __entry->expires,
 		  (long)__entry->expires - __entry->now,
 		  __entry->flags & TIMER_CPUMASK,
@@ -105,7 +105,8 @@ TRACE_EVENT(timer_expire_entry,
 		__entry->function	= timer->function;
 	),
 
-	TP_printk("timer=%p function=%pf now=%lu", __entry->timer, __entry->function,__entry->now)
+	TP_printk("timer=%p function=%ps now=%lu",
+		  __entry->timer, __entry->function, __entry->now)
 );
 
 /**
@@ -210,7 +211,7 @@ TRACE_EVENT(hrtimer_start,
 		__entry->mode		= mode;
 	),
 
-	TP_printk("hrtimer=%p function=%pf expires=%llu softexpires=%llu "
+	TP_printk("hrtimer=%p function=%ps expires=%llu softexpires=%llu "
 		  "mode=%s", __entry->hrtimer, __entry->function,
 		  (unsigned long long) __entry->expires,
 		  (unsigned long long) __entry->softexpires,
@@ -243,7 +244,8 @@ TRACE_EVENT(hrtimer_expire_entry,
 		__entry->function	= hrtimer->function;
 	),
 
-	TP_printk("hrtimer=%p function=%pf now=%llu", __entry->hrtimer, __entry->function,
+	TP_printk("hrtimer=%p function=%ps now=%llu",
+		  __entry->hrtimer, __entry->function,
 		  (unsigned long long) __entry->now)
 );
 
