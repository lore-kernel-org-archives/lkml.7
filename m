Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98259C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E41206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfDCIrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:47:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35889 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfDCIrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:47:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id y13so20203419wrd.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 01:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qrDUSDgGGS/5qX5PNBTtzmEP+L0tAtfFiAMhnD/UW2g=;
        b=kOsGHJeL5iEPUoklEHEIafVR7oUewpGHsqakmqmoAaTLwtRtDMyBrBP8KSr6spG0nd
         bTfj+Q94hap5q1fx9FYriGD5AQRRGSQz7suL61yWDqovsfYVwwIe+Rwox2ZBlDK6RoiO
         KgmXsxMXoz0FbofJU6/YMxub+4pLK5LXg0UY5WF/uU2bZXZq2q0hiYM/x+89MUFJE+Gd
         +1pJ/t6UuyOAg40pgBkEAivsAGFsbRXFb0PZY4oi3LGsX0ph2YzZF4cNexdTcceoLwe4
         jysr5pYP6OCFaCjHYlb9OkjO6IFOyANmTSKOClo+KMz+3JGOMwalf0un5PxwfuGGzAPf
         +Dzg==
X-Gm-Message-State: APjAAAVAp+cGFejGxW7M6XODCQii0TdX+xrHmzZvliNPZtPAuzKc/MvI
        t+L+JLFHiT0Q5m1cQygGn1iiTQgEmpA=
X-Google-Smtp-Source: APXvYqxZ40vibQmGdAZrFHfXZmz3oArszmiPb5lwFM/dRtnnbY2unQrt94n2W4rYGU2pQ8IZsi0y2A==
X-Received: by 2002:adf:efc3:: with SMTP id i3mr47217204wrp.92.1554281230253;
        Wed, 03 Apr 2019 01:47:10 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id o2sm12258081wrs.89.2019.04.03.01.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 01:47:09 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v7 0/7]  sched/deadline: fix cpusets bandwidth accounting
Date:   Wed,  3 Apr 2019 10:46:43 +0200
Message-Id: <20190403084650.4414-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v7 of a series of patches, originally authored by Mathieu, with the intent
of fixing a long standing issue of SCHED_DEADLINE bandwidth accounting.
As originally reported by Steve [1], when hotplug and/or (certain)
cpuset reconfiguration operations take place, DEADLINE bandwidth
accounting information is lost since root domains are destroyed and
recreated.

Mathieu's approach is based on restoring bandwidth accounting info on
the newly created root domains by iterating through the (DEADLINE) tasks
belonging to the configured cpuset(s).

Apart from the usual rebase on top of cgroup/for-next, changes worth of
notice are:

 - commented about potential problems w.r.t. userspace operations that
   grabs callback_lock (03/07 - peterz)
 - take cpuset_read_only_lock() before rq an pi locks, as to not
   introduce a dependency between the former and the latters; on !CONFIG_
   CPUSET cpuset_read_only(un)lock() (dis/en)ables irqs and preemption
   (04/07 - peterz)
 - make dl_add_task_root_domain() use !_irqsave (un)lock functions
 - also use __dl_add() to update root domain total_bw
 - 06/07 new patch; seq_show operations can be guarded by cpuset_mutex
   (peterz)
 - 07/07 new patch; deals with offline migrations (noticed the problem
   while testing)

Set also available at

 https://github.com/jlelli/linux.git fixes/deadline/root-domain-accounting-v7

Thanks,

- Juri

[1] https://lkml.org/lkml/2016/2/3/966

Juri Lelli (5):
  cgroup/cpuset: make callback_lock raw
  sched/core: Prevent race condition between cpuset and
    __sched_setscheduler()
  cpuset: Rebuild root domain deadline accounting information
  cgroup/cpuset: Use cpuset_mutex to protect seq_show operations
  sched/deadline: Fix bandwidth accounting at all levels after offline
    migration

Mathieu Poirier (2):
  sched/topology: Adding function partition_sched_domains_locked()
  sched/core: Streamlining calls to task_rq_unlock()

 include/linux/cgroup.h         |   1 +
 include/linux/cpuset.h         |  14 +++
 include/linux/sched.h          |   5 +
 include/linux/sched/deadline.h |   8 ++
 include/linux/sched/topology.h |  10 ++
 kernel/cgroup/cgroup.c         |   2 +-
 kernel/cgroup/cpuset.c         | 161 +++++++++++++++++++++++++--------
 kernel/sched/core.c            |  49 +++++++---
 kernel/sched/deadline.c        |  63 +++++++++++++
 kernel/sched/sched.h           |   3 -
 kernel/sched/topology.c        |  30 +++++-
 11 files changed, 286 insertions(+), 60 deletions(-)

-- 
2.17.2

