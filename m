Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB5ECA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8430E20679
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvs5x+RQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfKBMCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 08:02:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60965 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726163AbfKBMCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 08:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572696162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jnRJATl2rQ2Q8B3WO/mOVZzhIP778upzYXYv5asejew=;
        b=bvs5x+RQsR525KU0+0bHZ2m1VvitVH505Qk5TXBhPFrLlgbJZDzaIKmtmKgvRK0L/mqQ5v
        Mv2DlamEXmhmKCVZ10mHk2V4hqEY2lMv6Ke/Rkcm6gZLLk6QF6+VogPPFN1qWfAb6UOCSX
        IP2JkSEmdnG75/LqoGuzSj1G0QYJfv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-VkXqf0sUO_K0WImVSzYJGQ-1; Sat, 02 Nov 2019 08:02:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBD34800EBA;
        Sat,  2 Nov 2019 12:02:38 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-109.ams2.redhat.com [10.36.116.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9CB61001E75;
        Sat,  2 Nov 2019 12:02:21 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Tang Chen <tangchen@cn.fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Keith Busch <keith.busch@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v3] mm/memory_hotplug: Fix try_offline_node()
Date:   Sat,  2 Nov 2019 13:02:21 +0100
Message-Id: <20191102120221.7553-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: VkXqf0sUO_K0WImVSzYJGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

try_offline_node() is pretty much broken right now:
- The node span is updated when onlining memory, not when adding it. We
  ignore memory that was mever onlined. Bad.
- We touch possible garbage memmaps. The pfn_to_nid(pfn) can easily
  trigger a kernel panic. Bad for memory that is offline but also bad
  for subsection hotadd with ZONE_DEVICE, whereby the memmap of the first
  PFN of a section might contain garbage.
- Sections belonging to mixed nodes are not properly considered.

As memory blocks might belong to multiple nodes, we would have to walk all
pageblocks (or at least subsections) within present sections. However,
we don't have a way to identify whether a memmap that is not online was
initialized (relevant for ZONE_DEVICE). This makes things more complicated.

Luckily, we can piggy pack on the node span and the nid stored in
memory blocks. Currently, the node span is grown when calling
move_pfn_range_to_zone() - e.g., when onlining memory, and shrunk when
removing memory, before calling try_offline_node(). Sysfs links are
created via link_mem_sections(), e.g., during boot or when adding memory.

If the node still spans memory or if any memory block belongs to the
nid, we don't set the node offline. As memory blocks that span multiple
nodes cannot get offlined, the nid stored in memory blocks is reliable
enough (for such online memory blocks, the node still spans the memory).

Introduce for_each_memory_block() to efficiently walk all memory blocks.

Note: We will soon stop shrinking the ZONE_DEVICE zone and the node span
when removing ZONE_DEVICE memory to fix similar issues (access of garbage
memmaps) - until we have a reliable way to identify whether these memmaps
were properly initialized. This implies later, that once a node had
ZONE_DEVICE memory, we won't be able to set a node offline -
which should be acceptable.

Since commit f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded
memory to zones until online") memory that is added is not assoziated
with a zone/node (memmap not initialized). The introducing
commit 60a5a19e7419 ("memory-hotplug: remove sysfs file of node") already
missed that we could have multiple nodes for a section and that the
zone/node span is updated when onlining pages, not when adding them.

I tested this by hotplugging two DIMMs to a memory-less and cpu-less NUMA
node. The node is properly onlined when adding the DIMMs. When removing
the DIMMs, the node is properly offlined.

Fixes: 60a5a19e7419 ("memory-hotplug: remove sysfs file of node")
Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory =
to zones until online") # visiable after d0dc12e86b319
Cc: Tang Chen <tangchen@cn.fujitsu.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

v2 -> v3:
- Introduce and use for_each_memory_block(), which will run significantly
  faster than walk_memory_blocks()

v1 -> v2:
- Drop sysfs handling, simplify, and add a comment
- Make sure to include last section fully

We stop shrinking the ZONE_DEVICE zone after the following patch:
 [PATCH v6 04/10] mm/memory_hotplug: Don't access uninitialized memmaps
 in shrink_zone_span()
This implies, the above note regarding ZONE_DEVICE on a node blocking a
node from getting offlined until we sorted out how to properly shrink
the ZONE_DEVICE zone.

This patch is especially important for:
 [PATCH v6 05/10] mm/memory_hotplug: Shrink zones when offlining
 memory
As the BUG fixed with this patch becomes now easier to observe when memory
is offlined (in contrast to when memory would never have been onlined
before).

As both patches are stable fixes and in next/master for a long time, we
should probably pull this patch in front of both and also backport this
patch at least to
 Cc: stable@vger.kernel.org # v4.13+
I have not checked yet if there are real blockers to do that. I guess not.

---
 drivers/base/memory.c  | 36 +++++++++++++++++++++++++++++++++++
 include/linux/memory.h |  1 +
 mm/memory_hotplug.c    | 43 ++++++++++++++++++++++++++----------------
 3 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index a757d9ed88a7..d65ecdeb83e8 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -867,3 +867,39 @@ int walk_memory_blocks(unsigned long start, unsigned l=
ong size,
 =09}
 =09return ret;
 }
+
+struct for_each_memory_block_cb_data {
+=09walk_memory_blocks_func_t func;
+=09void *arg;
+};
+
+static int for_each_memory_block_cb(struct device *dev, void *data)
+{
+=09struct memory_block *mem =3D to_memory_block(dev);
+=09struct for_each_memory_block_cb_data *cb_data =3D data;
+
+=09return cb_data->func(mem, cb_data->arg);
+}
+
+/**
+ * for_each_memory_block - walk through all present memory blocks
+ *
+ * @arg: argument passed to func
+ * @func: callback for each memory block walked
+ *
+ * This function walks through all present memory blocks, calling func on
+ * each memory block.
+ *
+ * In case func() returns an error, walking is aborted and the error is
+ * returned.
+ */
+int for_each_memory_block(void *arg, walk_memory_blocks_func_t func)
+{
+=09struct for_each_memory_block_cb_data cb_data =3D {
+=09=09.func =3D func,
+=09=09.arg =3D arg,
+=09};
+
+=09return bus_for_each_dev(&memory_subsys, NULL, &cb_data,
+=09=09=09=09for_each_memory_block_cb);
+}
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 0ebb105eb261..4c75dae8dd29 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -119,6 +119,7 @@ extern struct memory_block *find_memory_block(struct me=
m_section *);
 typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
 extern int walk_memory_blocks(unsigned long start, unsigned long size,
 =09=09=09      void *arg, walk_memory_blocks_func_t func);
+extern int for_each_memory_block(void *arg, walk_memory_blocks_func_t func=
);
 #define CONFIG_MEM_BLOCK_SIZE=09(PAGES_PER_SECTION<<PAGE_SHIFT)
 #endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
=20
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0140c20837b6..46b2e056a43f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1634,6 +1634,18 @@ static int check_cpu_on_node(pg_data_t *pgdat)
 =09return 0;
 }
=20
+static int check_no_memblock_for_node_cb(struct memory_block *mem, void *a=
rg)
+{
+=09int nid =3D *(int *)arg;
+
+=09/*
+=09 * If a memory block belongs to multiple nodes, the stored nid is not
+=09 * reliable. However, such blocks are always online (e.g., cannot get
+=09 * offlined) and, therefore, are still spanned by the node.
+=09 */
+=09return mem->nid =3D=3D nid ? -EEXIST : 0;
+}
+
 /**
  * try_offline_node
  * @nid: the node ID
@@ -1646,25 +1658,24 @@ static int check_cpu_on_node(pg_data_t *pgdat)
 void try_offline_node(int nid)
 {
 =09pg_data_t *pgdat =3D NODE_DATA(nid);
-=09unsigned long start_pfn =3D pgdat->node_start_pfn;
-=09unsigned long end_pfn =3D start_pfn + pgdat->node_spanned_pages;
-=09unsigned long pfn;
-
-=09for (pfn =3D start_pfn; pfn < end_pfn; pfn +=3D PAGES_PER_SECTION) {
-=09=09unsigned long section_nr =3D pfn_to_section_nr(pfn);
-
-=09=09if (!present_section_nr(section_nr))
-=09=09=09continue;
+=09int rc;
=20
-=09=09if (pfn_to_nid(pfn) !=3D nid)
-=09=09=09continue;
+=09/*
+=09 * If the node still spans pages (especially ZONE_DEVICE), don't
+=09 * offline it. A node spans memory after move_pfn_range_to_zone(),
+=09 * e.g., after the memory block was onlined.
+=09 */
+=09if (pgdat->node_spanned_pages)
+=09=09return;
=20
-=09=09/*
-=09=09 * some memory sections of this node are not removed, and we
-=09=09 * can't offline node now.
-=09=09 */
+=09/*
+=09 * Especially offline memory blocks might not be spanned by the
+=09 * node. They will get spanned by the node once they get onlined.
+=09 * However, they link to the node in sysfs and can get onlined later.
+=09 */
+=09rc =3D for_each_memory_block(&nid, check_no_memblock_for_node_cb);
+=09if (rc)
 =09=09return;
-=09}
=20
 =09if (check_cpu_on_node(pgdat))
 =09=09return;
--=20
2.21.0

