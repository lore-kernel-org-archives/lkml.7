Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41CCC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FDB208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="QcB+IIW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfDWQSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:18:32 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51050 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbfDWQSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:18:32 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so1164557itk.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pNLBY1/NGrIYBU6rhGuEDDDc1V0YuFCt5ddYuXaekAQ=;
        b=QcB+IIW9/MwAcbFB2Gry9lZO0uWPGo0S9gUkxrpW7zY0fN8gCm/WDMCz5j1GL3WzLw
         3NRGO43n6PinSIfytVyAp1YIF8CtA90nVZaL316OaDm7WFBsdlr8Cu/7bXBhvvRM92er
         MWdlCzEAQ3mqWt9fZAOxKDEph8cwRQvZLdKSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pNLBY1/NGrIYBU6rhGuEDDDc1V0YuFCt5ddYuXaekAQ=;
        b=lgMT1NM0JDmrJh7QQjYc6vegOI4IDUtTeCrcHa7wZHxUfRpXsHOSTIyS8HB3CxNH7e
         zZpZn1DVJTeT03ra4rdcB0b4GdDt2H2fot0IPfwfcD9NLNLsoAVHzf3Ny7kwvFJ/+kpV
         WPGmkW8/Z3YMYZtgU/vJg+dKt+FVsanC4FewmpPHDM2oWgy58uLtBBv+7UO7zUk8vAVU
         lk16E0bPsBwSubARn9bsCj34WTuA3inCBf9mvDeBHbGWjP37I/uzdCgLzJt+mhfbfxFr
         fubtHeeXD6l7DOrfRdPD1e6OyHM18TCoRpAPdW1BndsC5E0JeLf04FoL1jlo2ITgfdFQ
         bzxw==
X-Gm-Message-State: APjAAAVVwVcR4MXdY8xSY1BsRuStpbPUeXIii/AW+fKRBayf2H+WuiTI
        HuCJkNktodRCKzbRo1M/INwsqQ==
X-Google-Smtp-Source: APXvYqygIQ3soUmUU3qx61BtiEBPGJD4zSNjEYue+Er+UwWjBVuyd/7BfK5N2u1rSVvpVfqlMtJa2g==
X-Received: by 2002:a02:1d03:: with SMTP id 3mr18595759jaj.73.1556036311271;
        Tue, 23 Apr 2019 09:18:31 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id z7sm2822378iog.75.2019.04.23.09.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 09:18:30 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v2 00/17] Core scheduling v2
Date:   Tue, 23 Apr 2019 16:18:05 +0000
Message-Id: <cover.1556025155.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Second iteration of the core-scheduling feature.

This version fixes apparent bugs and performance issues in v1. This
doesn't fully address the issue of core sharing between processes
with different tags. Core sharing still happens 1% to 5% of the time
based on the nature of workload and timing of the runnable processes.

Changes in v2
-------------
- rebased on mainline commit: 6d906f99817951e2257d577656899da02bb33105
- Fixes for couple of NULL pointer dereference crashes
  - Subhra Mazumdar
  - Tim Chen
- Improves priority comparison logic for process in different cpus
  - Peter Zijlstra
  - Aaron Lu
- Fixes a hard lockup in rq locking
  - Vineeth Pillai
  - Julien Desfossez
- Fixes a performance issue seen on IO heavy workloads
  - Vineeth Pillai
  - Julien Desfossez
- Fix for 32bit build
  - Aubrey Li

Issues
------
- Processes with different tags can still share the core
- A crash when disabling cpus with core-scheduling on
   - https://paste.debian.net/plainh/fa6bcfa8

---

Peter Zijlstra (16):
  stop_machine: Fix stop_cpus_in_progress ordering
  sched: Fix kerneldoc comment for ia64_set_curr_task
  sched: Wrap rq::lock access
  sched/{rt,deadline}: Fix set_next_task vs pick_next_task
  sched: Add task_struct pointer to sched_class::set_curr_task
  sched/fair: Export newidle_balance()
  sched: Allow put_prev_task() to drop rq->lock
  sched: Rework pick_next_task() slow-path
  sched: Introduce sched_class::pick_task()
  sched: Core-wide rq->lock
  sched: Basic tracking of matching tasks
  sched: A quick and dirty cgroup tagging interface
  sched: Add core wide task selection and scheduling.
  sched/fair: Add a few assertions
  sched: Trivial forced-newidle balancer
  sched: Debug bits...

Vineeth Remanan Pillai (1):
  sched: Wake up sibling if it has something to run

 include/linux/sched.h    |   9 +-
 kernel/Kconfig.preempt   |   7 +-
 kernel/sched/core.c      | 800 +++++++++++++++++++++++++++++++++++++--
 kernel/sched/cpuacct.c   |  12 +-
 kernel/sched/deadline.c  |  99 +++--
 kernel/sched/debug.c     |   4 +-
 kernel/sched/fair.c      | 137 +++++--
 kernel/sched/idle.c      |  42 +-
 kernel/sched/pelt.h      |   2 +-
 kernel/sched/rt.c        |  96 +++--
 kernel/sched/sched.h     | 185 ++++++---
 kernel/sched/stop_task.c |  35 +-
 kernel/sched/topology.c  |   4 +-
 kernel/stop_machine.c    |   2 +
 14 files changed, 1145 insertions(+), 289 deletions(-)

-- 
2.17.1

