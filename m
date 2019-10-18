Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8638CA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E4121D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="A0BdNat4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407319AbfJRA2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:28:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8396 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406928AbfJRA2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:28:42 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9I0NcwL008470
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=V0YM/pCY9GLC/OQdYE1wIpM4De9idAVu4Mjnr3cz5NE=;
 b=A0BdNat4X8rp15Sa2mMZvJJHR8nBRZ8XtxdWss1kzxwAIB9QvjwagT2Rsl5exfykhW5L
 +qXM5cq2YQvkTNfetyn1ich9cAe3PbkJzDD0axto7+pmMG6O/uaz/cYjhONLR0I7n9Ad
 MhVrYLUWWRfOu5vxaFXUnuw/Mj5FBhCTGU0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vpw9r9fae-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:41 -0700
Received: from 2401:db00:30:600c:face:0:39:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Oct 2019 17:28:36 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 1FE2218CE8491; Thu, 17 Oct 2019 17:28:34 -0700 (PDT)
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
Subject: [PATCH 15/16] tools/cgroup: make slabinfo.py compatible with new slab controller
Date:   Thu, 17 Oct 2019 17:28:19 -0700
Message-ID: <20191018002820.307763-16-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018002820.307763-1-guro@fb.com>
References: <20191018002820.307763-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_07:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=726
 lowpriorityscore=0 mlxscore=0 suspectscore=1 phishscore=0 clxscore=1015
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make slabinfo.py compatible with the new slab controller.

Because there are no more per-memcg kmem_caches, and also there
is no list of all slab pages in the system, it has to walk over
all pages and filter out slab pages belonging to non-root kmem_caches.

Then it counts objects belonging to the given cgroup. It might
sound as a very slow operation, however it's not so slow. It takes
about 30s seconds to walk over 8Gb of slabs out of 64Gb, and filter
out all objects belonging to the cgroup of interest.

Also, it provides an accurate number of active objects, which isn't
true for the old slab controller.

The script is backward compatible and works for both kernel versions.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 tools/cgroup/slabinfo.py | 105 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 98 insertions(+), 7 deletions(-)

diff --git a/tools/cgroup/slabinfo.py b/tools/cgroup/slabinfo.py
index 40b01a6ec4b0..79909ee36fe3 100755
--- a/tools/cgroup/slabinfo.py
+++ b/tools/cgroup/slabinfo.py
@@ -8,7 +8,10 @@ import argparse
 import sys
 
 from drgn.helpers.linux import list_for_each_entry, list_empty
-from drgn import container_of
+from drgn.helpers.linux import for_each_page
+from drgn.helpers.linux.cpumask import for_each_online_cpu
+from drgn.helpers.linux.percpu import per_cpu_ptr
+from drgn import container_of, FaultError
 
 
 DESC = """
@@ -47,7 +50,7 @@ def is_root_cache(s):
 
 def cache_name(s):
     if is_root_cache(s):
-        return s.name
+        return s.name.string_().decode('utf-8')
     else:
         return s.memcg_params.root_cache.name.string_().decode('utf-8')
 
@@ -99,12 +102,16 @@ def slub_get_slabinfo(s, cfg):
 # SLAB-specific functions can be added here...
 
 
-def cache_show(s, cfg):
+def cache_show(s, cfg, objs):
     if cfg['allocator'] == 'SLUB':
         sinfo = slub_get_slabinfo(s, cfg)
     else:
         err('SLAB isn\'t supported yet')
 
+    if cfg['shared_slab_pages']:
+        sinfo['active_objs'] = objs
+        sinfo['num_objs'] = objs
+
     print('%-17s %6lu %6lu %6u %4u %4d'
           ' : tunables %4u %4u %4u'
           ' : slabdata %6lu %6lu %6lu' % (
@@ -127,9 +134,60 @@ def detect_kernel_config():
     else:
         err('Can\'t determine the slab allocator')
 
+    if prog.type('struct memcg_cache_params').members[1][1] == 'memcg_cache':
+        cfg['shared_slab_pages'] = True
+    else:
+        cfg['shared_slab_pages'] = False
+
     return cfg
 
 
+def for_each_slab_page(prog):
+    PGSlab = 1 << prog.constant('PG_slab')
+    PGHead = 1 << prog.constant('PG_head')
+
+    for page in for_each_page(prog):
+        try:
+            if page.flags.value_() & PGSlab:
+                yield page
+        except FaultError:
+            pass
+
+
+# it doesn't find all objects, because by default full slabs are not
+# placed to the full list. however, it can be used in certain cases.
+def for_each_slab_page_fast(prog):
+    for s in list_for_each_entry('struct kmem_cache',
+                                 prog['slab_caches'].address_of_(),
+                                 'list'):
+        if is_root_cache(s):
+            continue
+
+        if s.cpu_partial:
+            for cpu in for_each_online_cpu(prog):
+                cpu_slab = per_cpu_ptr(s.cpu_slab, cpu)
+                if cpu_slab.page:
+                    yield cpu_slab.page
+
+                page = cpu_slab.partial
+                while page:
+                    yield page
+                    page = page.next
+
+        for node in range(prog['nr_online_nodes'].value_()):
+            n = s.node[node]
+
+            for page in list_for_each_entry('struct page',
+                                            n.partial.address_of_(),
+                                            'slab_list'):
+                yield page
+
+            for page in list_for_each_entry('struct page',
+                                            n.full.address_of_(),
+                                            'slab_list'):
+                yield page
+
+
 def main():
     parser = argparse.ArgumentParser(description=DESC,
                                      formatter_class=argparse.RawTextHelpFormatter)
@@ -150,10 +208,43 @@ def main():
           ' : tunables <limit> <batchcount> <sharedfactor>'
           ' : slabdata <active_slabs> <num_slabs> <sharedavail>')
 
-    for s in list_for_each_entry('struct kmem_cache',
-                                 memcg.kmem_caches.address_of_(),
-                                 'memcg_params.kmem_caches_node'):
-        cache_show(s, cfg)
+    if cfg['shared_slab_pages']:
+        memcg_ptrs = set()
+        stats = {}
+        caches = {}
+
+        # find memcg pointers belonging to the specified cgroup
+        for ptr in list_for_each_entry('struct mem_cgroup_ptr',
+                                       memcg.kmem_memcg_ptr_list.address_of_(),
+                                       'list'):
+            memcg_ptrs.add(ptr.value_())
+
+        # look over all slab pages, belonging to non-root memcgs
+        # and look for objects belonging to the given memory cgroup
+        for page in for_each_slab_page(prog):
+            cache = page.slab_cache
+            if not cache or is_root_cache(cache):
+                continue
+            addr = cache.value_()
+            caches[addr] = cache
+            memcg_vec = page.mem_cgroup_vec
+
+            if addr not in stats:
+                stats[addr] = 0
+
+            for i in range(oo_objects(cache)):
+                if memcg_vec[i].value_() in memcg_ptrs:
+                    stats[addr] += 1
+
+        for addr in caches:
+            if stats[addr] > 0:
+                cache_show(caches[addr], cfg, stats[addr])
+
+    else:
+        for s in list_for_each_entry('struct kmem_cache',
+                                     memcg.kmem_caches.address_of_(),
+                                     'memcg_params.kmem_caches_node'):
+            cache_show(s, cfg, None)
 
 
 main()
-- 
2.21.0

