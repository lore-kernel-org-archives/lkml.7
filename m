Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858E2C2D0BE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCD820652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575951969;
	bh=qY6D2p7W6BUJux1yJwdutyn8NAYZTKUx85rOEsvP0c4=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=Is1BqVlkJrzYWKFtk7cbfJq5st7yWq0I+sb21nomV1JSbgiK9kdWkRIIWeMk9cYGj
	 SWAfizIb69ISgf47Yw6onJ+zn45tncEgaesVvRRHyJptOlJ/TMz8avP1SXaGXSQ4RV
	 IzPXumQyQgQAutExyE7mBKBD7ZzMA7dKaswNx6FU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfLJE0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:26:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfLJE0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:26:07 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0F5520637;
        Tue, 10 Dec 2019 04:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951967;
        bh=qY6D2p7W6BUJux1yJwdutyn8NAYZTKUx85rOEsvP0c4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=UQS/C6glJ4jZf9hIwxEEApLS85Ptvptlj5n/Lwnom2843dpWNEnfWVPwVm/sQO6jK
         kIKWSjDQILJSpzEZE/E7rmF5t4ehz9hEcHSBX+cbib48o0EP4Yb968NeIMppbmUV5Y
         0Seq/o1zIzGwGES1pGa9cGHgK9ivfksEirS+1mME=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9ADA93522768; Mon,  9 Dec 2019 20:26:06 -0800 (PST)
Date:   Mon, 9 Dec 2019 20:26:06 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/11] Preemptible-RCU updates for v5.6
Message-ID: <20191210042606.GA3624@paulmck-ThinkPad-P72>
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

This series contains preemptible-RCU updates for v5.6:

1.	Fix dump_tree hierarchy print always active, courtesy of
	Stefan Reiter.

2.	Avoid data-race in rcu_gp_fqs_check_wake(), courtesy of Eric
	Dumazet.

3.	Use lockdep rather than comment to enforce lock held.

4.	Make PREEMPT_RCU be a modifier to TREE_RCU, courtesy of
	Lai Jiangshan.

5.	Use CONFIG_PREEMPTION where appropriate, courtesy of Sebastian
	Andrzej Siewior.

6.	Rename some instances of CONFIG_PREEMPTION to CONFIG_PREEMPT_RCU,
	courtesy of Lai Jiangshan.

7.	Clear .exp_hint only when deferred quiescent state has been
	reported, courtesy of Lai Jiangshan.

8.	Clear ->rcu_read_unlock_special only once, courtesy of Lai
	Jiangshan.

9.	Use READ_ONCE() for ->expmask in rcu_read_unlock_special().

10.	Provide wrappers for uses of ->rcu_read_lock_nesting, courtesy
	of Lai Jiangshan.

11.	Avoid tick_dep_set_cpu() misordering.

							Thanx, Paul

------------------------------------------------------------------------

 include/linux/rcupdate.h   |    8 +--
 include/trace/events/rcu.h |    4 -
 kernel/rcu/Kconfig         |   17 +++---
 kernel/rcu/Makefile        |    1 
 kernel/rcu/rcu.h           |    2 
 kernel/rcu/rcutorture.c    |    2 
 kernel/rcu/srcutiny.c      |    2 
 kernel/rcu/tree.c          |   20 ++++---
 kernel/rcu/tree_exp.h      |    6 +-
 kernel/rcu/tree_plugin.h   |  118 +++++++++++++++++++++++++--------------------
 kernel/rcu/tree_stall.h    |    6 +-
 kernel/rcu/update.c        |    2 
 kernel/sysctl.c            |    2 
 13 files changed, 105 insertions(+), 85 deletions(-)
