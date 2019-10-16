Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D222ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EEF206A4
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395194AbfJPXxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:53:00 -0400
Received: from www9186uo.sakura.ne.jp ([153.121.56.200]:35496 "EHLO
        www9186uo.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfJPXxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:53:00 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Oct 2019 19:52:58 EDT
Received: by www9186uo.sakura.ne.jp (Postfix, from userid 500)
        id D74D01E3745; Thu, 17 Oct 2019 08:47:08 +0900 (JST)
Date:   Thu, 17 Oct 2019 08:47:08 +0900
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm, soft-offline: convert parameter to pfn
Message-ID: <20191016234706.GA5493@www9186uo.sakura.ne.jp>
References: <20191016070924.GA10178@hori.linux.bs1.fc.nec.co.jp>
 <e931b14b-da27-2720-5344-b5c0b08b38ad@redhat.com>
 <20191016082735.GB13770@hori.linux.bs1.fc.nec.co.jp>
 <c78962ba-ffa1-90e2-0116-6c94d082de2f@redhat.com>
 <20191016085359.GD13770@hori.linux.bs1.fc.nec.co.jp>
 <997b5b51-db71-3e27-1f84-cbaa24fa66c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline
In-Reply-To: <997b5b51-db71-3e27-1f84-cbaa24fa66c7@redhat.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 10:57:57AM +0200, David Hildenbrand wrote:
> On 16.10.19 10:54, Naoya Horiguchi wrote:
> >On Wed, Oct 16, 2019 at 10:34:52AM +0200, David Hildenbrand wrote:
> >>On 16.10.19 10:27, Naoya Horiguchi wrote:
> >>>On Wed, Oct 16, 2019 at 09:56:19AM +0200, David Hildenbrand wrote:
> >>>>On 16.10.19 09:09, Naoya Horiguchi wrote:
> >>>>>Hi,
> >>>>>
> >>>>>I wrote a simple cleanup for parameter of soft_offline_page(),
> >>>>>based on thread https://lkml.org/lkml/2019/10/11/57.
> >>>>>
> >>>>>I know that we need more cleanup on hwpoison-inject, but I think
> >>>>>that will be mentioned in re-write patchset Oscar is preparing now.
> >>>>>So let me shared only this part as a separate one now.
> >>>...
> >>>>
> >>>>I think you should rebase that patch on linux-next (where the
> >>>>pfn_to_online_page() check is in place). I assume you'll want to move the
> >>>>pfn_to_online_page() check into soft_offline_page() then as well?
> >>>
> >>>I rebased to next-20191016. And yes, we will move pfn_to_online_page()
> >>>into soft offline code.  It seems that we can also move pfn_valid(),
> >>>but is simply moving like below good enough for you?
> >>
> >>At least I can't am the patch to current next/master (due to
> >>pfn_to_online_page()).
> 
> Could also be that my "git am" skills failed as the mail was not a
> proper patch itself :)

Sorry for the inconvenience, my company email system breaks original
message by introducing quoted-printable format ('=20' or '=3D').
Most mail client usually handles it but git-am doesn't.
I give up using it and send via smtp.gmail.com.

> >@@ -1877,11 +1877,17 @@ static int soft_offline_free_page(struct page *page)
> >   * This is not a 100% solution for all memory, but tries to be
> >   * ``good enough'' for the majority of memory.
> >   */
> >-int soft_offline_page(struct page *page, int flags)
> >+int soft_offline_page(unsigned long pfn, int flags)
> >  {
> >  	int ret;
> >-	unsigned long pfn = page_to_pfn(page);
> >+	struct page *page;
> >+	if (!pfn_valid(pfn))
> >+		return -ENXIO;
> >+	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
> >+	page = pfn_to_online_page(pfn);
> >+	if (!page)
> >+		return -EIO;
> >  	if (is_zone_device_page(page)) {
> 
> -> this is now no longer possible! So you can drop the whole if
> (is_zone_device....) case

OK, thanks. I updated it.

Thanks,
Naoya Horiguchi
---
From 5faf227839b578726fe7f5ff414a153abb3b3a31 Mon Sep 17 00:00:00 2001
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Date: Thu, 17 Oct 2019 08:40:53 +0900
Subject: [PATCH] mm, soft-offline: convert parameter to pfn

Currently soft_offline_page() receives struct page, and its sibling
memory_failure() receives pfn. This discrepancy looks weird and makes
precheck on pfn validity tricky. So let's align them.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 drivers/base/memory.c |  7 +------
 include/linux/mm.h    |  2 +-
 mm/madvise.c          |  2 +-
 mm/memory-failure.c   | 19 +++++++++----------
 4 files changed, 12 insertions(+), 18 deletions(-)

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
index 05c8c6df25e6..af2712004a4d 100644
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
@@ -1877,18 +1877,17 @@ static int soft_offline_free_page(struct page *page)
  * This is not a 100% solution for all memory, but tries to be
  * ``good enough'' for the majority of memory.
  */
-int soft_offline_page(struct page *page, int flags)
+int soft_offline_page(unsigned long pfn, int flags)
 {
 	int ret;
-	unsigned long pfn = page_to_pfn(page);
+	struct page *page;
 
-	if (is_zone_device_page(page)) {
-		pr_debug_ratelimited("soft_offline: %#lx page is device page\n",
-				pfn);
-		if (flags & MF_COUNT_INCREASED)
-			put_page(page);
+	if (!pfn_valid(pfn))
+		return -ENXIO;
+	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
+	page = pfn_to_online_page(pfn);
+	if (!page)
 		return -EIO;
-	}
 
 	if (PageHWPoison(page)) {
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
-- 
2.17.1

