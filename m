Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D748C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7C6223A2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbfGWFIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 01:08:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:26832 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfGWFIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 01:08:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 22:08:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,297,1559545200"; 
   d="scan'208";a="196991815"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jul 2019 22:08:43 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     huang ying <huang.ying.caritas@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: kernel BUG at mm/swap_state.c:170!
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
        <CAC=cRTMz5S636Wfqdn3UGbzwzJ+v_M46_juSfoouRLS1H62orQ@mail.gmail.com>
        <CABXGCsOo-4CJicvTQm4jF4iDSqM8ic+0+HEEqP+632KfCntU+w@mail.gmail.com>
        <878ssqbj56.fsf@yhuang-dev.intel.com>
        <CABXGCsOhimxC17j=jApoty-o1roRhKYoe+oiqDZ3c1s2r3QxFw@mail.gmail.com>
Date:   Tue, 23 Jul 2019 13:08:42 +0800
In-Reply-To: <CABXGCsOhimxC17j=jApoty-o1roRhKYoe+oiqDZ3c1s2r3QxFw@mail.gmail.com>
        (Mikhail Gavrilov's message of "Mon, 22 Jul 2019 12:56:18 +0500")
Message-ID: <87zhl59w2t.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> writes:

> On Mon, 22 Jul 2019 at 12:53, Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Yes.  This is quite complex.  Is the transparent huge page enabled in
>> your system?  You can check the output of
>>
>> $ cat /sys/kernel/mm/transparent_hugepage/enabled
>
> always [madvise] never
>
>> And, whether is the swap device you use a SSD or NVMe disk (not HDD)?
>
> NVMe INTEL Optane 905P SSDPE21D480GAM3

Thanks!  I have found another (easier way) to reproduce the panic.
Could you try the below patch on top of v5.2-rc2?  It can fix the panic
for me.

Best Regards,
Huang, Ying

-----------------------------------8<----------------------------------
From 5e519c2de54b9fd4b32b7a59e47ce7f94beb8845 Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Tue, 23 Jul 2019 08:49:57 +0800
Subject: [PATCH] dbg xa head

---
 mm/huge_memory.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9f8bce9a6b32..c6ca1c7157ed 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2482,6 +2482,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	struct page *head = compound_head(page);
 	pg_data_t *pgdat = page_pgdat(head);
 	struct lruvec *lruvec;
+	struct address_space *swap_cache = NULL;
+	unsigned long offset;
 	int i;
 
 	lruvec = mem_cgroup_page_lruvec(head, pgdat);
@@ -2489,6 +2491,14 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	/* complete memcg works before add pages to LRU */
 	mem_cgroup_split_huge_fixup(head);
 
+	if (PageAnon(head) && PageSwapCache(head)) {
+		swp_entry_t entry = { .val = page_private(head) };
+
+		offset = swp_offset(entry);
+		swap_cache = swap_address_space(entry);
+		xa_lock(&swap_cache->i_pages);
+	}
+
 	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
 		__split_huge_page_tail(head, i, lruvec, list);
 		/* Some pages can be beyond i_size: drop them from page cache */
@@ -2501,6 +2511,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		} else if (!PageAnon(page)) {
 			__xa_store(&head->mapping->i_pages, head[i].index,
 					head + i, 0);
+		} else if (swap_cache) {
+			__xa_store(&swap_cache->i_pages, offset + i,
+				   head + i, 0);
 		}
 	}
 
@@ -2508,9 +2521,10 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
 		/* Additional pin to swap cache */
-		if (PageSwapCache(head))
+		if (PageSwapCache(head)) {
 			page_ref_add(head, 2);
-		else
+			xa_unlock(&swap_cache->i_pages);
+		} else
 			page_ref_inc(head);
 	} else {
 		/* Additional pin to page cache */
-- 
2.20.1

