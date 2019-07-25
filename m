Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6B6C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B362521901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbfGYCz6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 22:55:58 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:57657 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389485AbfGYCz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:55:56 -0400
X-Greylist: delayed 560 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jul 2019 22:55:54 EDT
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x6P2ijAV011189
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 11:44:45 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x6P2ijmt010164;
        Thu, 25 Jul 2019 11:44:45 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x6P2hcGH020828;
        Thu, 25 Jul 2019 11:44:45 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-7096052; Thu, 25 Jul 2019 11:31:18 +0900
Received: from BPXM20GP.gisp.nec.co.jp ([10.38.151.212]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0439.000; Thu,
 25 Jul 2019 11:31:17 +0900
From:   Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
Subject: [PATCH 1/2] /proc/kpageflags: prevent an integer overflow in
 stable_page_flags()
Thread-Topic: [PATCH 1/2] /proc/kpageflags: prevent an integer overflow in
 stable_page_flags()
Thread-Index: AQHVQpEJxWCHK2zdZkqohzEuXiyadQ==
Date:   Thu, 25 Jul 2019 02:31:16 +0000
Message-ID: <20190725023100.31141-2-t-fukasawa@vx.jp.nec.com>
References: <20190725023100.31141-1-t-fukasawa@vx.jp.nec.com>
In-Reply-To: <20190725023100.31141-1-t-fukasawa@vx.jp.nec.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.135]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stable_page_flags() returns kpageflags info in u64, but it uses
"1 << KPF_*" internally which is considered as int. This type mismatch
causes no visible problem now, but it will if you set bit 32 or more as
done in a subsequent patch. So use BIT_ULL in order to avoid future
overflow issues.

Signed-off-by: Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
---
 fs/proc/page.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 544d1ee..69064ad 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -95,7 +95,7 @@ u64 stable_page_flags(struct page *page)
 	 * it differentiates a memory hole from a page with no flags
 	 */
 	if (!page)
-		return 1 << KPF_NOPAGE;
+		return BIT_ULL(KPF_NOPAGE);
 
 	k = page->flags;
 	u = 0;
@@ -107,22 +107,22 @@ u64 stable_page_flags(struct page *page)
 	 * simple test in page_mapped() is not enough.
 	 */
 	if (!PageSlab(page) && page_mapped(page))
-		u |= 1 << KPF_MMAP;
+		u |= BIT_ULL(KPF_MMAP);
 	if (PageAnon(page))
-		u |= 1 << KPF_ANON;
+		u |= BIT_ULL(KPF_ANON);
 	if (PageKsm(page))
-		u |= 1 << KPF_KSM;
+		u |= BIT_ULL(KPF_KSM);
 
 	/*
 	 * compound pages: export both head/tail info
 	 * they together define a compound page's start/end pos and order
 	 */
 	if (PageHead(page))
-		u |= 1 << KPF_COMPOUND_HEAD;
+		u |= BIT_ULL(KPF_COMPOUND_HEAD);
 	if (PageTail(page))
-		u |= 1 << KPF_COMPOUND_TAIL;
+		u |= BIT_ULL(KPF_COMPOUND_TAIL);
 	if (PageHuge(page))
-		u |= 1 << KPF_HUGE;
+		u |= BIT_ULL(KPF_HUGE);
 	/*
 	 * PageTransCompound can be true for non-huge compound pages (slab
 	 * pages or pages allocated by drivers with __GFP_COMP) because it
@@ -133,14 +133,13 @@ u64 stable_page_flags(struct page *page)
 		struct page *head = compound_head(page);
 
 		if (PageLRU(head) || PageAnon(head))
-			u |= 1 << KPF_THP;
+			u |= BIT_ULL(KPF_THP);
 		else if (is_huge_zero_page(head)) {
-			u |= 1 << KPF_ZERO_PAGE;
-			u |= 1 << KPF_THP;
+			u |= BIT_ULL(KPF_ZERO_PAGE);
+			u |= BIT_ULL(KPF_THP);
 		}
 	} else if (is_zero_pfn(page_to_pfn(page)))
-		u |= 1 << KPF_ZERO_PAGE;
-
+		u |= BIT_ULL(KPF_ZERO_PAGE);
 
 	/*
 	 * Caveats on high order pages: page->_refcount will only be set
@@ -148,23 +147,23 @@ u64 stable_page_flags(struct page *page)
 	 * SLOB won't set PG_slab at all on compound pages.
 	 */
 	if (PageBuddy(page))
-		u |= 1 << KPF_BUDDY;
+		u |= BIT_ULL(KPF_BUDDY);
 	else if (page_count(page) == 0 && is_free_buddy_page(page))
-		u |= 1 << KPF_BUDDY;
+		u |= BIT_ULL(KPF_BUDDY);
 
 	if (PageOffline(page))
-		u |= 1 << KPF_OFFLINE;
+		u |= BIT_ULL(KPF_OFFLINE);
 	if (PageTable(page))
-		u |= 1 << KPF_PGTABLE;
+		u |= BIT_ULL(KPF_PGTABLE);
 
 	if (page_is_idle(page))
-		u |= 1 << KPF_IDLE;
+		u |= BIT_ULL(KPF_IDLE);
 
 	u |= kpf_copy_bit(k, KPF_LOCKED,	PG_locked);
 
 	u |= kpf_copy_bit(k, KPF_SLAB,		PG_slab);
 	if (PageTail(page) && PageSlab(compound_head(page)))
-		u |= 1 << KPF_SLAB;
+		u |= BIT_ULL(KPF_SLAB);
 
 	u |= kpf_copy_bit(k, KPF_ERROR,		PG_error);
 	u |= kpf_copy_bit(k, KPF_DIRTY,		PG_dirty);
@@ -177,7 +176,7 @@ u64 stable_page_flags(struct page *page)
 	u |= kpf_copy_bit(k, KPF_RECLAIM,	PG_reclaim);
 
 	if (PageSwapCache(page))
-		u |= 1 << KPF_SWAPCACHE;
+		u |= BIT_ULL(KPF_SWAPCACHE);
 	u |= kpf_copy_bit(k, KPF_SWAPBACKED,	PG_swapbacked);
 
 	u |= kpf_copy_bit(k, KPF_UNEVICTABLE,	PG_unevictable);
-- 
1.8.3.1

