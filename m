Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D82C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 23:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B573207FF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 23:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZ0ta2UL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfKIXB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 18:01:56 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:41893 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfKIXBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 18:01:55 -0500
Received: by mail-il1-f194.google.com with SMTP id q15so3299492ils.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 15:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FwRPREe1zlVlybtuD1d4Hc4cJ3qSvHMEZqIKbSflE3g=;
        b=aZ0ta2ULYv+rHd90WBT4Z4gfzGZWp0wPYRChgWLFX5Mt9DXIljXYXyq0Tp++EkZCc0
         5sjYu/u35wuesclwm6E0efMv5y5mW5HOsSYr1U3b4UIBHNp0nLz9lTjTCpPztBABEnVj
         9ZwMTx2GbctRh5m+suzXoBJ3paFwJTsKr9+msm8nL+R+5th9auKKhpNtlo1HKmH0Z5uU
         RjIj+Vv058L2+fudjk6FlJIO1OaXQsMw9spLeoL6rI5tzw+WdbkY2kLEu20CiM9YejIo
         aitKlpL63hUwl6BeKB3fKqE3ezTiqLKsyB3btDb8xBjxL/0Z6LXihqRKl0ywevf3yTJv
         Qd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FwRPREe1zlVlybtuD1d4Hc4cJ3qSvHMEZqIKbSflE3g=;
        b=D564NLMXW1ypxGuMRIA4ngok/EAIzM4hsIo7+2soIuTvrDnnkhPB+NN1UFl0w9jM5P
         DYqBpPCnoNi6571WpKc14zgonnYU3LeF5A/5KUn6P4n0RdBXu6VnbYWZF9uG3pwt5Vyx
         aWgJebROZKUBUkF+eWmc6Fdh4m7m/IccoHOuHT5Z0oZVhykK8uHfAASrh3+8MxhdiDaY
         1bB4gXe+ReQTjPaCqi54SjD960De5rjok+bKvFCrfdL+TZJUzzuxkJKus7ANFFsJeCdd
         T07b3GwiaY4IaAj7N62Qudg/st1Z9nRuCqIWHKu07R2NBy6jX8TWKoakgFD6bQfhaTST
         QdDg==
X-Gm-Message-State: APjAAAWrztsaaVcMGWDHCPJYlB76bQxcgmU6pwaXsf1Js9ssXudFEbPx
        Z3Aq1f7AzdDFQTdx9/n5HYLxgQ4MZew=
X-Google-Smtp-Source: APXvYqxA4VhUL9dNe3KBuKuFSSC5VmHVNlJ/4VL04SoG5iGtQ5IuqbUGlRg6RzjvLMeapgJmQfkuuA==
X-Received: by 2002:a92:1f44:: with SMTP id i65mr20635000ile.123.1573340512720;
        Sat, 09 Nov 2019 15:01:52 -0800 (PST)
Received: from google.com ([2620:15c:183:0:9f3b:444a:4649:ca05])
        by smtp.gmail.com with ESMTPSA id k199sm1338458ilk.20.2019.11.09.15.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 15:01:51 -0800 (PST)
Date:   Sat, 9 Nov 2019 16:01:47 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 2/2] mm: avoid slub allocation while holding list_lock
Message-ID: <20191109230147.GA75074@google.com>
References: <20190914000743.182739-1-yuzhao@google.com>
 <20191108193958.205102-1-yuzhao@google.com>
 <20191108193958.205102-2-yuzhao@google.com>
 <alpine.DEB.2.21.1911092024560.9034@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911092024560.9034@www.lameter.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09, 2019 at 08:52:29PM +0000, Christopher Lameter wrote:
> On Fri, 8 Nov 2019, Yu Zhao wrote:
> 
> > If we are already under list_lock, don't call kmalloc(). Otherwise we
> > will run into deadlock because kmalloc() also tries to grab the same
> > lock.
> 
> How did this happen? The kmalloc needs to be always done before the
> list_lock is taken.
> 
> > Fixing the problem by using a static bitmap instead.
> >
> >   WARNING: possible recursive locking detected
> >   --------------------------------------------
> >   mount-encrypted/4921 is trying to acquire lock:
> >   (&(&n->list_lock)->rlock){-.-.}, at: ___slab_alloc+0x104/0x437
> >
> >   but task is already holding lock:
> >   (&(&n->list_lock)->rlock){-.-.}, at: __kmem_cache_shutdown+0x81/0x3cb
> >
> >   other info that might help us debug this:
> >    Possible unsafe locking scenario:
> >
> >          CPU0
> >          ----
> >     lock(&(&n->list_lock)->rlock);
> >     lock(&(&n->list_lock)->rlock);
> >
> >    *** DEADLOCK ***
> 
> 
> Ahh. list_slab_objects() in shutdown?
> 
> There is a much easier fix for this:
> 
> 
> 
> [FIX] slub: Remove kmalloc under list_lock from list_slab_objects()
> 
> list_slab_objects() is called when a slab is destroyed and there are objects still left
> to list the objects in the syslog. This is a pretty rare event.
> 
> And there it seems we take the list_lock and call kmalloc while holding that lock.
> 
> Perform the allocation in free_partial() before the list_lock is taken.
> 
> Fixes: bbd7d57bfe852d9788bae5fb171c7edb4021d8ac ("slub: Potential stack overflow")
> Signed-off-by: Christoph Lameter <cl@linux.com>
> 
> Index: linux/mm/slub.c
> ===================================================================
> --- linux.orig/mm/slub.c	2019-10-15 13:54:57.032655296 +0000
> +++ linux/mm/slub.c	2019-11-09 20:43:52.374187381 +0000
> @@ -3690,14 +3690,11 @@ error:
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
> -	if (!map)
> -		return;
>  	slab_err(s, page, text, s->name);
>  	slab_lock(page);
> 
> @@ -3723,6 +3720,10 @@ static void free_partial(struct kmem_cac
>  {
>  	LIST_HEAD(discard);
>  	struct page *page, *h;
> +	unsigned long *map = bitmap_alloc(oo_objects(s->max), GFP_KERNEL);
> +
> +	if (!map)
> +		return;

What would happen if we are trying to allocate from the slab that is
being shut down? And shouldn't the allocation be conditional (i.e.,
only when CONFIG_SLUB_DEBUG=y)?
