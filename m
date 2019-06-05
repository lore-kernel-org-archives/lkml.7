Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A00C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66A3206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfFELtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:49:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34607 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfFELtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:49:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so1598917wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 04:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Ue7OXtzKu1Kff0kNekLMtjlDJwlS2dW920UpK4s3Ms=;
        b=TCZG8lPvVDdqs/WNGs4b4/uBnx8MPnxI4ByTaNKVenD2KcQjcyttR6vQcJzvg60l7J
         YIvImRtXT5+wy+/oX7tPB74M31uXPJPS+SOqnjO9VpSUBTAt6dMTFxnZBGATHA+ZOdSS
         3rG3pE7T8Aq1TgAnWARnB2emL+7CfPH69AVWmE5mNZYOxeoUukVd8Tt73aRLG3+zKm8D
         6DMUwM/MmkJE+jEfOlTv47f6YKoGyGEhW4RFHKH7Oj0dZdgZxavibj7I2Wey3kPosglH
         e+XXqAUdOhrhBHOv2+B9w07/HwlFZgSgjM/NcJDIVm9o71kXZ+tZV4G2YbYQVvBEGR15
         H+dQ==
X-Gm-Message-State: APjAAAUUgiLoMMiU5vrJOM488MubkjVjBjLY+H96GUWcdro+Qbkfc1wr
        xzMV23oY8TtZi0FyRCVy4rTbDg==
X-Google-Smtp-Source: APXvYqzzwHQb34R7sFsjS5HGKPSwoEyCFLR1Wtv5JbBmSIVcnS1uLVQYiBHhDTy1DFXU4jHyMwncXA==
X-Received: by 2002:a1c:99ca:: with SMTP id b193mr8387665wme.31.1559735384686;
        Wed, 05 Jun 2019 04:49:44 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id h17sm17236079wrq.79.2019.06.05.04.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 04:49:44 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, bristot@redhat.com, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] sched/core: Fix cpu controller for !RT_GROUP_SCHED
Date:   Wed,  5 Jun 2019 13:49:35 +0200
Message-Id: <20190605114935.7683-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On !CONFIG_RT_GROUP_SCHED configurations it is currently not possible to
move RT tasks between cgroups to which cpu controller has been attached;
but it is oddly possible to first move tasks around and then make them
RT (setschedule to FIFO/RR).

E.g.:

  # mkdir /sys/fs/cgroup/cpu,cpuacct/group1
  # chrt -fp 10 $$
  # echo $$ > /sys/fs/cgroup/cpu,cpuacct/group1/tasks
  bash: echo: write error: Invalid argument
  # chrt -op 0 $$
  # echo $$ > /sys/fs/cgroup/cpu,cpuacct/group1/tasks
  # chrt -fp 10 $$
  # cat /sys/fs/cgroup/cpu,cpuacct/group1/tasks
  2345
  2598
  # chrt -p 2345
  pid 2345's current scheduling policy: SCHED_FIFO
  pid 2345's current scheduling priority: 10

Existing code comes with a comment saying the "we don't support RT-tasks
being in separate groups". Such comment is however stale and belongs to
pre-RT_GROUP_SCHED times. Also, it doesn't make much sense for
!RT_GROUP_ SCHED configurations, since checks related to RT bandwidth
are not performed at all in these cases.

Make moving RT tasks between cpu controller groups viable by removing
special case check for RT (and DEADLINE) tasks.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
Hi,

Although I'm pretty assertive in the changelog, I actually wonder what
am I missing here and why (if) current behavior is needed and makes
sense.

Any input?

Thanks,

Juri
---
 kernel/sched/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 29984d8c41f0..37386b8bd1ad 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6464,10 +6464,6 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 #ifdef CONFIG_RT_GROUP_SCHED
 		if (!sched_rt_can_attach(css_tg(css), task))
 			return -EINVAL;
-#else
-		/* We don't support RT-tasks being in separate groups */
-		if (task->sched_class != &fair_sched_class)
-			return -EINVAL;
 #endif
 		/*
 		 * Serialize against wake_up_new_task() such that if its
-- 
2.17.2

