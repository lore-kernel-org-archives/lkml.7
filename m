Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D51C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5742087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfD2ID3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:03:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:59379 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfD2ID3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:03:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 01:03:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="139699397"
Received: from shbuild999.sh.intel.com ([10.239.146.112])
  by orsmga006.jf.intel.com with ESMTP; 29 Apr 2019 01:03:26 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Eric W Biederman <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ying Huang <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [RFC PATCH 0/3] latencytop lock usage improvement 
Date:   Mon, 29 Apr 2019 16:03:28 +0800
Message-Id: <1556525011-28022-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

latencytop is a very nice tool for tracing system latency hotspots, and
we heavily use it in our LKP test suites.

However, we found in some benchmark tests, there are very severe lock
contentions which hits 70%+ of CPU cycles in perf profile, especially
for benchmark involving massive process scheduling on platforms with 
many CPUs, like running hackbench 
  "hackbench -g 1408 --process --pipe -l 1875 -s 1024"
on a 2 sockets Xeon E5-2699 machine (44 Cores/88 CPUs) with 64GB RAM.

And due to that, we have to explicitly disable latencytop for those test
cases.

By checking the code, we found latencytop use one global spinlock to
cover the latency data updating for both global data and per-task ones.

So initially we tried splitting single lock into one global lock and
per-task lock for better lock granularity, but the lock contention is
only reduced slightly (only 1% drop for perf profile). The reason is
the contention is still severe, as the benchmarks cause massive
scheduling on the 88 CPUs, and every schedule-in call will try to
acquire the lock.

Then we tried to reduce the operations inside the latency_lock's 
protection (between the spin_lock_irqsave/raw_spin_unlock_irqrestore
pair), and also there is only very small improvement, and lock contention
keeps high.

At last,  we tried adding one extra lazy mode which only update the global
latency data when a task exit, while still updating the per-task data
in real time. This reduces the lock contention from 70%+ to less than
5% while boost that hackbench case's throughput by 276%. 

Please help to review, thanks!

Patch 1/3 adds the missing sysctl description for "latencytop" and I
think it could be merged independently.

Patch 2/3 splits latency_lock to global lock and per task lock.
And actually, a more aggressive thought is the per-task lock may not be
needed as the per-task data is only updated at the enqueueing time for
a task, which implies no race condtion for it.

Patch 3/3 implements the lazy mode and update the document.

Thanks,
Feng


Feng Tang (3):
  kernel/sysctl: add description for "latencytop"
  latencytop: split latency_lock to global lock and per task lock
  latencytop: add a lazy mode for updating global data

 Documentation/sysctl/kernel.txt | 23 ++++++++++++++++++++
 include/linux/latencytop.h      |  5 +++++
 include/linux/sched.h           |  1 +
 init/init_task.c                |  3 +++
 kernel/exit.c                   |  2 ++
 kernel/fork.c                   |  4 ++++
 kernel/latencytop.c             | 47 +++++++++++++++++++++++++++++++++++------
 7 files changed, 78 insertions(+), 7 deletions(-)

-- 
2.7.4

