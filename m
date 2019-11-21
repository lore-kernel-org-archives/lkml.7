Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077BCC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86FE20674
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKUPTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:19:39 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:41523 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUPTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:19:39 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 6C8521C0004;
        Thu, 21 Nov 2019 15:19:26 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 00/19] Modify zonelist to nodelist v1
Date:   Thu, 21 Nov 2019 23:17:52 +0800
Message-Id: <20191121151811.49742-1-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Motivation
----------
Currently if we want to iterate through all the nodes we have to
traverse all the zones from the zonelist.

So in order to reduce the number of loops required to traverse node,
this series of patches modified the zonelist to nodelist.

Two new macros have been introduced:
1) for_each_node_nlist
2) for_each_node_nlist_nodemask


Benefit
-------
1. For a NUMA system with N nodes, each node has M zones, the number
   of loops is reduced from N*M times to N times when traversing node.

2. The size of pg_data_t is much reduced.


Test Result
-----------
Currently I have only performed a simple page allocation benchmark
test on my laptop, and the results show that the performance of a
system with only one node is almost unaffected.


Others
------
Next I will do more performance testing and add it to the Test Result.

Since I don't currently have multiple node NUMA systems, I would be
grateful if anyone would like to test this series of patches.

I am still not sure this series of patches is on the right way so I
am sending this as an RFC. 

Any comments are highly appreciated.

Pengfei Li (19):
  mm, mmzone: modify zonelist to nodelist
  mm, hugetlb: use for_each_node in dequeue_huge_page_nodemask()
  mm, oom_kill: use for_each_node in constrained_alloc()
  mm, slub: use for_each_node in get_any_partial()
  mm, slab: use for_each_node in fallback_alloc()
  mm, vmscan: use for_each_node in do_try_to_free_pages()
  mm, vmscan: use first_node in throttle_direct_reclaim()
  mm, vmscan: pass pgdat to wakeup_kswapd()
  mm, vmscan: use for_each_node in shrink_zones()
  mm, page_alloc: use for_each_node in wake_all_kswapds()
  mm, mempolicy: use first_node in mempolicy_slab_node()
  mm, mempolicy: use first_node in mpol_misplaced()
  mm, page_alloc: use first_node in local_memory_node()
  mm, compaction: rename compaction_zonelist_suitable
  mm, mm_init: rename mminit_verify_zonelist
  mm, page_alloc: cleanup build_zonelists
  mm, memory_hotplug: cleanup online_pages()
  kernel, sysctl: cleanup numa_zonelist_order
  mm, mmzone: cleanup zonelist in comments

 arch/hexagon/mm/init.c           |   2 +-
 arch/ia64/include/asm/topology.h |   2 +-
 arch/x86/mm/numa.c               |   2 +-
 drivers/tty/sysrq.c              |   2 +-
 include/linux/compaction.h       |   2 +-
 include/linux/gfp.h              |  18 +-
 include/linux/mmzone.h           | 249 +++++++++++++------------
 include/linux/oom.h              |   4 +-
 include/linux/swap.h             |   2 +-
 include/trace/events/oom.h       |   9 +-
 init/main.c                      |   2 +-
 kernel/cgroup/cpuset.c           |   4 +-
 kernel/sysctl.c                  |   8 +-
 mm/compaction.c                  |  20 +-
 mm/hugetlb.c                     |  21 +--
 mm/internal.h                    |  13 +-
 mm/memcontrol.c                  |   2 +-
 mm/memory_hotplug.c              |  24 +--
 mm/mempolicy.c                   |  26 ++-
 mm/mm_init.c                     |  74 +++++---
 mm/mmzone.c                      |  30 ++-
 mm/oom_kill.c                    |  16 +-
 mm/page_alloc.c                  | 301 ++++++++++++++++---------------
 mm/slab.c                        |  13 +-
 mm/slub.c                        |  14 +-
 mm/vmscan.c                      | 149 ++++++++-------
 26 files changed, 518 insertions(+), 491 deletions(-)

-- 
2.23.0

