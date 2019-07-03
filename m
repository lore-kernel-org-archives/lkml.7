Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5342C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE94F21880
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bew0bE1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfGCEj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 00:39:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34054 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfGCEj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 00:39:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so575863pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 21:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xcs6LVebZeYfm34tR+E2iNRTl8rNqT5+HyCV9cmyWAg=;
        b=bew0bE1vCsEia5mVlCBgThQkoqZt0DhnInUjeC77F/hf/+eC+B0SiAETi90XUiO6KV
         6iu+WAqDm/w4DbOoYmBau0bh4sjSRrLiEwCEqq3zaol5B7pM/Ab1FsynaKaGKMg7/u09
         +R7IgIITU1Yrg8Ynt/NttzgZEPOT5UeLuOnqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xcs6LVebZeYfm34tR+E2iNRTl8rNqT5+HyCV9cmyWAg=;
        b=CsNyuyYH6J4RZ+byQa599xHmZFTkfuZ6Yn12oEUfYgXXZ2ktzc3lz1sZV9Oy+LLBgT
         Zvi5VUz8H7UVoPYlqVF4hQhdRfEp4sDcSrvoASC79oUTqhE453f8Wl8YGYj1wRPhytXr
         vOXRV03aQlCdpsjyIuvg1ejDEKlklQ0V7gJZYKOBwgpEy3hJMgcpcXVecdiav28ZQxRM
         CgXiqu5VzMYIzRsxJiS1Rx9nG1j0NqLNknAPNqyW7Rz05EMO0dVEoanZiiDN2iohi3PM
         AL8/MNRoHeGiJ+4TZoknTxtBtZXLGoeovdibJRYujcJWxXmjL8TwfhvUK63PGAh0dLjb
         cI6g==
X-Gm-Message-State: APjAAAVLttn52FqFKPMJiz6c4xLDqsocCPGAACz0rYS8RpmcmTI72YIv
        7ObPjNIRWmtzgu+DT/c65PZl67ULkr4=
X-Google-Smtp-Source: APXvYqxxjCQ6yRUV3c52rlRzqGy1yqDWJHn798vUrWS/J1C2iV1HH1EAt8lqZZD5YDDjfcyTxrlDuA==
X-Received: by 2002:a63:1723:: with SMTP id x35mr34081099pgl.233.1562128797851;
        Tue, 02 Jul 2019 21:39:57 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 2sm678953pff.174.2019.07.02.21.39.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 21:39:56 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC] rcuperf: Make rcuperf test more robust for !expedited mode
Date:   Wed,  3 Jul 2019 00:39:45 -0400
Message-Id: <20190703043945.128825-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that rcuperf run concurrently with init starting up.
During this time, the system is running all grace periods as expedited.
However, rcuperf can also be run in a normal mode. The rcuperf test
depends on a holdoff before starting the test to ensure grace periods
start later. This works fine with the default holdoff time however it is
not robust in situations where init takes greater than the holdoff time
the finish running. Or, as in my case:

I modified the rcuperf test locally to also run a thread that did
preempt disable/enable in a loop. This had the effect of slowing down
init. The end result was "batches:" counter was 0. This was because only
expedited GPs seem to happen, not normal ones which led to the
rcu_state.gp_seq counter remaining constant across grace periods which
unexpectedly happen to be expedited.

This led me to debug that even though the test could be for normal GP
performance, because init has still not run enough, the
rcu_unexpedited_gp() call would not have run yet. In other words, the
test would concurrently with init booting in expedited GP mode.

To fix this properly, let us just check for whether rcu_unexpedited_gp()
was called yet before starting the writer test. With this, the holdoff
parameter could also be dropped or reduced to speed up the test.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
Please consider this patch as an RFC only! This is the first time I am
running the RCU performance tests, thanks!

Question:
I actually did not know that expedited gp does not increment
rcu_state.gp_seq. Does expedited GPs not go through the same RCU-tree
machinery as non-expedited? If yes, why doesn't rcu_state.gp_seq
increment when we are expedited? If no, why not?

 kernel/rcu/rcu.h     | 2 ++
 kernel/rcu/rcuperf.c | 5 +++++
 kernel/rcu/update.c  | 9 +++++++++
 3 files changed, 16 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 8fd4f82c9b3d..5d30dbc7000b 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -429,12 +429,14 @@ static inline void srcu_init(void) { }
 static inline bool rcu_gp_is_normal(void) { return true; }
 static inline bool rcu_gp_is_expedited(void) { return false; }
 static inline void rcu_expedite_gp(void) { }
+static inline bool rcu_expedite_gp_called(void) { }
 static inline void rcu_unexpedite_gp(void) { }
 static inline void rcu_request_urgent_qs_task(struct task_struct *t) { }
 #else /* #ifdef CONFIG_TINY_RCU */
 bool rcu_gp_is_normal(void);     /* Internal RCU use. */
 bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
 void rcu_expedite_gp(void);
+bool rcu_expedite_gp_called(void);
 void rcu_unexpedite_gp(void);
 void rcupdate_announce_bootup_oddness(void);
 void rcu_request_urgent_qs_task(struct task_struct *t);
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 4513807cd4c4..9902857d3cc6 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -375,6 +375,11 @@ rcu_perf_writer(void *arg)
 	if (holdoff)
 		schedule_timeout_uninterruptible(holdoff * HZ);
 
+	// Wait for rcu_unexpedite_gp() to be called from init to avoid
+	// doing expedited GPs if we are not supposed to
+	while (!gp_exp && rcu_expedite_gp_called())
+		schedule_timeout_uninterruptible(1);
+
 	t = ktime_get_mono_fast_ns();
 	if (atomic_inc_return(&n_rcu_perf_writer_started) >= nrealwriters) {
 		t_rcu_perf_writer_started = t;
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 249517058b13..840f62805d62 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -154,6 +154,15 @@ void rcu_expedite_gp(void)
 }
 EXPORT_SYMBOL_GPL(rcu_expedite_gp);
 
+/**
+ * rcu_expedite_gp_called - Was there a prior call to rcu_expedite_gp()?
+ */
+bool rcu_expedite_gp_called(void)
+{
+	return (atomic_read(&rcu_expedited_nesting) != 0);
+}
+EXPORT_SYMBOL_GPL(rcu_expedite_gp_called);
+
 /**
  * rcu_unexpedite_gp - Cancel prior rcu_expedite_gp() invocation
  *
-- 
2.22.0.410.gd8fdbe21b5-goog
