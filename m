Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0C4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B682184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfCNQDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:03:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfCNQDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:03:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4C513082E05;
        Thu, 14 Mar 2019 16:03:03 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-188.ams2.redhat.com [10.36.117.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F7356BF91;
        Thu, 14 Mar 2019 16:02:56 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     xen-devel@lists.xenproject.org
Cc:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien.grall@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>,
        Jan Beulich <JBeulich@suse.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2] xen/balloon: Fix mapping PG_offline pages to user space
Date:   Thu, 14 Mar 2019 17:02:56 +0100
Message-Id: <20190314160256.21713-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 14 Mar 2019 16:03:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XEN balloon driver - in contrast to other balloon drivers - allows
to map some inflated pages to user space. Such pages are allocated via
alloc_xenballooned_pages() and freed via free_xenballooned_pages().
The pfn space of these allocated pages is used to map other things
by the hypervisor using hypercalls.

Pages marked with PG_offline must never be mapped to user space (as
this page type uses the mapcount field of struct pages).

So what we can do is, clear/set PG_offline when allocating/freeing an
inflated pages. This way, most inflated pages can be excluded by
dumping tools and the "reused for other purpose" balloon pages are
correctly not marked as PG_offline.

Fixes: 77c4adf6a6df (xen/balloon: mark inflated pages PG_offline)
Reported-by: Julien Grall <julien.grall@arm.com>
Tested-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

v1 -> v2:
- Readd the braces dropped by accident :)


 drivers/xen/balloon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 39b229f9e256..d37dd5bb7a8f 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -604,6 +604,7 @@ int alloc_xenballooned_pages(int nr_pages, struct page **pages)
 	while (pgno < nr_pages) {
 		page = balloon_retrieve(true);
 		if (page) {
+			__ClearPageOffline(page);
 			pages[pgno++] = page;
 #ifdef CONFIG_XEN_HAVE_PVMMU
 			/*
@@ -645,8 +646,10 @@ void free_xenballooned_pages(int nr_pages, struct page **pages)
 	mutex_lock(&balloon_mutex);
 
 	for (i = 0; i < nr_pages; i++) {
-		if (pages[i])
+		if (pages[i]) {
+			__SetPageOffline(pages[i]);
 			balloon_append(pages[i]);
+		}
 	}
 
 	balloon_stats.target_unpopulated -= nr_pages;
-- 
2.17.2

