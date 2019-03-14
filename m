Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81B3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71910217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfCNPkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:40:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNPkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:40:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5BD0880F6B;
        Thu, 14 Mar 2019 15:40:30 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-188.ams2.redhat.com [10.36.117.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D93A15D75C;
        Thu, 14 Mar 2019 15:40:25 +0000 (UTC)
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
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v1] xen/balloon: Fix mapping PG_offline pages to user space
Date:   Thu, 14 Mar 2019 16:40:25 +0100
Message-Id: <20190314154025.21128-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 14 Mar 2019 15:40:30 +0000 (UTC)
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
 drivers/xen/balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 39b229f9e256..751d32f41f26 100644
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
@@ -646,6 +647,7 @@ void free_xenballooned_pages(int nr_pages, struct page **pages)
 
 	for (i = 0; i < nr_pages; i++) {
 		if (pages[i])
+			__SetPageOffline(pages[i]);
 			balloon_append(pages[i]);
 	}
 
-- 
2.17.2

