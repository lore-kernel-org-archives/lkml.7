Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05C0C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D09E2133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKX80zqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfJGICV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:02:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33239 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfJGICV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:02:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so8577385lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dD+rwXY/nYOWBAq4CYmtKPehya96hW8MC3evJji/Yec=;
        b=YKX80zqK9BnbAJeglBJloTgyzdIqVvyc8qZo+JZ3ztomB/oSL2bR0cdAskjskLkt7W
         V9UDSFbbXRmNPZ33L0D1wU65+1nH2oAp6y8pZPleWLLZCun4eCXakWs8mS4RWb6C/ker
         JW+RSQDoEOrmeywy1usBuMsnExaiprDjukREATWF2vWVXQ4YtCLFHEdtes6ohAKHQKtf
         q+L1AWmRm9SfD1K0Iykdhz4e4rb4yRZA5P2ouhEARMWWMz9rxMUok+sY7y4FKuV75C8t
         0xbcdLUk2/EkgOxlDRwB9q8u6xQVYUzdRCjrlrEYJnWvIf4sPd888A9bqnH++YKjN+jF
         dmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dD+rwXY/nYOWBAq4CYmtKPehya96hW8MC3evJji/Yec=;
        b=cntKYFheDOTnp/afZyWsj2L5m9nM2I0mmQtMa74iWbt/Ijl/1f5JNT05QTAPWkZ7/d
         F3/VRVbqrxzaUBubfymHr3yVhaF34qTHvc5fmTr26RQbnWwjNNntytSfs6Oi+JuhEu+B
         KvaZtfd8pU1ZYe5Wpi5K6sQlLN4vNqVzvEUlWFOXEN3hvNxOjZgsSJifg3KPuwWJgd5P
         b938M27LUL6CYsEf2+u0hLjq8w1N/B2k4p+6nNtc/PZrES7VT29lRCkU78Z1I4nJZqQI
         Iufp3YYKJznJTED6rRoo7HAf4aOQz7X4Y0Z48ZIPh6zJw9/O5+XTo5T92NaaoauzNOR/
         Hf3A==
X-Gm-Message-State: APjAAAXxzB/6v4YBwIHtYlJOp0NTeIJhC1GPM3psRj+trgvIRzhqpoQ6
        MMFQjBawzkRUjXqcf/VghYs=
X-Google-Smtp-Source: APXvYqyYVjjEk4t55bliwrB5kqrPSByuGmBtIo84DXhVvDur8OAwQWGVhoAdoOt78OMFi9yojAsMng==
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr16241092lfp.21.1570435338163;
        Mon, 07 Oct 2019 01:02:18 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id f21sm3218392lfm.90.2019.10.07.01.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 01:02:17 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 7 Oct 2019 10:02:09 +0200
To:     Daniel Axtens <dja@axtens.net>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
Subject: Re: [PATCH v8 1/5] kasan: support backing vmalloc space with real
 shadow memory
Message-ID: <20191007080209.GA22997@pc636>
References: <20191001065834.8880-1-dja@axtens.net>
 <20191001065834.8880-2-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001065834.8880-2-dja@axtens.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a3c70e275f4e..9fb7a16f42ae 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -690,8 +690,19 @@ merge_or_add_vmap_area(struct vmap_area *va,
>  	struct list_head *next;
>  	struct rb_node **link;
>  	struct rb_node *parent;
> +	unsigned long orig_start, orig_end;
>  	bool merged = false;
>  
> +	/*
> +	 * To manage KASAN vmalloc memory usage, we use this opportunity to
> +	 * clean up the shadow memory allocated to back this allocation.
> +	 * Because a vmalloc shadow page covers several pages, the start or end
> +	 * of an allocation might not align with a shadow page. Use the merging
> +	 * opportunities to try to extend the region we can release.
> +	 */
> +	orig_start = va->va_start;
> +	orig_end = va->va_end;
> +
>  	/*
>  	 * Find a place in the tree where VA potentially will be
>  	 * inserted, unless it is merged with its sibling/siblings.
> @@ -741,6 +752,10 @@ merge_or_add_vmap_area(struct vmap_area *va,
>  		if (sibling->va_end == va->va_start) {
>  			sibling->va_end = va->va_end;
>  
> +			kasan_release_vmalloc(orig_start, orig_end,
> +					      sibling->va_start,
> +					      sibling->va_end);
> +
>  			/* Check and update the tree if needed. */
>  			augment_tree_propagate_from(sibling);
>  
> @@ -754,6 +769,8 @@ merge_or_add_vmap_area(struct vmap_area *va,
>  	}
>  
>  insert:
> +	kasan_release_vmalloc(orig_start, orig_end, va->va_start, va->va_end);
> +
>  	if (!merged) {
>  		link_va(va, root, parent, link, head);
>  		augment_tree_propagate_from(va);
Hello, Daniel.

Looking at it one more, i think above part of code is a bit wrong
and should be separated from merge_or_add_vmap_area() logic. The
reason is to keep it simple and do only what it is supposed to do:
merging or adding.

Also the kasan_release_vmalloc() gets called twice there and looks like
a duplication. Apart of that, merge_or_add_vmap_area() can be called via
recovery path when vmap/vmaps is/are not even setup. See percpu
allocator.

I guess your part could be moved directly to the __purge_vmap_area_lazy()
where all vmaps are lazily freed. To do so, we also need to modify
merge_or_add_vmap_area() to return merged area:

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e92ff5f7dd8b..fecde4312d68 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -683,7 +683,7 @@ insert_vmap_area_augment(struct vmap_area *va,
  * free area is inserted. If VA has been merged, it is
  * freed.
  */
-static __always_inline void
+static __always_inline struct vmap_area *
 merge_or_add_vmap_area(struct vmap_area *va,
        struct rb_root *root, struct list_head *head)
 {
@@ -750,7 +750,10 @@ merge_or_add_vmap_area(struct vmap_area *va,
 
                        /* Free vmap_area object. */
                        kmem_cache_free(vmap_area_cachep, va);
-                       return;
+
+                       /* Point to the new merged area. */
+                       va = sibling;
+                       merged = true;
                }
        }
 
@@ -759,6 +762,8 @@ merge_or_add_vmap_area(struct vmap_area *va,
                link_va(va, root, parent, link, head);
                augment_tree_propagate_from(va);
        }
+
+       return va;
 }
 
 static __always_inline bool
@@ -1172,7 +1177,7 @@ static void __free_vmap_area(struct vmap_area *va)
        /*
         * Merge VA with its neighbors, otherwise just add it.
         */
-       merge_or_add_vmap_area(va,
+       (void) merge_or_add_vmap_area(va,
                &free_vmap_area_root, &free_vmap_area_list);
 }
 
@@ -1279,15 +1284,20 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
        spin_lock(&vmap_area_lock);
        llist_for_each_entry_safe(va, n_va, valist, purge_list) {
                unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
+               unsigned long orig_start = va->va_start;
+               unsigned long orig_end = va->va_end;
 
                /*
                 * Finally insert or merge lazily-freed area. It is
                 * detached and there is no need to "unlink" it from
                 * anything.
                 */
-               merge_or_add_vmap_area(va,
+               va = merge_or_add_vmap_area(va,
                        &free_vmap_area_root, &free_vmap_area_list);
 
+               kasan_release_vmalloc(orig_start,
+                       orig_end, va->va_start, va->va_end);
+
                atomic_long_sub(nr, &vmap_lazy_nr);
 
                if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
<snip>

--
Vlad Rezki
