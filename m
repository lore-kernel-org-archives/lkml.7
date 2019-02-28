Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340E8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC39D2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0NSmVl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbfB1Jkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:40:42 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55496 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfB1Jkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:40:41 -0500
Received: by mail-it1-f195.google.com with SMTP id z131so13719555itf.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 01:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S26r9EQQiDPxNxYvJmNZCbJAOL1UM5RvwiPMkziSBzg=;
        b=U0NSmVl8J7o8diMWrXaBfCRVVO9hkRPtkZrl6aaI7DAn6GobljIhfpFjav5mIPIS8h
         Jk0/ckQ2BcKcJGSZvPPqxMlWGkVVCunbaOGBPIGjep6k6E67Fut0r+hD1iE5++BFqjW7
         GFWekBaixpATDluYe1h0LFj3/KwhqNt38di+s6OczOUlUI7ibcqMgSsAB/V8h2f/WN7e
         pezFFRymqiaSWEq7rnyCdFnjeYNigblLeWPm32VhX4TIdyBhcjaOdu+k3ZqXMLYzRVWp
         HOphgOgOJxLBW3x+LFR9N7yNccsd8OSEGxbuDGnfHw/ykkEdlnnOnCo+Kh+MTFIcWPku
         xp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S26r9EQQiDPxNxYvJmNZCbJAOL1UM5RvwiPMkziSBzg=;
        b=l5CfnPzwMyt1KXioxrEq56Ai38Piuop1QL6whiT4C9aW4kpk0oiGM6aPmI4R7Sz6o4
         E8LZwAcV5ejiFpn9XwcTUWmUJsyNBhSrxEkDIkibgdsCFNFTS6mF4ICHwqhPOdTBjQFn
         i48xL9tUTbTl2UqBsjhLRvG/UXXvMxvfVxvu+ytriU+Sf2ik3ZyHqIgGb3KxfKCnSMaX
         ZLGrGrYJG2nqWhB/25KERS9LGBS0ui4DF7b7xEetE1/GvlZJeVj55be3eE7goIeIdS9U
         fbB6KPpCAKL6jnJ077DZMHE3z0k7p0cRA6uousHQfeW/kNbX17rlB1gJ0lKPdjWZnTYE
         LbOg==
X-Gm-Message-State: AHQUAuYX7vQ/ZwCJVqVaPAoo+4CbkOKskTsupOuCTOl4jn1bpp6Gv3Zf
        GJIbbxaXVOq8QvhVimYlwlG5D48K9HP7ZPrhdWc=
X-Google-Smtp-Source: APXvYqyLNampIdRkpMVsvaM4M4JZbyfAswlr4iCIih/PAb6NXl9jqGpo35tzyFoMCexDlnISxW3EVxD6yAbte4aapG0=
X-Received: by 2002:a24:5ec1:: with SMTP id h184mr2240354itb.4.1551346840414;
 Thu, 28 Feb 2019 01:40:40 -0800 (PST)
MIME-Version: 1.0
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com> <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
From:   Oliver <oohall@gmail.com>
Date:   Thu, 28 Feb 2019 20:40:29 +1100
Message-ID: <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jan Kara <jack@suse.cz>, Michael Ellerman <mpe@ellerman.id.au>,
        Ross Zwisler <zwisler@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 7:35 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Add a flag to indicate the ability to do huge page dax mapping. On architecture
> like ppc64, the hypervisor can disable huge page support in the guest. In
> such a case, we should not enable huge page dax mapping. This patch adds
> a flag which the architecture code will update to indicate huge page
> dax mapping support.

*groan*

> Architectures mostly do transparent_hugepage_flag = 0; if they can't
> do hugepages. That also takes care of disabling dax hugepage mapping
> with this change.
>
> Without this patch we get the below error with kvm on ppc64.
>
> [  118.849975] lpar: Failed hash pte insert with error -4
>
> NOTE: The patch also use
>
> echo never > /sys/kernel/mm/transparent_hugepage/enabled
> to disable dax huge page mapping.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
> TODO:
> * Add Fixes: tag
>
>  include/linux/huge_mm.h | 4 +++-
>  mm/huge_memory.c        | 4 ++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 381e872bfde0..01ad5258545e 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -53,6 +53,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
>                         pud_t *pud, pfn_t pfn, bool write);
>  enum transparent_hugepage_flag {
>         TRANSPARENT_HUGEPAGE_FLAG,
> +       TRANSPARENT_HUGEPAGE_DAX_FLAG,
>         TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
>         TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
>         TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
> @@ -111,7 +112,8 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>         if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
>                 return true;
>
> -       if (vma_is_dax(vma))
> +       if (vma_is_dax(vma) &&
> +           (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_DAX_FLAG)))
>                 return true;

Forcing PTE sized faults should be fine for fsdax, but it'll break
devdax. The devdax driver requires the fault size be >= the namespace
alignment since devdax tries to guarantee hugepage mappings will be
used and PMD alignment is the default. We can probably have devdax
fall back to the largest size the hypervisor has made available, but
it does run contrary to the design. Ah well, I suppose it's better off
being degraded rather than unusable.

>         if (transparent_hugepage_flags &
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index faf357eaf0ce..43d742fe0341 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -53,6 +53,7 @@ unsigned long transparent_hugepage_flags __read_mostly =
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE_MADVISE
>         (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)|
>  #endif
> +       (1 << TRANSPARENT_HUGEPAGE_DAX_FLAG) |
>         (1<<TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG)|
>         (1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG)|
>         (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
> @@ -475,6 +476,8 @@ static int __init setup_transparent_hugepage(char *str)
>                           &transparent_hugepage_flags);
>                 clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
>                           &transparent_hugepage_flags);
> +               clear_bit(TRANSPARENT_HUGEPAGE_DAX_FLAG,
> +                         &transparent_hugepage_flags);
>                 ret = 1;
>         }
>  out:

> @@ -753,6 +756,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>         spinlock_t *ptl;
>
>         ptl = pmd_lock(mm, pmd);
> +       /* should we check for none here again? */

VM_WARN_ON() maybe? If THP is disabled and we're here then something
has gone wrong.

>         entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
>         if (pfn_t_devmap(pfn))
>                 entry = pmd_mkdevmap(entry);
> --
> 2.20.1
>
