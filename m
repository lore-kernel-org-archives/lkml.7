Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34501C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FCB208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfKUAQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:16:18 -0500
Received: from mga17.intel.com ([192.55.52.151]:36701 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfKUAPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:15:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 16:15:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="357620027"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga004.jf.intel.com with ESMTP; 20 Nov 2019 16:15:34 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 7CE65300B64; Wed, 20 Nov 2019 16:15:34 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Optimize perf stat for large number of events/cpus
Date:   Wed, 20 Nov 2019 16:15:10 -0800
Message-Id: <20191121001522.180827-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v8: Address review feedback. Only changes one patch.]

This patch kit optimizes perf stat for a large number of events 
on systems with many CPUs and PMUs.

Some profiling shows that the most overhead is doing IPIs to
all the target CPUs. We can optimize this by using sched_setaffinity
to set the affinity to a target CPU once and then doing
the perf operation for all events on that CPU. This requires
some restructuring, but cuts the set up time quite a bit.

In theory we could go further by parallelizing these setups
too, but that would be much more complicated and for now just batching it
per CPU seems to be sufficient. At some point with many more cores 
parallelization or a better bulk perf setup API might be needed though.

In addition perf does a lot of redundant /sys accesses with
many PMUs, which can be also expensve. This is also optimized.

On a large test case (>700 events with many weak groups) on a 94 CPU
system I go from

real	0m8.607s
user	0m0.550s
sys	0m8.041s

to 

real	0m3.269s
user	0m0.760s
sys	0m1.694s

so shaving ~6 seconds of system time, at slightly more cost
in perf stat itself. On a 4 socket system the savings
are more dramatic:

real	0m15.641s
user	0m0.873s
sys	0m14.729s

to 

real	0m4.493s
user	0m1.578s
sys	0m2.444s

so 11s difference in the user visible set up time.

Also available in 

git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc perf/stat-scale-11

v1: Initial post.
v2: Rebase. Fix some minor issues.
v3: Rebase. Address review feedback. Fix one minor issue
v4: Modified based on review feedback. Now it maintains
all_cpus per evlist. There is still a need for cpu_index iteration
to get the correct index for indexing the file descriptors.
Fix bug with unsorted cpu maps, now they are always sorted.
Some cleanups and refactoring.
v5: Split patches. Redo loop iteration again. Fix cpu map
merging for uncore. Remove duplicates from cpumaps. Add unit
tests.
v6: Address review feedback. Fix some bugs. Add more comments.
Merge one invalid patch split.
v7: Address review feedback. Fix python scripting (thanks 0day)
Minor updates.
v8: Address review feedback.

-Andi

