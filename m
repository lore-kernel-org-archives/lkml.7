Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99B4C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFC7214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfLKLjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:39:14 -0500
Received: from foss.arm.com ([217.140.110.172]:54966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfLKLjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 06:39:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 869661FB;
        Wed, 11 Dec 2019 03:39:13 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 365743F6CF;
        Wed, 11 Dec 2019 03:39:12 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qperret@google.com, qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: [PATCH v3 0/5] sched/fair: Task placement biasing using uclamp
Date:   Wed, 11 Dec 2019 11:38:46 +0000
Message-Id: <20191211113851.24241-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While uclamp restrictions currently only impact schedutil's frequency
selection, it would make sense to also let them impact CPU selection in
asymmetric topologies. This would let us steer specific tasks towards
certain CPU capacities regardless of their actual utilization - I give a
few examples in patch 4.

The first three patches are mainly cleanups, the meat of the thing is
in patches 4 and 5.

Note that this is in the same spirit as what Patrick had proposed for EAS
on Android [1]

[1]: https://android.googlesource.com/kernel/common/+/b61876ed122f816660fe49e0de1b7ee4891deaa2%5E%21

Revisions
=========

Changed in v3:

- Collect Reviewed-by
- (new patch) Remove uclamp_util() (Dietmar)
- Make uclamp_eff_value()'s return type unsigned long (Vincent)
- Reword find_energy_efficient_cpu() tweak changelog (Dietmar)

Changed in v2:

- Collect Reviewed-by

- Make uclamp_task_util() unconditionally use util_est (Quentin)
- Because of the above, move uclamp_task_util() to fair.c

- Split v1's 3/3 into
  - task_fits_capacity() tweak (v2's 3/4)
  - find_energy_efficient_cpu() tweak (v2's 4/4).

Cheers,
Valentin

Valentin Schneider (5):
  sched/uclamp: Remove uclamp_util()
  sched/uclamp: Make uclamp util helpers use and return UL values
  sched/uclamp: Rename uclamp_util_with() into uclamp_rq_util_with()
  sched/fair: Make task_fits_capacity() consider uclamp restrictions
  sched/fair: Make EAS wakeup placement consider uclamp restrictions

 kernel/sched/core.c              |  6 +++---
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/fair.c              | 28 +++++++++++++++++++++++++---
 kernel/sched/sched.h             | 24 ++++++++----------------
 4 files changed, 37 insertions(+), 23 deletions(-)

--
2.24.0

