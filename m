Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7465C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE32E2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rHRl2+0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389533AbfJDO5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:57:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43404 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389378AbfJDO5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:57:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so4042973pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 07:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w2obvvD0YQZHLEq7fGZQtKqybBtTNFyX7qrcoUNkcuk=;
        b=rHRl2+0WeuRHpPB43fer0wtZz/voElxZMtstXIZ3hcmNuzWRZgK4eVFDJ3Q81Z2Sqb
         Un7WPlI4qOfGUn1c8LB+Egj32h+XnRx6kv0yULoLdwsm2mhUGZeSZ3s8B5sIR9F2lyWs
         vhSDEQ3ns/7NluK3dqLsKxVEYMuplU/HMAET0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w2obvvD0YQZHLEq7fGZQtKqybBtTNFyX7qrcoUNkcuk=;
        b=VJAVqBIJqrid5M+AwpYh6sI4c3wSNMd+zDn+DZUUxDxCizvcRwbfkdk7sfAmET+yfW
         EuE14HAvX1M40v07bDCLmd3xLg/m17REAVRJP8Sw+MwWEymag7FsNVXH0ldi2Q4Jt2wj
         hiuj0UNdftT9qRUFZDDOpZpEDNArzlsfjnXLkfZcOhrDzjg/zNTgygWJhL087BuiPCs9
         PqrugxaFheOKZlk596zBmHv5bSqvQG76IFUXiTKPXBUNF7GWAVJ1vXssXEfT1spiIAMd
         t8AkDbEzwuiBcTIU+VzuQvsFF1WENr9WX64ET+cE9mlqY7DS78KI6Nn+o2i90zYKXhXv
         evww==
X-Gm-Message-State: APjAAAVUzhXqobQUzbDmIsVpoeslO5EJI64Bl/4iew17e5HPsM6vfSpd
        l7exGd2cfaMJg7gAn4CJPR2tWD0E5Fk=
X-Google-Smtp-Source: APXvYqxqwEnceOEYdh5DBFB0KF+DIUkAYdTThezgyrXfVcZlONzVqeYt0nML7MKsm0YzbNjpmsYzAw==
X-Received: by 2002:a63:1e16:: with SMTP id e22mr16011959pge.413.1570201068335;
        Fri, 04 Oct 2019 07:57:48 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w134sm7668359pfd.4.2019.10.04.07.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 07:57:47 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>, bristot@redhat.com,
        peterz@infradead.org, oleg@redhat.com, paulmck@kernel.org,
        rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] Remove GP_REPLAY state from rcu_sync
Date:   Fri,  4 Oct 2019 10:57:41 -0400
Message-Id: <20191004145741.118292-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Fernandes <joel@joelfernandes.org>

Please consider this is an RFC for discussion only. Just want to discuss
why the GP_REPLAY state is needed at all.

Here's the intention AFAICS:
When rcu_sync_exit() has happened, the gp_state changes to GP_EXIT while
we wait for a grace period before transitioning to GP_IDLE. In the
meanwhile, if we receive another rcu_sync_exit(), then we want to wait
for another GP to account for that.

Drawing some timing diagrams, it looks like this:

Legend:
rse = rcu_sync_enter
rsx = rcu_sync_exit
i = GP_IDLE
x = GP_EXIT
r = GP_REPLAY
e = GP_ENTER
p = GP_PASSED
rx = GP_REPLAY changes to GP_EXIT

GP num = The GP we are one.

note: A GP passes between the states:
  e and p
  x and i
  x and rx
  rx and i

In a simple case, the timing and states look like:
time
---------------------->
GP num         1111111    2222222
GP state  i    e     p    x     i
CPU0 :         rse	  rsx

However we can enter the replay state like this:
time
---------------------->
GP num         1111111    2222222222222222222223333333
GP state  i    e     p    x              r     rx    i
CPU0 :         rse	  rsx
CPU1 :                         rse     rsx

Due to the second rse + rsx, we had to wait for another GP.

I believe the rationale is, if another rsx happens, another GP has to
happen.

But this is not always true if you consider the following events:

time
---------------------->
GP num         111111     22222222222222222222222222222222233333333
GP state  i    e     p    x                 r              rx     i
CPU0 :         rse	  rsx
CPU1 :                         rse     rsx
CPU2 :                                         rse     rsx

Here, we had 3 grace periods that elapsed, 1 for the rcu_sync_enter(),
and 2 for the rcu_sync_exit(s).

However, we had 3 rcu_sync_exit()s, not 2. In other words, the
rcu_sync_exit() got batched.

So my point here is, rcu_sync_exit() does not really always cause a new
GP to happen and we can end up having the rcu_sync_exit()s as batched
and sharing the same grace period.

Then what is the point of the GP_REPLAY state at all if it does not
always wait for a new GP?  Taking a step back, why did we intend to have
to wait for a new GP if another rcu_sync_exit() comes while one is still
in progress?

Cc: bristot@redhat.com
Cc: peterz@infradead.org
Cc: oleg@redhat.com
Cc: paulmck@kernel.org
Cc: rcu@vger.kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/sync.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index d4558ab7a07d..4f3aad67992c 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -10,7 +10,7 @@
 #include <linux/rcu_sync.h>
 #include <linux/sched.h>
 
-enum { GP_IDLE = 0, GP_ENTER, GP_PASSED, GP_EXIT, GP_REPLAY };
+enum { GP_IDLE = 0, GP_ENTER, GP_PASSED, GP_EXIT };
 
 #define	rss_lock	gp_wait.lock
 
@@ -85,13 +85,6 @@ static void rcu_sync_func(struct rcu_head *rhp)
 		 */
 		WRITE_ONCE(rsp->gp_state, GP_PASSED);
 		wake_up_locked(&rsp->gp_wait);
-	} else if (rsp->gp_state == GP_REPLAY) {
-		/*
-		 * A new rcu_sync_exit() has happened; requeue the callback to
-		 * catch a later GP.
-		 */
-		WRITE_ONCE(rsp->gp_state, GP_EXIT);
-		rcu_sync_call(rsp);
 	} else {
 		/*
 		 * We're at least a GP after the last rcu_sync_exit(); eveybody
@@ -167,16 +160,13 @@ void rcu_sync_enter(struct rcu_sync *rsp)
  */
 void rcu_sync_exit(struct rcu_sync *rsp)
 {
-	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);
-	WARN_ON_ONCE(READ_ONCE(rsp->gp_count) == 0);
+	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) < GP_PASSED);
 
 	spin_lock_irq(&rsp->rss_lock);
 	if (!--rsp->gp_count) {
 		if (rsp->gp_state == GP_PASSED) {
 			WRITE_ONCE(rsp->gp_state, GP_EXIT);
 			rcu_sync_call(rsp);
-		} else if (rsp->gp_state == GP_EXIT) {
-			WRITE_ONCE(rsp->gp_state, GP_REPLAY);
 		}
 	}
 	spin_unlock_irq(&rsp->rss_lock);
-- 
2.23.0.581.g78d2f28ef7-goog

