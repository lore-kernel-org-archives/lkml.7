Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EA2C47404
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4225A222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066366;
	bh=46272hxJR7y25Qsq03fV9SOQaynnC1NPAOanQP3rUCM=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=f4Zjki0ESBED8HK9J2m99HyKSehyTb473xhTTwmEsvGqhFSLvccK68eQcHhCkJ0/K
	 aSJtJ5BcUtLDfMfGu2nXz0REv6oq/rfp4veSQE13zm4h0dOlu3gMIT+xCEY4OSYfk4
	 jJtH7n0xD2g42IfO67dsueaLMvNZTr2U6i/1qFWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfJCBcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfJCBcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:32:45 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 878A0222BE;
        Thu,  3 Oct 2019 01:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066364;
        bh=46272hxJR7y25Qsq03fV9SOQaynnC1NPAOanQP3rUCM=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=VKczAUItJuzTpPJbeI5VqrbxnmqwS9tiSfD1XJs313j04brtDdvbSKDx59toGp2ud
         z1CYX49Fuo6OgFVuWHcg8HP7rDiu21Mefo6f3PXPKJRkI10CJsWTqVBQvME9fnhw2y
         H4phTtc+S8QsqDQ0+rxHP91v2tiokDWRFD3Aft3I=
Date:   Wed, 2 Oct 2019 18:32:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/8] Fixes for v5.5
Message-ID: <20191003013243.GA12705@paulmck-ThinkPad-P72>
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

1.	Remove unused function hlist_bl_del_init_rcu(), courtesy of
	Ethan Hansen.

2.	Make several rcu_segcblist functions state, courtesy of kbuild
	test robot.

3.	Convert for_each_wq to use built-in list check, courtesy of
	Joel Fernandes.

4.	Ensure that ->rcu_urgent_qs is set before resched IPI, courtesy
	of Joel Fernandes.

5-7.	Update tracepoint descriptions.

8.	Fix uninitialized variable in nocb_gp_wait(), courtesy of
	Dan Carpenter.

							Thanx, Paul

------------------------------------------------------------------------

 include/linux/rculist_bl.h |   28 --------------------------
 include/trace/events/rcu.h |   47 ++++++++++++++++++++++++---------------------
 kernel/rcu/rcu_segcblist.c |    6 ++---
 kernel/rcu/tree.c          |    1 
 kernel/rcu/tree_plugin.h   |    2 -
 kernel/workqueue.c         |   10 +--------
 6 files changed, 33 insertions(+), 61 deletions(-)
