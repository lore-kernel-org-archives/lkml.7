Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC00C32751
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84182087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXPi2pJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfG3Uq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:46:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41438 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfG3Uq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:46:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id d24so63390996ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3qpP13L/YlhBWREGN+w+dMx2b1ed0O1Yq+58BrCYMgw=;
        b=YXPi2pJprOg32fNIq/+jxiow4gPN9uM/aAtTlp5Q7VG3EO8jYfujKMDXWT8C7o397r
         nkslZFznDqWvUPbJOgE+69wiLowHfFdvGSDvcrgpi9AUYgpyzgQePyrr/ZpHiMnqmsoP
         xPcN3f9X51CSaeVlETuRr0UgEPaGnb1EeoEl0I3eT+w4el6JFqGnqVujQDi193UFTCZI
         oajbFBV0MCtw4Lg1vu95y3q64++mq8b+zVuc2/8I52WIbtsph5n20rVQRmc+Iz7DEMb/
         1EwIXMz25mRGeDcIKUP0EJgLPlfQDw192WF3WCNVEVIOIAss+ORTd+trpMapGBvVlZap
         NpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3qpP13L/YlhBWREGN+w+dMx2b1ed0O1Yq+58BrCYMgw=;
        b=LRpmusB4Ed9C6H7FoqsMl7C0ogKYRRb25R3WoEX8TZ5sxv/ASeFk4dB7bddS7tfRCh
         4+GBFSQQcDJAKcKGxenrYC8Ki7HTE7n1rmzeuVdW9UlAxMzbxoOU27qwn/FsZc5cJRHn
         tyMq2HDsqRjgoR7rwYYU9Ayp6Q5vLcNuABlVuJ0+6nOgcmArAyAECVhwTQSA7Q9kcAeA
         snCxebaigs9BMuo/J1XYK/+0zCt17vNVrmWI3U7DV2QllzRhp/Sq/+XbO+ClVbXl7L4y
         nGFbpfA9lHKgVJAKZ/w1CwBajl58ClwU5zzXXgdfRwYsj0Rv8Qzj9qkRhxmbDtqFkRS9
         EVug==
X-Gm-Message-State: APjAAAUxRgPdkPD+T5PMGWb5Q5Et902SPDQGB5JJOHmDOAzx10D24+tX
        DAUPmaS/zUJJGlzdx3LT0BDs2mCHBFeTyg==
X-Google-Smtp-Source: APXvYqxEaAJyuDCrYXGqiyBAgXHuyyxVjo61FR0VRnfuLbVGtOC6cmDnsTv53ObiZrRsnEhkwbB4hA==
X-Received: by 2002:a2e:730d:: with SMTP id o13mr42495381ljc.81.1564519615055;
        Tue, 30 Jul 2019 13:46:55 -0700 (PDT)
Received: from pc636 ([37.212.215.48])
        by smtp.gmail.com with ESMTPSA id p15sm13813248lji.80.2019.07.30.13.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jul 2019 13:46:53 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 30 Jul 2019 22:46:43 +0200
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     akpm@linux-foundation.org, urezki@gmail.com, dave.hansen@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mm/vmalloc.c: Fix percpu free VM area search
 criteria
Message-ID: <20190730204643.tsxgc3n4adb63rlc@pc636>
References: <20190729232139.91131-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729232139.91131-1-sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 04:21:39PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Recent changes to the vmalloc code by Commit 68ad4a330433
> ("mm/vmalloc.c: keep track of free blocks for vmap allocation") can
> cause spurious percpu allocation failures. These, in turn, can result in
> panic()s in the slub code. One such possible panic was reported by
> Dave Hansen in following link https://lkml.org/lkml/2019/6/19/939.
> Another related panic observed is,
> 
>  RIP: 0033:0x7f46f7441b9b
>  Call Trace:
>   dump_stack+0x61/0x80
>   pcpu_alloc.cold.30+0x22/0x4f
>   mem_cgroup_css_alloc+0x110/0x650
>   cgroup_apply_control_enable+0x133/0x330
>   cgroup_mkdir+0x41b/0x500
>   kernfs_iop_mkdir+0x5a/0x90
>   vfs_mkdir+0x102/0x1b0
>   do_mkdirat+0x7d/0xf0
>   do_syscall_64+0x5b/0x180
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> VMALLOC memory manager divides the entire VMALLOC space (VMALLOC_START
> to VMALLOC_END) into multiple VM areas (struct vm_areas), and it mainly
> uses two lists (vmap_area_list & free_vmap_area_list) to track the used
> and free VM areas in VMALLOC space. And pcpu_get_vm_areas(offsets[],
> sizes[], nr_vms, align) function is used for allocating congruent VM
> areas for percpu memory allocator. In order to not conflict with VMALLOC
> users, pcpu_get_vm_areas allocates VM areas near the end of the VMALLOC
> space. So the search for free vm_area for the given requirement starts
> near VMALLOC_END and moves upwards towards VMALLOC_START.
> 
> Prior to commit 68ad4a330433, the search for free vm_area in
> pcpu_get_vm_areas() involves following two main steps.
> 
> Step 1:
>     Find a aligned "base" adress near VMALLOC_END.
>     va = free vm area near VMALLOC_END
> Step 2:
>     Loop through number of requested vm_areas and check,
>         Step 2.1:
>            if (base < VMALLOC_START)
>               1. fail with error
>         Step 2.2:
>            // end is offsets[area] + sizes[area]
>            if (base + end > va->vm_end)
>                1. Move the base downwards and repeat Step 2
>         Step 2.3:
>            if (base + start < va->vm_start)
>               1. Move to previous free vm_area node, find aligned
>                  base address and repeat Step 2
> 
> But Commit 68ad4a330433 removed Step 2.2 and modified Step 2.3 as below:
> 
>         Step 2.3:
>            if (base + start < va->vm_start || base + end > va->vm_end)
>               1. Move to previous free vm_area node, find aligned
>                  base address and repeat Step 2
> 
> Above change is the root cause of spurious percpu memory allocation
> failures. For example, consider a case where a relatively large vm_area
> (~ 30 TB) was ignored in free vm_area search because it did not pass the
> base + end  < vm->vm_end boundary check. Ignoring such large free
> vm_area's would lead to not finding free vm_area within boundary of
> VMALLOC_start to VMALLOC_END which in turn leads to allocation failures.
> 
> So modify the search algorithm to include Step 2.2.
> 
> Fixes: 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  mm/vmalloc.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 4fa8d84599b0..1faa45a38c08 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3269,10 +3269,20 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  		if (va == NULL)
>  			goto overflow;
>  
> +		/*
> +		 * If required width exeeds current VA block, move
> +		 * base downwards and then recheck.
> +		 */
> +		if (base + end > va->va_end) {
> +			base = pvm_determine_end_from_reverse(&va, align) - end;
> +			term_area = area;
> +			continue;
> +		}
> +
>  		/*
>  		 * If this VA does not fit, move base downwards and recheck.
>  		 */
> -		if (base + start < va->va_start || base + end > va->va_end) {
> +		if (base + start < va->va_start) {
>  			va = node_to_va(rb_prev(&va->rb_node));
>  			base = pvm_determine_end_from_reverse(&va, align) - end;
>  			term_area = area;
> -- 
> 2.21.0
> 
I guess it is NUMA related issue, i mean when we have several
areas/sizes/offsets. Is that correct?

Thank you!

--
Vlad Rezki
