Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4A1C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFF4222C7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gy1+laFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfKSLwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:52:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51149 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726265AbfKSLwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574164367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PsXYX0X2r85QXAS5qwE4s/140V6fNQdbPj8fpf5crLs=;
        b=Gy1+laFEBP6/872iNGSo68v+BRwgI+u7A07wL/4Cq/CfizcwYOSR43YzjCRYDemLpJQChA
        a17mJjVqvgXhk/fXWT9HfTfEWZIqciozRvhppGsSSbx8+QbGavr6xNU6ljcDKdAv60l5x3
        KnnatGympJ8gqjzqJ7OwHdRINfXcOiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-O-vw1vSZNwe-KtEmrgt9FA-1; Tue, 19 Nov 2019 06:52:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2B591852E20;
        Tue, 19 Nov 2019 11:52:42 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-126.ams2.redhat.com [10.36.117.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 580BD10246F6;
        Tue, 19 Nov 2019 11:52:38 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v2] mm/memory_hotplug: Don't allow to online/offline memory blocks with holes
Date:   Tue, 19 Nov 2019 12:52:37 +0100
Message-Id: <20191119115237.6662-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: O-vw1vSZNwe-KtEmrgt9FA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our onlining/offlining code is unnecessarily complicated. Only memory
blocks added during boot can have holes (a range that is not
IORESOURCE_SYSTEM_RAM). Hotplugged memory never has holes (e.g., see
add_memory_resource()). All memory blocks that belong to boot memory are
already online.

Note that boot memory can have holes and the memmap of the holes is marked
PG_reserved. However, also memory allocated early during boot is
PG_reserved - basically every page of boot memory that is not given to the
buddy is PG_reserved.

Therefore, when we stop allowing to offline memory blocks with holes, we
implicitly no longer have to deal with onlining memory blocks with holes.
E.g., online_pages() will do a
walk_system_ram_range(..., online_pages_range), whereby
online_pages_range() will effectively only free the memory holes not
falling into a hole to the buddy. The other pages (holes) are kept
PG_reserved (via move_pfn_range_to_zone()->memmap_init_zone()).

This allows to simplify the code. For example, we no longer have to
worry about marking pages that fall into memory holes PG_reserved when
onlining memory. We can stop setting pages PG_reserved completely in
memmap_init_zone().

Offlining memory blocks added during boot is usually not guaranteed to work
either way (unmovable data might have easily ended up on that memory during
boot). So stopping to do that should not really hurt. Also, people are not
even aware of a setup where onlining/offlining of memory blocks with
holes used to work reliably (see [1] and [2] especially regarding the
hotplug path) - I doubt it worked reliably.

For the use case of offlining memory to unplug DIMMs, we should see no
change. (holes on DIMMs would be weird).

Please note that hardware errors (PG_hwpoison) are not memory holes and
are not affected by this change when offlining.

[1] https://lkml.org/lkml/2019/10/22/135
[2] https://lkml.org/lkml/2019/8/14/1365

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

This patch was part of:
=09[PATCH v1 00/10] mm: Don't mark hotplugged pages PG_reserved
=09(including ZONE_DEVICE)
=09-> https://www.spinics.net/lists/linux-driver-devel/msg130042.html

However, before we can perform the PG_reserved changes, we have to fix
pfn_to_online_page() in special scenarios first (bootmem and devmem falling
into a single section). Dan is working on that.

I propose to give this patch a churn in -next so we can identify if this
change would break any existing setup. I will then follow up with cleanups
and the PG_reserved changes later.

---
 mm/memory_hotplug.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 46b2e056a43f..fc617ad6f035 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1455,10 +1455,19 @@ static void node_states_clear_node(int node, struct=
 memory_notify *arg)
 =09=09node_clear_state(node, N_MEMORY);
 }
=20
+static int count_system_ram_pages_cb(unsigned long start_pfn,
+=09=09=09=09     unsigned long nr_pages, void *data)
+{
+=09unsigned long *nr_system_ram_pages =3D data;
+
+=09*nr_system_ram_pages +=3D nr_pages;
+=09return 0;
+}
+
 static int __ref __offline_pages(unsigned long start_pfn,
 =09=09  unsigned long end_pfn)
 {
-=09unsigned long pfn, nr_pages;
+=09unsigned long pfn, nr_pages =3D 0;
 =09unsigned long offlined_pages =3D 0;
 =09int ret, node, nr_isolate_pageblock;
 =09unsigned long flags;
@@ -1469,6 +1478,22 @@ static int __ref __offline_pages(unsigned long start=
_pfn,
=20
 =09mem_hotplug_begin();
=20
+=09/*
+=09 * Don't allow to offline memory blocks that contain holes.
+=09 * Consequently, memory blocks with holes can never get onlined
+=09 * via the hotplug path - online_pages() - as hotplugged memory has
+=09 * no holes. This way, we e.g., don't have to worry about marking
+=09 * memory holes PG_reserved, don't need pfn_valid() checks, and can
+=09 * avoid using walk_system_ram_range() later.
+=09 */
+=09walk_system_ram_range(start_pfn, end_pfn - start_pfn, &nr_pages,
+=09=09=09      count_system_ram_pages_cb);
+=09if (nr_pages !=3D end_pfn - start_pfn) {
+=09=09ret =3D -EINVAL;
+=09=09reason =3D "memory holes";
+=09=09goto failed_removal;
+=09}
+
 =09/* This makes hotplug much easier...and readable.
 =09   we assume this for now. .*/
 =09if (!test_pages_in_a_zone(start_pfn, end_pfn, &valid_start,
@@ -1480,7 +1505,6 @@ static int __ref __offline_pages(unsigned long start_=
pfn,
=20
 =09zone =3D page_zone(pfn_to_page(valid_start));
 =09node =3D zone_to_nid(zone);
-=09nr_pages =3D end_pfn - start_pfn;
=20
 =09/* set above range as isolated */
 =09ret =3D start_isolate_page_range(start_pfn, end_pfn,
--=20
2.21.0

