Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2D4ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66AE20872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404067AbfJPIyk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:54:40 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:38795 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732135AbfJPIyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:54:39 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9G8sMjn029051
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 16 Oct 2019 17:54:22 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9G8sMLv016072;
        Wed, 16 Oct 2019 17:54:22 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9G8rWeo007892;
        Wed, 16 Oct 2019 17:54:22 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.150] [10.38.151.150]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-9557864; Wed, 16 Oct 2019 17:54:01 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC22GP.gisp.nec.co.jp ([10.38.151.150]) with mapi id 14.03.0439.000; Wed,
 16 Oct 2019 17:54:00 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm, soft-offline: convert parameter to pfn
Thread-Topic: [PATCH] mm, soft-offline: convert parameter to pfn
Thread-Index: AQHVg/CjSPbKnBteSU6QJtzEs3jIHKdcT6KAgAAIvQCAAAIIAIAABVeA
Date:   Wed, 16 Oct 2019 08:54:00 +0000
Message-ID: <20191016085359.GD13770@hori.linux.bs1.fc.nec.co.jp>
References: <20191016070924.GA10178@hori.linux.bs1.fc.nec.co.jp>
 <e931b14b-da27-2720-5344-b5c0b08b38ad@redhat.com>
 <20191016082735.GB13770@hori.linux.bs1.fc.nec.co.jp>
 <c78962ba-ffa1-90e2-0116-6c94d082de2f@redhat.com>
In-Reply-To: <c78962ba-ffa1-90e2-0116-6c94d082de2f@redhat.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <91064F69C753194DB32F7FEE60BAE5C4@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 10:34:52AM +0200, David Hildenbrand wrote:
> On 16.10.19 10:27, Naoya Horiguchi wrote:
> > On Wed, Oct 16, 2019 at 09:56:19AM +0200, David Hildenbrand wrote:
> > > On 16.10.19 09:09, Naoya Horiguchi wrote:
> > > > Hi,
> > > > 
> > > > I wrote a simple cleanup for parameter of soft_offline_page(),
> > > > based on thread https://lkml.org/lkml/2019/10/11/57.
> > > > 
> > > > I know that we need more cleanup on hwpoison-inject, but I think
> > > > that will be mentioned in re-write patchset Oscar is preparing now.
> > > > So let me shared only this part as a separate one now.
> > ...
> > > 
> > > I think you should rebase that patch on linux-next (where the
> > > pfn_to_online_page() check is in place). I assume you'll want to move the
> > > pfn_to_online_page() check into soft_offline_page() then as well?
> > 
> > I rebased to next-20191016. And yes, we will move pfn_to_online_page()
> > into soft offline code.  It seems that we can also move pfn_valid(),
> > but is simply moving like below good enough for you?
> 
> At least I can't am the patch to current next/master (due to
> pfn_to_online_page()).
> 
> > 
> >    @@ -1877,11 +1877,17 @@ static int soft_offline_free_page(struct page *page)
> >      * This is not a 100% solution for all memory, but tries to be
> >      * ``good enough'' for the majority of memory.
> >      */
> >    -int soft_offline_page(struct page *page, int flags)
> >    +int soft_offline_page(unsigned long pfn, int flags)
> >     {
> >     	int ret;
> >    -	unsigned long pfn = page_to_pfn(page);
> >    +	struct page *page;
> >    +	if (!pfn_valid(pfn))
> >    +		return -ENXIO;
> >    +	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
> >    +	if (!pfn_to_online_page(pfn))
> >    +		return -EIO;
> >    +	page = pfn_to_page(pfn);
> >     	if (is_zone_device_page(page)) {
> >     		pr_debug_ratelimited("soft_offline: %#lx page is device page\n",
> >     				pfn);
> >    --
> > 
> > Or we might have an option to do as memory_failure() does like below:
> 
> In contrast to soft offlining, memory failure can deal with devmem. So I
> think the above makes sense.

OK, so here's the revised one.

Thanks,
Naoya Horiguchi
---
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Date: Wed, 16 Oct 2019 17:00:33 +0900
Subject: [PATCH] mm, soft-offline: convert parameter to pfn

Currently soft_offline_page() receives struct page, and its sibling
memory_failure() receives pfn. This discrepancy looks weird and makes
precheck on pfn validity tricky. So let's align them.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 drivers/base/memory.c |  7 +------
 include/linux/mm.h    |  2 +-
 mm/madvise.c          |  2 +-
 mm/memory-failure.c   | 14 ++++++++++----
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 55907c27075b..a757d9ed88a7 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -538,12 +538,7 @@ static ssize_t soft_offline_page_store(struct device *dev,
 	if (kstrtoull(buf, 0, &pfn) < 0)
 		return -EINVAL;
 	pfn >>= PAGE_SHIFT;
-	if (!pfn_valid(pfn))
-		return -ENXIO;
-	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
-	if (!pfn_to_online_page(pfn))
-		return -EIO;
-	ret = soft_offline_page(pfn_to_page(pfn), 0);
+	ret = soft_offline_page(pfn, 0);
 	return ret == 0 ? count : ret;
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 44d058723db9..fd360d208346 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2794,7 +2794,7 @@ extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p, int access);
 extern atomic_long_t num_poisoned_pages __read_mostly;
-extern int soft_offline_page(struct page *page, int flags);
+extern int soft_offline_page(unsigned long pfn, int flags);
 
 
 /*
diff --git a/mm/madvise.c b/mm/madvise.c
index 2be9f3fdb05e..99dd06fecfa9 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -887,7 +887,7 @@ static int madvise_inject_error(int behavior,
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 					pfn, start);
 
-			ret = soft_offline_page(page, MF_COUNT_INCREASED);
+			ret = soft_offline_page(pfn, MF_COUNT_INCREASED);
 			if (ret)
 				return ret;
 			continue;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 05c8c6df25e6..bdf408d7f65c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1476,7 +1476,7 @@ static void memory_failure_work_func(struct work_struct *work)
 		if (!gotten)
 			break;
 		if (entry.flags & MF_SOFT_OFFLINE)
-			soft_offline_page(pfn_to_page(entry.pfn), entry.flags);
+			soft_offline_page(entry.pfn, entry.flags);
 		else
 			memory_failure(entry.pfn, entry.flags);
 	}
@@ -1857,7 +1857,7 @@ static int soft_offline_free_page(struct page *page)
 
 /**
  * soft_offline_page - Soft offline a page.
- * @page: page to offline
+ * @pfn: pfn to soft-offline
  * @flags: flags. Same as memory_failure().
  *
  * Returns 0 on success, otherwise negated errno.
@@ -1877,11 +1877,17 @@ static int soft_offline_free_page(struct page *page)
  * This is not a 100% solution for all memory, but tries to be
  * ``good enough'' for the majority of memory.
  */
-int soft_offline_page(struct page *page, int flags)
+int soft_offline_page(unsigned long pfn, int flags)
 {
 	int ret;
-	unsigned long pfn = page_to_pfn(page);
+	struct page *page;
 
+	if (!pfn_valid(pfn))
+		return -ENXIO;
+	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
+	page = pfn_to_online_page(pfn);
+	if (!page)
+		return -EIO;
 	if (is_zone_device_page(page)) {
 		pr_debug_ratelimited("soft_offline: %#lx page is device page\n",
 				pfn);
-- 
2.17.1

