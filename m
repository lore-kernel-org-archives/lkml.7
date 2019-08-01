Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F55C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BC320B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="alHXwPPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbfHAOkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:40:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40049 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfHAOkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:40:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so73852086wrl.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 07:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jTtPyh0pLjeS+7FwsPfqe3t6PZDMm4TOnO3f+Npee9U=;
        b=alHXwPPiKAReLv0xgnxZfNo06Zj573Cox9QqRDxIkXDTx//g8is3ij40ditP4v8Wbf
         1blh0f6yEg0Mk7DL0rcI+5KrEosnfg2GumSvdpe7lUvK4jaZm9losqy5z6xviP/RmxEU
         X5OiF+5zyApe+4SO/SDdj72yRYyL2jYMkxXptkufLPpX6/ZvdtbiUniT91hOmck+amIr
         atfHDdeklUtNv6E7MCSp0421TjHjvU8yz8U5aYyrLbX5ZzgNhH/4nF/O/Ag0ccN8eluL
         5JPy7kHiATyHVn6+MDTqczbm/RAup2/+wqRYuDP3/0ez1R3OCZ2O8Mgrj9hiXyohEdqf
         D0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jTtPyh0pLjeS+7FwsPfqe3t6PZDMm4TOnO3f+Npee9U=;
        b=r11eAR5Rk5KZGSHqyYBwhsz9yUBex+1TxXcYG4vzzSesJ7ZM0cOQ9OLwnklCldznOD
         UDC2PP4pVOXWiEYYlvZ+BWJ8VVGXVgJplYgRQLXjwrBtxnwV3np+Hmay5bCUJ/NjdlKr
         RUVH3/j+lVSxi2gCURaS7Bj1mln12QZbX9t3vNC9SU5eXYiWKzIHTNOa03r1Ky9kU/83
         L1b+S8cHnxz2vUEHcNILPza1r5/LuuWTCwBpQwqujkUXnmBbPEl8g0GEdjyV0oTQ8sq9
         NZ9xe+/T6EnruK/51MsDXPtr8Y7P/QOqPTKF5gZwb/Xh7+Pon20QLr6T1q8mmShY5eAD
         pq6g==
X-Gm-Message-State: APjAAAXJIBqCg+X/M9s8cuZB9ay1PQhCnlwMYj+LL6laZpPbeQ0S0qqy
        9zApti26NgUOTaFWTQ7LG+3itOHIVk0=
X-Google-Smtp-Source: APXvYqxJO0NYhHbB6Moa6bKU45CQD364qfwUcby2Vljnis1Gu8kAw/I69dDoblBkE6NMvMRYbVH+Vw==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr92559255wrm.230.1564670429653;
        Thu, 01 Aug 2019 07:40:29 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9865:5ad1:5ff3:80c])
        by smtp.gmail.com with ESMTPSA id y10sm58768873wmj.2.2019.08.01.07.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 07:40:29 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 0/8] sched/fair: rework the CFS load balance
Date:   Thu,  1 Aug 2019 16:40:16 +0200
Message-Id: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several wrong task placement have been raised with the current load
balance algorithm but their fixes are not always straight forward and
end up with using biased values to force migrations. A cleanup and rework
of the load balance will help to handle such UCs and enable to fine grain
the behavior of the scheduler for other cases.

Patch 1 has already been sent separatly and only consolidate asym policy
in one place and help the review of the changes in load_balance.

Patch 2 renames the sum of h_nr_running in stats.

Patch 3 removes meaningless imbalance computation to make review of
patch 4 easier.

Patch 4 reworks load_balance algorithm and fixes some wrong task placement
but try to stay conservative.

Patch 5 add the sum of nr_running to monitor non cfs tasks and take that
into account when pulling tasks.

Patch 6 replaces runnable_load by load now that the metrics is only used
when overloaded.

Patch 7 improves the spread of tasks at the 1st scheduling level.

Patch 8 uses utilization instead of load in all steps of misfit task
path.

Some benchmarks results based on 8 iterations of each tests:
- small arm64 dual quad cores system

           tip/sched/core        w/ this patchset    improvement
schedpipe      54981 +/-0.36%        55459 +/-0.31%   (+0.97%)

hackbench
1 groups       0.906 +/-2.34%        0.906 +/-2.88%   (+0.06%)

- large arm64 2 nodes / 224 cores system

           tip/sched/core        w/ this patchset    improvement
schedpipe     125665 +/-0.61%       125455 +/-0.62%   (-0.17%)

hackbench -l (256000/#grp) -g #grp
1 groups      15.263 +/-3.53%       13.776 +/-3.30%   (+9.74%)
4 groups       5.852 +/-0.57%        5.340 +/-8.03%   (+8.75%)
16 groups      3.097 +/-1.08%        3.246 +/-0.97%   (-4.81%)
32 groups      2.882 +/-1.04%        2.845 +/-1.02%   (+1.29%)
64 groups      2.809 +/-1.30%        2.712 +/-1.17%   (+3.45%)
128 groups     3.129 +/-9.74%        2.813 +/-6.22%   (+9.11%)
256 groups     3.559 +/-11.07%       3.020 +/-1.75%  (+15.15%)

dbench
1 groups     330.897 +/-0.27%      330.612 +/-0.77%   (-0.09%)
4 groups     932.922 +/-0.54%      941.817 +/*1.10%   (+0.95%)
16 groups   1932.346 +/-1.37%     1962.944 +/-0.62%   (+1.58%)
32 groups   2251.079 +/-7.93%     2418.531 +/-0.69%   (+7.44%)
64 groups   2104.114 +/-9.67%     2348.698 +/-11.24% (+11.62%)
128 groups  2093.756 +/-7.26%     2278.156 +/-9.74%   (+8.81%)
256 groups  1216.736 +/-2.46%     1665.774 +/-4.68%  (+36.91%)

tip/sched/core sha1:
  a1dc0446d649 ('sched/core: Silence a warning in sched_init()')

Changes since v1:
- fixed some bugs
- Used switch case
- Renamed env->src_grp_type to env->balance_type
- split patches in smaller ones
- added comments

Vincent Guittot (8):
  sched/fair: clean up asym packing
  sched/fair: rename sum_nr_running to sum_h_nr_running
  sched/fair: remove meaningless imbalance calculation
  sched/fair: rework load_balance
  sched/fair: use rq->nr_running when balancing load
  sched/fair: use load instead of runnable load
  sched/fair: evenly spread tasks when not overloaded
  sched/fair: use utilization to select misfit task

 kernel/sched/fair.c  | 769 ++++++++++++++++++++++++++++-----------------------
 kernel/sched/sched.h |   2 +-
 2 files changed, 419 insertions(+), 352 deletions(-)

-- 
2.7.4

