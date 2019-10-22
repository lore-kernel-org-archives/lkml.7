Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B771CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38C321872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571771502;
	bh=BFpmJVp3g4mnzmJQ78mDOW+D/tMEALdCEUwJdQzpiH8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ENkoisrabYt4Qb8ECs98/2Y1LgvRWIvrA2l3dLfActy820rgFPe51H+31+ZTdzsp+
	 gysFCSV/Ah8t+0N2qRdHS4+CE8sLORaNHnsH9XYVemFCnYDAQHjOW/qdDsTOzc6x+D
	 SShEUXf9Y0HEM/bf4MBanpax1V0EiUDDzgPDhoHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbfJVTLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 15:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731436AbfJVTLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:11:40 -0400
Received: from paulmck-ThinkPad-P72 (rrcs-50-75-166-42.nys.biz.rr.com [50.75.166.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4702221783;
        Tue, 22 Oct 2019 19:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571771499;
        bh=BFpmJVp3g4mnzmJQ78mDOW+D/tMEALdCEUwJdQzpiH8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QWhr4Lnw3yx89gw8D9fogOsu1cchslGv8jz8NV5GsGR3SMIZ0puHpimuKHlGxSRTG
         SS639wk7K5YmSbaBtsG4Ldpt8yEuvzD/Z721UZ8JO9RXsj5mpKIAYvbY5c/ia5EyUN
         3RiNvvaNGf4JPjpX7YR8JvYHKg53jbL/I0sDp+2M=
Date:   Tue, 22 Oct 2019 12:11:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH v2 tip/core/rcu 0/10] Replace rcu_swap_protected() for v5.5
Message-ID: <20191022191136.GA25627@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191003014153.GA13156@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003014153.GA13156@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series replaces uses of rcu_swap_protected() with rcu_replace().
A later patch will remove rcu_swap_protected().

1.      Upgrade rcu_swap_protected() to rcu_replace().

2-10.    Replace calls to rcu_swap_protected() with rcu_replace().

Changes from v1:

o	Added security/safesetid patch.

o	Changed the name from rcu_replace() to rcu_replace_pointer()
	based on feedback from Ingo Molnar.

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
 net/sched/act_ct.c                          |    3 ++-
 net/sched/act_ctinfo.c                      |    4 ++--
 net/sched/act_ife.c                         |    2 +-
 net/sched/act_mirred.c                      |    4 ++--
 net/sched/act_mpls.c                        |    2 +-
 net/sched/act_police.c                      |    6 +++---
 net/sched/act_sample.c                      |    4 ++--
 net/sched/act_skbedit.c                     |    4 ++--
 net/sched/act_tunnel_key.c                  |    4 ++--
 net/sched/act_vlan.c                        |    2 +-
 security/safesetid/securityfs.c             |    4 ++--
 23 files changed, 61 insertions(+), 41 deletions(-)
