Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF18C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743512063F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfF1IGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:06:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36966 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfF1IGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:06:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so8032777wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 01:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V5rt7wqLf2YkGXLjqqYHPcMhXEcwrF0Z+/UteTLRmvM=;
        b=pEvSCKN2CEt/vTtCcmmyJqF8bbboMoyh9IUxtr5/oEcgFcft4GkYL+TdckIDUHMJEs
         p/2msaQEVYw3eQa2xcFbRt0MNnKWlHUl7tFzL1CPCLf+dgLMmEzXneRcqbuc0W9IXjkQ
         fH3/tsw8d4y+NZIUho756j4Hs9mSjCOuAeGmsikTkJRqZHjlMiRG3+lgFSkQnXZQCQpi
         ELhJZ1VRsoQLE1KFKoOKOLr4C6bpkC3w2Bgyskm77/B9Sq/LDEu7ZG9X9vGiNRAHQGU2
         FjCrEWNoLYYRRloilsl8GyI60vjpYCfocpTU1sTeF+UfJEB+uX9aFWPBomh0JQ0FYKEm
         hOqA==
X-Gm-Message-State: APjAAAUCxhWd8fyFpoLlGPuSfX81DK4aWOynJxrL9kVMb6pdTKjnlXbd
        rQCZBnDjREW+8lFqtaG+gn4ydQ==
X-Google-Smtp-Source: APXvYqx5HZ/YUb4LkRfOYZ6h7XL9aS4w0S6Hw0hi+5DF+hwgheHb+o6VpyBFs6OFlujmhWkWP+XGhw==
X-Received: by 2002:a1c:f102:: with SMTP id p2mr6053904wmh.126.1561709194665;
        Fri, 28 Jun 2019 01:06:34 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.165.245])
        by smtp.gmail.com with ESMTPSA id z19sm1472774wmi.7.2019.06.28.01.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 01:06:33 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v8 0/8] sched/deadline: fix cpusets bandwidth accounting
Date:   Fri, 28 Jun 2019 10:06:10 +0200
Message-Id: <20190628080618.522-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v8 of a series of patches, originally authored by Mathieu, with the intent
of fixing a long standing issue of SCHED_DEADLINE bandwidth accounting.
As originally reported by Steve [1], when hotplug and/or (certain)
cpuset reconfiguration operations take place, DEADLINE bandwidth
accounting information is lost since root domains are destroyed and
recreated.

Mathieu's approach is based on restoring bandwidth accounting info on
the newly created root domains by iterating through the (DEADLINE) tasks
belonging to the configured cpuset(s).

Apart from the usual rebase on top of cgroup/for-next, this version
brings in an important difference w.r.t. v7: cpuset_mutex conversion to
percpu_rwsem (as suggested by Peter) to deal with a performance
regression caused by the fact that grabbing the (v7) callback_lock raw
spinlock from sched_setscheduler() was in fact a bottleneck. The
conversion required some lock order changes and an rcu related mod.

So, this is (unfortunately) more than a small update. Hope it still
makes sense, though.

Set also available at

 https://github.com/jlelli/linux.git fixes/deadline/root-domain-accounting-v8

Thanks,

- Juri

[1] https://lkml.org/lkml/2016/2/3/966

Juri Lelli (6):
  cpuset: Rebuild root domain deadline accounting information
  sched/deadline: Fix bandwidth accounting at all levels after offline
    migration
  cgroup/cpuset: convert cpuset_mutex to percpu_rwsem
  cgroup/cpuset: Change cpuset_rwsem and hotplug lock order
  sched/core: Prevent race condition between cpuset and
    __sched_setscheduler()
  rcu/tree: Setschedule gp ktread to SCHED_FIFO outside of atomic region

Mathieu Poirier (2):
  sched/topology: Adding function partition_sched_domains_locked()
  sched/core: Streamlining calls to task_rq_unlock()

 include/linux/cgroup.h         |   1 +
 include/linux/cpuset.h         |  13 ++-
 include/linux/sched.h          |   5 +
 include/linux/sched/deadline.h |   8 ++
 include/linux/sched/topology.h |  10 ++
 kernel/cgroup/cgroup.c         |   2 +-
 kernel/cgroup/cpuset.c         | 163 +++++++++++++++++++++++++--------
 kernel/rcu/tree.c              |   6 +-
 kernel/sched/core.c            |  57 ++++++++----
 kernel/sched/deadline.c        |  63 +++++++++++++
 kernel/sched/sched.h           |   3 -
 kernel/sched/topology.c        |  30 +++++-
 12 files changed, 290 insertions(+), 71 deletions(-)

-- 
2.17.2

