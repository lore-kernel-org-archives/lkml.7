Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC2BC31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1717C2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JxTHDOuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408061AbfFKXSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:18:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46240 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408032AbfFKXSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:18:34 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BN9aF6031322
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:18:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=DteFzIjJ4ZFrhkN75BzQjDClOBOO9f/wTynzitSUJYE=;
 b=JxTHDOuDIUpTQWDSGgdGy5T4WqIIeIpnqPIBRR+cvmnctADA2GkeB27JUnhI8skSNSSg
 VYaUxdpewmHHzxOu9vsHw/dTdHDdBPFetP7Wl3jEgg6rQ4Vb21ip/OkzZQAihxgOqU2W
 ThYpmJnqCkfNAovaZ+kA9lmYg338n4JgQR0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t2ha1926c-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:18:32 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Jun 2019 16:18:22 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 27DD6130CBF65; Tue, 11 Jun 2019 16:18:20 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v7 00/10] mm: reparent slab memory on cgroup removal
Date:   Tue, 11 Jun 2019 16:18:03 -0700
Message-ID: <20190611231813.3148843-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=932 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110151
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# Why do we need this?

We've noticed that the number of dying cgroups is steadily growing on most
of our hosts in production. The following investigation revealed an issue
in the userspace memory reclaim code [1], accounting of kernel stacks [2],
and also the main reason: slab objects.

The underlying problem is quite simple: any page charged to a cgroup holds
a reference to it, so the cgroup can't be reclaimed unless all charged pages
are gone. If a slab object is actively used by other cgroups, it won't be
reclaimed, and will prevent the origin cgroup from being reclaimed.

Slab objects, and first of all vfs cache, is shared between cgroups, which are
using the same underlying fs, and what's even more important, it's shared
between multiple generations of the same workload. So if something is running
periodically every time in a new cgroup (like how systemd works), we do
accumulate multiple dying cgroups.

Strictly speaking pagecache isn't different here, but there is a key difference:
we disable protection and apply some extra pressure on LRUs of dying cgroups,
and these LRUs contain all charged pages.
My experiments show that with the disabled kernel memory accounting the number
of dying cgroups stabilizes at a relatively small number (~100, depends on
memory pressure and cgroup creation rate), and with kernel memory accounting
it grows pretty steadily up to several thousands.

Memory cgroups are quite complex and big objects (mostly due to percpu stats),
so it leads to noticeable memory losses. Memory occupied by dying cgroups
is measured in hundreds of megabytes. I've even seen a host with more than 100Gb
of memory wasted for dying cgroups. It leads to a degradation of performance
with the uptime, and generally limits the usage of cgroups.

My previous attempt [3] to fix the problem by applying extra pressure on slab
shrinker lists caused a regressions with xfs and ext4, and has been reverted [4].
The following attempts to find the right balance [5, 6] were not successful.

So instead of trying to find a maybe non-existing balance, let's do reparent
accounted slab caches to the parent cgroup on cgroup removal.


# Implementation approach

There is however a significant problem with reparenting of slab memory:
there is no list of charged pages. Some of them are in shrinker lists,
but not all. Introducing of a new list is really not an option.

But fortunately there is a way forward: every slab page has a stable pointer
to the corresponding kmem_cache. So the idea is to reparent kmem_caches
instead of slab pages.

It's actually simpler and cheaper, but requires some underlying changes:
1) Make kmem_caches to hold a single reference to the memory cgroup,
   instead of a separate reference per every slab page.
2) Stop setting page->mem_cgroup pointer for memcg slab pages and use
   page->kmem_cache->memcg indirection instead. It's used only on
   slab page release, so performance overhead shouldn't be a big issue.
3) Introduce a refcounter for non-root slab caches. It's required to
   be able to destroy kmem_caches when they become empty and release
   the associated memory cgroup.

There is a bonus: currently we release all memcg kmem_caches all together
with the memory cgroup itself. This patchset allows individual kmem_caches
to be released as soon as they become inactive and free.

Some additional implementation details are provided in corresponding
commit messages.


# Results

Below is the average number of dying cgroups on two groups of our production
hosts. They do run some sort of web frontend workload, the memory pressure
is moderate. As we can see, with the kernel memory reparenting the number
stabilizes in 60s range; however with the original version it grows almost
linearly and doesn't show any signs of plateauing. The difference in slab
and percpu usage between patched and unpatched versions also grows linearly.
In 7 days it exceeded 200Mb.

day           0    1    2    3    4    5    6    7
original     56  362  628  752 1070 1250 1490 1560
patched      23   46   51   55   60   57   67   69
mem diff(Mb) 22   74  123  152  164  182  214  241


# History

v7:
  1) refined cover letter and some commit logs
  2) dropped patch 1
  3) dropped the dying check on kmem_cache creation path
  4) dropped __rcu annotation in patch 10, switched to READ_ONCE()/WRITE_ONCE()
     where is necessary

v6:
  1) split biggest patches into parts to make the review easier
  2) changed synchronization around the dying flag
  3) sysfs entry removal on deactivation is back
  4) got rid of redundant rcu wait on kmem_cache release
  5) fixed getting memcg pointer in mem_cgroup_from_kmem()
  5) fixed missed smp_rmb()
  6) removed redundant CONFIG_SLOB
  7) some renames and cosmetic fixes

v5:
  1) fixed a compilation warning around missing kmemcg_queue_cache_shutdown()
  2) s/rcu_read_lock()/rcu_read_unlock() in memcg_kmem_get_cache()

v4:
  1) removed excessive memcg != parent check in memcg_deactivate_kmem_caches()
  2) fixed rcu_read_lock() usage in memcg_charge_slab()
  3) fixed synchronization around dying flag in kmemcg_queue_cache_shutdown()
  4) refreshed test results data
  5) reworked PageTail() checks in memcg_from_slab_page()
  6) added some comments in multiple places

v3:
  1) reworked memcg kmem_cache search on allocation path
  2) fixed /proc/kpagecgroup interface

v2:
  1) switched to percpu kmem_cache refcounter
  2) a reference to kmem_cache is held during the allocation
  3) slabs stats are fixed for !MEMCG case (and the refactoring
     is separated into a standalone patch)
  4) kmem_cache reparenting is performed from deactivatation context

v1:
  https://lkml.org/lkml/2019/4/17/1095


# Links

[1]: commit 68600f623d69 ("mm: don't miss the last page because of
round-off error")
[2]: commit 9b6f7e163cd0 ("mm: rework memcg kernel stack accounting")
[3]: commit 172b06c32b94 ("mm: slowly shrink slabs with a relatively
small number of objects")
[4]: commit a9a238e83fbb ("Revert "mm: slowly shrink slabs
with a relatively small number of objects")
[5]: https://lkml.org/lkml/2019/1/28/1865
[6]: https://marc.info/?l=linux-mm&m=155064763626437&w=2


Roman Gushchin (10):
  mm: postpone kmem_cache memcg pointer initialization to
    memcg_link_cache()
  mm: rename slab delayed deactivation functions and fields
  mm: generalize postponed non-root kmem_cache deactivation
  mm: introduce __memcg_kmem_uncharge_memcg()
  mm: unify SLAB and SLUB page accounting
  mm: don't check the dying flag on kmem_cache creation
  mm: synchronize access to kmem_cache dying flag using a spinlock
  mm: rework non-root kmem_cache lifecycle management
  mm: stop setting page->mem_cgroup pointer for slab pages
  mm: reparent memcg kmem_caches on cgroup removal

 include/linux/memcontrol.h |  10 +++
 include/linux/slab.h       |  11 +--
 mm/list_lru.c              |   3 +-
 mm/memcontrol.c            | 101 ++++++++++++++++-------
 mm/slab.c                  |  25 ++----
 mm/slab.h                  | 143 +++++++++++++++++++++++---------
 mm/slab_common.c           | 164 ++++++++++++++++++++++---------------
 mm/slub.c                  |  24 +-----
 8 files changed, 301 insertions(+), 180 deletions(-)

-- 
2.21.0

