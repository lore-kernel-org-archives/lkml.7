Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F2AECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3DA20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbfJIOYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:24:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731464AbfJIOYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:24:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33609A44AFA;
        Wed,  9 Oct 2019 14:24:48 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBF0D60BF4;
        Wed,  9 Oct 2019 14:24:46 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v2 2/2] mm/memory-failure.c: Don't access uninitialized memmaps in memory_failure()
Date:   Wed,  9 Oct 2019 16:24:35 +0200
Message-Id: <20191009142435.3975-3-david@redhat.com>
In-Reply-To: <20191009142435.3975-1-david@redhat.com>
References: <20191009142435.3975-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 09 Oct 2019 14:24:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should check for pfn_to_online_page() to not access uninitialized
memmaps. Reshuffle the code so we don't have to duplicate the error
message.

Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory-failure.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7ef849da8278..e866e6e5660b 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1253,17 +1253,19 @@ int memory_failure(unsigned long pfn, int flags)
 	if (!sysctl_memory_failure_recovery)
 		panic("Memory failure on page %lx", pfn);
 
-	if (!pfn_valid(pfn)) {
+	p = pfn_to_online_page(pfn);
+	if (!p) {
+		if (pfn_valid(pfn)) {
+			pgmap = get_dev_pagemap(pfn, NULL);
+			if (pgmap)
+				return memory_failure_dev_pagemap(pfn, flags,
+								  pgmap);
+		}
 		pr_err("Memory failure: %#lx: memory outside kernel control\n",
 			pfn);
 		return -ENXIO;
 	}
 
-	pgmap = get_dev_pagemap(pfn, NULL);
-	if (pgmap)
-		return memory_failure_dev_pagemap(pfn, flags, pgmap);
-
-	p = pfn_to_page(pfn);
 	if (PageHuge(p))
 		return memory_failure_hugetlb(pfn, flags);
 	if (TestSetPageHWPoison(p)) {
-- 
2.21.0

