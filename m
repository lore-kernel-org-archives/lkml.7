Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B014DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902052089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfKTR5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:57:31 -0500
Received: from foss.arm.com ([217.140.110.172]:43968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfKTR5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:57:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B86B1FB;
        Wed, 20 Nov 2019 09:57:30 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 414C23F6C4;
        Wed, 20 Nov 2019 09:57:29 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qperret@google.com, qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: [PATCH 0/3] sched/fair: Task placement biasing using uclamp
Date:   Wed, 20 Nov 2019 17:55:30 +0000
Message-Id: <20191120175533.4672-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While uclamp restrictions currently only impacts schedutil's frequency
selection, it would make sense to also let it impact CPU selection in
asymmetric topologies. This would let us steer specific tasks towards
certain CPU capacities regardless of their actual utilization - I give a
few examples in patch 3.

The first two patches are just paving the way for the meat of the thing
which is in patch 3.

Note that this is in the same spirit as what Patrick had proposed for EAS
on Android [1]

[1]: https://android.googlesource.com/kernel/common/+/b61876ed122f816660fe49e0de1b7ee4891deaa2%5E%21

Cheers,
Valentin

Valentin Schneider (3):
  sched/uclamp: Make uclamp_util_*() helpers use and return UL values
  sched/uclamp: Rename uclamp_util_*() into uclamp_rq_util_*()
  sched/fair: Consider uclamp for "task fits capacity" checks

 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/fair.c              | 11 +++++++++-
 kernel/sched/sched.h             | 35 ++++++++++++++++++++++----------
 3 files changed, 35 insertions(+), 13 deletions(-)

--
2.22.0

