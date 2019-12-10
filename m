Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCFEC2D0BE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6F82077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950485;
	bh=dTunXD0WJkk1dRKwE3osfvXLC7cPxIklIkask3+b8N0=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=c8AaLWyvIGBhw+A1OHIVDToSlZkvyPb1HB8DWKEXUJh9bffbydonby5QOAJCn6cyB
	 jv79iCl15NZMJeDXtftISguFqC7aFIZy4Uibpaqi06lgGq8sZMVxULOFIAie5s/ZM4
	 q50hTouPhpATxosG6DMRFKI9LeZ+VfHDQhTh2PRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfLJEBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:01:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfLJEBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:01:23 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C83EF205C9;
        Tue, 10 Dec 2019 04:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950482;
        bh=dTunXD0WJkk1dRKwE3osfvXLC7cPxIklIkask3+b8N0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=j5jblVif1yUG7YrcQInxLzaA2SVOKjUZztrqWzVedxP9DKmx7VzJDTmq5kUiXm+Fs
         uaxeY2JvAt4Rv0PCLasa3scEMV9Hv+RnvfYeg/PGD6kNlFSpx+Jw/AmYg1AAaGY9vD
         YhRuyQgm0VV3PYsIYEt/0/mxC+JUwgPdDYjQAOPk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6CF513522768; Mon,  9 Dec 2019 20:01:22 -0800 (PST)
Date:   Mon, 9 Dec 2019 20:01:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/10] Expedited grace-period updates for v5.6
Message-ID: <20191210040122.GA2419@paulmck-ThinkPad-P72>
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

This series provides updates to RCU's expedited grace periods:

1.	Use *_ONCE() to protect lockless ->expmask accesses.

2.	Avoid modifying mask_ofl_ipi in sync_rcu_exp_select_node_cpus(),
	courtesy of Boqun Feng.

3.	Fix data-race due to atomic_t copy-by-value, courtesy of
	Marco Elver.

4.	Lookup instead of bit-twiddling in sync_rcu_exp_select_node_cpus().

5.	Fix missed wakeup of exp_wq waiters, courtesy of Neeraj Upadhyay.

6.	Allow only one expedited GP to run concurrently with wakeups,
	courtesy of Neeraj Upadhyay.

7.	Rename sync_rcu_preempt_exp_done() to sync_rcu_exp_done().

8.	Update tree_exp.h function-header comments.

9.	Replace synchronize_sched_expedited_wait() "_sched" with "_rcu".

10.	Enable tick for nohz_full CPUs slow to provide expedited QS.

							Thanx, Paul

------------------------------------------------------------------------

 include/linux/tick.h       |    5 +
 include/trace/events/rcu.h |    4 -
 kernel/rcu/tree.c          |   11 +--
 kernel/rcu/tree.h          |    1 
 kernel/rcu/tree_exp.h      |  149 +++++++++++++++++++++++++++------------------
 kernel/rcu/tree_plugin.h   |    4 -
 6 files changed, 107 insertions(+), 67 deletions(-)
