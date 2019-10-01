Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DB1ECE589
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C142121906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733242AbfJAJCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:02:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729787AbfJAJCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:02:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D1C58980F9;
        Tue,  1 Oct 2019 09:02:01 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-182.ams2.redhat.com [10.36.117.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B09D60624;
        Tue,  1 Oct 2019 09:01:59 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, xen-devel@lists.xenproject.org,
        David Hildenbrand <david@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v1 2/3] xen/balloon: Mark pages PG_offline in balloon_append()
Date:   Tue,  1 Oct 2019 11:01:51 +0200
Message-Id: <20191001090152.1770-3-david@redhat.com>
In-Reply-To: <20191001090152.1770-1-david@redhat.com>
References: <20191001090152.1770-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Tue, 01 Oct 2019 09:02:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move the __SetPageOffline() call which all callers perform into
balloon_append().

In bp_state decrease_reservation(), pages are now marked PG_offline a
little later than before, however, this should not matter for XEN.

Suggested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/xen/balloon.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 37443c5fda99..8c245e99bb06 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -158,6 +158,8 @@ static DECLARE_DELAYED_WORK(balloon_worker, balloon_process);
 /* balloon_append: add the given page to the balloon. */
 static void balloon_append(struct page *page)
 {
+	__SetPageOffline(page);
+
 	/* Lowmem is re-populated first, so highmem pages go at list tail. */
 	if (PageHighMem(page)) {
 		list_add_tail(&page->lru, &ballooned_pages);
@@ -372,7 +374,6 @@ static void xen_online_page(struct page *page, unsigned int order)
 	for (i = 0; i < size; i++) {
 		p = pfn_to_page(start_pfn + i);
 		__online_page_set_limits(p);
-		__SetPageOffline(p);
 		balloon_append(p);
 	}
 	mutex_unlock(&balloon_mutex);
@@ -466,7 +467,6 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
 			state = BP_EAGAIN;
 			break;
 		}
-		__SetPageOffline(page);
 		adjust_managed_page_count(page, -1);
 		xenmem_reservation_scrub_page(page);
 		list_add(&page->lru, &pages);
@@ -648,10 +648,8 @@ void free_xenballooned_pages(int nr_pages, struct page **pages)
 	mutex_lock(&balloon_mutex);
 
 	for (i = 0; i < nr_pages; i++) {
-		if (pages[i]) {
-			__SetPageOffline(pages[i]);
+		if (pages[i])
 			balloon_append(pages[i]);
-		}
 	}
 
 	balloon_stats.target_unpopulated -= nr_pages;
@@ -669,7 +667,6 @@ static void __init balloon_add_region(unsigned long start_pfn,
 				      unsigned long pages)
 {
 	unsigned long pfn, extra_pfn_end;
-	struct page *page;
 
 	/*
 	 * If the amount of usable memory has been limited (e.g., with
@@ -679,12 +676,10 @@ static void __init balloon_add_region(unsigned long start_pfn,
 	extra_pfn_end = min(max_pfn, start_pfn + pages);
 
 	for (pfn = start_pfn; pfn < extra_pfn_end; pfn++) {
-		page = pfn_to_page(pfn);
 		/* totalram_pages and totalhigh_pages do not
 		   include the boot-time balloon extension, so
 		   don't subtract from it. */
-		__SetPageOffline(page);
-		balloon_append(page);
+		balloon_append(pfn_to_page(pfn));
 	}
 
 	balloon_stats.total_pages += extra_pfn_end - start_pfn;
-- 
2.21.0

