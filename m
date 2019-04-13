Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DAFC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC892073F
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ot0ehbWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfDMPLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 11:11:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35827 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfDMPLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 11:11:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id u21so9732954lfu.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Znuv7PRVSTefHhJ5YWIem4mXL9RvNBKhNffRq5l2N9M=;
        b=Ot0ehbWHVvNTRoG3jW64k8a8+ejKS2yDG8ws3t/UJwpif1let11nCitLi6A/LlbrWC
         0upz97XBXiOh9Osu2b/41yd+RXaSXt2C3g2l0FEXR6lI4a7Gnqx2ZabtNIX1rvKCkGqx
         JVwy4vL9ENhMDA36yw/w3Kxn2Mu9cHAQWGSvI1bZ53U3D2LyrrnHgGuyNNOwSvBAXkXP
         spb9V4HQkuWDkYkTuSfXskp5wr0+rGU3CeHyFAh7OCo2S/Ua1Ca/HTga1NijBnOThj0V
         QBVMp0/fDHeSD36N3AMziCVA5r7t9uJfZ0lSDPz2WWsFSqPA6Wf3pe/fpLFtIYstZoGp
         uKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Znuv7PRVSTefHhJ5YWIem4mXL9RvNBKhNffRq5l2N9M=;
        b=iz/O6zIZnhMxhaYEiNiE27jkiUw1j2yos8WxSMbr54o6RtAw6HdC9mgCr6kAWt3WGm
         d+qxKwS2Xv9857/FrrIqE3krelHG67zC0WPDefV8Y3MayL+PcRwsL4rZYyoROKWdhmwL
         xLlGnY8WPszhkkZ2NAkD1IQ04nBMOozPM33fFFGkoue+dKDOcDxwclDHEtO2UvbugPBk
         xLY6m/YjVxFp+Nlutp/8rAzf4CTXFbU778U5DYv2HgZKakMBNo+HwInFlbT32ZcmnJgp
         +SGxm1DgeO47YiZdvYo0CnGKc/Byk2PKL9lFzW1TLuC9UgzOBEAJral4+Z+jg+lSKwyZ
         ptFg==
X-Gm-Message-State: APjAAAUcoJSzoworrNzW13GOvLVoPq1kDDQk8mb1BcUGSA9n2vMcMbqA
        zeoqN3wpP3dKOMeFLg9r2qohAC6q5cuZuUe7lwQ=
X-Google-Smtp-Source: APXvYqwNYDXdPuWjq1Rfv9JH1RToFW+aPmIH0F3dPFNb8v+Tg3fGnDTl+SifrN7AkqwiDgRRR4Lo0zz5M8x090OQb3s=
X-Received: by 2002:ac2:490b:: with SMTP id n11mr3934378lfi.24.1555168291660;
 Sat, 13 Apr 2019 08:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190412160338.64994-1-thellstrom@vmware.com> <20190412160338.64994-2-thellstrom@vmware.com>
In-Reply-To: <20190412160338.64994-2-thellstrom@vmware.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 13 Apr 2019 20:41:19 +0530
Message-ID: <CAFqt6zb4qBdrWev1KEruDzPJt5wP4ax_7hUyz+JMV9zLxd_iiw@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm: Allow the [page|pfn]_mkwrite callbacks to drop
 the mmap_sem
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 9:34 PM Thomas Hellstrom <thellstrom@vmware.com> wr=
ote:
>
> Driver fault callbacks are allowed to drop the mmap_sem when expecting
> long hardware waits to avoid blocking other mm users. Allow the mkwrite
> callbacks to do the same by returning early on VM_FAULT_RETRY.
>
> In particular we want to be able to drop the mmap_sem when waiting for
> a reservation object lock on a GPU buffer object. These locks may be
> held while waiting for the GPU.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> ---
>  mm/memory.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index e11ca9dd823f..a95b4a3b1ae2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2144,7 +2144,7 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *=
vmf)
>         ret =3D vmf->vma->vm_ops->page_mkwrite(vmf);
>         /* Restore original flags so that caller is not surprised */
>         vmf->flags =3D old_flags;
> -       if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))
> +       if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_RETRY | VM_FAULT_NO=
PAGE)))

With this patch there will multiple instances of (VM_FAULT_ERROR |
VM_FAULT_RETRY | VM_FAULT_NOPAGE)
in mm/memory.c. Does it make sense to wrap it in a macro and use it ?

>                 return ret;
>         if (unlikely(!(ret & VM_FAULT_LOCKED))) {
>                 lock_page(page);
> @@ -2419,7 +2419,7 @@ static vm_fault_t wp_pfn_shared(struct vm_fault *vm=
f)
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>                 vmf->flags |=3D FAULT_FLAG_MKWRITE;
>                 ret =3D vma->vm_ops->pfn_mkwrite(vmf);
> -               if (ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE))
> +               if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY | VM_FAULT_NOP=
AGE))
>                         return ret;
>                 return finish_mkwrite_fault(vmf);
>         }
> @@ -2440,7 +2440,8 @@ static vm_fault_t wp_page_shared(struct vm_fault *v=
mf)
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>                 tmp =3D do_page_mkwrite(vmf);
>                 if (unlikely(!tmp || (tmp &
> -                                     (VM_FAULT_ERROR | VM_FAULT_NOPAGE))=
)) {
> +                                     (VM_FAULT_ERROR | VM_FAULT_RETRY |
> +                                      VM_FAULT_NOPAGE)))) {
>                         put_page(vmf->page);
>                         return tmp;
>                 }
> @@ -3494,7 +3495,8 @@ static vm_fault_t do_shared_fault(struct vm_fault *=
vmf)
>                 unlock_page(vmf->page);
>                 tmp =3D do_page_mkwrite(vmf);
>                 if (unlikely(!tmp ||
> -                               (tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)=
))) {
> +                               (tmp & (VM_FAULT_ERROR | VM_FAULT_RETRY |
> +                                       VM_FAULT_NOPAGE)))) {
>                         put_page(vmf->page);
>                         return tmp;
>                 }
> --
> 2.20.1
>
