Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897CBC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2A52077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950837;
	bh=1Z8DAY0fVZOvCUKy6ksDot53CEDph4iidwVKSYkWCno=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=Gpg3W88xXW6h3VbjB6A13pM9+HWKk6BjNConoozD5kjF1/W5n/nU+x6Dhyo0Ei7vE
	 +TVGLilVUIqjKPr9Mwh0KamQHUp3nlnPopYR8XP9cLX8sKiLlUnhlCTVbQxU6RrSYa
	 uUOHmk/u9Tvyyv/XDevDhu1tcFGpSF3TdunzpUZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLJEHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:07:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfLJEHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:07:15 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E783C2071E;
        Tue, 10 Dec 2019 04:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950835;
        bh=1Z8DAY0fVZOvCUKy6ksDot53CEDph4iidwVKSYkWCno=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=IfNpviWN5TF+PWWG4siWsokf3+3UlUpjjC7pq53LGAcVE0wZnwm+RtxgqmMkQCjR2
         E2kObI25Da7hTu0ThTTY14gttIdeMi0fb4SvzIlQnDG2+t8PtkAoluLv8SiwIOWM9P
         v8h1CDyfRInf/0H6oOnD08QxZah+UqIag1xgc+Qw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 80D203522768; Mon,  9 Dec 2019 20:07:14 -0800 (PST)
Date:   Mon, 9 Dec 2019 20:07:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/12] Miscellaneous fixes for v5.6
Message-ID: <20191210040714.GA2715@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides miscellaneous fixes:

1.	Remove rcu_swap_protected().

2.	Mark non-global functions and variables as static.

3.	Fix harmless omission of "CONFIG_" from #if condition, courtesy
	of Lai Jiangshan.

4.	Fix tracepoint tracking RCU CPU kthread utilization, courtesy
	of Lai Jiangshan.

5.	Remove the declaration of call_rcu() in tree.h, courtesy of
	Lai Jiangshan.

6.	Move gp_state_names[] and gp_state_getname() to tree_stall.h,
	courtesy of Lai Jiangshan.

7.	Move rcu_{expedited,normal} definitions into rcupdate.h,
	courtesy of Ben Dooks.

8.	Switch force_qs_rnp() to for_each_leaf_node_cpu_mask().

9.	Apply *_ONCE() to ->srcu_last_gp_end.

10.	Add .mailmap entries for old paulmck@kernel.org addresses.

11.	Remove comment about read_barrier_depends(), courtesy of
	Will Deacon.

12.	Remove unused stop-machine #include.

							Thanx, Paul

------------------------------------------------------------------------

 .mailmap                           |    5 +++++
 arch/powerpc/include/asm/barrier.h |    2 --
 include/linux/rcupdate.h           |   20 ++++----------------
 kernel/rcu/rcu.h                   |    4 ++--
 kernel/rcu/srcutree.c              |    7 ++++---
 kernel/rcu/tree.c                  |   34 ++++++++++------------------------
 kernel/rcu/tree.h                  |   16 ----------------
 kernel/rcu/tree_stall.h            |   22 ++++++++++++++++++++++
 kernel/rcu/update.c                |    2 --
 9 files changed, 47 insertions(+), 65 deletions(-)
