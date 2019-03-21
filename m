Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A518C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33984218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfCUMKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:10:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37918 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfCUMKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:10:16 -0400
Received: from p200300d06f010d00c8d029af8ffc83b7.dip0.t-ipconnect.de ([2003:d0:6f01:d00:c8d0:29af:8ffc:83b7] helo=somnus.fritz.box)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1h6wWS-00035a-LA; Thu, 21 Mar 2019 13:10:12 +0100
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, fweisbec@gmail.com, peterz@infradead.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH 2/4] timer: Move trace point to get proper index
Date:   Thu, 21 Mar 2019 13:09:19 +0100
Message-Id: <20190321120921.16463-3-anna-maria@linutronix.de>
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

When placing the timer_start trace point before timer wheel bucket
index is calculated, index information in trace point is useless.

It is not possible to simply move debug_activate() call after index
calculation, because debug_object_activate() function needs to be
called before touching the object.

Therefore split debug_activate() function and move trace point into
timer enqueue after index calculation. debug_object_activate() call
remains at the original place.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
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
-- 
2.20.1

