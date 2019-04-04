Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B11FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1C920820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="BezHIDG2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2D9wkEza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfDDCLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:11:12 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50557 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbfDDCJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:09:46 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7C3F3220D4;
        Wed,  3 Apr 2019 22:01:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 22:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:reply-to:mime-version
        :content-transfer-encoding; s=fm3; bh=C86YDs4SbMweOs3My3Kcqku/Wg
        45b/kZ9T+M5WE8h/k=; b=BezHIDG27dmJKK8ben7d+w2Hbxo59duzUMNwZiAcQj
        h8eiNS0AJw4oYxDlkH6spbEBFkNAqouhSDFrbRPp1b5qKIAB8X55erf7aUFHL1uR
        MRO1rMme837OOdOmCJze3uLO3TSM1Z+Jb7qGakzbxOV0brRi1RmxyeDNkOwbdiv7
        ny3wCvTNpa6XkHKbFXyhxms4eQp0lYfIIJeNr1EbjVU0IvJTa42cBerEBeqNJJ1m
        Rl3rj8pWmKjUKC1VrmKVezHRfynSd9PHxf6D6wrCShc1D/eiIl2sAmtdhBERCeUI
        DJcR4aZCFtZWGtcWfMtesc7FZAMp2gEOmwOE0R9kSWug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:reply-to:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=C86YDs
        4SbMweOs3My3Kcqku/Wg45b/kZ9T+M5WE8h/k=; b=2D9wkEzacbTP94DOSCBioG
        Fkaxrz7mEee+hJHZwZgpoo4XlLJ+ojQ4WWgyEI0JWjNEuW0fIEJI4ajdxItc52wY
        TIwyPbF3STX05D40CTQyPh4mAcQ7iyJ2LeUV1ASFNQGJNKek73TGktJZxulEWF3q
        TN5fNDy2aSYPxWBvh/512RlMlS/X0o49DLPnubskZHqhBULdowG9PIIRfgp6ayj8
        uuioKrYdImPEq57eY+SI18qNX49ulr9sqoHNd/yjzXBHDVzhncypHG9EeQ/AtGoj
        nnJ9e2OE9d+alQejU1DBi1wwsXJKALpKLDku0yWIwnUXMZ51qNXfzeXXr7CUKEHg
        ==
X-ME-Sender: <xms:aGWlXNqmLK-x2EBUKKvzZsa2JRZ2yD7xg1l4S5iQ5Ls5clJaGI5ogQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeggdehudculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofhrggfgsedtkeertdertddtnecu
    hfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucffohhmrg
    hinhepkhgvrhhnvghlrdhorhhgpdhisghmrdgtohhmpdhsthhorhgrghgvrhgvvhhivgif
    rdgtohhmnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrghmpehmrghilh
    hfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:aGWlXLAZ0C3sQ10DAoInHg44Hi_sIwQhgpJEMWh-RDUTddYj_aCBfA>
    <xmx:aGWlXH8SV9Yjjlf7KIB4NTYa7dMT0YUAoenRhGv7XZMdaE9KsTQ4Hg>
    <xmx:aGWlXPYw9HoPlY2vUdD5WgWnm1wcAW9Khz9KasdPoWCvsPmaYLVN4w>
    <xmx:amWlXA2K272L-yqj8TNQj5zqza-QAO60Slm6hAVt6Fj-Ej_o_v1NDw>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 14A2310392;
        Wed,  3 Apr 2019 22:01:11 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        Javier Cabezas <jcabezas@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 00/25] Accelerate page migration and use memcg for PMEM management
Date:   Wed,  3 Apr 2019 19:00:21 -0700
Message-Id: <20190404020046.32741-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.20.1
Reply-To: ziy@nvidia.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Thanks to Dave Hansen's patches, which make PMEM as part of memory as NUMA nodes.
How to use PMEM along with normal DRAM remains an open problem. There are
several patchsets posted on the mailing list, proposing to use page migration to
move pages between PMEM and DRAM using Linux page replacement policy [1,2,3].
There are some important problems not addressed in these patches:
1. The page migration in Linux does not provide high enough throughput for us to
fully exploit PMEM or other use cases.
2. Linux page replacement is running too infrequent to distinguish hot and cold
pages.

I am trying to attack the problems with this patch series. This is not a final
solution, but I would like to gather more feedback and comments from the mailing
list.

Page migration throughput problem
====

For example, in my recent email [4], I gave the page migration throughput numbers
for different page migrations, none of which can achieve > 2.5GB/s throughput
(the throughput is measured around kernel functions: migrate_pages() and
migrate_page_copy()):

                             |  migrate_pages() |    migrate_page_copy()
migrating single 4KB page:   |  0.312GB/s       |   1.385GB/s
migrating 512 4KB pages:     |  0.854GB/s       |   1.983GB/s
migrating single 2MB THP:    |  2.387GB/s       |   2.481GB/s

In reality, microbenchmarks show that Intel PMEM can provide ~65GB/s read
throughput and ~16GB/s write throughput [5], which are much higher than
the throughput achieved by Linux page migration.

In addition, it is also desirable to use page migration to move data
between high-bandwidth memory and DRAM, like IBM Summit, which exposes
high-performance GPU memories as NUMA nodes [6]. This requires even higher page
migration throughput.

In this patch series, I propose four different ways of improving page migration
throughput (mostly on 2MB THP migration):
1. multi-threaded page migration: Patch 03 to 06.
2. DMA-based (using Intel IOAT DMA) page migration: Patch 07 and 08.
3. concurrent (batched) page migration: Patch 09, 10, and 11.
4. exchange pages: Patch 12 to 17. (This is a repost of part of [7])

Here are some throughput numbers showing clear throughput improvements on
a two-socket NUMA machine with two Xeon E5-2650 v3 @ 2.30GHz and a 19.2GB/s
bandwidth QPI link (the same machine as mentioned in [4]):

                                    |  migrate_pages() |   migrate_page_copy()
=> migrating single 2MB THP         |  2.387GB/s       |   2.481GB/s
 2-thread single THP migration      |  3.478GB/s       |   3.704GB/s
 4-thread single THP migration      |  5.474GB/s       |   6.054GB/s
 8-thread single THP migration      |  7.846GB/s       |   9.029GB/s
16-thread single THP migration      |  7.423GB/s       |   8.464GB/s
16-ch. DMA single THP migration     |  4.322GB/s       |   4.536GB/s

 2-thread 16-THP migration          |  3.610GB/s       |   3.838GB/s
 2-thread 16-THP batched migration  |  4.138GB/s       |   4.344GB/s
 4-thread 16-THP migration          |  6.385GB/s       |   7.031GB/s
 4-thread 16-THP batched migration  |  7.382GB/s       |   8.072GB/s
 8-thread 16-THP migration          |  8.039GB/s       |   9.029GB/s
 8-thread 16-THP batched migration  |  9.023GB/s       |   10.056GB/s
16-thread 16-THP migration          |  8.137GB/s       |   9.137GB/s
16-thread 16-THP batched migration  |  9.907GB/s       |   11.175GB/s

 1-thread 16-THP exchange           |  4.135GB/s       |   4.225GB/s
 2-thread 16-THP batched exchange   |  7.061GB/s       |   7.325GB/s
 4-thread 16-THP batched exchange   |  9.729GB/s       |   10.237GB/s
 8-thread 16-THP batched exchange   |  9.992GB/s       |   10.533GB/s
16-thread 16-THP batched exchange   |  9.520GB/s       |   10.056GB/s

=> migrating 512 4KB pages          |  0.854GB/s       |   1.983GB/s
 1-thread 512-4KB batched exchange  |  1.271GB/s       |   3.433GB/s
 2-thread 512-4KB batched exchange  |  1.240GB/s       |   3.190GB/s
 4-thread 512-4KB batched exchange  |  1.255GB/s       |   3.823GB/s
 8-thread 512-4KB batched exchange  |  1.336GB/s       |   3.921GB/s
16-thread 512-4KB batched exchange  |  1.334GB/s       |   3.897GB/s

Concerns were raised on how to avoid CPU resource competition between
page migration and user applications and have power awareness.
Daniel Jordan recently posted a multi-threaded ktask patch series could be
a solution [8].


Infrequent page list update problem
====

Current page lists are updated by calling shrink_list() when memory pressure
comes,  which might not be frequent enough to keep track of hot and cold pages.
Because all pages are on active lists at the first time shrink_list() is called
and the reference bit on the pages might not reflect the up to date access status
of these pages. But we also do not want to periodically shrink the global page
lists, which adds unnecessary overheads to the whole system. So I propose to
actively shrink page lists on the memcg we are interested in.

Patch 18 to 25 add a new system call to shrink page lists on given application's
memcg and migrate pages between two NUMA nodes. It isolates the impact from the
rest of the system. To share DRAM among different applications, Patch 18 and 19
add per-node memcg size limit, so you can limit the memory usage for particular
NUMA node(s).


Patch structure
====
1. multi-threaded page migration: Patch 01 to 06.
2. DMA-based (using Intel IOAT DMA) page migration: Patch 07 and 08.
3. concurrent (batched) page migration: Patch 09, 10, and 11.
4. exchange pages: Patch 12 to 17. (This is a repost of part of [7])
5. per-node size limit in memcg: Patch 18 and 19.
6. actively shrink page lists and perform page migration in given memcg: Patch 20 to 25.


Any comment is welcome.

[1]: https://lore.kernel.org/linux-mm/20181226131446.330864849@intel.com/
[2]: https://lore.kernel.org/linux-mm/20190321200157.29678-1-keith.busch@intel.com/
[3]: https://lore.kernel.org/linux-mm/1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com/
[4]: https://lore.kernel.org/linux-mm/6A903D34-A293-4056-B135-6FA227DE1828@nvidia.com/
[5]: https://www.storagereview.com/supermicro_superserver_with_intel_optane_dc_persistent_memory_first_look_review
[6]: https://www.ibm.com/thought-leadership/summit-supercomputer/
[7]: https://lore.kernel.org/linux-mm/20190215220856.29749-1-zi.yan@sent.com/
[8]: https://lore.kernel.org/linux-mm/20181105165558.11698-1-daniel.m.jordan@oracle.com/

Zi Yan (25):
  mm: migrate: Change migrate_mode to support combination migration
    modes.
  mm: migrate: Add mode parameter to support future page copy routines.
  mm: migrate: Add a multi-threaded page migration function.
  mm: migrate: Add copy_page_multithread into migrate_pages.
  mm: migrate: Add vm.accel_page_copy in sysfs to control page copy
    acceleration.
  mm: migrate: Make the number of copy threads adjustable via sysctl.
  mm: migrate: Add copy_page_dma to use DMA Engine to copy pages.
  mm: migrate: Add copy_page_dma into migrate_page_copy.
  mm: migrate: Add copy_page_lists_dma_always to support copy a list of
       pages.
  mm: migrate: copy_page_lists_mt() to copy a page list using
    multi-threads.
  mm: migrate: Add concurrent page migration into move_pages syscall.
  exchange pages: new page migration mechanism: exchange_pages()
  exchange pages: add multi-threaded exchange pages.
  exchange pages: concurrent exchange pages.
  exchange pages: exchange anonymous page and file-backed page.
  exchange page: Add THP exchange support.
  exchange page: Add exchange_page() syscall.
  memcg: Add per node memory usage&max stats in memcg.
  mempolicy: add MPOL_F_MEMCG flag, enforcing memcg memory limit.
  memory manage: Add memory manage syscall.
  mm: move update_lru_sizes() to mm_inline.h for broader use.
  memory manage: active/inactive page list manipulation in memcg.
  memory manage: page migration based page manipulation between NUMA
    nodes.
  memory manage: limit migration batch size.
  memory manage: use exchange pages to memory manage to improve
    throughput.

 arch/x86/entry/syscalls/syscall_64.tbl |    2 +
 fs/aio.c                               |   12 +-
 fs/f2fs/data.c                         |    6 +-
 fs/hugetlbfs/inode.c                   |    4 +-
 fs/iomap.c                             |    4 +-
 fs/ubifs/file.c                        |    4 +-
 include/linux/cgroup-defs.h            |    1 +
 include/linux/exchange.h               |   27 +
 include/linux/highmem.h                |    3 +
 include/linux/ksm.h                    |    4 +
 include/linux/memcontrol.h             |   67 ++
 include/linux/migrate.h                |   12 +-
 include/linux/migrate_mode.h           |    8 +
 include/linux/mm_inline.h              |   21 +
 include/linux/sched/coredump.h         |    1 +
 include/linux/sched/sysctl.h           |    3 +
 include/linux/syscalls.h               |   10 +
 include/uapi/linux/mempolicy.h         |    9 +-
 kernel/sysctl.c                        |   47 +
 mm/Makefile                            |    5 +
 mm/balloon_compaction.c                |    2 +-
 mm/compaction.c                        |   22 +-
 mm/copy_page.c                         |  708 +++++++++++++++
 mm/exchange.c                          | 1560 ++++++++++++++++++++++++++++++++
 mm/exchange_page.c                     |  228 +++++
 mm/internal.h                          |  113 +++
 mm/ksm.c                               |   35 +
 mm/memcontrol.c                        |   80 ++
 mm/memory_manage.c                     |  649 +++++++++++++
 mm/mempolicy.c                         |   38 +-
 mm/migrate.c                           |  621 ++++++++++++-
 mm/vmscan.c                            |  115 +--
 mm/zsmalloc.c                          |    2 +-
 33 files changed, 4261 insertions(+), 162 deletions(-)
 create mode 100644 include/linux/exchange.h
 create mode 100644 mm/copy_page.c
 create mode 100644 mm/exchange.c
 create mode 100644 mm/exchange_page.c
 create mode 100644 mm/memory_manage.c

--
2.7.4

