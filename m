Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6948EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4B220652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129194;
	bh=IaPhxYrKNQ/uK9uFrGkBup/9HKUmxI/Nal5ou2OPOiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d9sLA9FC4IYxYUiKejeNvlz8R4teNdZoV5kjpjM6ffg69xXwNLbFQjYM+8zWTFtI+
	 zrqDHSJAsT+INaYwlRDmlgkxrbM4PNRN/MSmLFGdDwXKNUW5uycFAXJaPksCtKcppl
	 Oq1zzspFT+CswEGgnNCaIaNk4E59HhP6IgEiVVDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbfDXRRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388658AbfDXRRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:17:42 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BBEC218B0;
        Wed, 24 Apr 2019 17:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126261;
        bh=IaPhxYrKNQ/uK9uFrGkBup/9HKUmxI/Nal5ou2OPOiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcOU7rdKxGADxOf6uAHhb49hy3oqb62WBUH59lPyHSf274PVoFO2yArQME7jx5vS7
         vRgEmozGTxWydkq0+7LrGI5mC5q2LAmEP+4IQoEHbQPSDLAfhox+AjNOkMJ6F2Mdj5
         Io96N+63U0QcpJWIHOoXZSxe0/FW28tZRVIQGHgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Shi <yang.shi@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Cyril Hrubis <chrubis@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rafael Aquini <aquini@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 006/168] mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified
Date:   Wed, 24 Apr 2019 19:07:30 +0200
Message-Id: <20190424170923.838945391@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Shi <yang.shi@linux.alibaba.com>

commit a7f40cfe3b7ada57af9b62fd28430eeb4a7cfcb7 upstream.

When MPOL_MF_STRICT was specified and an existing page was already on a
node that does not follow the policy, mbind() should return -EIO.  But
commit 6f4576e3687b ("mempolicy: apply page table walker on
queue_pages_range()") broke the rule.

And commit c8633798497c ("mm: mempolicy: mbind and migrate_pages support
thp migration") didn't return the correct value for THP mbind() too.

If MPOL_MF_STRICT is set, ignore vma_migratable() to make sure it
reaches queue_pages_to_pte_range() or queue_pages_pmd() to check if an
existing page was already on a node that does not follow the policy.
And, non-migratable vma may be used, return -EIO too if MPOL_MF_MOVE or
MPOL_MF_MOVE_ALL was specified.

Tested with https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/mbind/mbind02.c

[akpm@linux-foundation.org: tweak code comment]
Link: http://lkml.kernel.org/r/1553020556-38583-1-git-send-email-yang.shi@linux.alibaba.com
Fixes: 6f4576e3687b ("mempolicy: apply page table walker on queue_pages_range()")
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reported-by: Cyril Hrubis <chrubis@suse.cz>
Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
Acked-by: Rafael Aquini <aquini@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Rientjes <rientjes@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 mm/mempolicy.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -514,12 +514,16 @@ static int queue_pages_pte_range(pmd_t *
 		if (node_isset(nid, *qp->nmask) == !!(flags & MPOL_MF_INVERT))
 			continue;
 
-		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
+			if (!vma_migratable(vma))
+				break;
 			migrate_page_add(page, qp->pagelist, flags);
+		} else
+			break;
 	}
 	pte_unmap_unlock(pte - 1, ptl);
 	cond_resched();
-	return 0;
+	return addr != end ? -EIO : 0;
 }
 
 static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,


