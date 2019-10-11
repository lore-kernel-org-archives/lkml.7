Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20545C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DBF2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="AOu22roD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfJKFQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:16:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40091 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfJKFQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:16:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id d26so5082099pgl.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 22:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=JNE3qIp3GwZhiIaVERKeTReBCbfaT6qnnngWA97+jmk=;
        b=AOu22roDAjo2Iw+3ow0fVFNymLA4XBqbwMDgFJZyPjBxC4xlTXYjrRBrz2nneQ5BxF
         sbxK7nQd39Xz28F4U95JzmCvqagYnkud8AjfEHFfy1gzZ0Xf5ELRIiKXZHiGMtS6LAgp
         5GYBEWP2o+WH4nxjrWEq08XdmsoVQ9uFUxcWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JNE3qIp3GwZhiIaVERKeTReBCbfaT6qnnngWA97+jmk=;
        b=A7j5Hj6BYfCtYQ4qZWoAZxaN+0Za3vwyWlVfnd+NAzMpGMaEuZkFhWHejtOi/PeW3m
         4liz8Kb7MX4PZGl376PADzQYiIj9ys4qikblY3L+cZvnjAnCi2hb399TzQg1xMkzjhrJ
         s7BweAGKtIUDnXuokHHkyqXxGM3XQymosgdvaqg4fI3UMGyBSYIv2d05+uGfn/imJGe5
         u9svTO2RsebjU0HaemQL+KRrtRtwLb2N0nvwHRJPGMFWOnxzpeueImZ5J4Bx/+3gN9o6
         Em5AhI9aQvgsr9LCSHa5QQaWjpimhjIQwFC7VBQWKgdHrizJeFmL/TPBmlpUwouuhmk4
         kcSw==
X-Gm-Message-State: APjAAAWLgzAM/SeVjacHC8yOGPTj1DCdZ8NY8PQvp4PUGUhFgCMKCzQt
        i7VWAza+3dMHv4J6VHLd7i7e/tZ2sJ0zJw==
X-Google-Smtp-Source: APXvYqyssA7gSzANSBd3uHeJuSuJcZZ6Tgu3LYuU0Dw0BEbm5M5u9xetMF08ol8pUsyxy0slgFZujw==
X-Received: by 2002:aa7:8dd9:: with SMTP id j25mr12341886pfr.94.1570770964627;
        Thu, 10 Oct 2019 22:16:04 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id x125sm7795793pfb.93.2019.10.10.22.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 22:16:03 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
Subject: Re: [PATCH v8 1/5] kasan: support backing vmalloc space with real shadow memory
In-Reply-To: <20191007080209.GA22997@pc636>
References: <20191001065834.8880-1-dja@axtens.net> <20191001065834.8880-2-dja@axtens.net> <20191007080209.GA22997@pc636>
Date:   Fri, 11 Oct 2019 16:15:59 +1100
Message-ID: <87sgnzuak0.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uladzislau,


> Looking at it one more, i think above part of code is a bit wrong
> and should be separated from merge_or_add_vmap_area() logic. The
> reason is to keep it simple and do only what it is supposed to do:
> merging or adding.
>
> Also the kasan_release_vmalloc() gets called twice there and looks like
> a duplication. Apart of that, merge_or_add_vmap_area() can be called via
> recovery path when vmap/vmaps is/are not even setup. See percpu
> allocator.
>
> I guess your part could be moved directly to the __purge_vmap_area_lazy()
> where all vmaps are lazily freed. To do so, we also need to modify
> merge_or_add_vmap_area() to return merged area:

Thanks for the review. I've integrated your snippet - it seems to work
fine, and I agree that it is much simpler and clearer. so I've rolled it
in to v9 which I will post soon.

Regards,
Daniel

>
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e92ff5f7dd8b..fecde4312d68 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -683,7 +683,7 @@ insert_vmap_area_augment(struct vmap_area *va,
>   * free area is inserted. If VA has been merged, it is
>   * freed.
>   */
> -static __always_inline void
> +static __always_inline struct vmap_area *
>  merge_or_add_vmap_area(struct vmap_area *va,
>         struct rb_root *root, struct list_head *head)
>  {
> @@ -750,7 +750,10 @@ merge_or_add_vmap_area(struct vmap_area *va,
>  
>                         /* Free vmap_area object. */
>                         kmem_cache_free(vmap_area_cachep, va);
> -                       return;
> +
> +                       /* Point to the new merged area. */
> +                       va = sibling;
> +                       merged = true;
>                 }
>         }
>  
> @@ -759,6 +762,8 @@ merge_or_add_vmap_area(struct vmap_area *va,
>                 link_va(va, root, parent, link, head);
>                 augment_tree_propagate_from(va);
>         }
> +
> +       return va;
>  }
>  
>  static __always_inline bool
> @@ -1172,7 +1177,7 @@ static void __free_vmap_area(struct vmap_area *va)
>         /*
>          * Merge VA with its neighbors, otherwise just add it.
>          */
> -       merge_or_add_vmap_area(va,
> +       (void) merge_or_add_vmap_area(va,
>                 &free_vmap_area_root, &free_vmap_area_list);
>  }
>  
> @@ -1279,15 +1284,20 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>         spin_lock(&vmap_area_lock);
>         llist_for_each_entry_safe(va, n_va, valist, purge_list) {
>                 unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
> +               unsigned long orig_start = va->va_start;
> +               unsigned long orig_end = va->va_end;
>  
>                 /*
>                  * Finally insert or merge lazily-freed area. It is
>                  * detached and there is no need to "unlink" it from
>                  * anything.
>                  */
> -               merge_or_add_vmap_area(va,
> +               va = merge_or_add_vmap_area(va,
>                         &free_vmap_area_root, &free_vmap_area_list);
>  
> +               kasan_release_vmalloc(orig_start,
> +                       orig_end, va->va_start, va->va_end);
> +
>                 atomic_long_sub(nr, &vmap_lazy_nr);
>  
>                 if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
> <snip>
>
> --
> Vlad Rezki
