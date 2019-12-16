Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC4FC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 23:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB0E22464
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 23:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZCh14J0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLPXWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 18:22:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27552 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726712AbfLPXWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 18:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576538551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=5OOTT2mX9AmY7pDyb29cIv9VcrumF/+0ub9vIafI/h8=;
        b=iZCh14J0rw/h+PD1zBN7r3jmm4JgYjAeb7/7Ry9pzDgsQan3//nKiX0wugU3wpPcZhWDUw
        ZT/5Sg1ZblOdcWcO2LqP3jbPYqR4Avmhga98HWu13IY1UBKG015gUScC6GIX3hC+tvvRnh
        tyT7ptDz+YxNBPh5u9Z6zR7tAvmTeC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-BmxvM2MAOsaMltoA5WeUTg-1; Mon, 16 Dec 2019 18:22:28 -0500
X-MC-Unique: BmxvM2MAOsaMltoA5WeUTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94C28107ACC4;
        Mon, 16 Dec 2019 23:22:27 +0000 (UTC)
Received: from intel-purley-fpgabmp-02.ml3.eng.bos.redhat.com (intel-purley-fpgabmp-02.ml3.eng.bos.redhat.com [10.19.176.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E35827C82F;
        Mon, 16 Dec 2019 23:22:26 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Scott Wood <swood@redhat.com>
Subject: [PATCH 2/4] tick/sched: Set last_tick in init paths
Date:   Mon, 16 Dec 2019 18:22:23 -0500
Message-Id: <1576538545-13274-2-git-send-email-swood@redhat.com>
In-Reply-To: <1576538545-13274-1-git-send-email-swood@redhat.com>
References: <1576538545-13274-1-git-send-email-swood@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This eliminates the need to save last_tick on nohz entry.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/time/tick-sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8936b604dd6c..59e663e240fc 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -794,7 +794,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 		calc_load_nohz_start();
 		quiet_vmstat();
 
-		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
 		ts->tick_stopped = 1;
 		trace_tick_stop(1, TICK_DEP_MASK_NONE);
 	}
@@ -1248,6 +1247,7 @@ static void tick_nohz_switch_to_nohz(void)
 
 	hrtimer_set_expires(&ts->sched_timer, next);
 	hrtimer_forward_now(&ts->sched_timer, tick_period);
+	ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 	tick_nohz_activate(ts, NOHZ_MODE_LOWRES);
 }
@@ -1355,6 +1355,7 @@ void tick_setup_sched_timer(void)
 	}
 
 	hrtimer_forward(&ts->sched_timer, now, tick_period);
+	ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
 	hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
 	tick_nohz_activate(ts, NOHZ_MODE_HIGHRES);
 }
-- 
1.8.3.1

