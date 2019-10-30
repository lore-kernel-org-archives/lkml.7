Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D128CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E1920856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="FtmLRU/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfJ3Sdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:33:53 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34333 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfJ3Sdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:33:52 -0400
Received: by mail-yw1-f66.google.com with SMTP id d192so1203245ywa.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lvuusyMNXla1fWfAJEm0tfN9JVIMXTzkFXg7lF7H8XM=;
        b=FtmLRU/xXYmwhHN00C9/nHoAXoYX7nT0qZcvm07MsLF1bA9BsuVmpqqHMiAppyOc8J
         NQGP+8pUHIxYaQSAj+Xq3mie+O4tu6zxXP1toliEWv2geUEepM5FuK6k1cVfAQnWBOR7
         wrqg8YJPhXDkVovhq60XBW6iMpRg1NumyWJMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lvuusyMNXla1fWfAJEm0tfN9JVIMXTzkFXg7lF7H8XM=;
        b=OZXN950FoWt6Npaj1/sMuU4aQuMzzT4TIxXm00iAjKRSwoC+DW35I5MmPRq0xr+QK6
         r3BR6donkWS9NiI5yF22D9pAxsXQrnhdQScHuNWo/KU/Ks9FqA51lG7xiQxm+2tslr08
         HSKjd9nKDNQM5kKKyQDGrh59b20cJZ8ABwXP/kiHXkrs8Fo6ZQXTwJGj2TEsunskoSjD
         Oy7uoGPG+AqIHVtE+1qYtbE+K/p3edCFYOXKURQ9MTidIUBSh9gbb0b+Goe717OwK5Rt
         ayN1bDYfxhjXloYK/SzYcGjE3cCJgJbLb1ejaUqmygazvVafvyS4cQ0l03kiAtF8TYSN
         Jgfg==
X-Gm-Message-State: APjAAAXfpRpC6amdY/APMNyLcuwRrwAyEVXK/bF7UDYjff29AYHLnu7m
        THMPmDdd3mQnXh9RbosPl55nIw==
X-Google-Smtp-Source: APXvYqwpt/dY98j2ZDz3wLsoQrv6G/SQIhbz7cOECs388LF9Kwc33LVlneT16MKKQQ0pd+Y4GKVNhg==
X-Received: by 2002:a0d:c986:: with SMTP id l128mr804026ywd.407.1572460431201;
        Wed, 30 Oct 2019 11:33:51 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id u7sm1020282ywu.45.2019.10.30.11.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:33:50 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v4 00/19] Core scheduling v4
Date:   Wed, 30 Oct 2019 18:33:13 +0000
Message-Id: <cover.1572437285.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fourth iteration of the Core-Scheduling feature.

This version was aiming mostly at addressing the vruntime comparison
issues with v3. The main issue seen in v3 was the starvation of
interactive tasks when competing with cpu intensive tasks. This issue
is mitigated to a large extent.

We have tested and verified that incompatible processes are not
selected during schedule. In terms of performance, the impact
depends on the workload:
- on CPU intensive applications that use all the logical CPUs with
  SMT enabled, enabling core scheduling performs better than nosmt.
- on mixed workloads with considerable io compared to cpu usage,
  nosmt seems to perform better than core scheduling.

v4 is rebased on top of 5.3.5(dc073f193b70):
https://github.com/digitalocean/linux-coresched/tree/coresched/v4-v5.3.5

Changes in v4
-------------
- Implement a core wide min_vruntime for vruntime comparison of tasks
  across cpus in a core.
- Fixes a typo bug in setting the forced_idle cpu.

Changes in v3
-------------
- Fixes the issue of sibling picking up an incompatible task
  - Aaron Lu
  - Vineeth Pillai
  - Julien Desfossez
- Fixes the issue of starving threads due to forced idle
  - Peter Zijlstra
- Fixes the refcounting issue when deleting a cgroup with tag
  - Julien Desfossez
- Fixes a crash during cpu offline/online with coresched enabled
  - Vineeth Pillai
- Fixes a comparison logic issue in sched_core_find
  - Aaron Lu

Changes in v2
-------------
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

TODO
----
- Decide on the API for exposing the feature to userland
- Investigate the source of the overhead even when no tasks are tagged:
  https://lkml.org/lkml/2019/10/29/242
- Investigate the performance scaling issue when we have a high number of
  tagged threads: https://lkml.org/lkml/2019/10/29/248
- Try to optimize the performance for IO-demanding applications:
  https://lkml.org/lkml/2019/10/29/261

---

Aaron Lu (3):
  sched/fair: wrapper for cfs_rq->min_vruntime
  sched/fair: core wide vruntime comparison
  sched/fair : Wake up forced idle siblings if needed

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

 include/linux/sched.h    |   9 +-
 kernel/Kconfig.preempt   |   6 +
 kernel/sched/core.c      | 847 +++++++++++++++++++++++++++++++++++++--
 kernel/sched/cpuacct.c   |  12 +-
 kernel/sched/deadline.c  |  99 +++--
 kernel/sched/debug.c     |   4 +-
 kernel/sched/fair.c      | 346 +++++++++++-----
 kernel/sched/idle.c      |  42 +-
 kernel/sched/pelt.h      |   2 +-
 kernel/sched/rt.c        |  96 ++---
 kernel/sched/sched.h     | 246 +++++++++---
 kernel/sched/stop_task.c |  35 +-
 kernel/sched/topology.c  |   4 +-
 kernel/stop_machine.c    |   2 +
 14 files changed, 1399 insertions(+), 351 deletions(-)

-- 
2.17.1

