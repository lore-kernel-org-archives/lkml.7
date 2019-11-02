Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818A6CA9ED4
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BC1214AF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKBMr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 08:47:26 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44401 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbfKBMrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 08:47:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Th-p52Z_1572698839;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Th-p52Z_1572698839)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Nov 2019 20:47:20 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH V2 3/7] rcu: remove useless special.b.deferred_qs
Date:   Sat,  2 Nov 2019 12:45:55 +0000
Message-Id: <20191102124559.1135-4-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191102124559.1135-1-laijs@linux.alibaba.com>
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
Reply-To: <20191101162109.GN20975@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

->read_read_unlock_special.b.deferred_qs is set when
->read_read_unlock_special is non-zero, and it is cleared when
->read_read_unlock_special is cleared.

So it is useless.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 include/linux/sched.h    | 2 +-
 kernel/rcu/tree_plugin.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2c2e56bd8913..3ba392d71de9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -604,7 +604,7 @@ union rcu_special {
 		u8			blocked;
 		u8			need_qs;
 		u8			exp_hint; /* Hint for performance. */
-		u8			deferred_qs;
+		u8			pad; /* No garbage from compiler! */
 	} b; /* Bits. */
 	u32 s; /* Set of bits. */
 };
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2fab8be2061f..f2fd7d687bdb 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -622,7 +622,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
 		}
-		t->rcu_read_unlock_special.b.deferred_qs = true;
 		local_irq_restore(flags);
 		return;
 	}
-- 
2.20.1

