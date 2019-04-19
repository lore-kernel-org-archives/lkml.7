Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1C3C282E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F77C217FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfDSWrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:47:47 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41775 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfDSWrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:47:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id x10so6234435qto.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 15:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vIS7MDTSEtYce2+CW2jJ89KJsV5GOFggi2hqHHvCCSE=;
        b=SfQYGph+ujJtF9iVqS6W13OaVUk8Q8rczYcJWoXqveqjJbTA+Zx7yIdFgm1ghCVI5f
         wwMN26Jq3ATHFn1yhXJLxMdYP+6PVf0XksF9azBgu8YpaRFarMpId2kj+jqHEXU8grfE
         7E/HWxwgnc4u2nF+qt80tzeKEkaEDG4eYfZ4hmdbBtVd4D6ILu5tjh//EvRAj5Qupy3F
         nnaBEajISYITW+I6JQwFEV1RXVhuQKKbiah9mSsQT4s8x8wPgiujbgv1SzgPwp7ZLNCl
         WfTft8K9xraSlSKl976xkZTiMEdBh1jZcBq3Ur7Og8LLn/nxre18EyLgqpYuq38mKsfr
         Wtpg==
X-Gm-Message-State: APjAAAWOkwrKHIaWlVf33IPa3zmMHYgxlGDN9pvL7WmurDlP2J7i/F5F
        52TvsBbjaPPc7az3F5O7jVhGZg==
X-Google-Smtp-Source: APXvYqxx4I9Xry+3LvTfBjLXp09NMdxLKmu0XJFptxlEsqLx3fO3wGWj0g3xOnFPx1VxyxPlyOdBKQ==
X-Received: by 2002:a0c:924a:: with SMTP id 10mr5537258qvz.168.1555714065488;
        Fri, 19 Apr 2019 15:47:45 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id z9sm3804230qtb.73.2019.04.19.15.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 15:47:44 -0700 (PDT)
Date:   Fri, 19 Apr 2019 18:47:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Julien Freche <jfreche@vmware.com>
Subject: Re: [PATCH v2 1/4] mm/balloon_compaction: list interfaces
Message-ID: <20190419183802-mutt-send-email-mst@kernel.org>
References: <20190328010718.2248-1-namit@vmware.com>
 <20190328010718.2248-2-namit@vmware.com>
 <20190419174452-mutt-send-email-mst@kernel.org>
 <B2DD0CC3-DA8D-408C-986F-130B4B00A892@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B2DD0CC3-DA8D-408C-986F-130B4B00A892@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 10:34:04PM +0000, Nadav Amit wrote:
> > On Apr 19, 2019, at 3:07 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Thu, Mar 28, 2019 at 01:07:15AM +0000, Nadav Amit wrote:
> >> Introduce interfaces for ballooning enqueueing and dequeueing of a list
> >> of pages. These interfaces reduce the overhead of storing and restoring
> >> IRQs by batching the operations. In addition they do not panic if the
> >> list of pages is empty.
> >> 
> >> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >> Cc: Jason Wang <jasowang@redhat.com>
> >> Cc: linux-mm@kvack.org
> >> Cc: virtualization@lists.linux-foundation.org
> >> Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
> >> Signed-off-by: Nadav Amit <namit@vmware.com>
> >> ---
> >> include/linux/balloon_compaction.h |   4 +
> >> mm/balloon_compaction.c            | 145 +++++++++++++++++++++--------
> >> 2 files changed, 111 insertions(+), 38 deletions(-)
> >> 
> >> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> >> index f111c780ef1d..1da79edadb69 100644
> >> --- a/include/linux/balloon_compaction.h
> >> +++ b/include/linux/balloon_compaction.h
> >> @@ -64,6 +64,10 @@ extern struct page *balloon_page_alloc(void);
> >> extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
> >> 				 struct page *page);
> >> extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info);
> >> +extern size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
> >> +				      struct list_head *pages);
> >> +extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
> >> +				     struct list_head *pages, int n_req_pages);
> > 
> > Why size_t I wonder? It can never be > n_req_pages which is int.
> > Callers also seem to assume int.
> 
> Only because on the previous iteration
> ( https://lkml.org/lkml/2019/2/6/912 ) you said:
> 
> > Are we sure this int never overflows? Why not just use u64
> > or size_t straight away?

And the answer is because n_req_pages is an int too?

> 
> I am ok either way, but please be consistent.

I guess n_req_pages should be size_t too then?

> > 
> >> static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
> >> {
> > 
> > 
> >> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> >> index ef858d547e2d..88d5d9a01072 100644
> >> --- a/mm/balloon_compaction.c
> >> +++ b/mm/balloon_compaction.c
> >> @@ -10,6 +10,106 @@
> >> #include <linux/export.h>
> >> #include <linux/balloon_compaction.h>
> >> 
> >> +static int balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
> >> +				     struct page *page)
> >> +{
> >> +	/*
> >> +	 * Block others from accessing the 'page' when we get around to
> >> +	 * establishing additional references. We should be the only one
> >> +	 * holding a reference to the 'page' at this point.
> >> +	 */
> >> +	if (!trylock_page(page)) {
> >> +		WARN_ONCE(1, "balloon inflation failed to enqueue page\n");
> >> +		return -EFAULT;
> > 
> > Looks like all callers bug on a failure. So let's just do it here,
> > and then make this void?
> 
> As you noted below, actually balloon_page_list_enqueue() does not do
> anything when an error occurs. I really prefer to avoid adding BUG_ON() - 
> I always get pushed back on such things. Yes, this might lead to memory
> leak, but there is no reason to crash the system.

Need to audit callers to make sure they don't misbehave in worse ways.

I think in this case this indicates that someone is using the page so if
one keeps going and adds it into balloon this will lead to corruption down the road.

If you can change the caller code such that it's just a leak,
then a warning is more appropriate. Or even do not warn at all.


> >> +	}
> >> +	list_del(&page->lru);
> >> +	balloon_page_insert(b_dev_info, page);
> >> +	unlock_page(page);
> >> +	__count_vm_event(BALLOON_INFLATE);
> >> +	return 0;
> >> +}
> >> +
> >> +/**
> >> + * balloon_page_list_enqueue() - inserts a list of pages into the balloon page
> >> + *				 list.
> >> + * @b_dev_info: balloon device descriptor where we will insert a new page to
> >> + * @pages: pages to enqueue - allocated using balloon_page_alloc.
> >> + *
> >> + * Driver must call it to properly enqueue a balloon pages before definitively
> >> + * removing it from the guest system.
> > 
> > A bunch of grammar error here. Pls fix for clarify.
> > Also - document that nothing must lock the pages? More assumptions?
> > What is "it" in this context? All pages? And what does removing from
> > guest mean? Really adding to the balloon?
> 
> I pretty much copy-pasted this description from balloon_page_enqueue(). I
> see that you edited this message in the past at least couple of times (e.g.,
> c7cdff0e86471 “virtio_balloon: fix deadlock on OOM”) and left it as is.
> 
> So maybe all of the comments in this file need a rework, but I don’t think
> this patch-set needs to do it.

I see.
That one dealt with one page so "it" was the page. This one deals with
many pages so you can't just copy it over without changes.
Makes it look like "it" refers to driver or guest.

> >> + *
> >> + * Return: number of pages that were enqueued.
> >> + */
> >> +size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
> >> +			       struct list_head *pages)
> >> +{
> >> +	struct page *page, *tmp;
> >> +	unsigned long flags;
> >> +	size_t n_pages = 0;
> >> +
> >> +	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> >> +	list_for_each_entry_safe(page, tmp, pages, lru) {
> >> +		balloon_page_enqueue_one(b_dev_info, page);
> > 
> > Do we want to do something about an error here?
> 
> Hmm… This is really something that should never happen, but I still prefer
> to avoid BUG_ON(), as I said before. I will just not count the page.

Callers can BUG then if they want. That is fine but you then
need to change the callers to do it.

> > 
> >> +		n_pages++;
> >> +	}
> >> +	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> >> +	return n_pages;
> >> +}
> >> +EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
> >> +
> >> +/**
> >> + * balloon_page_list_dequeue() - removes pages from balloon's page list and
> >> + *				 returns a list of the pages.
> >> + * @b_dev_info: balloon device decriptor where we will grab a page from.
> >> + * @pages: pointer to the list of pages that would be returned to the caller.
> >> + * @n_req_pages: number of requested pages.
> >> + *
> >> + * Driver must call it to properly de-allocate a previous enlisted balloon pages
> >> + * before definetively releasing it back to the guest system. This function
> >> + * tries to remove @n_req_pages from the ballooned pages and return it to the
> >> + * caller in the @pages list.
> >> + *
> >> + * Note that this function may fail to dequeue some pages temporarily empty due
> >> + * to compaction isolated pages.
> >> + *
> >> + * Return: number of pages that were added to the @pages list.
> >> + */
> >> +size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
> >> +				 struct list_head *pages, int n_req_pages)
> >> +{
> >> +	struct page *page, *tmp;
> >> +	unsigned long flags;
> >> +	size_t n_pages = 0;
> >> +
> >> +	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> >> +	list_for_each_entry_safe(page, tmp, &b_dev_info->pages, lru) {
> >> +		/*
> >> +		 * Block others from accessing the 'page' while we get around
> >> +		 * establishing additional references and preparing the 'page'
> >> +		 * to be released by the balloon driver.
> >> +		 */
> >> +		if (!trylock_page(page))
> >> +			continue;
> >> +
> >> +		if (IS_ENABLED(CONFIG_BALLOON_COMPACTION) &&
> >> +		    PageIsolated(page)) {
> >> +			/* raced with isolation */
> >> +			unlock_page(page);
> >> +			continue;
> >> +		}
> >> +		balloon_page_delete(page);
> >> +		__count_vm_event(BALLOON_DEFLATE);
> >> +		unlock_page(page);
> >> +		list_add(&page->lru, pages);
> >> +		if (++n_pages >= n_req_pages)
> >> +			break;
> >> +	}
> >> +	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> >> +
> >> +	return n_pages;
> >> +}
> >> +EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
> >> +
> >> /*
> >>  * balloon_page_alloc - allocates a new page for insertion into the balloon
> >>  *			  page list.
> >> @@ -43,17 +143,9 @@ void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
> >> {
> >> 	unsigned long flags;
> >> 
> >> -	/*
> >> -	 * Block others from accessing the 'page' when we get around to
> >> -	 * establishing additional references. We should be the only one
> >> -	 * holding a reference to the 'page' at this point.
> >> -	 */
> >> -	BUG_ON(!trylock_page(page));
> >> 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> >> -	balloon_page_insert(b_dev_info, page);
> >> -	__count_vm_event(BALLOON_INFLATE);
> >> +	balloon_page_enqueue_one(b_dev_info, page);
> > 
> > We used to bug on failure to lock page, now we
> > silently ignore this error. Why?
> 
> That’s a mistake. I’ll add a BUG_ON() if balloon_page_enqueue_one() fails.
> 
> 
