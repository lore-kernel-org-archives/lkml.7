Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5948ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970FA2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="JDRvwufl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391361AbfJPHuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:50:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53223 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391302AbfJPHt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:49:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id r19so1724300wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Of9U+idySm1f7zahNIvCqAevKwBri2ZmJMTLKSSsyAM=;
        b=JDRvwuflF5JjJLkwOlEL2zXx2Czdzdk9RV9OXNAYOpDXXQ4yv0GekH0yOJQe1pT7O2
         IRKQSJMqSBmS6z2WLJC1ofVqU8cSOIgIGXwY6bmOjrqCkWReRrv8leYVraJrh9DmU3r7
         0/Ygo/0nut2WZSooZoC9k31IeP/GV7VM4gJbdtZzwwgBFKv1G4ecEZdHYVJ0KaX7f2GQ
         v7ABD7pi/PISIFSmTixlj/iWL2w6meSHc1pqL2Mne5K9Vo9yPM4Qt82NpO7SuJO4v6P0
         mAUI4EpTdWMiwujK0Z0h5B2BvJIAjQAO++ja/8NStba6ltxtj9uzBAaWaqqaURNnVnyo
         vY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Of9U+idySm1f7zahNIvCqAevKwBri2ZmJMTLKSSsyAM=;
        b=XxWWnOlaBEbMcbLzWhgpK4qFaBdL9icJnN77z5dGD9zLjqIjWkJcFx0yC7KdeaFpP5
         u4jGxHr+VRXMMyH9FmT/+CmREh0pCzi2BtPggpLi7WKdjZsQ8fw6nfPU3OF21+rcjAlB
         mjc1zBcNqDQ8s8cUCxVNWStQ6D/m2mRXdFkpuSb4iNH3FWucP/izd3E1Kwh2W5x6QBcI
         fdFDx66WCYvZ/hJcRJtnH4L1NdfnYyAi0HlR5fSBwL3y6R5j6oq+NvW8mW9LeowLQLqN
         xzVYRMeStFKv1TuWSPNgHmCFD5yBePaW/ZnSVMI0YYykj7dLXnN5d1Ze0k32AtMdthPU
         ijMw==
X-Gm-Message-State: APjAAAVDMhji0fxarSDq5EerBsmnUmg8EMACOgDLZlGLcZIwxrx0BwfE
        hEzTSK4cNMhYhnyGa2YIrRdH5nTg0AFov94jKwVPSA==
X-Google-Smtp-Source: APXvYqz3LCGD0ihBV0I11F3X+PJJZ+xeWK2dkBbT4TN59RQ/UGEIL7SmGAdg9INWz7ievs7QPV0ci0GAdJyvMVB+QuY=
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr2001725wml.177.1571212197232;
 Wed, 16 Oct 2019 00:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191016073408.7299-1-greentime.hu@sifive.com>
In-Reply-To: <20191016073408.7299-1-greentime.hu@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 16 Oct 2019 13:19:45 +0530
Message-ID: <CAAhSdy275aL_hicDWUBKF+9_dr+FWfvZi0__Zm2=FzzpkYj22w@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: fix virtual address overlapped in FIXADDR_START
 and VMEMMAP_START
To:     greentime.hu@sifive.com
Cc:     Greentime Hu <green.hu@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 1:04 PM <greentime.hu@sifive.com> wrote:
>
> From: Greentime Hu <greentime.hu@sifive.com>
>
> This patch fixes the virtual address layout in pgtable.h.
> The virtual address of FIXADDR_START and VMEMMAP_START should not be overlapped.
> These addresses will be existed at the same time in Linux kernel that they can't
> be overlapped.
>
> Fixes: d95f1a542c3d ("RISC-V: Implement sparsemem")
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 4f4162d90586..b927fb4ecf1c 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -87,14 +87,6 @@ extern pgd_t swapper_pg_dir[];
>  #define VMALLOC_END      (PAGE_OFFSET - 1)
>  #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
>
> -#define FIXADDR_TOP      VMALLOC_START
> -#ifdef CONFIG_64BIT
> -#define FIXADDR_SIZE     PMD_SIZE
> -#else
> -#define FIXADDR_SIZE     PGDIR_SIZE
> -#endif
> -#define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
> -
>  /*
>   * Roughly size the vmemmap space to be large enough to fit enough
>   * struct pages to map half the virtual address space. Then
> @@ -108,6 +100,14 @@ extern pgd_t swapper_pg_dir[];
>
>  #define vmemmap                ((struct page *)VMEMMAP_START)
>
> +#define FIXADDR_TOP      (VMEMMAP_START)
> +#ifdef CONFIG_64BIT
> +#define FIXADDR_SIZE     PMD_SIZE
> +#else
> +#define FIXADDR_SIZE     PGDIR_SIZE
> +#endif
> +#define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
> +
>  /*
>   * ZERO_PAGE is a global shared page that is always zero,
>   * used for zero-mapped memory areas, etc.
> --
> 2.17.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
