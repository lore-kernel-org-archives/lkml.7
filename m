Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F8CC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 21:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6BA21852
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 21:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="sFx1qyWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfHRVuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 17:50:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39548 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfHRVuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 17:50:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id z3so4830999pln.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 14:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Wg9JME0FWTs1tYyJ3nmuvph2mMJv0VgG1hoJmiI+89Y=;
        b=sFx1qyWsXacdqGPc0XPcx/uSYdMTruibrn5pboJKb0GPUIVxMWLd6yd09zXGovBFEI
         31vFPeXRk7jCScWKtdivUBw6ciSCob0vEGXgbXo08y2aals0woz+GXdP4HIl1/QQlsRa
         bzBo2BdvaV+I3u+DQVQGNIMPMYPA97ZyNigQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Wg9JME0FWTs1tYyJ3nmuvph2mMJv0VgG1hoJmiI+89Y=;
        b=aZbkxp74aJOEBnOpkpBrY4JjtVkb8jGwmmXHfgjbV9gD2+6MXITkE5OTua0EwtZpN7
         WEOyuzTC2bSLLwjw1s4jBTHnRKJfpEkbUIaVrTq4i6sAOVFyPaojEp1vEKj7mSAWcG00
         oU/ss9+BF0lPENvgf4Jp4CHygTiKmMqUNLc/qf0HMTJBy8YL9czJ3FuyggpkHDYTHOQQ
         cBn8uFHx02SUczqRX+/m7qER8q+CmzbC/D0W/9e+qjNhdouEZJkWsJHW2YAIk4KFNieh
         YIEqxH7JGMbtRVkrRVwGF4XoJmWyto/rDNUQaDsdqg0/DEKCN/hnGcaSl53F2bWVzEqb
         cqUA==
X-Gm-Message-State: APjAAAUIw/FZwHmZB1+U/USJclxJJXdxa6+g3l+ACk2wtaXdIBW8PgHg
        gM8skPcad7j0OkhAtAWci3QDAn8TJQ8=
X-Google-Smtp-Source: APXvYqzdnZqbCZQxwGZmMxdNNdL2R6VE2UIUjJOX/DEW15dQCctAiH1YCOyh6z0/ZGjPA6AXwR46cw==
X-Received: by 2002:a17:902:822:: with SMTP id 31mr1685767plk.343.1566165006033;
        Sun, 18 Aug 2019 14:50:06 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id f12sm12543645pgo.85.2019.08.18.14.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 14:50:05 -0700 (PDT)
Date:   Sun, 18 Aug 2019 17:49:48 -0400
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during unlock
Message-ID: <20190818214948.GA134430@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we're in hard interrupt context in rcu_read_unlock_special(), we
can still benefit from invoke_rcu_core() doing wake ups of rcuc
threads when the !use_softirq parameter is passed.  This is safe
to do so because:

1. We avoid the scheduler deadlock issues thanks to the deferred_qs bit
introduced in commit 23634ebc1d94 ("rcu: Check for wakeup-safe
conditions in rcu_read_unlock_special()") by checking for the same in
this patch.

2. in_irq() implies in_interrupt() which implies raising softirq will
not do any wake ups.

The rcuc thread which is awakened will run when the interrupt returns.

We also honor 25102de ("rcu: Only do rcu_read_unlock_special() wakeups
if expedited") thus doing the rcuc awakening only when none of the
following are true:
  1. Critical section is blocking an expedited GP.
  2. A nohz_full CPU.
If neither of these cases are true (exp == false), then the "else" block
will run to do the irq_work stuff.

This commit is based on a partial revert of d143b3d1cd89 ("rcu: Simplify
rcu_read_unlock_special() deferred wakeups") with an additional in_irq()
check added.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
v1->v2: Some minor character encoding issues in changelog corrected.

Note that I am still testing this patch, but I sent an early RFC for your
feedback. Thanks!

 kernel/rcu/tree_plugin.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2defc7fe74c3..f4b3055026dc 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -621,6 +621,11 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// Using softirq, safe to awaken, and we get
 			// no help from enabling irqs, unlike bh/preempt.
 			raise_softirq_irqoff(RCU_SOFTIRQ);
+		} else if (exp && in_irq() && !use_softirq &&
+			   !t->rcu_read_unlock_special.b.deferred_qs) {
+			// Safe to awaken rcuc kthread which will be
+                       // scheduled in from the interrupt return path.
+			invoke_rcu_core();
 		} else {
 			// Enabling BH or preempt does reschedule, so...
 			// Also if no expediting or NO_HZ_FULL, slow is OK.
-- 
2.23.0.rc1.153.gdeed80330f-goog

