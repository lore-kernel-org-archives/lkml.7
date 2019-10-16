Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89320FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634A8218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392309AbfJPOXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:23:40 -0400
Received: from foss.arm.com ([217.140.110.172]:41190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfJPOXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:23:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B1F4142F;
        Wed, 16 Oct 2019 07:23:39 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A62433F68E;
        Wed, 16 Oct 2019 07:23:38 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     mike.kravetz@oracle.com, vincenzo.frascino@arm.com
Subject: [PATCH] hugetlb: Fix clang compilation warning
Date:   Wed, 16 Oct 2019 15:23:24 +0100
Message-Id: <20191016142324.52250-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the kernel with a recent version of clang I noticed the warning
below:

mm/hugetlb.c:4055:40: warning: expression does not compute the number of
elements in this array; element type is 'unsigned long', not 'u32'
(aka 'unsigned int') [-Wsizeof-array-div]
        hash = jhash2((u32 *)&key, sizeof(key)/sizeof(u32), 0);
                                          ~~~ ^
mm/hugetlb.c:4049:16: note: array 'key' declared here
        unsigned long key[2];
                      ^
mm/hugetlb.c:4055:40: note: place parentheses around the 'sizeof(u32)'
expression to silence this warning
        hash = jhash2((u32 *)&key, sizeof(key)/sizeof(u32), 0);
                                              ^  CC      fs/ext4/ialloc.o

Fix the warning adding parentheses around the sizeof(u32) expression.

Cc: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ef37c85423a5..ce9ff2b35962 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4052,7 +4052,7 @@ u32 hugetlb_fault_mutex_hash(struct hstate *h, struct address_space *mapping,
 	key[0] = (unsigned long) mapping;
 	key[1] = idx;
 
-	hash = jhash2((u32 *)&key, sizeof(key)/sizeof(u32), 0);
+	hash = jhash2((u32 *)&key, sizeof(key)/(sizeof(u32)), 0);
 
 	return hash & (num_fault_mutexes - 1);
 }
-- 
2.23.0

