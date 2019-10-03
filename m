Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403CBC4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB44222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066917;
	bh=bzqrGPwyvYmyxv4cMeaBL5r00na4FxhLczouqFPG5Fc=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=BsrqpO+FOeDpZKv67QxOA9Ybz0xGAqxbw1GX4zy8AxApoPGLaINtNVcEYvMlydEn0
	 qvwCh4671QDi4a+9STnKRXWOHwpEUmaE/QSA3m6RHk8lW4xnK3+Gu6EZNCQzVptowo
	 ampY1zP65erNFfc4oreoa0owVc2kkVsVRxIugptM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfJCBl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfJCBl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:41:56 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDE28222BE;
        Thu,  3 Oct 2019 01:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066915;
        bh=bzqrGPwyvYmyxv4cMeaBL5r00na4FxhLczouqFPG5Fc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=QhjP1X3vwPFLuxkX2H+tbj8Ufauau79bS4svw1wkRtCEC7yzCd31Yf8PReBKbKASS
         E3M9IAjoRvU13CVH5DEepuvBaB+MAc/m3irRsmqzEFc7T/Zbn7j/XddWcgNqzxyYh4
         yNI2vuhIieOlIlUbwDa08b9aMgdhOwvucj0bXtdI=
Date:   Wed, 2 Oct 2019 18:41:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/9] Replace rcu_swap_protected() for v5.5
Message-ID: <20191003014153.GA13156@paulmck-ThinkPad-P72>
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

This series replaces uses of rcu_swap_protected() with rcu_replace().
A later patch will remove rcu_swap_protected().

1.	Upgrade rcu_swap_protected() to rcu_replace().

2-9.	Replace calls to rcu_swap_protected() with rcu_replace().

							Thanx, Paul

------------------------------------------------------------------------

 arch/x86/kvm/pmu.c                          |    4 ++--
 drivers/gpu/drm/i915/gem/i915_gem_context.c |    2 +-
 drivers/scsi/scsi.c                         |    4 ++--
 drivers/scsi/scsi_sysfs.c                   |    8 ++++----
 fs/afs/vl_list.c                            |    4 ++--
 include/linux/rcupdate.h                    |   18 ++++++++++++++++++
 kernel/bpf/cgroup.c                         |    4 ++--
 net/core/dev.c                              |    4 ++--
 net/core/sock_reuseport.c                   |    4 ++--
 net/netfilter/nf_tables_api.c               |    5 +++--
 net/sched/act_api.c                         |    2 +-
 net/sched/act_csum.c                        |    4 ++--
 net/sched/act_ct.c                          |    2 +-
 net/sched/act_ctinfo.c                      |    4 ++--
 net/sched/act_ife.c                         |    2 +-
 net/sched/act_mirred.c                      |    4 ++--
 net/sched/act_mpls.c                        |    2 +-
 net/sched/act_police.c                      |    6 +++---
 net/sched/act_skbedit.c                     |    4 ++--
 net/sched/act_tunnel_key.c                  |    4 ++--
 net/sched/act_vlan.c                        |    2 +-
 21 files changed, 56 insertions(+), 37 deletions(-)
