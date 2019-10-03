Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17583C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27D9222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570067233;
	bh=mIbmoRtxDUoM/LgKixRqpYpNw9TMaZ1mcIB9zDzPIHY=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=bfHepPzm4jyTXrWyCyouXmeet6eEEye7Ym1Crch5nW/3RKuHBOhL8ZaJfljl2+HFM
	 B5dB5eao536Brv+h7CbtL9Do2RWMb9np9MM8omK1dIisF4g3yb/PaP1IxlSvrln0SM
	 GskrpamS0uiyIg/qC8W1+/nY8p4mS7XH4fh9iPfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfJCBrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfJCBrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:47:12 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1620222C0;
        Thu,  3 Oct 2019 01:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570067231;
        bh=mIbmoRtxDUoM/LgKixRqpYpNw9TMaZ1mcIB9zDzPIHY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=vwbqNYeftR/7D6sZz70InV7xHh10EavHYXJS/91X6gq7/PpU4avGAK8OhRJfaYzIa
         7sFrcjClBr37SLaZ4/ZSHVpik6ovM9XewBfuFN+O5hHHPB3xRkQBozpqySz6qOrqt0
         VZd0IgySRI90+h9rBTAQVQZhH0rZjclM8EdGgwwc=
Date:   Wed, 2 Oct 2019 18:47:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/9] Torture-test updates
Message-ID: <20191003014710.GA13323@paulmck-ThinkPad-P72>
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

This series provides torture-test updates.

1.	Remove unused function rcutorture_record_progress(), courtesy
	of Ethan Hansen.

2.	Replace strncmp() with str_has_prefix(), courtesy of Chuhong Yuan.

3.	Remove CONFIG_HOTPLUG_CPU=n from scenarios.

4.	Emulate dyntick aspect of userspace nohz_full sojourn.

5.	Remove unused variable rcu_perf_writer_state, courtesy of
	Ethan Hansen.

6.	Separate warnings for each failure type.

7.	Make in-kernel-loop testing more brutal.

8.	locktorture: Do not include rwlock.h directly, courtesy of
	Wolfgang M. Reimer.

9.	Suppress levelspread uninitialized messages.

							Thanx, Paul

------------------------------------------------------------------------

 include/linux/rcutiny.h                                     |    1 
 kernel/locking/locktorture.c                                |    9 +--
 kernel/rcu/rcu.h                                            |    4 -
 kernel/rcu/rcuperf.c                                        |   16 ------
 kernel/rcu/rcutorture.c                                     |   28 +++++++++---
 kernel/rcu/tree.c                                           |    1 
 tools/testing/selftests/rcutorture/configs/rcu/TASKS03      |    3 -
 tools/testing/selftests/rcutorture/configs/rcu/TREE02       |    3 -
 tools/testing/selftests/rcutorture/configs/rcu/TREE04       |    3 -
 tools/testing/selftests/rcutorture/configs/rcu/TREE06       |    3 -
 tools/testing/selftests/rcutorture/configs/rcu/TREE08       |    3 -
 tools/testing/selftests/rcutorture/configs/rcu/TREE09       |    3 -
 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL      |    3 -
 tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt |    1 
 14 files changed, 29 insertions(+), 52 deletions(-)
