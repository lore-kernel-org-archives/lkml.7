Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187BEC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0722077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950876;
	bh=6hVA58dIBEyN/mPJBos2dUyQmVqkjqz0PDuZsQk7yqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KPA3j09fP1z//VYqqWuZFhPXjRxMDlBG38HiPKkCO+TwXYWt2kxMAjt+MH84F8Q4p
	 AMDQyzMQ//rKErGwW6YjE3Pg+ndT2mKrrn/K0RhWWHRYfwvEQ/Bl4YA6bkvVXwXfVP
	 a1NAV3/wRSkPcHm4rFONZlliaC6eFJktrkZB5Eps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfLJEHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:07:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:43734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfLJEHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:07:52 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E848F24680;
        Tue, 10 Dec 2019 04:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950871;
        bh=6hVA58dIBEyN/mPJBos2dUyQmVqkjqz0PDuZsQk7yqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dc3T+9yIJERy9jMjJpVUOTUSeBrvZG1T4FlZKqyraXiZtzzpCgpIbAI63vSWCKgJy
         myjPU5qZQbFEOqocCn9xkLA8Jhx7R67fhHuFmaRsw3wW0byFlC3tpdFpjaFDxD1hg2
         I5S+5j7GQ2T2lh+o82w7QHgpeWuaAhy9py4DGcN8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/12] rcu: Remove unused stop-machine #include
Date:   Mon,  9 Dec 2019 20:07:41 -0800
Message-Id: <20191210040741.2943-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040714.GA2715@paulmck-ThinkPad-P72>
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Long ago, RCU used the stop-machine mechanism to implement expedited
grace periods, but no longer does so.  This commit therefore removes
the no-longer-needed #includes of linux/stop_machine.h.

Link: https://lwn.net/Articles/805317/
Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 -
 kernel/rcu/tree.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d950764..878f62f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -43,7 +43,6 @@
 #include <uapi/linux/sched/types.h>
 #include <linux/prefetch.h>
 #include <linux/delay.h>
-#include <linux/stop_machine.h>
 #include <linux/random.h>
 #include <linux/trace_events.h>
 #include <linux/suspend.h>
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9d5986a..ce90c68 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -16,7 +16,6 @@
 #include <linux/cpumask.h>
 #include <linux/seqlock.h>
 #include <linux/swait.h>
-#include <linux/stop_machine.h>
 #include <linux/rcu_node_tree.h>
 
 #include "rcu_segcblist.h"
-- 
2.9.5

