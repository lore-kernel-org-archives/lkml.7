Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C646EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7DD206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F96XFSXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfLDWkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:40:49 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38635 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfLDWks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 17:40:48 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so866788lfm.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 14:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PXU0l6hsLNwOEAachYcf3O/SAhU82EqIUjlmH0om7uk=;
        b=F96XFSXRmW86ugKdykHTCw+//Ckr2I37FfACIGnU9BIPH5uQDgSkjEaFAJjn5FOd9N
         ghzJbE0W0zDlD4xBGKMbcWs9mdQDJlJ4RRJYRRWH2dTttCzUlySAKLwlWjfdlQd8Inpj
         AqnY9qnCilK/APl5c93l5GJXqWw6TnVlqwrsKPxnYgTZNyiiQu7DegGpw3qSy4GvEviy
         yvkyIeft4+SJpKxQs2wvH7TkCm/iL2cR87+qLAvXqYcjDTidd5oqLe+teimX0iYs5uob
         CS8JXtTgcwFeaCuPij5HAP/bR66jxE9lT2dsEgLl1xkrD+tIrcB1JW5znVjUp6InIpZx
         fIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PXU0l6hsLNwOEAachYcf3O/SAhU82EqIUjlmH0om7uk=;
        b=rBYgerIQMixk2i6NQD/5sa0OQ1UbnUzrl8XMIwKyFWb2+Ne0LV1cnSc3hRhUNGPyI6
         77DrM3HFKBiYrYz2rMJt4QZP2rJhF/ZcBvS0jyW7+n+Vna7M1io3IbyNvOINvpJ4LVlO
         lpZy3GYpd3q7ZzQbpQHrjlXS+Hf2gdJt+NFvBWJyEXYYvb/resirAyMLrcLR7XZ7kScf
         O4z6txZoXHqy/htO70YpTR87SSlRJbAYroOChYXSE5XaRMr+BDfs0E+OpDCM+HXnDgzK
         yRfZiHuumql6ZXSWORe1o955lRxNWhC9TKTjpAqFhwxVHKanuqQ3bLRC9fTSjV6HXT4l
         Fbow==
X-Gm-Message-State: APjAAAV04eTxcsxa6h989aA34MKp4yClZs0WrPYmJkVI0rkbyhqp8XkT
        tsHbGezUNc65YhdCBzT9zhc=
X-Google-Smtp-Source: APXvYqwIqR7t1ouhgP9BBoaid56UlfHiPWLcqeM8nXJ6uLkUo4RIKcPrFGz8TtL+baL1omb7r/wJVg==
X-Received: by 2002:a19:4f46:: with SMTP id a6mr3490704lfk.143.1575499246564;
        Wed, 04 Dec 2019 14:40:46 -0800 (PST)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id m16sm3932304ljb.47.2019.12.04.14.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 14:40:45 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 4 Dec 2019 23:40:37 +0100
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Daniel Axtens <dja@axtens.net>, Qian Cai <cai@lca.pw>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        syzbot+82e323920b78d54aaed5@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] kasan: fix crashes on access to memory mapped by
 vm_map_ram()
Message-ID: <20191204224037.GA12896@pc636>
References: <20191204204534.32202-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204204534.32202-1-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 4d3b3d60d893..a5412f14f57f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1073,6 +1073,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	struct vmap_area *va, *pva;
>  	unsigned long addr;
>  	int purged = 0;
> +	int ret = -EBUSY;
>  
>  	BUG_ON(!size);
>  	BUG_ON(offset_in_page(size));
> @@ -1139,6 +1140,10 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	va->va_end = addr + size;
>  	va->vm = NULL;
>  
> +	ret = kasan_populate_vmalloc(addr, size);
> +	if (ret)
> +		goto out;
> +
But it introduces another issues when is CONFIG_KASAN_VMALLOC=y. If
the kasan_populate_vmalloc() gets failed for some reason it just
leaves the function, that will lead to waste of vmap space.

>  	spin_lock(&vmap_area_lock);
>  	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
>  	spin_unlock(&vmap_area_lock);
>
     ret = kasan_populate_vmalloc(addr, size);
     if (ret) {
         free_vmap_area(va);
         return ERR_PTR(-EBUSY);;
     }

> @@ -1169,8 +1174,9 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
>  			size);
>  
> +out:
>  	kmem_cache_free(vmap_area_cachep, va);
> -	return ERR_PTR(-EBUSY);
> +	return ERR_PTR(ret);
>  }
>  
