Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382B7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D1D21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257032;
	bh=Xiadh1m8iofDT40wQNvmLVAYQ0TtKFCPcQw1CIWeJK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MG063SRSnidRundbnYo/T5X+EwKV/RxlgUbljRhE8xssw76Epfzu/2O+midLEeIjE
	 zegDZloEPG9xJ5GXjaJdULrGikMuRraOSrD3L+kdoLnNh3LMK2CwCqF17V1ZNQTZEl
	 AgMR99oZaHxDSDVKF1d3cHj/QMgboCCP+kz1Uuyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390330AbfCVMRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:17:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390068AbfCVMRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:17:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 790752083D;
        Fri, 22 Mar 2019 12:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257026;
        bh=Xiadh1m8iofDT40wQNvmLVAYQ0TtKFCPcQw1CIWeJK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9N7cpT86Idk2XPXWoVOFgMpsiYYryEiJ9qICyMyb2r3p/L9nXGmWgi/GRW81hSBT
         FeLn1pnccpuBbDfKZhatFRHwua98eu0vaH6SL2rtLZeMsrXAJD/2pwkHqiC+JLHE+j
         rJCOVyienI/1lAhE7v9bQqQNTbgK/29UpQHN8XNw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhongjiang <zhongjiang@huawei.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.0 109/238] mm: hwpoison: fix thp split handing in soft_offline_in_use_page()
Date:   Fri, 22 Mar 2019 12:15:28 +0100
Message-Id: <20190322111304.956938608@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: zhongjiang <zhongjiang@huawei.com>

commit 46612b751c4941c5c0472ddf04027e877ae5990f upstream.

When soft_offline_in_use_page() runs on a thp tail page after pmd is
split, we trigger the following VM_BUG_ON_PAGE():

  Memory failure: 0x3755ff: non anonymous thp
  __get_any_page: 0x3755ff: unknown zero refcount page type 2fffff80000000
  Soft offlining pfn 0x34d805 at process virtual address 0x20fff000
  page:ffffea000d360140 count:0 mapcount:0 mapping:0000000000000000 index:0x1
  flags: 0x2fffff80000000()
  raw: 002fffff80000000 ffffea000d360108 ffffea000d360188 0000000000000000
  raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
  page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
  ------------[ cut here ]------------
  kernel BUG at ./include/linux/mm.h:519!

soft_offline_in_use_page() passed refcount and page lock from tail page
to head page, which is not needed because we can pass any subpage to
split_huge_page().

Naoya had fixed a similar issue in c3901e722b29 ("mm: hwpoison: fix thp
split handling in memory_failure()").  But he missed fixing soft
offline.

Link: http://lkml.kernel.org/r/1551452476-24000-1-git-send-email-zhongjiang@huawei.com
Fixes: 61f5d698cc97 ("mm: re-enable THP")
Signed-off-by: zhongjiang <zhongjiang@huawei.com>
Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: <stable@vger.kernel.org>	[4.5+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memory-failure.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1825,19 +1825,17 @@ static int soft_offline_in_use_page(stru
 	struct page *hpage = compound_head(page);
 
 	if (!PageHuge(page) && PageTransHuge(hpage)) {
-		lock_page(hpage);
-		if (!PageAnon(hpage) || unlikely(split_huge_page(hpage))) {
-			unlock_page(hpage);
-			if (!PageAnon(hpage))
+		lock_page(page);
+		if (!PageAnon(page) || unlikely(split_huge_page(page))) {
+			unlock_page(page);
+			if (!PageAnon(page))
 				pr_info("soft offline: %#lx: non anonymous thp\n", page_to_pfn(page));
 			else
 				pr_info("soft offline: %#lx: thp split failed\n", page_to_pfn(page));
-			put_hwpoison_page(hpage);
+			put_hwpoison_page(page);
 			return -EBUSY;
 		}
-		unlock_page(hpage);
-		get_hwpoison_page(page);
-		put_hwpoison_page(hpage);
+		unlock_page(page);
 	}
 
 	/*


