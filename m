Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9888AC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E2220866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="KGGpG8Iz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfFLTiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:38:02 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34905 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfFLTiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:38:02 -0400
Received: by mail-oi1-f194.google.com with SMTP id y6so12608829oix.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Vsa8HyqC2oPVjqlWmiidGbfDST1iKBAlh+u3suUXlA=;
        b=KGGpG8IzSmQohtF+bMSMFl4GFI15MvmdWRIlvGpQyOPp35DsSAu2JozT3LGhHlQ1ra
         FNFgVxOVWVBq7FOtyKPIdP04Myv72GdGJDG/s4L7Mb6s3JvP+6MBMgEFXX5molJ7old0
         6si/wHUAvzULxk8fzjD1TWJvwttYJbt+mBabkmLGSrfCl/NoFalC9FCSfvjjeeqANhG8
         ouCGKedWKozURrDF2xKTG1yTWv9gz0MUFNadg/r0qBcUA5mNVxL/KhXg7SqNxGbX094l
         O/yrR7vV4ZPh5idL0/z0TmmYhtzd+dhOi0QEo1kktO976505BmdBaX4Ld6+H5PqzWf8I
         RRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Vsa8HyqC2oPVjqlWmiidGbfDST1iKBAlh+u3suUXlA=;
        b=uLpSl07SDhS8AQW3gGbmNBcu9ZNvb7KLMaJ7vfI/LBqiIwkAB/WCd6syVC94TlYVGa
         MCKMshEfxAkeYJ6XneAS7p+K0yYMrC6MVNd9yDjVlgzApnU2690vnN3bCZDAhQIIlHVV
         GJ5TmPFI8bLv/zLDhntE5EhcCA4g1CyzTOgfV6AU1uqGd8ZLRjtCx65NNTKLW5gUYxdm
         mBmZ019MKNUKisVRDPb/m+txniqRhaIMrmccTynQ94uvwFawbjfi446pES1qwifeodNX
         APYRWe9aAhlRZfE8C4J6c0dxJQyCN5G0CXgvxLFG/V1jCEehMjQCtofn/lqElC2b3a5H
         ROmg==
X-Gm-Message-State: APjAAAWvj2o8zc8Z7LJ1wGLfUNFOBEQFDMWTOuts/yJm4oBeLKX1XeKp
        WlLd5pS+3fiIJ5w0eJIh1qTket0vvXmJ4g8pBVomhA==
X-Google-Smtp-Source: APXvYqzW5RJxhzCoPftf/A/PNavKGkuPNW5LiOizI6LRDGXLVwIJ9/ouGmWX6jQxJ6p1DBRxRCBCrKftesSOqV/nJ+E=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr618670oii.0.1560368281476;
 Wed, 12 Jun 2019 12:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <1560366952-10660-1-git-send-email-cai@lca.pw>
In-Reply-To: <1560366952-10660-1-git-send-email-cai@lca.pw>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Jun 2019 12:37:49 -0700
Message-ID: <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from pfn_to_online_page()
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 12:16 PM Qian Cai <cai@lca.pw> wrote:
>
> The linux-next commit "mm/sparsemem: Add helpers track active portions
> of a section at boot" [1] causes a crash below when the first kmemleak
> scan kthread kicks in. This is because kmemleak_scan() calls
> pfn_to_online_page(() which calls pfn_valid_within() instead of
> pfn_valid() on x86 due to CONFIG_HOLES_IN_ZONE=n.
>
> The commit [1] did add an additional check of pfn_section_valid() in
> pfn_valid(), but forgot to add it in the above code path.
>
> page:ffffea0002748000 is uninitialized and poisoned
> raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> ------------[ cut here ]------------
> kernel BUG at include/linux/mm.h:1084!
> invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
> CPU: 5 PID: 332 Comm: kmemleak Not tainted 5.2.0-rc4-next-20190612+ #6
> Hardware name: Lenovo ThinkSystem SR530 -[7X07RCZ000]-/-[7X07RCZ000]-,
> BIOS -[TEE113T-1.00]- 07/07/2017
> RIP: 0010:kmemleak_scan+0x6df/0xad0
> Call Trace:
>  kmemleak_scan_thread+0x9f/0xc7
>  kthread+0x1d2/0x1f0
>  ret_from_fork+0x35/0x4
>
> [1] https://patchwork.kernel.org/patch/10977957/
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  include/linux/memory_hotplug.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 0b8a5e5ef2da..f02be86077e3 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -28,6 +28,7 @@
>         unsigned long ___nr = pfn_to_section_nr(___pfn);           \
>                                                                    \
>         if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
> +           pfn_section_valid(__nr_to_section(___nr), pfn) &&      \
>             pfn_valid_within(___pfn))                              \
>                 ___page = pfn_to_page(___pfn);                     \
>         ___page;                                                   \

Looks ok to me:

Acked-by: Dan Williams <dan.j.williams@intel.com>

...but why is pfn_to_online_page() a multi-line macro instead of a
static inline like all the helper routines it invokes?
