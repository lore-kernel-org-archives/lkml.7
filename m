Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99176C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6814D2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDj3lwrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbfGPP6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:58:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40369 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfGPP6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 11:58:39 -0400
Received: by mail-lj1-f193.google.com with SMTP id m8so20467246lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XQ410IUsZxin0lRODEmBFRGZWq/RPTQwE6XaaTIWCEA=;
        b=bDj3lwrmaFpxNyQK2qAgblH+qScOy6wvDRBKuQmIo9xXYIIRIKYe8yCti20qp+sBMQ
         vR5gcelSC96/R8Nw9+lAF3K5OXHJHj/567AJx8Maoz9lw4K5kzwSNskmjRRxVoGeVjCA
         Q5nIRbojMw5Xj4WrZzTvc+i9ujglezIdEHC42amyCVAWlV8jsCs/DeeSgklmmOm7QlyS
         /n5dfkqhNjeyRRkGKjS+/amF7qdf6kPz85pY4J00exm0lSe7gDO6oNO/hprM6dPE2ZmS
         QZjYWNoz5Kd8ztvkSpTgTcENkVCBWXejmoEPb0mExP25awBR7Y3bfpYtm3iqB+UpHHXw
         hJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XQ410IUsZxin0lRODEmBFRGZWq/RPTQwE6XaaTIWCEA=;
        b=lUQJNUzYElDc+UVC07E/kYDxBge7W2AO7cDHwMARPeUPBy8B5coLfa2khU5NeWOhds
         9qsQTzvi9+M0lM2QLrIbRiwn2nZ+BwJVOPqgXKykHF2qlburResD+QQaMiE4kfpqqtsz
         6FkvlAV4wV1C/1Ps7S06peja/zJkhvwPw7N/7mhNS0ikxMSrZQ+9i24ROGRpEGP6CXgm
         muJiOmizNen3KuItHUiCvXZUM+7oSDSZ5qWRtYAPQyA3Z/oHD14GkNvY604wHpmeKKSQ
         u7/RrYD8E+6ItWFa93xRqSN8Z0KWI1dVdxnCc9+AIyvx99r7i3lZTKdelmMgRdTZNeYn
         XmwA==
X-Gm-Message-State: APjAAAVNmD7gFZXc8FcvZqbdJ4BRyC/QAy42U4I3kl8dU+8/oTGBH2EQ
        Ch5COUyl8qYauLusI7WLl5Y=
X-Google-Smtp-Source: APXvYqx4O4YL/HwVrYmVuGlLH9FEYLvY42UH1KiM+psjSzG/ll6t382D5c9edjlsPR08mwxaUrWfBg==
X-Received: by 2002:a05:651c:21c:: with SMTP id y28mr1031225ljn.187.1563292717243;
        Tue, 16 Jul 2019 08:58:37 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id z12sm2922304lfg.67.2019.07.16.08.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jul 2019 08:58:36 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 16 Jul 2019 17:58:29 +0200
To:     Pengfei Li <lpf.vector@gmail.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, urezki@gmail.com,
        rpenyaev@suse.de, peterz@infradead.org, guro@fb.com,
        rick.p.edgecombe@intel.com, rppt@linux.ibm.com,
        aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] mm/vmalloc: modify struct vmap_area to reduce its
 size
Message-ID: <20190716155829.zdrzadrmwxrkfkro@pc636>
References: <20190716152656.12255-1-lpf.vector@gmail.com>
 <20190716152656.12255-3-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716152656.12255-3-lpf.vector@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 11:26:56PM +0800, Pengfei Li wrote:
> Objective
> ---------
> The current implementation of struct vmap_area wasted space.
> 
> After applying this commit, sizeof(struct vmap_area) has been
> reduced from 11 words to 8 words.
> 
> Description
> -----------
> 1) Pack "subtree_max_size", "vm" and "purge_list".
> This is no problem because
>     A) "subtree_max_size" is only used when vmap_area is in
>        "free" tree
>     B) "vm" is only used when vmap_area is in "busy" tree
>     C) "purge_list" is only used when vmap_area is in
>        vmap_purge_list
> 
> 2) Eliminate "flags".
> Since only one flag VM_VM_AREA is being used, and the same
> thing can be done by judging whether "vm" is NULL, then the
> "flags" can be eliminated.
> 
> Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
> Suggested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/vmalloc.h | 20 +++++++++++++-------
>  mm/vmalloc.c            | 24 ++++++++++--------------
>  2 files changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 9b21d0047710..a1334bd18ef1 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -51,15 +51,21 @@ struct vmap_area {
>  	unsigned long va_start;
>  	unsigned long va_end;
>  
> -	/*
> -	 * Largest available free size in subtree.
> -	 */
> -	unsigned long subtree_max_size;
> -	unsigned long flags;
>  	struct rb_node rb_node;         /* address sorted rbtree */
>  	struct list_head list;          /* address sorted list */
> -	struct llist_node purge_list;    /* "lazy purge" list */
> -	struct vm_struct *vm;
> +
> +	/*
> +	 * The following three variables can be packed, because
> +	 * a vmap_area object is always one of the three states:
> +	 *    1) in "free" tree (root is vmap_area_root)
> +	 *    2) in "busy" tree (root is free_vmap_area_root)
> +	 *    3) in purge list  (head is vmap_purge_list)
> +	 */
> +	union {
> +		unsigned long subtree_max_size; /* in "free" tree */
> +		struct vm_struct *vm;           /* in "busy" tree */
> +		struct llist_node purge_list;   /* in purge list */
> +	};
>  };
>  
>  /*
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 71d8040a8a0b..2f7edc0466e7 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -329,7 +329,6 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
>  #define DEBUG_AUGMENT_PROPAGATE_CHECK 0
>  #define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
>  
> -#define VM_VM_AREA	0x04
>  
>  static DEFINE_SPINLOCK(vmap_area_lock);
>  /* Export for kexec only */
> @@ -1115,7 +1114,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  
>  	va->va_start = addr;
>  	va->va_end = addr + size;
> -	va->flags = 0;
> +	va->vm = NULL;
>  	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
>  
>  	spin_unlock(&vmap_area_lock);
> @@ -1922,7 +1921,6 @@ void __init vmalloc_init(void)
>  		if (WARN_ON_ONCE(!va))
>  			continue;
>  
> -		va->flags = VM_VM_AREA;
>  		va->va_start = (unsigned long)tmp->addr;
>  		va->va_end = va->va_start + tmp->size;
>  		va->vm = tmp;
> @@ -2020,7 +2018,6 @@ static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
>  	vm->size = va->va_end - va->va_start;
>  	vm->caller = caller;
>  	va->vm = vm;
> -	va->flags |= VM_VM_AREA;
>  	spin_unlock(&vmap_area_lock);
>  }
>  
> @@ -2125,10 +2122,10 @@ struct vm_struct *find_vm_area(const void *addr)
>  	struct vmap_area *va;
>  
>  	va = find_vmap_area((unsigned long)addr);
> -	if (va && va->flags & VM_VM_AREA)
> -		return va->vm;
> +	if (!va)
> +		return NULL;
>  
> -	return NULL;
> +	return va->vm;
>  }
>  
>  /**
> @@ -2149,11 +2146,10 @@ struct vm_struct *remove_vm_area(const void *addr)
>  
>  	spin_lock(&vmap_area_lock);
>  	va = __find_vmap_area((unsigned long)addr);
> -	if (va && va->flags & VM_VM_AREA) {
> +	if (va && va->vm) {
>  		struct vm_struct *vm = va->vm;
>  
>  		va->vm = NULL;
> -		va->flags &= ~VM_VM_AREA;
>  		spin_unlock(&vmap_area_lock);
>  
>  		kasan_free_shadow(vm);
> @@ -2856,7 +2852,7 @@ long vread(char *buf, char *addr, unsigned long count)
>  		if (!count)
>  			break;
>  
> -		if (!(va->flags & VM_VM_AREA))
> +		if (!va->vm)
>  			continue;
>  
>  		vm = va->vm;
> @@ -2936,7 +2932,7 @@ long vwrite(char *buf, char *addr, unsigned long count)
>  		if (!count)
>  			break;
>  
> -		if (!(va->flags & VM_VM_AREA))
> +		if (!va->vm)
>  			continue;
>  
>  		vm = va->vm;
> @@ -3466,10 +3462,10 @@ static int s_show(struct seq_file *m, void *p)
>  	va = list_entry(p, struct vmap_area, list);
>  
>  	/*
> -	 * s_show can encounter race with remove_vm_area, !VM_VM_AREA on
> -	 * behalf of vmap area is being tear down or vm_map_ram allocation.
> +	 * s_show can encounter race with remove_vm_area, !vm on behalf
> +	 * of vmap area is being tear down or vm_map_ram allocation.
>  	 */
> -	if (!(va->flags & VM_VM_AREA)) {
> +	if (!va->vm) {
>  		seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
>  			(void *)va->va_start, (void *)va->va_end,
>  			va->va_end - va->va_start);
> -- 
> 2.21.0
> 

This patch depends on https://lkml.org/lkml/2019/7/16/276 and looks ok
to me, so

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thanks!

--
Vlad Rezki
