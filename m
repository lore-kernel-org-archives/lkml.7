Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F21EC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F4B207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfJNLrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 07:47:46 -0400
Received: from foss.arm.com ([217.140.110.172]:41490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbfJNLrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 07:47:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A4DE337;
        Mon, 14 Oct 2019 04:47:45 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (unknown [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4EE483F68E;
        Mon, 14 Oct 2019 04:47:44 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@qperret.net, stable@vger.kernel.org
Subject: [PATCH] sched/topology: Disable sched_asym_cpucapacity on domain destruction
Date:   Mon, 14 Oct 2019 12:47:10 +0100
Message-Id: <20191014114710.22142-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the static key is correctly initialized as being disabled, it will
remain forever enabled once turned on. This means that if we start with an
asymmetric system and hotplug out enough CPUs to end up with an SMP system,
the static key will remain set - which is obviously wrong. We should detect
this and turn off things like misfit migration and EAS wakeups.

Having that key enabled should also mandate

  per_cpu(sd_asym_cpucapacity, cpu) != NULL

for all CPUs, but this is obviously not true with the above.

On top of that, sched domain rebuilds first lead to attaching the NULL
domain to the affected CPUs, which means there will be a window where the
static key is set but the sd_asym_cpucapacity shortcut points to NULL even
if asymmetry hasn't been hotplugged out.

Disable the static key when destroying domains, and let
build_sched_domains() (re) enable it as needed.

Cc: <stable@vger.kernel.org>
Fixes: df054e8445a4 ("sched/topology: Add static_key for asymmetric CPU capacity optimizations")
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b5667a273bf6..c49ae57a0611 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2123,7 +2123,8 @@ static void detach_destroy_domains(const struct cpumask *cpu_map)
 {
 	int i;
 
+	static_branch_disable_cpuslocked(&sched_asym_cpucapacity);
+
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map)
 		cpu_attach_domain(NULL, &def_root_domain, i);
--
2.22.0

