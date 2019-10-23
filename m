Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC99DCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7C12086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406800AbfJWPir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:38:47 -0400
Received: from [217.140.110.172] ([217.140.110.172]:55190 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2403912AbfJWPip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:38:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A714A3E8;
        Wed, 23 Oct 2019 08:38:25 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 127083F718;
        Wed, 23 Oct 2019 08:38:23 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc:     lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org,
        mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com
Subject: [PATCH v4 0/2] sched/topology: Asymmetric topologies fixes
Date:   Wed, 23 Oct 2019 16:37:43 +0100
Message-Id: <20191023153745.19515-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got a nice splat while testing out the toggling of
sched_asym_cpucapacity, so this is a cpuset fix plus a topology patch.

Details are in the logs.

v2 changes:
  - Use static_branch_{inc,dec} rather than enable/disable

v3 changes:
  - New patch: add fix for empty cpumap in sched domain rebuild
  - Move static_branch_dec outside of RCU read-side section (Quentin)

v4 changes:
  - Patch 1/2: Directly tweak the cpuset array (Dietmar)
  - Patch 2/2: Add an example to the changelog (Dietmar)

Cheers,
Valentin

Valentin Schneider (2):
  sched/topology: Don't try to build empty sched domains
  sched/topology: Allow sched_asym_cpucapacity to be disabled

 kernel/cgroup/cpuset.c  |  3 ++-
 kernel/sched/topology.c | 11 +++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

--
2.22.0

