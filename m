Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6095C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE692084B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsFnrhH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfK0RmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:42:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39912 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726510AbfK0RmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574876527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fu4vXbUUMvSBjPH2M1cbMw0k+CW6yRG7pnf382Atz/c=;
        b=bsFnrhH2KzgVG+XqPjfD9hQiHbbIHMpD5EyzIbDUTj1ORC0q3Wl+0rcWaqM94koZW+Bevh
        /5jScJ7XRFiZ/TaLbt4Vuqsj6cWkh5J1NH5cLULTvSd4cWbdvrDtN7vEanKcVLl7H7OjQY
        2HKDYL//cI6H6XRyjbYsjqxAeYrozog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-ZGaArMaFOLCh192yX9tacQ-1; Wed, 27 Nov 2019 12:42:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 376A4107ACE3;
        Wed, 27 Nov 2019 17:42:03 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-69.ams2.redhat.com [10.36.116.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13B8E608B9;
        Wed, 27 Nov 2019 17:41:58 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1] mm/memory_hotplug: don't check the nid in find_(smallest|biggest)_section_pfn
Date:   Wed, 27 Nov 2019 18:41:58 +0100
Message-Id: <20191127174158.28226-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ZGaArMaFOLCh192yX9tacQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we always check against a zone, we can stop checking against
the nid, it is implicitly covered by the zone.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 46b2e056a43f..602f753c662c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -344,17 +344,14 @@ int __ref __add_pages(int nid, unsigned long pfn, uns=
igned long nr_pages,
 }
=20
 /* find the smallest valid pfn in the range [start_pfn, end_pfn) */
-static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
-=09=09=09=09     unsigned long start_pfn,
-=09=09=09=09     unsigned long end_pfn)
+static unsigned long find_smallest_section_pfn(struct zone *zone,
+=09=09=09=09=09       unsigned long start_pfn,
+=09=09=09=09=09       unsigned long end_pfn)
 {
 =09for (; start_pfn < end_pfn; start_pfn +=3D PAGES_PER_SUBSECTION) {
 =09=09if (unlikely(!pfn_to_online_page(start_pfn)))
 =09=09=09continue;
=20
-=09=09if (unlikely(pfn_to_nid(start_pfn) !=3D nid))
-=09=09=09continue;
-
 =09=09if (zone !=3D page_zone(pfn_to_page(start_pfn)))
 =09=09=09continue;
=20
@@ -365,9 +362,9 @@ static unsigned long find_smallest_section_pfn(int nid,=
 struct zone *zone,
 }
=20
 /* find the biggest valid pfn in the range [start_pfn, end_pfn). */
-static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
-=09=09=09=09    unsigned long start_pfn,
-=09=09=09=09    unsigned long end_pfn)
+static unsigned long find_biggest_section_pfn(struct zone *zone,
+=09=09=09=09=09      unsigned long start_pfn,
+=09=09=09=09=09      unsigned long end_pfn)
 {
 =09unsigned long pfn;
=20
@@ -377,9 +374,6 @@ static unsigned long find_biggest_section_pfn(int nid, =
struct zone *zone,
 =09=09if (unlikely(!pfn_to_online_page(pfn)))
 =09=09=09continue;
=20
-=09=09if (unlikely(pfn_to_nid(pfn) !=3D nid))
-=09=09=09continue;
-
 =09=09if (zone !=3D page_zone(pfn_to_page(pfn)))
 =09=09=09continue;
=20
@@ -393,7 +387,6 @@ static void shrink_zone_span(struct zone *zone, unsigne=
d long start_pfn,
 =09=09=09     unsigned long end_pfn)
 {
 =09unsigned long pfn;
-=09int nid =3D zone_to_nid(zone);
=20
 =09zone_span_writelock(zone);
 =09if (zone->zone_start_pfn =3D=3D start_pfn) {
@@ -403,7 +396,7 @@ static void shrink_zone_span(struct zone *zone, unsigne=
d long start_pfn,
 =09=09 * In this case, we find second smallest valid mem_section
 =09=09 * for shrinking zone.
 =09=09 */
-=09=09pfn =3D find_smallest_section_pfn(nid, zone, end_pfn,
+=09=09pfn =3D find_smallest_section_pfn(zone, end_pfn,
 =09=09=09=09=09=09zone_end_pfn(zone));
 =09=09if (pfn) {
 =09=09=09zone->spanned_pages =3D zone_end_pfn(zone) - pfn;
@@ -419,7 +412,7 @@ static void shrink_zone_span(struct zone *zone, unsigne=
d long start_pfn,
 =09=09 * In this case, we find second biggest valid mem_section for
 =09=09 * shrinking zone.
 =09=09 */
-=09=09pfn =3D find_biggest_section_pfn(nid, zone, zone->zone_start_pfn,
+=09=09pfn =3D find_biggest_section_pfn(zone, zone->zone_start_pfn,
 =09=09=09=09=09       start_pfn);
 =09=09if (pfn)
 =09=09=09zone->spanned_pages =3D pfn - zone->zone_start_pfn + 1;
--=20
2.21.0

