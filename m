Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56093C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243642084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfDCTeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:34:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfDCTdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:33:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60F60F961D;
        Wed,  3 Apr 2019 19:33:32 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-125-190.rdu2.redhat.com [10.10.125.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93647605CA;
        Wed,  3 Apr 2019 19:33:31 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v3 03/12] mm/hmm: do not erase snapshot when a range is invalidated
Date:   Wed,  3 Apr 2019 15:33:09 -0400
Message-Id: <20190403193318.16478-4-jglisse@redhat.com>
In-Reply-To: <20190403193318.16478-1-jglisse@redhat.com>
References: <20190403193318.16478-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 03 Apr 2019 19:33:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Users of HMM might be using the snapshot information to do
preparatory step like dma mapping pages to a device before
checking for invalidation through hmm_vma_range_done() so
do not erase that information and assume users will do the
right thing.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 mm/hmm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 919d78fd21c5..84e0577a912a 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -174,16 +174,10 @@ static int hmm_invalidate_range(struct hmm *hmm, bool device,
 
 	spin_lock(&hmm->lock);
 	list_for_each_entry(range, &hmm->ranges, list) {
-		unsigned long addr, idx, npages;
-
 		if (update->end < range->start || update->start >= range->end)
 			continue;
 
 		range->valid = false;
-		addr = max(update->start, range->start);
-		idx = (addr - range->start) >> PAGE_SHIFT;
-		npages = (min(range->end, update->end) - addr) >> PAGE_SHIFT;
-		memset(&range->pfns[idx], 0, sizeof(*range->pfns) * npages);
 	}
 	spin_unlock(&hmm->lock);
 
-- 
2.17.2

