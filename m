Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF311ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD0C206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfJIMbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:31:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727029AbfJIMbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:31:46 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 95FD72B76B81C23962B2;
        Wed,  9 Oct 2019 20:31:41 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Wed, 9 Oct 2019 20:31:32 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        "Henry Burns" <henryburns@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] mm/z3fold.c: remove set but not used variable 'newpage'
Date:   Wed, 9 Oct 2019 12:31:11 +0000
Message-ID: <20191009123111.80425-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

mm/z3fold.c: In function 'compact_single_buddy':
mm/z3fold.c:693:16: warning:
 variable 'newpage' set but not used [-Wunused-but-set-variable]

mm/z3fold.c:664:13: warning:
 variable 'bud' set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 mm/z3fold.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 25713a4a7186..d48d0ec3bcdd 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -661,7 +661,6 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
 	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
 	void *p = zhdr;
 	unsigned long old_handle = 0;
-	enum buddy bud;
 	size_t sz = 0;
 	struct z3fold_header *new_zhdr = NULL;
 	int first_idx = __idx(zhdr, FIRST);
@@ -673,24 +672,20 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
 	 * the page lock is already taken
 	 */
 	if (zhdr->first_chunks && zhdr->slots->slot[first_idx]) {
-		bud = FIRST;
 		p += ZHDR_SIZE_ALIGNED;
 		sz = zhdr->first_chunks << CHUNK_SHIFT;
 		old_handle = (unsigned long)&zhdr->slots->slot[first_idx];
 	} else if (zhdr->middle_chunks && zhdr->slots->slot[middle_idx]) {
-		bud = MIDDLE;
 		p += zhdr->start_middle << CHUNK_SHIFT;
 		sz = zhdr->middle_chunks << CHUNK_SHIFT;
 		old_handle = (unsigned long)&zhdr->slots->slot[middle_idx];
 	} else if (zhdr->last_chunks && zhdr->slots->slot[last_idx]) {
-		bud = LAST;
 		p += PAGE_SIZE - (zhdr->last_chunks << CHUNK_SHIFT);
 		sz = zhdr->last_chunks << CHUNK_SHIFT;
 		old_handle = (unsigned long)&zhdr->slots->slot[last_idx];
 	}
 
 	if (sz > 0) {
-		struct page *newpage;
 		enum buddy new_bud = HEADLESS;
 		short chunks = size_to_chunks(sz);
 		void *q;
@@ -699,7 +694,6 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
 		if (!new_zhdr)
 			return NULL;
 
-		newpage = virt_to_page(new_zhdr);
 		if (WARN_ON(new_zhdr == zhdr))
 			goto out_fail;



