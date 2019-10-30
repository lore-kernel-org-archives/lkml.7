Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F52CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49128217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0t2hUb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfJ3OaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:30:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47033 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfJ3OaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:30:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id w8so2876519lji.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 07:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UDQi5D+Jni0obEk/hrjnnpFb3HIzP7e6/KmAnzzfUzA=;
        b=h0t2hUb4oT0r62g/cYibJjD1Fyqyoyjgd8JaJBdp8oUdJ7aXI+MoelJSuvU31m5zTW
         9t5FudXDw80Z5My1dBKKXgsCu/7Gu9eh73ATRKB2rhIAv7GMWeavnW21688kuF9jpZpY
         pHRE1y4vCKpMV/jmFLcEaX5CZ/9VFgXcarK09YTh+zaJmfM7uLK0aEDFGASxF1tJ/bLC
         tx/2yWUM7YlMaRGD+S8pU+7cwTcuigP80RQ993kbcqqxly7AyKZctejgg3d+T2w44YUK
         p6GXHGwn+arn3+YBZCrYhbJpGGVM8j9kad/eRmovTQxPTGy3BsJpRhEHIrSABScQ8Wsn
         et0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UDQi5D+Jni0obEk/hrjnnpFb3HIzP7e6/KmAnzzfUzA=;
        b=Ym9D3Snf2yUOeAv7tuVge8mFiTsULwAN7CyGsB1B9Dv7yxkzANWbUsqtRHZ7Qf3vNt
         xxcDSmrCQv6ptx9Y04hsxoe6/duLE36N3Xzzwtxooc1lyzmf6RP3NmI9oQcwfj9jvtay
         VVElIsKB6vfwkN7+jq+aKCnP8cGXlhmZ/qtowShOcLqFsmjdeTZ+CafoEflzAb4rc7/j
         opiNSzRto7tyOrAvhofStpC8cT+W55HOlCmdLOzrWlYCt2Yr2KyiQ/NqwuI4Ft43txnd
         FkRAkOPfUlZdHpI9SRVSXnFPt87mukD3KyQyGzoNOnfDp+53GTQ7ah+HR6dOlFtkOHvg
         VfRA==
X-Gm-Message-State: APjAAAV/THMqlnHcNFgpq9fDcfPOqgJmNjC4fOl0UDBXoTwT41lFzneo
        kSEjPrtxN02oqr+Pbvfs/xQ=
X-Google-Smtp-Source: APXvYqx/6ls83NprcmJjVqcPOseDGmZ24WPegNnd0fqzJOSCj4K/d9bGCTxDyewu+1FbJJXi3uqHXg==
X-Received: by 2002:a2e:8545:: with SMTP id u5mr7565ljj.213.1572445800371;
        Wed, 30 Oct 2019 07:30:00 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id s7sm32320ljo.98.2019.10.30.07.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 07:29:59 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 30 Oct 2019 15:29:51 +0100
To:     Daniel Axtens <dja@axtens.net>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
Subject: Re: [PATCH v10 1/5] kasan: support backing vmalloc space with real
 shadow memory
Message-ID: <20191030142951.GA24958@pc636>
References: <20191029042059.28541-1-dja@axtens.net>
 <20191029042059.28541-2-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029042059.28541-2-dja@axtens.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Daniel

>  
> @@ -1294,14 +1299,19 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>  	spin_lock(&free_vmap_area_lock);
>  	llist_for_each_entry_safe(va, n_va, valist, purge_list) {
>  		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
> +		unsigned long orig_start = va->va_start;
> +		unsigned long orig_end = va->va_end;
>  
>  		/*
>  		 * Finally insert or merge lazily-freed area. It is
>  		 * detached and there is no need to "unlink" it from
>  		 * anything.
>  		 */
> -		merge_or_add_vmap_area(va,
> -			&free_vmap_area_root, &free_vmap_area_list);
> +		va = merge_or_add_vmap_area(va, &free_vmap_area_root,
> +					    &free_vmap_area_list);
> +
> +		kasan_release_vmalloc(orig_start, orig_end,
> +				      va->va_start, va->va_end);
>  
I have some questions here. I have not analyzed kasan_releace_vmalloc()
logic in detail, sorry for that if i miss something. __purge_vmap_area_lazy()
deals with big address space, so not only vmalloc addresses it frees here,
basically it can be any, starting from 1 until ULONG_MAX, whereas vmalloc
space spans from VMALLOC_START - VMALLOC_END:

1) Should it be checked that vmalloc only address is freed or you handle
it somewhere else?

if (is_vmalloc_addr(va->va_start))
    kasan_release_vmalloc(...)

2) Have you run any bencmarking just to see how much overhead it adds?
I am asking, because probably it make sense to add those figures to the
backlog(commit message). For example you can run:

<snip>
sudo ./test_vmalloc.sh performance
and
sudo ./test_vmalloc.sh sequential_test_order=1
<snip>

Thanks!

--
Vlad Rezki
