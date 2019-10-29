Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7E7CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F53620717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfJ2Jwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:52:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47697 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfJ2Jw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:52:29 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iPOAk-0004MA-Hl; Tue, 29 Oct 2019 10:52:18 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 230E71C047B;
        Tue, 29 Oct 2019 10:52:18 +0100 (CET)
Date:   Tue, 29 Oct 2019 09:52:17 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/topology: Don't try to build empty sched domains
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar.Eggemann@arm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, hannes@cmpxchg.org,
        lizefan@huawei.com, morten.rasmussen@arm.com, qperret@google.com,
        tj@kernel.org, vincent.guittot@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191023153745.19515-2-valentin.schneider@arm.com>
References: <20191023153745.19515-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <157234273774.29376.13053377889800055975.tip-bot2@tip-bot2>
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

Commit-ID:     cd1cb3350561d2bf544ddfef76fbf0b1c9c7178f
Gitweb:        https://git.kernel.org/tip/cd1cb3350561d2bf544ddfef76fbf0b1c9c7178f
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 23 Oct 2019 16:37:44 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Oct 2019 09:58:45 +01:00

sched/topology: Don't try to build empty sched domains

Turns out hotplugging CPUs that are in exclusive cpusets can lead to the
cpuset code feeding empty cpumasks to the sched domain rebuild machinery.

This leads to the following splat:

    Internal error: Oops: 96000004 [#1] PREEMPT SMP
    Modules linked in:
    CPU: 0 PID: 235 Comm: kworker/5:2 Not tainted 5.4.0-rc1-00005-g8d495477d62e #23
    Hardware name: ARM Juno development board (r0) (DT)
    Workqueue: events cpuset_hotplug_workfn
    pstate: 60000005 (nZCv daif -PAN -UAO)
    pc : build_sched_domains (./include/linux/arch_topology.h:23 kernel/sched/topology.c:1898 kernel/sched/topology.c:1969)
    lr : build_sched_domains (kernel/sched/topology.c:1966)
    Call trace:
    build_sched_domains (./include/linux/arch_topology.h:23 kernel/sched/topology.c:1898 kernel/sched/topology.c:1969)
    partition_sched_domains_locked (kernel/sched/topology.c:2250)
    rebuild_sched_domains_locked (./include/linux/bitmap.h:370 ./include/linux/cpumask.h:538 kernel/cgroup/cpuset.c:955 kernel/cgroup/cpuset.c:978 kernel/cgroup/cpuset.c:1019)
    rebuild_sched_domains (kernel/cgroup/cpuset.c:1032)
    cpuset_hotplug_workfn (kernel/cgroup/cpuset.c:3205 (discriminator 2))
    process_one_work (./arch/arm64/include/asm/jump_label.h:21 ./include/linux/jump_label.h:200 ./include/trace/events/workqueue.h:114 kernel/workqueue.c:2274)
    worker_thread (./include/linux/compiler.h:199 ./include/linux/list.h:268 kernel/workqueue.c:2416)
    kthread (kernel/kthread.c:255)
    ret_from_fork (arch/arm64/kernel/entry.S:1167)
    Code: f860dae2 912802d6 aa1603e1 12800000 (f8616853)

The faulty line in question is:

  cap = arch_scale_cpu_capacity(cpumask_first(cpu_map));

and we're not checking the return value against nr_cpu_ids (we shouldn't
have to!), which leads to the above.

Prevent generate_sched_domains() from returning empty cpumasks, and add
some assertion in build_sched_domains() to scream bloody murder if it
happens again.

The above splat was obtained on my Juno r0 with the following reproducer:

  $ cgcreate -g cpuset:asym
  $ cgset -r cpuset.cpus=0-3 asym
  $ cgset -r cpuset.mems=0 asym
  $ cgset -r cpuset.cpu_exclusive=1 asym

  $ cgcreate -g cpuset:smp
  $ cgset -r cpuset.cpus=4-5 smp
  $ cgset -r cpuset.mems=0 smp
  $ cgset -r cpuset.cpu_exclusive=1 smp

  $ cgset -r cpuset.sched_load_balance=0 .

  $ echo 0 > /sys/devices/system/cpu/cpu4/online
  $ echo 0 > /sys/devices/system/cpu/cpu5/online

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
Fixes: 05484e098448 ("sched/topology: Add SD_ASYM_CPUCAPACITY flag detection")
Link: https://lkml.kernel.org/r/20191023153745.19515-2-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/cgroup/cpuset.c  | 3 ++-
 kernel/sched/topology.c | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c52bc91..c87ee64 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -798,7 +798,8 @@ static int generate_sched_domains(cpumask_var_t **domains,
 		    cpumask_subset(cp->cpus_allowed, top_cpuset.effective_cpus))
 			continue;
 
-		if (is_sched_load_balance(cp))
+		if (is_sched_load_balance(cp) &&
+		    !cpumask_empty(cp->effective_cpus))
 			csa[csn++] = cp;
 
 		/* skip @cp's subtree if not a partition root */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b5667a2..9318acf 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1948,7 +1948,7 @@ next_level:
 static int
 build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *attr)
 {
-	enum s_alloc alloc_state;
+	enum s_alloc alloc_state = sa_none;
 	struct sched_domain *sd;
 	struct s_data d;
 	struct rq *rq = NULL;
@@ -1956,6 +1956,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	struct sched_domain_topology_level *tl_asym;
 	bool has_asym = false;
 
+	if (WARN_ON(cpumask_empty(cpu_map)))
+		goto error;
+
 	alloc_state = __visit_domain_allocation_hell(&d, cpu_map);
 	if (alloc_state != sa_rootdomain)
 		goto error;
