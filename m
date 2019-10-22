Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1553DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13E22084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWK9/qJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389406AbfJVQWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:22:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43455 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388713AbfJVQWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571761359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=C4NOIOVvdrhzwymDNbd8vVDR4monhBKtMiBMiTTo7rY=;
        b=hWK9/qJi0nS0BaWh4e/w5WwNF9IPEcd9jsjw/lSLnGmwT3y5KFgH9UlyoDL/12FwfQbyQE
        j3muiRGUxEL6uOyC8hRkL3skOwUaWdbepnamhfVuy2tWS7Z3zXI1vktNp+MaEGYe7NVntX
        BB0rbVedzKrMI/dH0iugLs6R3Ad907Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-hv_qLxVuPQWgmwwdBheuAw-1; Tue, 22 Oct 2019 12:22:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30AFF80183D;
        Tue, 22 Oct 2019 16:22:33 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9190E10027A1;
        Tue, 22 Oct 2019 16:22:26 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/vmstat: Reduce zone lock hold time when reading /proc/pagetypeinfo
Date:   Tue, 22 Oct 2019 12:21:56 -0400
Message-Id: <20191022162156.17316-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: hv_qLxVuPQWgmwwdBheuAw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pagetypeinfo_showfree_print() function prints out the number of
free blocks for each of the page orders and migrate types. The current
code just iterates the each of the free lists to get counts.  There are
bug reports about hard lockup panics when reading the /proc/pagetyeinfo
file just because it look too long to iterate all the free lists within
a zone while holing the zone lock with irq disabled.

Given the fact that /proc/pagetypeinfo is readable by all, the possiblity
of crashing a system by the simple act of reading /proc/pagetypeinfo
by any user is a security problem that needs to be addressed.

There is a free_area structure associated with each page order. There
is also a nr_free count within the free_area for all the different
migration types combined. Tracking the number of free list entries
for each migration type will probably add some overhead to the fast
paths like moving pages from one migration type to another which may
not be desirable.

we can actually skip iterating the list of one of the migration types
and used nr_free to compute the missing count. Since MIGRATE_MOVABLE
is usually the largest one on large memory systems, this is the one
to be skipped. Since the printing order is migration-type =3D> order, we
will have to store the counts in an internal 2D array before printing
them out.

Even by skipping the MIGRATE_MOVABLE pages, we may still be holding the
zone lock for too long blocking out other zone lock waiters from being
run. This can be problematic for systems with large amount of memory.
So a check is added to temporarily release the lock and reschedule if
more than 64k of list entries have been iterated for each order. With
a MAX_ORDER of 11, the worst case will be iterating about 700k of list
entries before releasing the lock.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/vmstat.c | 51 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 6afc892a148a..40c9a1494709 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1373,23 +1373,54 @@ static void pagetypeinfo_showfree_print(struct seq_=
file *m,
 =09=09=09=09=09pg_data_t *pgdat, struct zone *zone)
 {
 =09int order, mtype;
+=09unsigned long nfree[MAX_ORDER][MIGRATE_TYPES];
=20
-=09for (mtype =3D 0; mtype < MIGRATE_TYPES; mtype++) {
-=09=09seq_printf(m, "Node %4d, zone %8s, type %12s ",
-=09=09=09=09=09pgdat->node_id,
-=09=09=09=09=09zone->name,
-=09=09=09=09=09migratetype_names[mtype]);
-=09=09for (order =3D 0; order < MAX_ORDER; ++order) {
+=09lockdep_assert_held(&zone->lock);
+=09lockdep_assert_irqs_disabled();
+
+=09/*
+=09 * MIGRATE_MOVABLE is usually the largest one in large memory
+=09 * systems. We skip iterating that list. Instead, we compute it by
+=09 * subtracting the total of the rests from free_area->nr_free.
+=09 */
+=09for (order =3D 0; order < MAX_ORDER; ++order) {
+=09=09unsigned long nr_total =3D 0;
+=09=09struct free_area *area =3D &(zone->free_area[order]);
+
+=09=09for (mtype =3D 0; mtype < MIGRATE_TYPES; mtype++) {
 =09=09=09unsigned long freecount =3D 0;
-=09=09=09struct free_area *area;
 =09=09=09struct list_head *curr;
=20
-=09=09=09area =3D &(zone->free_area[order]);
-
+=09=09=09if (mtype =3D=3D MIGRATE_MOVABLE)
+=09=09=09=09continue;
 =09=09=09list_for_each(curr, &area->free_list[mtype])
 =09=09=09=09freecount++;
-=09=09=09seq_printf(m, "%6lu ", freecount);
+=09=09=09nfree[order][mtype] =3D freecount;
+=09=09=09nr_total +=3D freecount;
 =09=09}
+=09=09nfree[order][MIGRATE_MOVABLE] =3D area->nr_free - nr_total;
+
+=09=09/*
+=09=09 * If we have already iterated more than 64k of list
+=09=09 * entries, we might have hold the zone lock for too long.
+=09=09 * Temporarily release the lock and reschedule before
+=09=09 * continuing so that other lock waiters have a chance
+=09=09 * to run.
+=09=09 */
+=09=09if (nr_total > (1 << 16)) {
+=09=09=09spin_unlock_irq(&zone->lock);
+=09=09=09cond_resched();
+=09=09=09spin_lock_irq(&zone->lock);
+=09=09}
+=09}
+
+=09for (mtype =3D 0; mtype < MIGRATE_TYPES; mtype++) {
+=09=09seq_printf(m, "Node %4d, zone %8s, type %12s ",
+=09=09=09=09=09pgdat->node_id,
+=09=09=09=09=09zone->name,
+=09=09=09=09=09migratetype_names[mtype]);
+=09=09for (order =3D 0; order < MAX_ORDER; ++order)
+=09=09=09seq_printf(m, "%6lu ", nfree[order][mtype]);
 =09=09seq_putc(m, '\n');
 =09}
 }
--=20
2.18.1

