Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FD4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A92A20878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GXwkKL4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfDXE5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 00:57:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59554 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726442AbfDXE5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 00:57:14 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3O4o99N008850
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 21:57:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=IageNkEiRHM81rPnOO5YgAXjmZaajuBLKVn0WeMYvaQ=;
 b=GXwkKL4AyZWIoscJpMq8zGDCIW2G6gEhPpYpDJC3D/BEFapeFwyHl8NeHXtvkJUcIoq3
 OqmXsQW9FkVVUsUltrY34s+PBboUvO+HpNeZlRJGLuoSnLOUhNkwoVNvqCoA97tcdzrG
 INoIfglObuZwXu3tt5LJTB9wLQxPohsKzUM= 
Authentication-Results: fb.com;
        spf=pass smtp.mailfrom=guro@fb.com
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2s2c5qs6va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 21:57:13 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 23 Apr 2019 21:57:12 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id BD9EE1142D2DE; Tue, 23 Apr 2019 14:31:36 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <cgroups@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 0/6] mm: reparent slab memory on cgroup removal
Date:   Tue, 23 Apr 2019 14:31:27 -0700
Message-ID: <20190423213133.3551969-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=799 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240041
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# Why do we need this?

We've noticed that the number of dying cgroups is steadily growing on most
of our hosts in production. The following investigation revealed an issue
in userspace memory reclaim code [1], accounting of kernel stacks [2],
and also the mainreason: slab objects.

The underlying problem is quite simple: any page charged
to a cgroup holds a reference to it, so the cgroup can't be reclaimed unless
all charged pages are gone. If a slab object is actively used by other cgroups,
it won't be reclaimed, and will prevent the origin cgroup from being reclaimed.

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
the accounted slabs to the parent cgroup on cgroup removal.


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
   slab page release, so it shouldn't be a big issue.
3) Introduce a refcounter for non-root slab caches. It's required to
   be able to destroy kmem_caches when they become empty and release
   the associated memory cgroup.

There is a bonus: currently we do release empty kmem_caches on cgroup
removal, however all other are waiting for the releasing of the memory cgroup.
These refactorings allow kmem_caches to be released as soon as they
become inactive and free.

Some additional implementation details are provided in corresponding
commit messages.


# Results

Below is the average number of dying cgroups on two groups of our production
hosts. They do run some sort of web frontend workload, the memory pressure
is moderate. As we can see, with the kernel memory reparenting the number
stabilizes in 50s range; however with the original version it grows almost
linearly and doesn't show any signs of plateauing. The difference in slab
and percpu usage between patched and unpatched versions also grows linearly.
In 6 days it reached 200Mb.

day           0    1    2    3    4    5    6
original     39  338  580  827 1098 1349 1574
patched      23   44   45   47   50   46   55
mem diff(Mb) 53   73   99  137  148  182  209


# History

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


Roman Gushchin (6):
  mm: postpone kmem_cache memcg pointer initialization to
    memcg_link_cache()
  mm: generalize postponed non-root kmem_cache deactivation
  mm: introduce __memcg_kmem_uncharge_memcg()
  mm: unify SLAB and SLUB page accounting
  mm: rework non-root kmem_cache lifecycle management
  mm: reparent slab memory on cgroup removal

 include/linux/memcontrol.h |  10 +++
 include/linux/slab.h       |  13 ++--
 mm/memcontrol.c            |  55 ++++++++------
 mm/slab.c                  |  25 ++-----
 mm/slab.h                  |  74 ++++++++++++++++--
 mm/slab_common.c           | 150 ++++++++++++++++++++-----------------
 mm/slub.c                  |  36 ++-------
 7 files changed, 213 insertions(+), 150 deletions(-)

-- 
2.20.1

