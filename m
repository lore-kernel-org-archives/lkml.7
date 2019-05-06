Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E5FC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082082082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557133919;
	bh=zQvvpZkRUBeNGPFNkQR8YANoqMJHSeQly3k4bxBRWRg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=cvUm0DWC8j9/qn9KAfpeseNmF9D1WIcsi9cONjTnkd0hLfGO6Ce/Ext7fzkxHH3tL
	 4eHGGcFiXtwRzJ78RPAvgw+ACCgds45AZRdZ0OQh3n88LTywsNUnqMskh8I0Ca06hG
	 1FBF+A/yIt92joSGD8cNtYjJ0i1dwBnzBazSmWsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfEFJL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:11:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38871 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFJL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:11:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id k16so16267206wrn.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iopmvjh/K0goQnipddx1YjV4JvPA9HSsZDyAOf6j4zs=;
        b=Rpc1bCWAsZZNhkui+Nwh1LEaxyv1JdRUY0agjMgVlJEW+lGdQS5+VP/7mdNwc+Vzpu
         3EJNyLtZWKg5f6B8wVIJZZjRAq695HToWLIf20BxSvxmlVzEyFMdTmxfGjEo8OftzMeF
         61gMnSP6lYn3TKPrZ1qF96rIBKkVCFrRnhIF5i0OPuYv6KKMMy4jV6/q0tjjMItZVg5N
         TIu0rNOZrfahM7EuYOmItUDvibG6+u97O+G/VnPKpewdSVJbrTUuKC636oAS9yWggkiT
         6zwVBjGR3vGyfzcK6/Ml/tH8tQ9qsi51eSwW9es5pPd9E4mMHBxZUPwqytKTcdc2myY0
         oKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=iopmvjh/K0goQnipddx1YjV4JvPA9HSsZDyAOf6j4zs=;
        b=J6ZQ226p/BFd379QqH8iGEKjPixos26wE/8lmx3XY1fnT2YJBreU6Kyv74oVTWbMe0
         QkFTmw/38/4BpEWHE8pGv1vDniATwwiBl+fpFgA99GJaXbN6sUjRceBYQzl0c3IbbRT0
         7m4sICnG9Dpq1ODRjYtyTYvePTn0jgtboOdkkLGrtbIUzdDn1xGidp61r0kU6SrKcQbV
         KC50XhnrzgMVYYK7vpfZuPnEdqZ2j4ENGxYTUTzBCdA/EULYgOizqf5339USsHgaWMh3
         34Iat0Ts8FfWOPUGo5vgn9c2iEVQWiOabjRXqEGlhYrL6UGQ7Vx3o0gMIHaIW2SuuHyM
         2IPg==
X-Gm-Message-State: APjAAAW4CA2u+kKHFBXwEJqwhGaRLHzSa6U4Jgid2go5c3sm1jlPS/q3
        DFZqZSEGrejc2IJyLLwusbs=
X-Google-Smtp-Source: APXvYqzTUMW9ShnDwejfRuN3nCa1dkjC/AklXs3mXJ4ZH5WE5kuRDjq16o4Z/JKhhQs9zl3Z6CgZTg==
X-Received: by 2002:adf:ea86:: with SMTP id s6mr17106315wrm.44.1557133915984;
        Mon, 06 May 2019 02:11:55 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h24sm12543197wmb.40.2019.05.06.02.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 02:11:55 -0700 (PDT)
Date:   Mon, 6 May 2019 11:11:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler changes for v5.2
Message-ID: <20190506091153.GA38979@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus

   # HEAD: 08ae95f4fd3b38b257f5dc7e6507e071c27ba0d5 nohz_full: Allow the boot CPU to be nohz_full

The main changes in this cycle were:

 - Make nohz housekeeping processing more permissive and less intrusive 
   to isolated CPUs

 - Decouple CPU-bound workqueue acconting from the scheduler and move it 
   into the workqueue code.

 - Optimize topology building

 - Better handle quota and period overflows

 - Add more RCU annotations

 - Comment updates, misc cleanups

 Thanks,

	Ingo

------------------>
Colin Ian King (1):
      sched/debug: Fix spelling mistake "logaritmic" -> "logarithmic"

Joel Fernandes (Google) (4):
      sched/cpufreq: Annotate cpufreq_update_util_data pointer with __rcu
      sched_domain: Annotate RCU pointers properly
      rcuwait: Annotate task_struct with __rcu
      sched/core: Annotate perf_domain pointer with __rcu

Joel Savitz (1):
      sched/core: Fix typo in comment

Juri Lelli (2):
      cgroup/cpuset: Update stale generate_sched_domains() comments
      sched/topology: Update init_sched_domains() comment

Konstantin Khlebnikov (3):
      sched/rt: Check integer overflow at usec to nsec conversion
      sched/core: Handle overflow in cpu_shares_write_u64
      sched/core: Check quota and period overflow at usec to nsec conversion

Nicholas Piggin (6):
      sched/nohz: Run NOHZ idle load balancer on HK_FLAG_MISC CPUs
      sched/core: Allow the remote scheduler tick to be started on CPU0
      power/suspend: Add function to disable secondaries for suspend
      kernel/cpu: Allow non-zero CPU to be primary for suspend / kexec freeze
      sched/isolation: Require a present CPU in housekeeping mask
      nohz_full: Allow the boot CPU to be nohz_full

Peter Zijlstra (2):
      sched/core: Remove ttwu_activate()
      sched/core: Unify p->on_rq updates

Thomas Gleixner (1):
      sched/core, workqueues: Distangle worker accounting from rq lock

Valentin Schneider (3):
      sched/topology: Fix build_sched_groups() comment
      sched/topology: Skip duplicate group rewrites in build_sched_groups()
      sched/fair: Remove unneeded prototype of capacity_of()

YueHaibing (2):
      sched/fair: Make sync_entity_load_avg() and remove_entity_load_avg() static
      sched/core: Make some functions static


 arch/powerpc/Kconfig           |   4 ++
 include/linux/cpu.h            |  17 ++++++
 include/linux/rcuwait.h        |   2 +-
 include/linux/sched/topology.h |   4 +-
 kernel/cgroup/cpuset.c         |  11 ++--
 kernel/cpu.c                   |  10 +++-
 kernel/kexec_core.c            |   4 +-
 kernel/power/Kconfig           |   9 +++
 kernel/power/hibernate.c       |  12 ++--
 kernel/power/suspend.c         |   4 +-
 kernel/sched/core.c            | 127 +++++++++++++----------------------------
 kernel/sched/cpufreq.c         |   2 +-
 kernel/sched/debug.c           |   2 +-
 kernel/sched/fair.c            |  25 ++++----
 kernel/sched/isolation.c       |  18 ++++--
 kernel/sched/rt.c              |   5 ++
 kernel/sched/sched.h           |  18 +++---
 kernel/sched/topology.c        |  31 +++++-----
 kernel/time/tick-common.c      |  50 ++++++++++++++--
 kernel/time/tick-sched.c       |  34 +++++++----
 kernel/workqueue.c             |  54 ++++++++----------
 kernel/workqueue_internal.h    |   5 +-
 22 files changed, 255 insertions(+), 193 deletions(-)
