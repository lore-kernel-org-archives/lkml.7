Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D03CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 22:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAAD214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 22:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A61E7LDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfJ0W11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 18:27:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34458 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726717AbfJ0W11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 18:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572215246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wRHG8SDGIYgraIGReOni3E60U4X7OoMWr6f5ZsbvZJU=;
        b=A61E7LDky5LozS2T248aVDpYauGsh09IaPeBDbRdWETm2mK3KG7boUYFykMCbYC4uieOMz
        PUcOPVA5Dtzc+kZvRL11md0B9wPOthNBQX93QST6M1MX2vbbMTVmi3dHSjxdWMVNi/jrDt
        PZFu2Pm71UcceNcLfbDhSW/hoHHFY2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-N3mIgUl8NmS54_KnDVdKfQ-1; Sun, 27 Oct 2019 18:27:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7617476;
        Sun, 27 Oct 2019 22:27:20 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-60.ams2.redhat.com [10.36.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D93519C68;
        Sun, 27 Oct 2019 22:27:15 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1] mm/memory_hotplug: Fix updating the node span
Date:   Sun, 27 Oct 2019 23:27:14 +0100
Message-Id: <20191027222714.5313-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: N3mIgUl8NmS54_KnDVdKfQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently started updating the node span based on the zone span to
avoid touching uninitialized memmaps.

Currently, we will always detect the node span to start at 0, meaning a
node can easily span too many pages. pgdat_is_empty() will still work
correctly if all zones span no pages. We should skip over all zones without
spanned pages and properly handle the first detected zone that spans pages.

Unfortunately, in contrast to the zone span (/proc/zoneinfo), the node span
cannot easily be inspected and tested. The node span gives no real
guarantees when an architecture supports memory hotplug, meaning it can
easily contain holes or span pages of different nodes.

The node span is not really used after init on architectures that support
memory hotplug. E.g., we use it in mm/memory_hotplug.c:try_offline_node()
and in mm/kmemleak.c:kmemleak_scan(). These users seem to be fine.

Fixes: 00d6c019b5bc ("mm/memory_hotplug: don't access uninitialized memmaps=
 in shrink_pgdat_span()")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Luckily, this patch made me realize that try_offline_node() is completely
broken:
- We easily touch the (garbage) memmap of offline sections
- We will not properly handle the case where we have different NIDs within
  a single section
This needs proper fixing. We will have to look at the memory block nid
of offline memory blocks and scan all pages (or rather pageblocks) of
online memory blocks.

---
 mm/memory_hotplug.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 561371ead39a..0140c20837b6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -442,6 +442,14 @@ static void update_pgdat_span(struct pglist_data *pgda=
t)
 =09=09=09=09=09     zone->spanned_pages;
=20
 =09=09/* No need to lock the zones, they can't change. */
+=09=09if (!zone->spanned_pages)
+=09=09=09continue;
+=09=09if (!node_end_pfn) {
+=09=09=09node_start_pfn =3D zone->zone_start_pfn;
+=09=09=09node_end_pfn =3D zone_end_pfn;
+=09=09=09continue;
+=09=09}
+
 =09=09if (zone_end_pfn > node_end_pfn)
 =09=09=09node_end_pfn =3D zone_end_pfn;
 =09=09if (zone->zone_start_pfn < node_start_pfn)
--=20
2.21.0

