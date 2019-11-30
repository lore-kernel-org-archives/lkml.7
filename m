Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0266C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 23:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F8020833
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 23:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575155351;
	bh=+rUlFwPAJgYEfS8TYww8cNCIY3tqU3ON5emEPe+Dxfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=l0xzGf/YtIzYXNZAOlRBfEnYXAuyFFdNfFaDJl2LgJh79vkPY1Q/ixxWVCKkmeWQU
	 rqyrfMcVCo8NZ9leBlZFDyawT+QFjzJCXqIAk4VANYIH1QC7h/c+6RDmSL+DSftyg6
	 3rrcmzZIO6yHWSCdIzNclYGa/grnyKyAqBropHh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfK3XJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 18:09:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfK3XJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 18:09:10 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4245C2072C;
        Sat, 30 Nov 2019 23:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575155349;
        bh=+rUlFwPAJgYEfS8TYww8cNCIY3tqU3ON5emEPe+Dxfg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1ZdZyFhwrZJBqdGQXkp6Hoijogl30uQ+ZRQwlJf19mnxuMjE5ivT9r0jE3o+EiZp0
         BT4uDPgEM32KfQwXAFwS1mhENhRHgOiIMtV/bNx7AVvIAS7OZwYtI+3R6NYm5QxwIQ
         M0q50569YvYKbV7UK+jtko15zqW0G9piez2yGHOU=
Date:   Sat, 30 Nov 2019 15:09:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Yu Zhao <yuzhao@google.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [FIX] slub: Remove kmalloc under list_lock from
 list_slab_objects() V2
Message-Id: <20191130150908.06b2646edfa7bdc12a943c25@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1911111553020.15366@www.lameter.com>
References: <20190914000743.182739-1-yuzhao@google.com>
        <20191108193958.205102-1-yuzhao@google.com>
        <20191108193958.205102-2-yuzhao@google.com>
        <alpine.DEB.2.21.1911092024560.9034@www.lameter.com>
        <20191109230147.GA75074@google.com>
        <alpine.DEB.2.21.1911092313460.32415@www.lameter.com>
        <20191110184721.GA171640@google.com>
        <alpine.DEB.2.21.1911111543420.10669@www.lameter.com>
        <alpine.DEB.2.21.1911111553020.15366@www.lameter.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 15:55:05 +0000 (UTC) Christopher Lameter <cl@linux.com> wrote:

> Regardless of the issue with memcgs allowing allocations from its
> kmalloc array during shutdown: This patch cleans things up and properly
> allocates the bitmap outside of the list_lock.
> 
> 
> [FIX] slub: Remove kmalloc under list_lock from list_slab_objects() V2
> 
> V1->V2 : Properly handle CONFIG_SLUB_DEBUG. Handle bitmap free correctly.
> 
> list_slab_objects() is called when a slab is destroyed and there are objects still left
> to list the objects in the syslog. This is a pretty rare event.
> 
> And there it seems we take the list_lock and call kmalloc while holding that lock.
> 
> Perform the allocation in free_partial() before the list_lock is taken.

No response here?  It looks a lot simpler than the originally proposed
patch?

> --- linux.orig/mm/slub.c	2019-10-15 13:54:57.032655296 +0000
> +++ linux/mm/slub.c	2019-11-11 15:52:11.616397853 +0000
> @@ -3690,14 +3690,15 @@ error:
>  }
> 
>  static void list_slab_objects(struct kmem_cache *s, struct page *page,
> -							const char *text)
> +					const char *text, unsigned long *map)
>  {
>  #ifdef CONFIG_SLUB_DEBUG
>  	void *addr = page_address(page);
>  	void *p;
> -	unsigned long *map = bitmap_zalloc(page->objects, GFP_ATOMIC);
> +
>  	if (!map)
>  		return;
> +
>  	slab_err(s, page, text, s->name);
>  	slab_lock(page);
> 
> @@ -3710,7 +3711,6 @@ static void list_slab_objects(struct kme
>  		}
>  	}
>  	slab_unlock(page);
> -	bitmap_free(map);
>  #endif
>  }
> 
> @@ -3723,6 +3723,11 @@ static void free_partial(struct kmem_cac
>  {
>  	LIST_HEAD(discard);
>  	struct page *page, *h;
> +	unsigned long *map = NULL;
> +
> +#ifdef CONFIG_SLUB_DEBUG
> +	map = bitmap_alloc(oo_objects(s->max), GFP_KERNEL);
> +#endif
> 
>  	BUG_ON(irqs_disabled());
>  	spin_lock_irq(&n->list_lock);
> @@ -3732,11 +3737,16 @@ static void free_partial(struct kmem_cac
>  			list_add(&page->slab_list, &discard);
>  		} else {
>  			list_slab_objects(s, page,
> -			"Objects remaining in %s on __kmem_cache_shutdown()");
> +			"Objects remaining in %s on __kmem_cache_shutdown()",
> +			map);
>  		}
>  	}
>  	spin_unlock_irq(&n->list_lock);
> 
> +#ifdef CONFIG_SLUB_DEBUG
> +	bitmap_free(map);
> +#endif
> +
>  	list_for_each_entry_safe(page, h, &discard, slab_list)
>  		discard_slab(s, page);
>  }
