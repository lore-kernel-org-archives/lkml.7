Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8734C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887DE20854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfJOK0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:26:11 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:46837 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbfJOK0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:26:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tf7eiU6_1571135135;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tf7eiU6_1571135135)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Oct 2019 18:26:08 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 1/7] rcu: fix incorrect conditional compilation
Date:   Tue, 15 Oct 2019 10:23:56 +0000
Message-Id: <20191015102402.1978-2-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191015102402.1978-1-laijs@linux.alibaba.com>
References: <20191015102402.1978-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DO NOT pick it to stable tree.
(Since the title has "fix", this statement may help stop
AI pick it to stable tree)

The tokens SRCU and TINY_RCU are not defined by any configurations,
they should be CONFIG_SRCU and CONFIG_TINY_RCU. But there is no
harm when "TINY_RCU" is wrongly used, which are always non-defined,
which makes "!defined(TINY_RCU)" always true, which means
the code block is always inclued, and the included code block
doesn't cause any compilation error so far when CONFIG_TINY_RCU.
It is also the reason this change doesn't need for stable.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/rcu/rcu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index a7ab2a023dd3..05f936ed167a 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -254,7 +254,7 @@ void rcu_test_sync_prims(void);
  */
 extern void resched_cpu(int cpu);
 
-#if defined(SRCU) || !defined(TINY_RCU)
+#if defined(CONFIG_SRCU) || !defined(CONFIG_TINY_RCU)
 
 #include <linux/rcu_node_tree.h>
 
@@ -391,7 +391,7 @@ do {									\
 #define raw_lockdep_assert_held_rcu_node(p)				\
 	lockdep_assert_held(&ACCESS_PRIVATE(p, lock))
 
-#endif /* #if defined(SRCU) || !defined(TINY_RCU) */
+#endif /* #if defined(CONFIG_SRCU) || !defined(CONFIG_TINY_RCU) */
 
 #ifdef CONFIG_SRCU
 void srcu_init(void);
-- 
2.20.1

