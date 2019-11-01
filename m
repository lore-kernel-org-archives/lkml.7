Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DB5CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC162080F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfKAH6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:58:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:16169 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfKAH6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:58:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 00:58:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,254,1569308400"; 
   d="scan'208";a="225962481"
Received: from yhuang-dev.sh.intel.com ([10.239.159.29])
  by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2019 00:58:27 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: [RFC 03/10] autonuma: Add NUMA_BALANCING_MEMORY_TIERING mode
Date:   Fri,  1 Nov 2019 15:57:20 +0800
Message-Id: <20191101075727.26683-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101075727.26683-1-ying.huang@intel.com>
References: <20191101075727.26683-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

With the advent of various new memory types, some machines will have
multiple memory types, e.g. DRAM and PMEM (persistent memory).
Because the performance of the different types of memory may be
different, the memory subsystem could be called memory tiering system.

In a typical memory tiering system, there are CPUs, fast memory and
slow memory in each physical NUMA node.  The CPUs and the fast memory
will be put in one logical node (called fast memory node), while the
slow memory will be put in another (faked) logical node (called slow
memory node).  And in autonuma, there are a set of mechanisms to
identify the pages recently accessed by the CPUs in a node and migrate
the pages to the node.  So the performance optimization to promote the
hot pages in slow memory node to the fast memory node in the memory
tiering system could be implemented based on the autonuma framework.

But the requirement of the hot page promotion in the memory tiering
system is different from that of the normal NUMA balancing in some
aspects.  E.g. for the hot page promotion, we can skip to scan fastest
memory node because we have nowhere to promote the hot pages to.  To
make autonuma works for both the normal NUMA balancing and the memory
tiering hot page promotion, we have defined a set of flags and made
the value of sysctl_numa_balancing_mode to be "OR" of these flags.
The flags are as follows,

- 0x0: NUMA_BALANCING_DISABLED
- 0x1: NUMA_BALANCING_NORMAL
- 0x2: NUMA_BALANCING_MEMORY_TIERING

NUMA_BALANCING_NORMAL enables the normal NUMA balancing across
sockets, while NUMA_BALANCING_MEMORY_TIERING enables the hot page
promotion across memory tiers.  They can be enabled individually or
together.  If all flags are cleared, the autonuma is disabled
completely.

The sysctl interface is extended accordingly in a backward compatible
way.

TODO:

- Update ABI document: Documentation/sysctl/kernel.txt

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/sched/sysctl.h | 5 +++++
 kernel/sched/core.c          | 9 +++------
 kernel/sysctl.c              | 7 ++++---
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 99ce6d728df7..5cfe38783c60 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -33,6 +33,11 @@ enum sched_tunable_scaling {
 };
 extern enum sched_tunable_scaling sysctl_sched_tunable_scaling;
 
+#define NUMA_BALANCING_DISABLED		0x0
+#define NUMA_BALANCING_NORMAL		0x1
+#define NUMA_BALANCING_MEMORY_TIERING	0x2
+
+extern int sysctl_numa_balancing_mode;
 extern unsigned int sysctl_numa_balancing_scan_delay;
 extern unsigned int sysctl_numa_balancing_scan_period_min;
 extern unsigned int sysctl_numa_balancing_scan_period_max;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427742a9..6f490e2fd45e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2169,6 +2169,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
+int sysctl_numa_balancing_mode;
 
 #ifdef CONFIG_NUMA_BALANCING
 
@@ -2184,20 +2185,16 @@ void set_numabalancing_state(bool enabled)
 int sysctl_numa_balancing(struct ctl_table *table, int write,
 			 void __user *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct ctl_table t;
 	int err;
-	int state = static_branch_likely(&sched_numa_balancing);
 
 	if (write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	t = *table;
-	t.data = &state;
-	err = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
+	err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (err < 0)
 		return err;
 	if (write)
-		set_numabalancing_state(state);
+		set_numabalancing_state(*(int *)table->data);
 	return err;
 }
 #endif
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 1beca96fb625..442acedb1fe7 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -129,6 +129,7 @@ static int __maybe_unused neg_one = -1;
 static int zero;
 static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
+static int __maybe_unused three = 3;
 static int __maybe_unused four = 4;
 static unsigned long zero_ul;
 static unsigned long one_ul = 1;
@@ -422,12 +423,12 @@ static struct ctl_table kern_table[] = {
 	},
 	{
 		.procname	= "numa_balancing",
-		.data		= NULL, /* filled in by handler */
-		.maxlen		= sizeof(unsigned int),
+		.data		= &sysctl_numa_balancing_mode,
+		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= sysctl_numa_balancing,
 		.extra1		= &zero,
-		.extra2		= &one,
+		.extra2		= &three,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_SCHED_DEBUG */
-- 
2.23.0

