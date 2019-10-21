Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE55CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC462077C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Py4n80tN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfJURYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 13:24:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33649 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726819AbfJURYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571678652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UvH8Ol4VAdo7noZ3C65OrAnCzJI5GL3IcQ02s8qoRYQ=;
        b=Py4n80tNb4NzA0X/waRJf1VBefp1hulW2XVqT81Ys1wkQwhqRLu6p4gVLfNlwjx0AJPpRB
        Z7INnZAZvqWVPD9pgl6e88KWdS/gqLjgUpcs9mIDpELsOEoFRp26W5Aw8+LeUb8LvTqU5O
        oQk0z2y3Jxv1Tm5BbWw+F7qwzOmoTOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-EsPr5lRHNQKd3l15BJ32Vw-1; Mon, 21 Oct 2019 13:24:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2105F47B;
        Mon, 21 Oct 2019 17:24:07 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-42.ams2.redhat.com [10.36.116.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6D0460A9F;
        Mon, 21 Oct 2019 17:24:01 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>
Subject: [PATCH v2 1/2] mm/page_alloc.c: Don't set pages PageReserved() when offlining
Date:   Mon, 21 Oct 2019 19:23:52 +0200
Message-Id: <20191021172353.3056-2-david@redhat.com>
In-Reply-To: <20191021172353.3056-1-david@redhat.com>
References: <20191021172353.3056-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: EsPr5lRHNQKd3l15BJ32Vw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We call __offline_isolated_pages() from __offline_pages() after all
pages were isolated and are either free (PageBuddy()) or PageHWPoison.
Nothing can stop us from offlining memory at this point.

In __offline_isolated_pages() we first set all affected memory sections
offline (offline_mem_sections(pfn, end_pfn)), to mark the memmap as
invalid (pfn_to_online_page() will no longer succeed), and then walk over
all pages to pull the free pages from the free lists (to the isolated
free lists, to be precise).

Note that re-onlining a memory block will result in the whole memmap
getting reinitialized, overwriting any old state. We already poision the
memmap when offlining is complete to find any access to
stale/uninitialized memmaps.

So, setting the pages PageReserved() is not helpful. The memap is marked
offline and all pageblocks are isolated. As soon as offline, the memmap
is stale either way.

This looks like a leftover from ancient times where we initialized the
memmap when adding memory and not when onlining it (the pages were set
PageReserved so re-onling would work as expected).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 4 +---
 mm/page_alloc.c     | 5 +----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 5e6b2a312362..3524e2e1a9df 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1346,9 +1346,7 @@ do_migrate_range(unsigned long start_pfn, unsigned lo=
ng end_pfn)
 =09return ret;
 }
=20
-/*
- * remove from free_area[] and mark all as Reserved.
- */
+/* Mark all sections offline and remove all free pages from the buddy. */
 static int
 offline_isolated_pages_cb(unsigned long start, unsigned long nr_pages,
 =09=09=09void *data)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ed8884dc0c47..bf6b21f02154 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8667,7 +8667,7 @@ __offline_isolated_pages(unsigned long start_pfn, uns=
igned long end_pfn)
 {
 =09struct page *page;
 =09struct zone *zone;
-=09unsigned int order, i;
+=09unsigned int order;
 =09unsigned long pfn;
 =09unsigned long flags;
 =09unsigned long offlined_pages =3D 0;
@@ -8695,7 +8695,6 @@ __offline_isolated_pages(unsigned long start_pfn, uns=
igned long end_pfn)
 =09=09 */
 =09=09if (unlikely(!PageBuddy(page) && PageHWPoison(page))) {
 =09=09=09pfn++;
-=09=09=09SetPageReserved(page);
 =09=09=09offlined_pages++;
 =09=09=09continue;
 =09=09}
@@ -8709,8 +8708,6 @@ __offline_isolated_pages(unsigned long start_pfn, uns=
igned long end_pfn)
 =09=09=09pfn, 1 << order, end_pfn);
 #endif
 =09=09del_page_from_free_area(page, &zone->free_area[order]);
-=09=09for (i =3D 0; i < (1 << order); i++)
-=09=09=09SetPageReserved((page+i));
 =09=09pfn +=3D (1 << order);
 =09}
 =09spin_unlock_irqrestore(&zone->lock, flags);
--=20
2.21.0

