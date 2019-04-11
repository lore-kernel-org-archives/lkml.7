Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF967C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87688217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfDKD53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:57:29 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:41519 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726564AbfDKD51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:57:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TP0I5rB_1554955031;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TP0I5rB_1554955031)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Apr 2019 11:57:21 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
Date:   Thu, 11 Apr 2019 11:56:50 +0800
Message-Id: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


With Dave Hansen's patches merged into Linus's tree

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c221c0b0308fd01d9fb33a16f64d2fd95f8830a4

PMEM could be hot plugged as NUMA node now.  But, how to use PMEM as NUMA node
effectively and efficiently is still a question. 

There have been a couple of proposals posted on the mailing list [1] [2] [3].


Changelog
=========
v1 --> v2:
* Dropped the default allocation node mask.  The memory placement restriction
  could be achieved by mempolicy or cpuset.
* Dropped the new mempolicy since its semantic is not that clear yet.
* Dropped PG_Promote flag.
* Defined N_CPU_MEM nodemask for the nodes which have both CPU and memory.
* Extended page_check_references() to implement "twice access" check for
  anonymous page in NUMA balancing path.
* Reworked the memory demotion code.

v1: https://lore.kernel.org/linux-mm/1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com/


Design
======
Basically, the approach is aimed to spread data from DRAM (closest to local
CPU) down further to PMEM and disk (typically assume the lower tier storage
is slower, larger and cheaper than the upper tier) by their hotness.  The
patchset tries to achieve this goal by doing memory promotion/demotion via
NUMA balancing and memory reclaim as what the below diagram shows:

    DRAM <--> PMEM <--> Disk
      ^                   ^
      |-------------------|
               swap

When DRAM has memory pressure, demote pages to PMEM via page reclaim path.
Then NUMA balancing will promote pages to DRAM as long as the page is referenced
again.  The memory pressure on PMEM node would push the inactive pages of PMEM 
to disk via swap.

The promotion/demotion happens only between "primary" nodes (the nodes have
both CPU and memory) and PMEM nodes.  No promotion/demotion between PMEM nodes
and promotion from DRAM to PMEM and demotion from PMEM to DRAM.

The HMAT is effectively going to enforce "cpu-less" nodes for any memory range
that has differentiated performance from the conventional memory pool, or
differentiated performance for a specific initiator, per Dan Williams.  So,
assuming PMEM nodes are cpuless nodes sounds reasonable.

However, cpuless nodes might be not PMEM nodes.  But, actually, memory
promotion/demotion doesn't care what kind of memory will be the target nodes,
it could be DRAM, PMEM or something else, as long as they are the second tier
memory (slower, larger and cheaper than regular DRAM), otherwise it sounds
pointless to do such demotion.

Defined "N_CPU_MEM" nodemask for the nodes which have both CPU and memory in
order to distinguish with cpuless nodes (memory only, i.e. PMEM nodes) and
memoryless nodes (some architectures, i.e. Power, may have memoryless nodes).
Typically, memory allocation would happen on such nodes by default unless
cpuless nodes are specified explicitly, cpuless nodes would be just fallback
nodes, so they are also as known as "primary" nodes in this patchset.  With
two tier memory system (i.e. DRAM + PMEM), this sounds good enough to
demonstrate the promotion/demotion approach for now, and this looks more
architecture-independent.  But it may be better to construct such node mask
by reading hardware information (i.e. HMAT), particularly for more complex
memory hierarchy.

To reduce memory thrashing and PMEM bandwidth pressure, promote twice faulted
page in NUMA balancing.  Implement "twice access" check by extending
page_check_references() for anonymous pages.

When doing demotion, demote to the less-contended local PMEM node.  If the
local PMEM node is contended (i.e. migrate_pages() returns -ENOMEM), just do
swap instead of demotion.  To make things simple, demotion to the remote PMEM
node is not allowed for now if the local PMEM node is online.  If the local
PMEM node is not online, just demote to the remote one.  If no PMEM node online,
just do normal swap.

Anonymous page only for the time being since NUMA balancing can't promote
unmapped page cache.

Added vmstat counters for pgdemote_kswapd, pgdemote_direct and
numa_pages_promoted.

There are definitely still some details need to be sorted out, for example,
shall respect to mempolicy in demotion path, etc.

Any comment is welcome.


Test
====
The stress test was done with mmtests + applications workload (i.e. sysbench,
grep, etc).

Generate memory pressure by running mmtest's usemem-stress-numa-compact,
then run other applications as workload to stress the promotion and demotion
path.  The machine was still alive after the stress test had been running for
~30 hours.  The /proc/vmstat also shows:

...
pgdemote_kswapd 3316563
pgdemote_direct 1930721
...
numa_pages_promoted 81838


TODO
====
1. Promote page cache. There are a couple of ways to handle this in kernel,
   i.e. promote via active LRU in reclaim path on PMEM node, or promote in
   mark_page_accessed().

2. Promote/demote HugeTLB. Now HugeTLB is not on LRU and NUMA balancing just
   skips it.

3. May place kernel pages (i.e. page table, slabs, etc) on DRAM only.


[1]: https://lore.kernel.org/linux-mm/20181226131446.330864849@intel.com/
[2]: https://lore.kernel.org/linux-mm/20190321200157.29678-1-keith.busch@intel.com/
[3]: https://lore.kernel.org/linux-mm/20190404071312.GD12864@dhcp22.suse.cz/T/#me1c1ed102741ba945c57071de9749e16a76e9f3d


Yang Shi (9):
      mm: define N_CPU_MEM node states
      mm: page_alloc: make find_next_best_node find return cpuless node
      mm: numa: promote pages to DRAM when it gets accessed twice
      mm: migrate: make migrate_pages() return nr_succeeded
      mm: vmscan: demote anon DRAM pages to PMEM node
      mm: vmscan: don't demote for memcg reclaim
      mm: vmscan: check if the demote target node is contended or not
      mm: vmscan: add page demotion counter
      mm: numa: add page promotion counter

 drivers/base/node.c            |   2 +
 include/linux/gfp.h            |  12 +++
 include/linux/migrate.h        |   6 +-
 include/linux/mmzone.h         |   3 +
 include/linux/nodemask.h       |   3 +-
 include/linux/vm_event_item.h  |   3 +
 include/linux/vmstat.h         |   1 +
 include/trace/events/migrate.h |   3 +-
 mm/compaction.c                |   3 +-
 mm/debug.c                     |   1 +
 mm/gup.c                       |   4 +-
 mm/huge_memory.c               |  15 ++++
 mm/internal.h                  | 105 +++++++++++++++++++++++++
 mm/memory-failure.c            |   7 +-
 mm/memory.c                    |  25 ++++++
 mm/memory_hotplug.c            |  10 ++-
 mm/mempolicy.c                 |   7 +-
 mm/migrate.c                   |  33 +++++---
 mm/page_alloc.c                |  19 +++--
 mm/vmscan.c                    | 262 +++++++++++++++++++++++++++++++++++++++++----------------------
 mm/vmstat.c                    |  14 +++-
 21 files changed, 418 insertions(+), 120 deletions(-)

