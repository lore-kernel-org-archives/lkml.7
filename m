Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F408DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D433522D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfICJqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:46:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:11447 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbfICJqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:46:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 02:46:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,462,1559545200"; 
   d="scan'208";a="187200218"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Sep 2019 02:46:05 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i55O1-000FcR-BB; Tue, 03 Sep 2019 17:46:05 +0800
Date:   Tue, 3 Sep 2019 17:45:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     kbuild-all@01.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 3/3] task: Clean house now that tasks on the runqueue are
 rcu protected
Message-ID: <201909031743.p1GcoXXk%lkp@intel.com>
References: <8736het20c.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736het20c.fsf_-_@x220.int.ebiederm.org>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Eric,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.3-rc7 next-20190902]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Eric-W-Biederman/task-Making-tasks-on-the-runqueue-rcu-protected/20190903-130546
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> kernel/sched/membarrier.c:74:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> kernel/sched/membarrier.c:74:21: sparse:    struct task_struct [noderef] <asn:4> *
>> kernel/sched/membarrier.c:74:21: sparse:    struct task_struct *
   kernel/sched/membarrier.c:153:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/membarrier.c:153:21: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/membarrier.c:153:21: sparse:    struct task_struct *

vim +74 kernel/sched/membarrier.c

    32	
    33	static int membarrier_global_expedited(void)
    34	{
    35		int cpu;
    36		bool fallback = false;
    37		cpumask_var_t tmpmask;
    38	
    39		if (num_online_cpus() == 1)
    40			return 0;
    41	
    42		/*
    43		 * Matches memory barriers around rq->curr modification in
    44		 * scheduler.
    45		 */
    46		smp_mb();	/* system call entry is not a mb. */
    47	
    48		/*
    49		 * Expedited membarrier commands guarantee that they won't
    50		 * block, hence the GFP_NOWAIT allocation flag and fallback
    51		 * implementation.
    52		 */
    53		if (!zalloc_cpumask_var(&tmpmask, GFP_NOWAIT)) {
    54			/* Fallback for OOM. */
    55			fallback = true;
    56		}
    57	
    58		cpus_read_lock();
    59		for_each_online_cpu(cpu) {
    60			struct task_struct *p;
    61	
    62			/*
    63			 * Skipping the current CPU is OK even through we can be
    64			 * migrated at any point. The current CPU, at the point
    65			 * where we read raw_smp_processor_id(), is ensured to
    66			 * be in program order with respect to the caller
    67			 * thread. Therefore, we can skip this CPU from the
    68			 * iteration.
    69			 */
    70			if (cpu == raw_smp_processor_id())
    71				continue;
    72	
    73			rcu_read_lock();
  > 74			p = rcu_dereference(cpu_rq(cpu)->curr);
    75			if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
    76					   MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
    77				if (!fallback)
    78					__cpumask_set_cpu(cpu, tmpmask);
    79				else
    80					smp_call_function_single(cpu, ipi_mb, NULL, 1);
    81			}
    82			rcu_read_unlock();
    83		}
    84		if (!fallback) {
    85			preempt_disable();
    86			smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
    87			preempt_enable();
    88			free_cpumask_var(tmpmask);
    89		}
    90		cpus_read_unlock();
    91	
    92		/*
    93		 * Memory barrier on the caller thread _after_ we finished
    94		 * waiting for the last IPI. Matches memory barriers around
    95		 * rq->curr modification in scheduler.
    96		 */
    97		smp_mb();	/* exit from system call is not a mb */
    98		return 0;
    99	}
   100	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
