Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBC4CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F08020717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfJ2Jwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:52:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47732 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfJ2Jwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:52:31 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iPOAk-0004M9-Aq; Tue, 29 Oct 2019 10:52:18 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9B4B81C0073;
        Tue, 29 Oct 2019 10:52:17 +0100 (CET)
Date:   Tue, 29 Oct 2019 09:52:17 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/topology: Allow sched_asym_cpucapacity to
 be disabled
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Dietmar.Eggemann@arm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, hannes@cmpxchg.org,
        lizefan@huawei.com, morten.rasmussen@arm.com, qperret@google.com,
        tj@kernel.org, vincent.guittot@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191023153745.19515-3-valentin.schneider@arm.com>
References: <20191023153745.19515-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <157234273730.29376.11861956477066450978.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     e284df705cf1eeedb5ec3a66ed82d17a64659150
Gitweb:        https://git.kernel.org/tip/e284df705cf1eeedb5ec3a66ed82d17a64659150
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 23 Oct 2019 16:37:45 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Oct 2019 09:58:46 +01:00

sched/topology: Allow sched_asym_cpucapacity to be disabled

While the static key is correctly initialized as being disabled, it will
remain forever enabled once turned on. This means that if we start with an
asymmetric system and hotplug out enough CPUs to end up with an SMP system,
the static key will remain set - which is obviously wrong. We should detect
this and turn off things like misfit migration and capacity aware wakeups.

As Quentin pointed out, having separate root domains makes this slightly
trickier. We could have exclusive cpusets that create an SMP island - IOW,
the domains within this root domain will not see any asymmetry. This means
we can't just disable the key on domain destruction, we need to count how
many asymmetric root domains we have.

Consider the following example using Juno r0 which is 2+4 big.LITTLE, where
two identical cpusets are created: they both span both big and LITTLE CPUs:

    asym0    asym1
  [       ][       ]
   L  L  B  L  L  B

  $ cgcreate -g cpuset:asym0
  $ cgset -r cpuset.cpus=0,1,3 asym0
  $ cgset -r cpuset.mems=0 asym0
  $ cgset -r cpuset.cpu_exclusive=1 asym0

  $ cgcreate -g cpuset:asym1
  $ cgset -r cpuset.cpus=2,4,5 asym1
  $ cgset -r cpuset.mems=0 asym1
  $ cgset -r cpuset.cpu_exclusive=1 asym1

  $ cgset -r cpuset.sched_load_balance=0 .

(the CPU numbering may look odd because on the Juno LITTLEs are CPUs 0,3-5
and bigs are CPUs 1-2)

If we make one of those SMP (IOW remove asymmetry) by e.g. hotplugging its
big core, we would end up with an SMP cpuset and an asymmetric cpuset - the
static key must remain set, because we still have one asymmetric root domain.

With the above example, this could be done with:

  $ echo 0 > /sys/devices/system/cpu/cpu2/online

Which would result in:

    asym0   asym1
  [       ][    ]
   L  L  B  L  L

When both SMP and asymmetric cpusets are present, all CPUs will observe
sched_asym_cpucapacity being set (it is system-wide), but not all CPUs
observe asymmetry in their sched domain hierarchy:

  per_cpu(sd_asym_cpucapacity, <any CPU in asym0>) == <some SD at DIE level>
  per_cpu(sd_asym_cpucapacity, <any CPU in asym1>) == NULL

Change the simple key enablement to an increment, and decrement the key
counter when destroying domains that cover asymmetric CPUs.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Dietmar.Eggemann@arm.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: hannes@cmpxchg.org
Cc: lizefan@huawei.com
Cc: morten.rasmussen@arm.com
Cc: qperret@google.com
Cc: tj@kernel.org
Cc: vincent.guittot@linaro.org
Fixes: df054e8445a4 ("sched/topology: Add static_key for asymmetric CPU capacity optimizations")
Link: https://lkml.kernel.org/r/20191023153745.19515-3-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/topology.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9318acf..49b835f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2029,7 +2029,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	rcu_read_unlock();
 
 	if (has_asym)
-		static_branch_enable_cpuslocked(&sched_asym_cpucapacity);
+		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
 
 	if (rq && sched_debug_enabled) {
 		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
@@ -2124,8 +2124,12 @@ int sched_init_domains(const struct cpumask *cpu_map)
  */
 static void detach_destroy_domains(const struct cpumask *cpu_map)
 {
+	unsigned int cpu = cpumask_any(cpu_map);
 	int i;
 
+	if (rcu_access_pointer(per_cpu(sd_asym_cpucapacity, cpu)))
+		static_branch_dec_cpuslocked(&sched_asym_cpucapacity);
+
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map)
 		cpu_attach_domain(NULL, &def_root_domain, i);
