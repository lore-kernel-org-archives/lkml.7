Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1DDC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F0D2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKOSNY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:13:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44270 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfKOSNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:13:24 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVg5i-00051Y-UY; Fri, 15 Nov 2019 19:13:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6C7BE1C08AC;
        Fri, 15 Nov 2019 19:13:06 +0100 (CET)
Date:   Fri, 15 Nov 2019 18:13:06 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/topology, cpuset: Account for housekeeping
 CPUs to avoid empty cpumasks
Cc:     mkoutny@suse.com, Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar.Eggemann@arm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, hannes@cmpxchg.org,
        lizefan@huawei.com, morten.rasmussen@arm.com, qperret@google.com,
        tj@kernel.org, vincent.guittot@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191104003906.31476-1-valentin.schneider@arm.com>
References: <20191104003906.31476-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <157384158622.12247.6135151696743651397.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     48a723d23b0d957e5b5861b974864e53c6841de8
Gitweb:        https://git.kernel.org/tip/48a723d23b0d957e5b5861b974864e53c6841de8
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 04 Nov 2019 00:39:06 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Nov 2019 11:02:20 +01:00

sched/topology, cpuset: Account for housekeeping CPUs to avoid empty cpumasks

Michal noted that a cpuset's effective_cpus can be a non-empy mask, but
because of the masking done with housekeeping_cpumask(HK_FLAG_DOMAIN)
further down the line, we can still end up with an empty cpumask being
passed down to partition_sched_domains_locked().

Do the proper thing and don't just check the mask is non-empty - check
that its intersection with housekeeping_cpumask(HK_FLAG_DOMAIN) is
non-empty.

Reported-by: Michal Koutný <mkoutny@suse.com>
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
Fixes: cd1cb3350561 ("sched/topology: Don't try to build empty sched domains")
Link: https://lkml.kernel.org/r/20191104003906.31476-1-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/cgroup/cpuset.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c87ee64..e4c1078 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -798,8 +798,14 @@ static int generate_sched_domains(cpumask_var_t **domains,
 		    cpumask_subset(cp->cpus_allowed, top_cpuset.effective_cpus))
 			continue;
 
+		/*
+		 * Skip cpusets that would lead to an empty sched domain.
+		 * That could be because effective_cpus is empty, or because
+		 * it's only spanning CPUs outside the housekeeping mask.
+		 */
 		if (is_sched_load_balance(cp) &&
-		    !cpumask_empty(cp->effective_cpus))
+		    cpumask_intersects(cp->effective_cpus,
+				       housekeeping_cpumask(HK_FLAG_DOMAIN)))
 			csa[csn++] = cp;
 
 		/* skip @cp's subtree if not a partition root */
