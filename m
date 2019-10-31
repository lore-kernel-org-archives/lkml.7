Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD6DCA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E8520856
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cL6OZ5ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfJaAvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 20:51:36 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13954 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfJaAvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 20:51:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dba30170000>; Wed, 30 Oct 2019 17:51:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 30 Oct 2019 17:51:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 30 Oct 2019 17:51:29 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 31 Oct
 2019 00:51:28 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 31 Oct 2019 00:51:28 +0000
Received: from ng-linuxvm.nvidia.com (Not Verified[10.110.48.88]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dba300d0000>; Wed, 30 Oct 2019 17:51:27 -0700
From:   Nitin Gupta <nigupta@nvidia.com>
To:     <mgorman@techsingularity.net>, <mhocko@suse.com>
CC:     Nitin Gupta <nigupta@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Janne Huttunen <janne.huttunen@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arun KS <arunks@codeaurora.org>,
        Song Liu <songliubraving@fb.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [RFC v2] mm: Proactive compaction
Date:   Wed, 30 Oct 2019 17:51:07 -0700
Message-ID: <20191031005127.8037-1-nigupta@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572483096; bh=ZgVzKO8JBX1FnHDxZ2SuNPzOXzQ6joDSYPLBQPpsVlM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=cL6OZ5zeXYyRY7VZK/AasDtLrFb4fJEUsZSZdGIKN8Be9zmdfCzG8gnLbNvnWkOC4
         L1NW1X5llXtjgZsXI5D7ZyqdmQ+7eaQlDclXD7qLVSJfZhI1kacdR64/06MEUJ+haw
         Gx+QfL5pLUk6HppT3e6qJttte+5CYTaUp64o8K5g3WuSiNsULG7fq3/U+e8W5uuPx5
         RCqZMfiugjusHC11Q5hIvYDize3bQUP9pxo1s1Uyq34Kmd0EY1ngoqUBW1cwhxb8Nf
         /t5u1UVds2bNpZB100AZwgc55hEImD9VuLByJTZJzwbR/ECkTEONuTXO/eXA8VOT91
         8UtO8jrNjdWhQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some applications we need to allocate almost all memory as
hugepages. However, on a running system, higher order allocations can
fail if the memory is fragmented. Linux kernel currently does on-demand
compaction as we request more hugepages but this style of compaction
incurs very high latency. Experiments with one-time full memory
compaction (followed by hugepage allocations) shows that kernel is able
to restore a highly fragmented memory state to a fairly compacted memory
state within <1 sec for a 32G system. Such data suggests that a more
proactive compaction can help us allocate a large fraction of memory as
hugepages keeping allocation latencies low.

For a more proactive compaction, the approach taken here is to define
per page-node tunable called =E2=80=98hpage_compaction_effort=E2=80=99 whic=
h dictates
bounds for external fragmentation for HPAGE_PMD_ORDER pages which
kcompactd should try to maintain.

The tunable is exposed through sysfs:
  /sys/kernel/mm/compaction/node-n/hpage_compaction_effort

The value of this tunable is used to determine low and high thresholds
for external fragmentation wrt HPAGE_PMD_ORDER order.

Note that previous version of this patch [1] was found to introduce too
many tunables (per-order, extfrag_{low, high}) but this one reduces them
to just (per-node, hpage_compaction_effort). Also, the new tunable is an
opaque value instead of asking for specific bounds of =E2=80=9Cexternal
fragmentation=E2=80=9D which would have been difficult to estimate. The int=
ernal
interpretation of this opaque value allows for future fine-tuning.

Currently, we use a simple translation from this tunable to [low, high]
extfrag thresholds (low=3D100-hpage_compaction_effort, high=3Dlow+10%). To
periodically check per-node extfrag status, we reuse per-node kcompactd
threads which are woken up every few milliseconds to check the same. If
any zone on its corresponding node has extfrag above the high threshold
for the HPAGE_PMD_ORDER order, the thread starts compaction in
background till all zones are below the low extfrag level for this
order. By default. By default, the tunable is set to 0 (=3D> low=3D100%,
high=3D100%).

This patch is largely based on ideas from Michal Hocko posted here:
https://lore.kernel.org/linux-mm/20161230131412.GI13301@dhcp22.suse.cz/

* Performance data

System: x64_64, 32G RAM, 12-cores.

I made a small driver that allocates as many hugepages as possible and
measures allocation latency:

The driver first tries to allocate hugepage using GFP_TRANSHUGE_LIGHT
and if that fails, tries to allocate with `GFP_TRANSHUGE |
__GFP_RETRY_MAYFAIL`. The drives stops when both methods fail for a
hugepage allocation.

Before starting the driver, the system was fragmented from a userspace
program that allocates all memory and then for each 2M aligned section,
frees 3/4 of base pages using munmap. The workload is mainly anonymous
userspace pages which are easy to move around. I intentionally avoided
unmovable pages in this test to see how much latency we incur just by
hitting the slow path for most allocations.

(all latency values are in microseconds)

- With vanilla kernel 5.4.0-rc5:

percentile latency
---------- -------
         5       7
        10       7
        25       8
        30       8
        40       8
        50       8
        60       9
        75     215
        80     222
        90     323
        95     429

Total 2M hugepages allocated =3D 1829 (3.5G worth of hugepages out of 25G
total free =3D> 14% of free memory could be allocated as hugepages)

- Now with kernel 5.4.0-rc5 + this patch:
(hpage_compaction_effort =3D 60)

percentile latency
---------- -------
         5       3
        10       3
        25       4
        30       4
        40       4
        50       4
        60       5
        75       6
        80       9
        90     370
        95     652

Total 2M hugepages allocated =3D 11120 (21.7G worth of hugepages out of
25G total free =3D> 86% of free memory could be allocated as hugepages)

Above workload produces a memory state which is easy to compact.
However, if memory is filled with unmovable pages, pro-active compaction
should essentially back off. To test this aspect, I ran a mix of this
workload (thanks to Matthew Wilcox for suggesting these):

- dentry_thrash: it opens /tmp/missing.x for x in [1, 1000000] where
first 10000 files actually exist.
- pagecache_thrash: it opens a 128G file (on a 32G system) and then
reads at random offsets.

With this mix of workload, system quickly reaches 90-100% fragmentation
wrt order-9. Trace of compaction events shows that we keep hitting
compaction_deferred event, as expected.

After terminating dentry_thrash and dropping denty caches, the system
could proceed with compaction according to set value of
hpage_compaction_effort (60).

[1] https://patchwork.kernel.org/patch/11098289/

Signed-off-by: Nitin Gupta <nigupta@nvidia.com>
---
 include/linux/compaction.h |  10 ++
 mm/compaction.c            | 193 ++++++++++++++++++++++++++++++-------
 mm/vmstat.c                |  12 +++
 3 files changed, 178 insertions(+), 37 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 4b898cdbdf05..7bf78b74b46a 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -60,6 +60,15 @@ enum compact_result {
=20
 struct alloc_context; /* in mm/internal.h */
=20
+// "node-%d"
+#define COMPACTION_STATE_NAME_LEN 16
+// Per-node compaction state
+struct compaction_state {
+	int node_id;
+	unsigned int hpage_compaction_effort;
+	char name[COMPACTION_STATE_NAME_LEN];
+};
+
 /*
  * Number of free order-0 pages that should be available above given water=
mark
  * to make sure compaction has reasonable chance of not running out of fre=
e
@@ -90,6 +99,7 @@ extern int sysctl_compaction_handler(struct ctl_table *ta=
ble, int write,
 extern int sysctl_extfrag_threshold;
 extern int sysctl_compact_unevictable_allowed;
=20
+extern int extfrag_for_order(struct zone *zone, unsigned int order);
 extern int fragmentation_index(struct zone *zone, unsigned int order);
 extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
 		unsigned int order, unsigned int alloc_flags,
diff --git a/mm/compaction.c b/mm/compaction.c
index 672d3c78c6ab..e9f46e96ab94 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -25,6 +25,10 @@
 #include <linux/psi.h>
 #include "internal.h"
=20
+#ifdef CONFIG_COMPACTION
+struct compaction_state compaction_states[MAX_NUMNODES];
+#endif
+
 #ifdef CONFIG_COMPACTION
 static inline void count_compact_event(enum vm_event_item item)
 {
@@ -1846,6 +1850,31 @@ static inline bool is_via_compact_memory(int order)
 	return order =3D=3D -1;
 }
=20
+static unsigned int extfrag_hpage_wmark(struct zone *zone, bool low)
+{
+	int node_id, wmark, wmark_low;
+
+	node_id =3D zone->zone_pgdat->node_id;
+	wmark_low =3D 100 - compaction_states[node_id].hpage_compaction_effort;
+	wmark =3D low ? wmark_low : min(wmark_low + 10, 100);
+
+	return extfrag_for_order(zone, HPAGE_PMD_ORDER) > wmark;
+}
+
+static bool node_hpage_should_compact(pg_data_t *pgdat)
+{
+	struct zone *zone;
+
+	for_each_populated_zone(zone) {
+		if (extfrag_hpage_wmark(zone, false) &&
+			compaction_suitable(zone, HPAGE_PMD_ORDER,
+				0, zone_idx(zone)) =3D=3D COMPACT_CONTINUE) {
+			return true;
+		}
+	}
+	return false;
+}
+
 static enum compact_result __compact_finished(struct compact_control *cc)
 {
 	unsigned int order;
@@ -1875,6 +1904,9 @@ static enum compact_result __compact_finished(struct =
compact_control *cc)
 	if (is_via_compact_memory(cc->order))
 		return COMPACT_CONTINUE;
=20
+	if (extfrag_hpage_wmark(cc->zone, true))
+		return COMPACT_CONTINUE;
+
 	/*
 	 * Always finish scanning a pageblock to reduce the possibility of
 	 * fallbacks in the future. This is particularly important when
@@ -1965,15 +1997,6 @@ static enum compact_result __compaction_suitable(str=
uct zone *zone, int order,
 	if (is_via_compact_memory(order))
 		return COMPACT_CONTINUE;
=20
-	watermark =3D wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
-	/*
-	 * If watermarks for high-order allocation are already met, there
-	 * should be no need for compaction at all.
-	 */
-	if (zone_watermark_ok(zone, order, watermark, classzone_idx,
-								alloc_flags))
-		return COMPACT_SUCCESS;
-
 	/*
 	 * Watermarks for order-0 must be met for compaction to be able to
 	 * isolate free pages for migration targets. This means that the
@@ -2003,31 +2026,9 @@ enum compact_result compaction_suitable(struct zone =
*zone, int order,
 					int classzone_idx)
 {
 	enum compact_result ret;
-	int fragindex;
=20
 	ret =3D __compaction_suitable(zone, order, alloc_flags, classzone_idx,
 				    zone_page_state(zone, NR_FREE_PAGES));
-	/*
-	 * fragmentation index determines if allocation failures are due to
-	 * low memory or external fragmentation
-	 *
-	 * index of -1000 would imply allocations might succeed depending on
-	 * watermarks, but we already failed the high-order watermark check
-	 * index towards 0 implies failure is due to lack of memory
-	 * index towards 1000 implies failure is due to fragmentation
-	 *
-	 * Only compact if a failure would be due to fragmentation. Also
-	 * ignore fragindex for non-costly orders where the alternative to
-	 * a successful reclaim/compaction is OOM. Fragindex and the
-	 * vm.extfrag_threshold sysctl is meant as a heuristic to prevent
-	 * excessive compaction for costly orders, but it should not be at the
-	 * expense of system stability.
-	 */
-	if (ret =3D=3D COMPACT_CONTINUE && (order > PAGE_ALLOC_COSTLY_ORDER)) {
-		fragindex =3D fragmentation_index(zone, order);
-		if (fragindex >=3D 0 && fragindex <=3D sysctl_extfrag_threshold)
-			ret =3D COMPACT_NOT_SUITABLE_ZONE;
-	}
=20
 	trace_mm_compaction_suitable(zone, order, ret);
 	if (ret =3D=3D COMPACT_NOT_SUITABLE_ZONE)
@@ -2419,7 +2420,6 @@ static void compact_node(int nid)
 		.gfp_mask =3D GFP_KERNEL,
 	};
=20
-
 	for (zoneid =3D 0; zoneid < MAX_NR_ZONES; zoneid++) {
=20
 		zone =3D &pgdat->node_zones[zoneid];
@@ -2492,8 +2492,122 @@ void compaction_unregister_node(struct node *node)
 }
 #endif /* CONFIG_SYSFS && CONFIG_NUMA */
=20
+#ifdef CONFIG_SYSFS
+
+#define COMPACTION_ATTR_RO(_name) \
+	static struct kobj_attribute _name##_attr =3D __ATTR_RO(_name)
+
+#define COMPACTION_ATTR(_name) \
+	static struct kobj_attribute _name##_attr =3D \
+		__ATTR(_name, 0644, _name##_show, _name##_store)
+
+static struct kobject *compaction_kobj;
+static struct kobject *compaction_kobjs[MAX_NUMNODES];
+
+static struct compaction_state *kobj_to_compaction_state(struct kobject *k=
obj)
+{
+	int node;
+
+	for_each_online_node(node) {
+		if (compaction_kobjs[node] =3D=3D kobj)
+			return &compaction_states[node];
+	}
+
+	return NULL;
+}
+
+static ssize_t hpage_compaction_effort_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	int err;
+	unsigned long input;
+	struct compaction_state *c =3D kobj_to_compaction_state(kobj);
+
+	err =3D kstrtoul(buf, 10, &input);
+	if (err)
+		return err;
+	if (input > 100)
+		return -EINVAL;
+
+	c->hpage_compaction_effort =3D input;
+	return count;
+}
+
+static ssize_t hpage_compaction_effort_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct compaction_state *c =3D kobj_to_compaction_state(kobj);
+
+	return sprintf(buf, "%u\n", c->hpage_compaction_effort);
+}
+
+COMPACTION_ATTR(hpage_compaction_effort);
+
+static struct attribute *compaction_attrs[] =3D {
+	&hpage_compaction_effort_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group compaction_attr_group =3D {
+	.attrs =3D compaction_attrs,
+};
+
+static int compaction_sysfs_add_node(struct compaction_state *c,
+	struct kobject *parent, struct kobject **compaction_kobjs,
+	const struct attribute_group *compaction_attr_group)
+{
+	int retval;
+
+	compaction_kobjs[c->node_id] =3D
+			kobject_create_and_add(c->name, parent);
+	if (!compaction_kobjs[c->node_id])
+		return -ENOMEM;
+
+	retval =3D sysfs_create_group(compaction_kobjs[c->node_id],
+				compaction_attr_group);
+	if (retval)
+		kobject_put(compaction_kobjs[c->node_id]);
+
+	return retval;
+}
+
+static void __init compaction_sysfs_init(void)
+{
+	struct compaction_state *c;
+	int err, node;
+
+	compaction_kobj =3D kobject_create_and_add("compaction", mm_kobj);
+	if (!compaction_kobj)
+		return;
+
+	for_each_online_node(node) {
+		c =3D &compaction_states[node];
+		err =3D compaction_sysfs_add_node(c, compaction_kobj,
+					compaction_kobjs,
+					&compaction_attr_group);
+		if (err)
+			pr_err("compaction: Unable to add state %s", c->name);
+	}
+}
+
+static void __init compaction_init(void)
+{
+	int node;
+
+	for_each_online_node(node) {
+		struct compaction_state *c =3D &compaction_states[node];
+
+		c->node_id =3D node;
+		c->hpage_compaction_effort =3D 0;
+		snprintf(c->name, COMPACTION_STATE_NAME_LEN, "node-%d", node);
+	}
+}
+#endif
+
 static inline bool kcompactd_work_requested(pg_data_t *pgdat)
 {
+	if (node_hpage_should_compact(pgdat) && !pgdat->kcompactd_max_order)
+		pgdat->kcompactd_max_order =3D 1;
 	return pgdat->kcompactd_max_order > 0 || kthread_should_stop();
 }
=20
@@ -2529,7 +2643,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		.order =3D pgdat->kcompactd_max_order,
 		.search_order =3D pgdat->kcompactd_max_order,
 		.classzone_idx =3D pgdat->kcompactd_classzone_idx,
-		.mode =3D MIGRATE_SYNC_LIGHT,
+		.mode =3D MIGRATE_SYNC,
 		.ignore_skip_hint =3D false,
 		.gfp_mask =3D GFP_KERNEL,
 	};
@@ -2556,7 +2670,6 @@ static void kcompactd_do_work(pg_data_t *pgdat)
=20
 		cc.zone =3D zone;
 		status =3D compact_zone(&cc, NULL);
-
 		if (status =3D=3D COMPACT_SUCCESS) {
 			compaction_defer_reset(zone, cc.order, false);
 		} else if (status =3D=3D COMPACT_PARTIAL_SKIPPED || status =3D=3D COMPAC=
T_COMPLETE) {
@@ -2641,11 +2754,14 @@ static int kcompactd(void *p)
 	pgdat->kcompactd_classzone_idx =3D pgdat->nr_zones - 1;
=20
 	while (!kthread_should_stop()) {
-		unsigned long pflags;
+		unsigned long ret, pflags;
=20
 		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
-		wait_event_freezable(pgdat->kcompactd_wait,
-				kcompactd_work_requested(pgdat));
+		ret =3D wait_event_freezable_timeout(pgdat->kcompactd_wait,
+				kcompactd_work_requested(pgdat),
+				msecs_to_jiffies(500));
+		if (!ret)
+			continue;
=20
 		psi_memstall_enter(&pflags);
 		kcompactd_do_work(pgdat);
@@ -2726,6 +2842,9 @@ static int __init kcompactd_init(void)
 		return ret;
 	}
=20
+	compaction_init();
+	compaction_sysfs_init();
+
 	for_each_node_state(nid, N_MEMORY)
 		kcompactd_run(nid);
 	return 0;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 6afc892a148a..06abe3307db8 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1074,6 +1074,18 @@ static int __fragmentation_index(unsigned int order,=
 struct contig_page_info *in
 	return 1000 - div_u64( (1000+(div_u64(info->free_pages * 1000ULL, request=
ed))), info->free_blocks_total);
 }
=20
+int extfrag_for_order(struct zone *zone, unsigned int order)
+{
+	struct contig_page_info info;
+
+	fill_contig_page_info(zone, order, &info);
+	if (info.free_pages =3D=3D 0)
+		return 0;
+
+	return (info.free_pages - (info.free_blocks_suitable << order)) * 100
+							/ info.free_pages;
+}
+
 /* Same as __fragmentation index but allocs contig_page_info on stack */
 int fragmentation_index(struct zone *zone, unsigned int order)
 {
--=20
2.17.1

