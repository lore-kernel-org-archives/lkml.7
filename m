Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABB7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8513218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfCUMKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:10:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37921 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfCUMKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:10:17 -0400
Received: from p200300d06f010d00c8d029af8ffc83b7.dip0.t-ipconnect.de ([2003:d0:6f01:d00:c8d0:29af:8ffc:83b7] helo=somnus.fritz.box)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1h6wWT-00035a-IW; Thu, 21 Mar 2019 13:10:13 +0100
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, fweisbec@gmail.com, peterz@infradead.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH 3/4] timer: Replace deprecated vsprintf pointer extension %pf by %ps
Date:   Thu, 21 Mar 2019 13:09:20 +0100
Message-Id: <20190321120921.16463-4-anna-maria@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321120921.16463-1-anna-maria@linutronix.de>
References: <20190321120921.16463-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 04b8eb7a4ccd ("symbol lookup: introduce
dereference_symbol_descriptor()") %pf is deprecated, because %ps is smart
enough to handle function pointer dereference on platforms where such
dereference is required.

While at it shorten touched lines not to contain more than 80 characters.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
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
 
-- 
2.20.1

