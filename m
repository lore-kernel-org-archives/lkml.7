Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5773ECA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A90222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CFfepWBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407082AbfJRA2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:28:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31506 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404597AbfJRA2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:28:39 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9I0OMlL002611
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=KJuj2h5kFIqlCHoCvQvjqiWCfrs/97lam01HAjo1aEw=;
 b=CFfepWBvGdpsFUDe41TogfLEmZAf1kl2XC4kRgXIQs9tCCxYd4uIIbp+4m53PsuDuGVr
 AoL90gLOVYjjZK9i6SJqNV2vdEjdyPxqA6zNusQQYOLbgQMlRTapXHRJbY8BYVtCcSLr
 35sxFJcuVYf0bmK1R9Ngj8+sebUOPbIoNvw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vq2nkr1pg-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:37 -0700
Received: from 2401:db00:30:600c:face:0:39:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Oct 2019 17:28:35 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id E0DD718CE8474; Thu, 17 Oct 2019 17:28:33 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 00/16] The new slab memory controller
Date:   Thu, 17 Oct 2019 17:28:04 -0700
Message-ID: <20191018002820.307763-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_07:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing slab memory controller is based on the idea of replicating
slab allocator internals for each memory cgroup. This approach promises
a low memory overhead (one pointer per page), and isn't adding too much
code on hot allocation and release paths. But is has a very serious flaw:
it leads to a low slab utilization.

Using a drgn* script I've got an estimation of slab utilization on
a number of machines running different production workloads. In most
cases it was between 45% and 65%, and the best number I've seen was
around 85%. Turning kmem accounting off brings it to high 90s. Also
it brings back 30-50% of slab memory. It means that the real price
of the existing slab memory controller is way bigger than a pointer
per page.

The real reason why the existing design leads to a low slab utilization
is simple: slab pages are used exclusively by one memory cgroup.
If there are only few allocations of certain size made by a cgroup,
or if some active objects (e.g. dentries) are left after the cgroup is
deleted, or the cgroup contains a single-threaded application which is
barely allocating any kernel objects, but does it every time on a new CPU:
in all these cases the resulting slab utilization is very low.
If kmem accounting is off, the kernel is able to use free space
on slab pages for other allocations.

Arguably it wasn't an issue back to days when the kmem controller was
introduced and was an opt-in feature, which had to be turned on
individually for each memory cgroup. But now it's turned on by default
on both cgroup v1 and v2. And modern systemd-based systems tend to
create a large number of cgroups.

This patchset provides a new implementation of the slab memory controller,
which aims to reach a much better slab utilization by sharing slab pages
between multiple memory cgroups. Below is the short description of the new
design (more details in commit messages).

Accounting is performed per-object instead of per-page. Slab-related
vmstat counters are converted to bytes. Charging is performed on page-basis,
with rounding up and remembering leftovers.

Memcg ownership data is stored in a per-slab-page vector: for each slab page
a vector of corresponding size is allocated. To keep slab memory reparenting
working, instead of saving a pointer to the memory cgroup directly an
intermediate object is used. It's simply a pointer to a memcg (which can be
easily changed to the parent) with a built-in reference counter. This scheme
allows to reparent all allocated objects without walking them over and changing
memcg pointer to the parent.

Instead of creating an individual set of kmem_caches for each memory cgroup,
two global sets are used: the root set for non-accounted and root-cgroup
allocations and the second set for all other allocations. This allows to
simplify the lifetime management of individual kmem_caches: they are destroyed
with root counterparts. It allows to remove a good amount of code and make
things generally simpler.

The patchset contains a couple of semi-independent parts, which can find their
usage outside of the slab memory controller too:
1) subpage charging API, which can be used in the future for accounting of
   other non-page-sized objects, e.g. percpu allocations.
2) mem_cgroup_ptr API (refcounted pointers to a memcg, can be reused
   for the efficient reparenting of other objects, e.g. pagecache.

The patchset has been tested on a number of different workloads in our
production. In all cases, it saved hefty amounts of memory:
1) web frontend, 650-700 Mb, ~42% of slab memory
2) database cache, 750-800 Mb, ~35% of slab memory
3) dns server, 700 Mb, ~36% of slab memory

(These numbers were received used a backport of this patchset to the kernel
version used in fb production. But similar numbers can be obtained on
a vanilla kernel. If used on a modern systemd-based distributive,
e.g. Fedora 30, the patched kernel shows the same order of slab memory
savings just after system start).

So far I haven't found any regression on all tested workloads, but
potential CPU regression caused by more precise accounting is a concern.

Obviously the amount of saved memory depend on the number of memory cgroups,
uptime and specific workloads, but overall it feels like the new controller
saves 30-40% of slab memory, sometimes more. Additionally, it should lead
to a lower memory fragmentation, just because of a smaller number of
non-movable pages and also because there is no more need to move all
slab objects to a new set of pages when a workload is restarted in a new
memory cgroup.

* https://github.com/osandov/drgn


v1:
  1) fixed a bug in zoneinfo_show_print()
  2) added some comments to the subpage charging API, a minor fix
  3) separated memory.kmem.slabinfo deprecation into a separate patch,
     provided a drgn-based replacement
  4) rebased on top of the current mm tree

RFC:
  https://lwn.net/Articles/798605/


Roman Gushchin (16):
  mm: memcg: introduce mem_cgroup_ptr
  mm: vmstat: use s32 for vm_node_stat_diff in struct per_cpu_nodestat
  mm: vmstat: convert slab vmstat counter to bytes
  mm: memcg/slab: allocate space for memcg ownership data for non-root
    slabs
  mm: slub: implement SLUB version of obj_to_index()
  mm: memcg/slab: save memcg ownership data for non-root slab objects
  mm: memcg: move memcg_kmem_bypass() to memcontrol.h
  mm: memcg: introduce __mod_lruvec_memcg_state()
  mm: memcg/slab: charge individual slab objects instead of pages
  mm: memcg: move get_mem_cgroup_from_current() to memcontrol.h
  mm: memcg/slab: replace memcg_from_slab_page() with
    memcg_from_slab_obj()
  tools/cgroup: add slabinfo.py tool
  mm: memcg/slab: deprecate memory.kmem.slabinfo
  mm: memcg/slab: use one set of kmem_caches for all memory cgroups
  tools/cgroup: make slabinfo.py compatible with new slab controller
  mm: slab: remove redundant check in memcg_accumulate_slabinfo()

 drivers/base/node.c        |  14 +-
 fs/proc/meminfo.c          |   4 +-
 include/linux/memcontrol.h |  98 +++++++-
 include/linux/mm_types.h   |   5 +-
 include/linux/mmzone.h     |  12 +-
 include/linux/slab.h       |   3 +-
 include/linux/slub_def.h   |   9 +
 include/linux/vmstat.h     |   8 +
 kernel/power/snapshot.c    |   2 +-
 mm/list_lru.c              |  12 +-
 mm/memcontrol.c            | 302 ++++++++++++-------------
 mm/oom_kill.c              |   2 +-
 mm/page_alloc.c            |   8 +-
 mm/slab.c                  |  37 ++-
 mm/slab.h                  | 300 ++++++++++++------------
 mm/slab_common.c           | 452 ++++---------------------------------
 mm/slob.c                  |  12 +-
 mm/slub.c                  |  63 ++----
 mm/vmscan.c                |   3 +-
 mm/vmstat.c                |  37 ++-
 mm/workingset.c            |   6 +-
 tools/cgroup/slabinfo.py   | 250 ++++++++++++++++++++
 22 files changed, 816 insertions(+), 823 deletions(-)
 create mode 100755 tools/cgroup/slabinfo.py

-- 
2.21.0

