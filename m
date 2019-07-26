Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B79C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C50622BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QsvMTHeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfGZAG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 20:06:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41930 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfGZAG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 20:06:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so13480325pgg.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 17:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LX3WgT6XIyZ+DazVbDL+JemkgQ8O0fcebqlsSSEdmGM=;
        b=QsvMTHeLg8602rHTa5Q9ZHCQQM9SabYqubgXZOIYbiLd17mnqreKieXa1uwtQ54iam
         GK3VgRhF3/tKHNucJ5sfjCd/qYyDQvoJVlk94JB4k21B1AIuxwzgWVWZgsL3FyNKjiBD
         ulsn5EXL/bfFAQ3/1QUigwK0s18crxSGp+SuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LX3WgT6XIyZ+DazVbDL+JemkgQ8O0fcebqlsSSEdmGM=;
        b=FWsCqK6RvZV3CJsOtZ89r3fDEvXkuoXMmUpLLXnAvWaU1MN/v7BAV3PspYB4Ir4BpB
         uybfcW+721mCvLxww1klxBU4itWepiVYDEoaNK/3G7MfxsA0ZNTlDlzFZIF4VXvSY/pO
         AxWmYx7+XBu1DmO0DomVf7vpwBrRSnUBkJFoPM266K1nu71Oq2BoqLIUWtM3O1zVdMcj
         t+GPcKHp4PSsydFl1tU9lQ13U/VzjJJ0EALVBoLz9sqChS3A7ilPT0L9SPV59qQkl3rJ
         qJ0VqjDEFhO4x/RMfVqhQ8a5EMnLBOGd12VD5scKpbuf2VTDNcqYrO/WrihC4p3TV443
         1UvA==
X-Gm-Message-State: APjAAAWsMLQFlNBEjBKD8VlD/AGimZA/nkNlK2AKZfWcYK1WhRddgQab
        u5gOIp4oVwCtHHzryRtmZwA=
X-Google-Smtp-Source: APXvYqynq4GHcctnGxdvrjEr2VgQvO3199IKeDONR22HjODvLIe8AO5rXpZgJfVmZIRQ9psLB00K5A==
X-Received: by 2002:aa7:8106:: with SMTP id b6mr19230834pfi.5.1564099617036;
        Thu, 25 Jul 2019 17:06:57 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a3sm50932747pfl.145.2019.07.25.17.06.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 17:06:56 -0700 (PDT)
Date:   Thu, 25 Jul 2019 20:06:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        vdavydov.dev@gmail.com, Brendan Gregg <bgregg@netflix.com>,
        kernel-team@android.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        carmenjackson@google.com, Christian Hansen <chansen3@cisco.com>,
        Colin Ian King <colin.king@canonical.com>, dancol@google.com,
        David Howells <dhowells@redhat.com>, fmayer@google.com,
        joaodias@google.com, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, namhyung@google.com,
        sspatil@google.c
Subject: Re: [PATCH v1 1/2] mm/page_idle: Add support for per-pid page_idle
 using virtual indexing
Message-ID: <20190726000654.GB66718@google.com>
References: <20190722213205.140845-1-joel@joelfernandes.org>
 <20190723061358.GD128252@google.com>
 <20190723142049.GC104199@google.com>
 <20190724042842.GA39273@google.com>
 <20190724141052.GB9945@google.com>
 <c116f836-5a72-c6e6-498f-a904497ef557@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c116f836-5a72-c6e6-498f-a904497ef557@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:15:53AM +0300, Konstantin Khlebnikov wrote:
[snip]
> >>> Thanks for bringing up the swapping corner case..  Perhaps we can improve
> >>> the heap profiler to detect this by looking at bits 0-4 in pagemap. While it
> >>
> >> Yeb, that could work but it could add overhead again what you want to remove?
> >> Even, userspace should keep metadata to identify that page was already swapped
> >> in last period or newly swapped in new period.
> >
> > Yep.
> Between samples page could be read from swap and swapped out back multiple times.
> For tracking this swap ptes could be marked with idle bit too.
> I believe it's not so hard to find free bit for this.
> 
> Refault\swapout will automatically clear this bit in pte even if
> page goes nowhere stays if swap-cache.

Could you clarify more about your idea? Do you mean swapout will clear the new
idle swap-pte bit if the page was accessed just before the swapout?

Instead, I thought of using is_swap_pte() to detect if the PTE belong to a
page that was swapped. And if so, then assume the page was idle. Sure we
would miss data that the page was accessed before the swap out in the
sampling window, however if the page was swapped out, then it is likely idle
anyway.

My current patch was just reporting swapped out pages as non-idle (idle bit
not set) which is wrong as Minchan pointed. So I added below patch on top of
this patch (still testing..) :

thanks,

 - Joel
---8<-----------------------

diff --git a/mm/page_idle.c b/mm/page_idle.c
index 3667ed9cc904..46c2dd18cca8 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -271,10 +271,14 @@ struct page_idle_proc_priv {
 	struct list_head *idle_page_list;
 };
 
+/*
+ * Add a page to the idle page list.
+ * page can also be NULL if pte was not present or swapped.
+ */
 static void add_page_idle_list(struct page *page,
 			       unsigned long addr, struct mm_walk *walk)
 {
-	struct page *page_get;
+	struct page *page_get = NULL;
 	struct page_node *pn;
 	int bit;
 	unsigned long frames;
@@ -290,9 +294,11 @@ static void add_page_idle_list(struct page *page,
 			return;
 	}
 
-	page_get = page_idle_get_page(page);
-	if (!page_get)
-		return;
+	if (page) {
+		page_get = page_idle_get_page(page);
+		if (!page_get)
+			return;
+	}
 
 	pn = &(priv->page_nodes[priv->cur_page_node++]);
 	pn->page = page_get;
@@ -326,6 +332,15 @@ static int pte_page_idle_proc_range(pmd_t *pmd, unsigned long addr,
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
+		/*
+		 * We add swapped pages to the idle_page_list so that we can
+		 * reported to userspace that they are idle.
+		 */
+		if (is_swap_pte(*pte)) {
+			add_page_idle_list(NULL, addr, walk);
+			continue;
+		}
+
 		if (!pte_present(*pte))
 			continue;
 
@@ -413,10 +428,12 @@ ssize_t page_idle_proc_generic(struct file *file, char __user *ubuff,
 			goto remove_page;
 
 		if (write) {
-			page_idle_clear_pte_refs(page);
-			set_page_idle(page);
+			if (page) {
+				page_idle_clear_pte_refs(page);
+				set_page_idle(page);
+			}
 		} else {
-			if (page_really_idle(page)) {
+			if (!page || page_really_idle(page)) {
 				off = ((cur->addr) >> PAGE_SHIFT) - start_frame;
 				bit = off % BITMAP_CHUNK_BITS;
 				index = off / BITMAP_CHUNK_BITS;
-- 
2.22.0.709.g102302147b-goog

