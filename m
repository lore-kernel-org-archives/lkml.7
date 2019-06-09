Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417A6C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1934A205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100561;
	bh=4GvWFZqaU3k4rYGE70Hur3iofPXWSS18dVfI9woKIQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PEsKu41++rr9liLMftDAqWMU3o0nfg9E/CQ5HNA1vmoyAUe+Kp5INrum/Lz/lNjHu
	 PwMb38Pyatjxz56ThajSBLOM51z2ZhWGFGBYYOstEiqnnQXXS34G73tcAXtI3ClExy
	 W3ioH5RGst7S1aG1tq5CXNvNstfX7ERJI4l+pYgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733299AbfFIRQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729873AbfFIQxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:53:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBAEA206BB;
        Sun,  9 Jun 2019 16:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099233;
        bh=4GvWFZqaU3k4rYGE70Hur3iofPXWSS18dVfI9woKIQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Za3TUYrlnFloC9RlW4FyFvBJgLXzq5AdlhdAMYu2VNYR4NNXAn1wqivSmKcn5cyK2
         B8dmZCG+TBSfBuTBuJs6moXoM3vJDLMjbgoxnjr4Wpk/ba0C26tQr60UA9UmsDfWf0
         pOVKBxiPfIDpGew0Jgt8fnz0IGR4zrxlxdn0qPFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hillf Danton <hillf.zj@alibaba-inc.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 56/83] mm, gup: ensure real head page is ref-counted when using hugepages
Date:   Sun,  9 Jun 2019 18:42:26 +0200
Message-Id: <20190609164132.696575559@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.843327870@linuxfoundation.org>
References: <20190609164127.843327870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Punit Agrawal <punit.agrawal@arm.com>

commit d63206ee32b6e64b0e12d46e5d6004afd9913713 upstream.

When speculatively taking references to a hugepage using
page_cache_add_speculative() in gup_huge_pmd(), it is assumed that the
page returned by pmd_page() is the head page.  Although normally true,
this assumption doesn't hold when the hugepage comprises of successive
page table entries such as when using contiguous bit on arm64 at PTE or
PMD levels.

This can be addressed by ensuring that the page passed to
page_cache_add_speculative() is the real head or by de-referencing the
head page within the function.

We take the first approach to keep the usage pattern aligned with
page_cache_get_speculative() where users already pass the appropriate
page, i.e., the de-referenced head.

Apply the same logic to fix gup_huge_[pud|pgd]() as well.

[punit.agrawal@arm.com: fix arm64 ltp failure]
  Link: http://lkml.kernel.org/r/20170619170145.25577-5-punit.agrawal@arm.com
Link: http://lkml.kernel.org/r/20170522133604.11392-3-punit.agrawal@arm.com
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Steve Capper <steve.capper@arm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Hillf Danton <hillf.zj@alibaba-inc.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/gup.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1313,8 +1313,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_
 		return 0;
 
 	refs = 0;
-	head = pmd_page(orig);
-	page = head + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
+	page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
 	do {
 		pages[*nr] = page;
 		(*nr)++;
@@ -1322,6 +1321,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_
 		refs++;
 	} while (addr += PAGE_SIZE, addr != end);
 
+	head = compound_head(pmd_page(orig));
 	if (!page_cache_add_speculative(head, refs)) {
 		*nr -= refs;
 		return 0;
@@ -1347,8 +1347,7 @@ static int gup_huge_pud(pud_t orig, pud_
 		return 0;
 
 	refs = 0;
-	head = pud_page(orig);
-	page = head + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
+	page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
 	do {
 		pages[*nr] = page;
 		(*nr)++;
@@ -1356,6 +1355,7 @@ static int gup_huge_pud(pud_t orig, pud_
 		refs++;
 	} while (addr += PAGE_SIZE, addr != end);
 
+	head = compound_head(pud_page(orig));
 	if (!page_cache_add_speculative(head, refs)) {
 		*nr -= refs;
 		return 0;
@@ -1382,8 +1382,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_
 		return 0;
 
 	refs = 0;
-	head = pgd_page(orig);
-	page = head + ((addr & ~PGDIR_MASK) >> PAGE_SHIFT);
+	page = pgd_page(orig) + ((addr & ~PGDIR_MASK) >> PAGE_SHIFT);
 	do {
 		pages[*nr] = page;
 		(*nr)++;
@@ -1391,6 +1390,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_
 		refs++;
 	} while (addr += PAGE_SIZE, addr != end);
 
+	head = compound_head(pgd_page(orig));
 	if (!page_cache_add_speculative(head, refs)) {
 		*nr -= refs;
 		return 0;


