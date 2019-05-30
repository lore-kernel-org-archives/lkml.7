Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948DAC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA97261FD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXs8yL23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfE3Vyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 17:54:45 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33838 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfE3Vyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:54:44 -0400
Received: by mail-ot1-f67.google.com with SMTP id l17so7200544otq.1;
        Thu, 30 May 2019 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+Hql3UnNz+U+1lYmmCsad2oNlY6bZIgkjk9Ecr29j+A=;
        b=BXs8yL238Nx++nVmRKlg3dNF8CTnKOpeTXH0AG07gUebKWVwBReMaUvxW+ADvzwJwk
         HL7Z2/iu94p7I4zy38LSM+GFa9I3DNkDzScHJPMvIDd3EIXwnwx7TU9/jRgQ2bPHCNTN
         b2ZeQhQnwYYnXtsyLbJi6ZBBU7WMzu+BduNJjFj7Yb342UxFjbViJCZZ1aWCPfh3p5z3
         UqJZVkfskln9C5j/67ONPb9LHHYvE0bD2NGQUnSUtNRASvc24zb66/hAutak8OFQ70Mi
         +a9a/wdBysp+q2E181m0otXqpxVwLVHU5jpjDa7eHqaV2QssIfLYiRjA53oBXVcPZziH
         Oy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+Hql3UnNz+U+1lYmmCsad2oNlY6bZIgkjk9Ecr29j+A=;
        b=s+c62hmA4wJ8xfbPMysohBjJt4lk1QQYwTc/H6q+xK+86SwcpwbfKEzjiNfOyq2dC4
         TOhUm9hFqDVRFGu1GBYewPanVQBbNjagizLX7Vuk1gSVPUg9P1qwCkKoYukh2Iy7Yq0x
         zUgebW+M3lGv57wGwPkXCZ7dSqzKbO9xuVRVB7t75vsanjd6XQ6+0AGfWYxOw53XE5hv
         dcmSf9C3TpZDHirXK1yYsMFb5JfCcMzA/ZiuOJZADHyIeRwDF3Av/C42FdnX9XDn6VbV
         DPCq9t1Tk/GajHlzt3iuZgY4wea1mw4HfMWTrV4IPOhDfW39QL7lwiOrfK1885jPgjre
         THag==
X-Gm-Message-State: APjAAAVbBztQ6iIYbnrfunjX8PDAd9on+pVK1RoxEibRi/96zItPPs2H
        FgtSpC+95F0ajeKtDyWaY6c=
X-Google-Smtp-Source: APXvYqxGTR2Bptz8i/SgWXoKTL+4Bu+dJLGidAXFm62PcUBVrIR9eyVW68+tWL2IUSUeElRSKJsvlg==
X-Received: by 2002:a9d:5ec:: with SMTP id 99mr4311813otd.57.1559253283263;
        Thu, 30 May 2019 14:54:43 -0700 (PDT)
Received: from localhost.localdomain (50-126-100-225.drr01.csby.or.frontiernet.net. [50.126.100.225])
        by smtp.gmail.com with ESMTPSA id n7sm1450349oih.18.2019.05.30.14.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 14:54:42 -0700 (PDT)
Subject: [RFC PATCH 09/11] mm: Count isolated pages as "treated"
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     nitesh@redhat.com, kvm@vger.kernel.org, david@redhat.com,
        mst@redhat.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     yang.zhang.wz@gmail.com, pagupta@redhat.com, riel@surriel.com,
        konrad.wilk@oracle.com, lcapitulino@redhat.com,
        wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com,
        dan.j.williams@intel.com, alexander.h.duyck@linux.intel.com
Date:   Thu, 30 May 2019 14:54:41 -0700
Message-ID: <20190530215441.13974.33609.stgit@localhost.localdomain>
In-Reply-To: <20190530215223.13974.22445.stgit@localhost.localdomain>
References: <20190530215223.13974.22445.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Treat isolated pages as though they have already been treated. We do this
so that we can avoid trying to treat pages that have been marked for
isolation. The issue is that we don't want to run into issues where we are
treating a page, and when we put it back we find it has been moved into the
isolated migratetype, nor would we want to pull pages out of the isolated
migratetype and then find that they are now being located in a different
migratetype.

To avoid those issues we can specifically mark all isolated pages as being
"treated" and avoid special case handling for them since they will never be
merged anyway, so we can just add them to the head of the free_list.

In addition we will skip over the isolate migratetype when getting raw
pages.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 include/linux/mmzone.h |    7 +++++++
 mm/aeration.c          |    8 ++++++--
 mm/page_alloc.c        |    2 +-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index be996e8ca6b5..f749ccfcc62a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -137,6 +137,13 @@ static inline void add_to_free_area_tail(struct page *page, struct free_area *ar
 {
 	area->nr_free_treated++;
 
+#ifdef CONFIG_MEMORY_ISOLATION
+	/* Bypass membrane for isolated pages, all are considered "treated" */
+	if (migratetype == MIGRATE_ISOLATE) {
+		list_add(&page->lru, &area->free_list[migratetype]);
+		return;
+	}
+#endif
 	BUG_ON(area->treatment_mt != migratetype);
 
 	/* Insert page above membrane, then move membrane to the page */
diff --git a/mm/aeration.c b/mm/aeration.c
index aaf8af8d822f..f921295ed3ae 100644
--- a/mm/aeration.c
+++ b/mm/aeration.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/memory_aeration.h>
+#include <linux/mm.h>
 #include <linux/mmzone.h>
+#include <linux/page-isolation.h>
 #include <linux/gfp.h>
 #include <linux/export.h>
 #include <linux/delay.h>
@@ -83,8 +85,10 @@ static int __aerator_fill(struct zone *zone, unsigned int size)
 			 * new raw pages can build. In the meantime move on
 			 * to the next migratetype.
 			 */
-			if (++mt >= MIGRATE_TYPES)
-				mt = 0;
+			do {
+				if (++mt >= MIGRATE_TYPES)
+					mt = 0;
+			} while (is_migrate_isolate(mt));
 
 			/*
 			 * Pull pages from free list until we have drained
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e79c65413dc9..e3800221414b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -989,7 +989,7 @@ static inline void __free_one_page(struct page *page,
 	set_page_order(page, order);
 
 	area = &zone->free_area[order];
-	if (PageTreated(page)) {
+	if (is_migrate_isolate(migratetype) || PageTreated(page)) {
 		add_to_free_area_treated(page, area, migratetype);
 		return;
 	}

