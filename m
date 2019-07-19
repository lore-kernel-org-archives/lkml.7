Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214D3C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E820621852
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfGSOA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 10:00:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35648 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbfGSOA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:00:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so29142040wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 07:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fURSZsES8/FFy7omO0nwJ/wZ8WE0Q3uyMY9LgzNs6zc=;
        b=afyNTB/bulBhQhF22vlWr4pbvIoH1EBZocqjwVAd88onBDZYa1qTzdXa0xDT5/4Hv5
         9OMREslKRslUb5XEA4iII2VdO2SnhxcbGSEwujbTteOM1TxCa2DCqYzrfpAQmiBqQnB7
         hZcFwoobz5oBC2U44vguBDXpVGqTDw8kLqWidyZpU64SOIuDXjzMxrkH67BolxHB67AW
         eiMpbqlDRlH1zdT20hEDgPr09faWC+Q+GzOnSNapE5ffSJTfmGW4NlVhzqE5Hvj2SEPV
         UM8ZSeib9gk8+7laMr6yExD10eQZAKIA2Ho3Ck2optEvT9+5aQ5XymY74cYo+oFzAeJp
         tzYQ==
X-Gm-Message-State: APjAAAXiZMVKRrzSOBi5eBR0fsmLtIDCX+8rl9VPhbM28brSL+KI9oTh
        EwTM9VpIkQtZe8+hrd4/Zuxy7g==
X-Google-Smtp-Source: APXvYqyOvyKtmyz3QqXAkcudV0OvMUh00yVu9Qw9TWNYCzZ68HjF2KA6TDNewngTQqrc6ARv24zNCw==
X-Received: by 2002:a1c:7304:: with SMTP id d4mr47784756wmb.39.1563544825550;
        Fri, 19 Jul 2019 07:00:25 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id f10sm21276926wrs.22.2019.07.19.07.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 07:00:24 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        longman@redhat.com, dietmar.eggemann@arm.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v9 0/8] sched/deadline: fix cpusets bandwidth accounting
Date:   Fri, 19 Jul 2019 15:59:52 +0200
Message-Id: <20190719140000.31694-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v9 of a series of patches, originally authored by Mathieu, with the intent
of fixing a long standing issue of SCHED_DEADLINE bandwidth accounting.
As originally reported by Steve [1], when hotplug and/or (certain)
cpuset reconfiguration operations take place, DEADLINE bandwidth
accounting information is lost since root domains are destroyed and
recreated.

Mathieu's approach is based on restoring bandwidth accounting info on
the newly created root domains by iterating through the (DEADLINE) tasks
belonging to the configured cpuset(s).

Apart from the usual rebase on top of cgroup/for-next, this version

 - make cpuset_{can,cancel}_attach grab cpuset_rwsem for write (5/8 - Peter)
 - moves v8 8/8 to 7/8 for bisectability (Peter)
 - adds comment in changelog regarding normalize_rt_tasks() (8/8 - Peter)

Set also available at

 https://github.com/jlelli/linux.git fixes/deadline/root-domain-accounting-v9

Thanks,

- Juri

[1] https://lkml.org/lkml/2016/2/3/966

Juri Lelli (6):
  cpuset: Rebuild root domain deadline accounting information
  sched/deadline: Fix bandwidth accounting at all levels after offline
    migration
  cgroup/cpuset: convert cpuset_mutex to percpu_rwsem
  cgroup/cpuset: Change cpuset_rwsem and hotplug lock order
  rcu/tree: Setschedule gp ktread to SCHED_FIFO outside of atomic region
  sched/core: Prevent race condition between cpuset and
    __sched_setscheduler()

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

