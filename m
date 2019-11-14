Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307D0C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F452071B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SL9kRBTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKNNTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:19:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25151 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726190AbfKNNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573737570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FShlsdp9uAT9PPnDzdG1aOkyx6w1qRrFXco73XPgz9g=;
        b=SL9kRBTNV7DnZeaZSQNnpUQWaMyU4+HuTO5JuHHgVbyINrt7TWjmereYMXNSQS3XeQKGMg
        6Kbkt/l46s03STqqeuPUKyiz3/48lk0awYvZ1ISpzwN752dMVkg4nFRj4ErC9aTX56xUoB
        SHvrNMYRwqQyw/7ddxyuvFl6TMviV2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-IAawIluHMLCgkj3eAzTO6w-1; Thu, 14 Nov 2019 08:19:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DCE51852E20;
        Thu, 14 Nov 2019 13:19:25 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-13.ams2.redhat.com [10.36.117.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F14610013D9;
        Thu, 14 Nov 2019 13:19:21 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>, Qian Cai <cai@lca.pw>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 1/2] mm: remove the memory isolate notifier
Date:   Thu, 14 Nov 2019 14:19:10 +0100
Message-Id: <20191114131911.11783-2-david@redhat.com>
In-Reply-To: <20191114131911.11783-1-david@redhat.com>
References: <20191114131911.11783-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: IAawIluHMLCgkj3eAzTO6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luckily, we have no users left, so we can get rid of it. Cleanup
set_migratetype_isolate() a little bit.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Qian Cai <cai@lca.pw>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c  | 19 -------------------
 include/linux/memory.h | 27 ---------------------------
 mm/page_isolation.c    | 38 ++++----------------------------------
 3 files changed, 4 insertions(+), 80 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index a757d9ed88a7..03c18c97c2bf 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -73,20 +73,6 @@ void unregister_memory_notifier(struct notifier_block *n=
b)
 }
 EXPORT_SYMBOL(unregister_memory_notifier);
=20
-static ATOMIC_NOTIFIER_HEAD(memory_isolate_chain);
-
-int register_memory_isolate_notifier(struct notifier_block *nb)
-{
-=09return atomic_notifier_chain_register(&memory_isolate_chain, nb);
-}
-EXPORT_SYMBOL(register_memory_isolate_notifier);
-
-void unregister_memory_isolate_notifier(struct notifier_block *nb)
-{
-=09atomic_notifier_chain_unregister(&memory_isolate_chain, nb);
-}
-EXPORT_SYMBOL(unregister_memory_isolate_notifier);
-
 static void memory_block_release(struct device *dev)
 {
 =09struct memory_block *mem =3D to_memory_block(dev);
@@ -178,11 +164,6 @@ int memory_notify(unsigned long val, void *v)
 =09return blocking_notifier_call_chain(&memory_chain, val, v);
 }
=20
-int memory_isolate_notify(unsigned long val, void *v)
-{
-=09return atomic_notifier_call_chain(&memory_isolate_chain, val, v);
-}
-
 /*
  * The probe routines leave the pages uninitialized, just as the bootmem c=
ode
  * does. Make sure we do not access them, but instead use only information=
 from
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 0ebb105eb261..d3fde2d0d94b 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -55,19 +55,6 @@ struct memory_notify {
 =09int status_change_nid;
 };
=20
-/*
- * During pageblock isolation, count the number of pages within the
- * range [start_pfn, start_pfn + nr_pages) which are owned by code
- * in the notifier chain.
- */
-#define MEM_ISOLATE_COUNT=09(1<<0)
-
-struct memory_isolate_notify {
-=09unsigned long start_pfn;=09/* Start of range to check */
-=09unsigned int nr_pages;=09=09/* # pages in range to check */
-=09unsigned int pages_found;=09/* # pages owned found by callbacks */
-};
-
 struct notifier_block;
 struct mem_section;
=20
@@ -94,27 +81,13 @@ static inline int memory_notify(unsigned long val, void=
 *v)
 {
 =09return 0;
 }
-static inline int register_memory_isolate_notifier(struct notifier_block *=
nb)
-{
-=09return 0;
-}
-static inline void unregister_memory_isolate_notifier(struct notifier_bloc=
k *nb)
-{
-}
-static inline int memory_isolate_notify(unsigned long val, void *v)
-{
-=09return 0;
-}
 #else
 extern int register_memory_notifier(struct notifier_block *nb);
 extern void unregister_memory_notifier(struct notifier_block *nb);
-extern int register_memory_isolate_notifier(struct notifier_block *nb);
-extern void unregister_memory_isolate_notifier(struct notifier_block *nb);
 int create_memory_block_devices(unsigned long start, unsigned long size);
 void remove_memory_block_devices(unsigned long start, unsigned long size);
 extern void memory_dev_init(void);
 extern int memory_notify(unsigned long val, void *v);
-extern int memory_isolate_notify(unsigned long val, void *v);
 extern struct memory_block *find_memory_block(struct mem_section *);
 typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
 extern int walk_memory_blocks(unsigned long start, unsigned long size,
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 04ee1663cdbe..21af88b718aa 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -18,9 +18,7 @@
 static int set_migratetype_isolate(struct page *page, int migratetype, int=
 isol_flags)
 {
 =09struct zone *zone;
-=09unsigned long flags, pfn;
-=09struct memory_isolate_notify arg;
-=09int notifier_ret;
+=09unsigned long flags;
 =09int ret =3D -EBUSY;
=20
 =09zone =3D page_zone(page);
@@ -35,41 +33,11 @@ static int set_migratetype_isolate(struct page *page, i=
nt migratetype, int isol_
 =09if (is_migrate_isolate_page(page))
 =09=09goto out;
=20
-=09pfn =3D page_to_pfn(page);
-=09arg.start_pfn =3D pfn;
-=09arg.nr_pages =3D pageblock_nr_pages;
-=09arg.pages_found =3D 0;
-
-=09/*
-=09 * It may be possible to isolate a pageblock even if the
-=09 * migratetype is not MIGRATE_MOVABLE. The memory isolation
-=09 * notifier chain is used by balloon drivers to return the
-=09 * number of pages in a range that are held by the balloon
-=09 * driver to shrink memory. If all the pages are accounted for
-=09 * by balloons, are free, or on the LRU, isolation can continue.
-=09 * Later, for example, when memory hotplug notifier runs, these
-=09 * pages reported as "can be isolated" should be isolated(freed)
-=09 * by the balloon driver through the memory notifier chain.
-=09 */
-=09notifier_ret =3D memory_isolate_notify(MEM_ISOLATE_COUNT, &arg);
-=09notifier_ret =3D notifier_to_errno(notifier_ret);
-=09if (notifier_ret)
-=09=09goto out;
 =09/*
 =09 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
 =09 * We just check MOVABLE pages.
 =09 */
-=09if (!has_unmovable_pages(zone, page, arg.pages_found, migratetype,
-=09=09=09=09 isol_flags))
-=09=09ret =3D 0;
-
-=09/*
-=09 * immobile means "not-on-lru" pages. If immobile is larger than
-=09 * removable-by-driver pages reported by notifier, we'll fail.
-=09 */
-
-out:
-=09if (!ret) {
+=09if (!has_unmovable_pages(zone, page, 0, migratetype, isol_flags)) {
 =09=09unsigned long nr_pages;
 =09=09int mt =3D get_pageblock_migratetype(page);
=20
@@ -79,8 +47,10 @@ static int set_migratetype_isolate(struct page *page, in=
t migratetype, int isol_
 =09=09=09=09=09=09=09=09=09NULL);
=20
 =09=09__mod_zone_freepage_state(zone, -nr_pages, mt);
+=09=09ret =3D 0;
 =09}
=20
+out:
 =09spin_unlock_irqrestore(&zone->lock, flags);
 =09if (!ret)
 =09=09drain_all_pages(zone);
--=20
2.21.0

