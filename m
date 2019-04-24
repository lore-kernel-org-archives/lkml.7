Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF207C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751AC218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbfDXNuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:50:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42606 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfDXNt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:49:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so20287448qtc.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 06:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HwuSGcRM2DIuoEtZ8HV1XXllsAb7Q8eRlbQDoXvCNOA=;
        b=ChqBsGkV7qn7F5R0DHpVgBvLC8yQd10HumWf9QLRmAsS/J8kTDa5UfBZMZIoj/fu0N
         olV9S9e9ef627F0Zy32IMVLWVt6CEVO18N/+MCb3oPQENT3JKhrMqdhH2mrovvQJshFi
         zU8ZX+kwalgL3kyRmm+r6kI6hgGs0MGxFAuMsCo6ilPJSZmqE3DFXd46xHPi7X4YR3VT
         5ogrODmVKgju1PExcKu10r3b7c56EGAjms6W7M0zLGA+fDVk9KcTVHltvNMadTF1cmav
         gQWu5oCUEYPg/L+rlto7P7cGo8i+kpQhGnX7ucoPTrDYoducMLzYHZlD0q5ai9L/dcc3
         es0g==
X-Gm-Message-State: APjAAAXRPHxZH3EdTcF19/KdwTErpwoHOWuevI9i9u0e5SgLiWrj7YXO
        lS/H90TJYkclfmIcT1jIMLmrsQ==
X-Google-Smtp-Source: APXvYqwavF4I0GfRzamem636qQb1cKbPLXq6Zr/qwHQav9LdpvsMBc+2nCq8KFAaSJ4iLylIbZg1rQ==
X-Received: by 2002:ac8:1621:: with SMTP id p30mr15629737qtj.23.1556113798434;
        Wed, 24 Apr 2019 06:49:58 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net. [173.76.105.71])
        by smtp.gmail.com with ESMTPSA id o9sm3729249qtq.84.2019.04.24.06.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 06:49:57 -0700 (PDT)
Date:   Wed, 24 Apr 2019 09:49:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Julien Freche <jfreche@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/4] mm/balloon_compaction: list interfaces
Message-ID: <20190424092829-mutt-send-email-mst@kernel.org>
References: <20190423234531.29371-1-namit@vmware.com>
 <20190423234531.29371-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423234531.29371-2-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:45:28PM -0700, Nadav Amit wrote:
> Introduce interfaces for ballooning enqueueing and dequeueing of a list
> of pages. These interfaces reduce the overhead of storing and restoring
> IRQs by batching the operations. In addition they do not panic if the
> list of pages is empty.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: virtualization@lists.linux-foundation.org
> Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
> Signed-off-by: Nadav Amit <namit@vmware.com>


Looks good overall. Two minor comments below.


> ---
>  include/linux/balloon_compaction.h |   4 +
>  mm/balloon_compaction.c            | 144 +++++++++++++++++++++--------
>  2 files changed, 110 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index f111c780ef1d..430b6047cef7 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -64,6 +64,10 @@ extern struct page *balloon_page_alloc(void);
>  extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
>  				 struct page *page);
>  extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info);
> +extern size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
> +				      struct list_head *pages);
> +extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
> +				     struct list_head *pages, size_t n_req_pages);
>  
>  static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
>  {
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index ef858d547e2d..a2995002edc2 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -10,6 +10,105 @@
>  #include <linux/export.h>
>  #include <linux/balloon_compaction.h>
>  
> +static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
> +				     struct page *page)
> +{
> +	/*
> +	 * Block others from accessing the 'page' when we get around to
> +	 * establishing additional references. We should be the only one
> +	 * holding a reference to the 'page' at this point. If we are not, then
> +	 * memory corruption is possible and we should stop execution.
> +	 */
> +	BUG_ON(!trylock_page(page));
> +	list_del(&page->lru);
> +	balloon_page_insert(b_dev_info, page);
> +	unlock_page(page);
> +	__count_vm_event(BALLOON_INFLATE);
> +}
> +
> +/**
> + * balloon_page_list_enqueue() - inserts a list of pages into the balloon page
> + *				 list.
> + * @b_dev_info: balloon device descriptor where we will insert a new page to
> + * @pages: pages to enqueue - allocated using balloon_page_alloc.
> + *
> + * Driver must call it to properly enqueue a balloon pages before definitively
> + * removing it from the guest system.
> + *
> + * Return: number of pages that were enqueued.
> + */
> +size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
> +				 struct list_head *pages)
> +{
> +	struct page *page, *tmp;
> +	unsigned long flags;
> +	size_t n_pages = 0;
> +
> +	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +	list_for_each_entry_safe(page, tmp, pages, lru) {
> +		balloon_page_enqueue_one(b_dev_info, page);
> +		n_pages++;
> +	}
> +	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +	return n_pages;
> +}
> +EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
> +
> +/**
> + * balloon_page_list_dequeue() - removes pages from balloon's page list and
> + *				 returns a list of the pages.
> + * @b_dev_info: balloon device decriptor where we will grab a page from.
> + * @pages: pointer to the list of pages that would be returned to the caller.
> + * @n_req_pages: number of requested pages.
> + *
> + * Driver must call this function to properly de-allocate a previous enlisted
> + * balloon pages before definetively releasing it back to the guest system.
> + * This function tries to remove @n_req_pages from the ballooned pages and
> + * return them to the caller in the @pages list.
> + *
> + * Note that this function may fail to dequeue some pages temporarily empty due
> + * to compaction isolated pages.
> + *
> + * Return: number of pages that were added to the @pages list.
> + */
> +size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
> +				 struct list_head *pages, size_t n_req_pages)
> +{
> +	struct page *page, *tmp;
> +	unsigned long flags;
> +	size_t n_pages = 0;
> +
> +	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +	list_for_each_entry_safe(page, tmp, &b_dev_info->pages, lru) {
> +		if (n_pages == n_req_pages)
> +			break;
> +
> +		/*
> +		 * Block others from accessing the 'page' while we get around

should be "get around to" - same as in other places


> +		 * establishing additional references and preparing the 'page'
> +		 * to be released by the balloon driver.
> +		 */
> +		if (!trylock_page(page))
> +			continue;
> +
> +		if (IS_ENABLED(CONFIG_BALLOON_COMPACTION) &&
> +		    PageIsolated(page)) {
> +			/* raced with isolation */
> +			unlock_page(page);
> +			continue;
> +		}
> +		balloon_page_delete(page);
> +		__count_vm_event(BALLOON_DEFLATE);
> +		unlock_page(page);
> +		list_add(&page->lru, pages);

I'm not sure whether this list_add must be under the page lock,
but enqueue does list_del under page lock, so I think it's
a good idea to keep dequeue consistent, operating in the
reverse order of enqueue.

> +		++n_pages;
> +	}
> +	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +
> +	return n_pages;
> +}
> +EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
> +
>  /*
>   * balloon_page_alloc - allocates a new page for insertion into the balloon
>   *			  page list.
> @@ -43,17 +142,9 @@ void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
>  {
>  	unsigned long flags;
>  
> -	/*
> -	 * Block others from accessing the 'page' when we get around to
> -	 * establishing additional references. We should be the only one
> -	 * holding a reference to the 'page' at this point.
> -	 */
> -	BUG_ON(!trylock_page(page));
>  	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> -	balloon_page_insert(b_dev_info, page);
> -	__count_vm_event(BALLOON_INFLATE);
> +	balloon_page_enqueue_one(b_dev_info, page);
>  	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> -	unlock_page(page);
>  }
>  EXPORT_SYMBOL_GPL(balloon_page_enqueue);
>  
> @@ -70,36 +161,13 @@ EXPORT_SYMBOL_GPL(balloon_page_enqueue);
>   */
>  struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info)
>  {
> -	struct page *page, *tmp;
>  	unsigned long flags;
> -	bool dequeued_page;
> +	LIST_HEAD(pages);
> +	int n_pages;
>  
> -	dequeued_page = false;
> -	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> -	list_for_each_entry_safe(page, tmp, &b_dev_info->pages, lru) {
> -		/*
> -		 * Block others from accessing the 'page' while we get around
> -		 * establishing additional references and preparing the 'page'
> -		 * to be released by the balloon driver.
> -		 */
> -		if (trylock_page(page)) {
> -#ifdef CONFIG_BALLOON_COMPACTION
> -			if (PageIsolated(page)) {
> -				/* raced with isolation */
> -				unlock_page(page);
> -				continue;
> -			}
> -#endif
> -			balloon_page_delete(page);
> -			__count_vm_event(BALLOON_DEFLATE);
> -			unlock_page(page);
> -			dequeued_page = true;
> -			break;
> -		}
> -	}
> -	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +	n_pages = balloon_page_list_dequeue(b_dev_info, &pages, 1);
>  
> -	if (!dequeued_page) {
> +	if (n_pages != 1) {
>  		/*
>  		 * If we are unable to dequeue a balloon page because the page
>  		 * list is empty and there is no isolated pages, then something
> @@ -112,9 +180,9 @@ struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info)
>  			     !b_dev_info->isolated_pages))
>  			BUG();
>  		spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> -		page = NULL;
> +		return NULL;
>  	}
> -	return page;
> +	return list_first_entry(&pages, struct page, lru);
>  }
>  EXPORT_SYMBOL_GPL(balloon_page_dequeue);
>  
> -- 
> 2.19.1


With above addressed:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

-- 
MST
