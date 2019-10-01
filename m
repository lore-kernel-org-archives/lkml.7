Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C753ECE589
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14B321927
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733209AbfJAJCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:02:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729787AbfJAJB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:01:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F203554CD;
        Tue,  1 Oct 2019 09:01:59 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-182.ams2.redhat.com [10.36.117.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8CA91D9;
        Tue,  1 Oct 2019 09:01:57 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, xen-devel@lists.xenproject.org,
        David Hildenbrand <david@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v1 1/3] xen/balloon: Drop __balloon_append()
Date:   Tue,  1 Oct 2019 11:01:50 +0200
Message-Id: <20191001090152.1770-2-david@redhat.com>
In-Reply-To: <20191001090152.1770-1-david@redhat.com>
References: <20191001090152.1770-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 01 Oct 2019 09:01:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's simply use balloon_append() directly.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/xen/balloon.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 91cba70b69df..37443c5fda99 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -156,7 +156,7 @@ static DECLARE_DELAYED_WORK(balloon_worker, balloon_process);
 	(GFP_HIGHUSER | __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC)
 
 /* balloon_append: add the given page to the balloon. */
-static void __balloon_append(struct page *page)
+static void balloon_append(struct page *page)
 {
 	/* Lowmem is re-populated first, so highmem pages go at list tail. */
 	if (PageHighMem(page)) {
@@ -169,11 +169,6 @@ static void __balloon_append(struct page *page)
 	wake_up(&balloon_wq);
 }
 
-static void balloon_append(struct page *page)
-{
-	__balloon_append(page);
-}
-
 /* balloon_retrieve: rescue a page from the balloon, if it is not empty. */
 static struct page *balloon_retrieve(bool require_lowmem)
 {
@@ -378,7 +373,7 @@ static void xen_online_page(struct page *page, unsigned int order)
 		p = pfn_to_page(start_pfn + i);
 		__online_page_set_limits(p);
 		__SetPageOffline(p);
-		__balloon_append(p);
+		balloon_append(p);
 	}
 	mutex_unlock(&balloon_mutex);
 }
@@ -689,7 +684,7 @@ static void __init balloon_add_region(unsigned long start_pfn,
 		   include the boot-time balloon extension, so
 		   don't subtract from it. */
 		__SetPageOffline(page);
-		__balloon_append(page);
+		balloon_append(page);
 	}
 
 	balloon_stats.total_pages += extra_pfn_end - start_pfn;
-- 
2.21.0

