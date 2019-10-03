Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DB7C47404
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F66222CA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570067252;
	bh=FZaEnThzQ0fWwn2NhEycNLE9s5KkE0+/ewlFg3S3uVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LTEDhNxfLES2y/gQTOiyx00O8qkiJ5m/S1bIDOZ74L+cUE7/fYB8CgxOCynJT5kI0
	 u+3KuQ/Qxmrni9MpODGNzE7ALAWyJkNr+TXIx3wf6HVKmhF5xx3Q9uqnG0+rTYfowq
	 I0xjmerCuQ40duK/6HNT9Aj8u/xHCfRoqaBnDB5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfJCBrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:47:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfJCBrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:47:31 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3670222C2;
        Thu,  3 Oct 2019 01:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570067250;
        bh=FZaEnThzQ0fWwn2NhEycNLE9s5KkE0+/ewlFg3S3uVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J85OynBCRMll0NDkfKrXvnxUXlFxqvUNSdWQZs+lJsa0UzYkQnfVgheKQ3wx6TGwE
         8WbNVxXKblVtJKzJJzLASVctMOswletUlcylTDqiLpeW9PVTNXmuaDSdIlezVGTpYE
         3yojHm+KR9C0qgtY5abkDFwaRZdhtuRyGevTC7vw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Ethan Hansen <1ethanhansen@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 1/9] rcu: Remove unused function rcutorture_record_progress()
Date:   Wed,  2 Oct 2019 18:47:20 -0700
Message-Id: <20191003014728.13496-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003014710.GA13323@paulmck-ThinkPad-P72>
References: <20191003014710.GA13323@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ethan Hansen <1ethanhansen@gmail.com>

The function rcutorture_record_progress() is declared in rcu.h, but is
never used.  This commit therefore removes rcutorture_record_progress()
to clean code.

Signed-off-by: Ethan Hansen <1ethanhansen@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 8fd4f82..aeec70f 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -455,7 +455,6 @@ enum rcutorture_type {
 #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
 void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 			    unsigned long *gp_seq);
-void rcutorture_record_progress(unsigned long vernum);
 void do_trace_rcu_torture_read(const char *rcutorturename,
 			       struct rcu_head *rhp,
 			       unsigned long secs,
@@ -468,7 +467,6 @@ static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
 	*flags = 0;
 	*gp_seq = 0;
 }
-static inline void rcutorture_record_progress(unsigned long vernum) { }
 #ifdef CONFIG_RCU_TRACE
 void do_trace_rcu_torture_read(const char *rcutorturename,
 			       struct rcu_head *rhp,
-- 
2.9.5

