Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66074C32774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397B3206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRCf0Qsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfI0GiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 02:38:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36879 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfI0GiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 02:38:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id f22so4889320wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 23:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Owq66DDGFiymKtRCifTYoKISdbP/+uwfvEw1o14BnvA=;
        b=gRCf0QsuhrQoJtXTprczxr/dllFuh2YdgOjedXS2oZph/OT3yc247VSnDSBEBJ+JY5
         6W+XTdq4rYo2i/DBm4XA1CZd24p36zZi9kd65vWBr0/qBQ+r/dBM85o3gbtbzIh40c4q
         iQehrWH3DWbdZMurjEL7nqYVCm6n8QGRs7I5RuJS03XivI2ta7O+M9MpcaNwg4MQ/SK3
         O3YoxskcP+tXZHqbWBWcfzuRsKvDmw9hHoXj6K8lSyONPd4xpUnaO7dr2/mmnvinYL1S
         bTvl9Z7QJ6AjrizR/Px0aqJeGJRP2J+UxubWjYQpl6EUItsIKZWxY4JdG7w4QJVd3KX6
         3hNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Owq66DDGFiymKtRCifTYoKISdbP/+uwfvEw1o14BnvA=;
        b=Sa7zwgWEgmT+OpM+Dmh6bTCoRKvOtKI9x1A8PGuaJvbV7caadSslbZGOv0ApjQX+P0
         jKd0dbgPzxUv1mo/P5jwzAp1/FqX1LfL5fAXQ+lWDfhYIinR0WnGPXlX5V91T63FwQFY
         HYctZjSDo+imx0Y9/ue5mlRuy7a3/JfNvSAIyICkeFmPTb6UNU4MHkZrRS40Mn7MizDb
         0A2mK8UxbYx3a77oY9O45NhupnS0EAgHmMbgZIiN7a8SqKO1aB7A1do1z3vjP+bGU8Un
         1YLuiO4FdkCKRxhxEOMle9B9Sruu+2mMnOMBFuEgCCkxyqy/oheKNVkNiDh+BMCz03yW
         upEA==
X-Gm-Message-State: APjAAAUs1/8iQn4rFoZ9F4vaHrAknKV+azF9ZsbovjB5idiRkspnl/Xj
        1elbpvrfz9AM57dc0HyhrAAIOQgaK4EFKoagK58=
X-Google-Smtp-Source: APXvYqyTIKxHef+KF9Q5eelRllB1C6bWIaIEoaVVq8xO0PjfcZYnc2VCsRn/kJ/xLRtG6YYf3yQERhTVSJWwplX1xvo=
X-Received: by 2002:a1c:f714:: with SMTP id v20mr6087485wmh.55.1569566287677;
 Thu, 26 Sep 2019 23:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190926045419.22827-1-alastair@au1.ibm.com> <20190926045419.22827-6-alastair@au1.ibm.com>
In-Reply-To: <20190926045419.22827-6-alastair@au1.ibm.com>
From:   Mark Marshall <markmarshall14@gmail.com>
Date:   Fri, 27 Sep 2019 08:37:56 +0200
Message-ID: <CAD4b4WLdMgunRoBDVtNZbhaMPbMw57AbcJgkKfmy2zpshgVyqQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] powerpc: Chunk calls to flush_dcache_range in arch_*_memory
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Qian Cai <cai@lca.pw>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comment below...

On Thu, 26 Sep 2019 at 12:18, Alastair D'Silva <alastair@au1.ibm.com> wrote:
>
> From: Alastair D'Silva <alastair@d-silva.org>
>
> When presented with large amounts of memory being hotplugged
> (in my test case, ~890GB), the call to flush_dcache_range takes
> a while (~50 seconds), triggering RCU stalls.
>
> This patch breaks up the call into 1GB chunks, calling
> cond_resched() inbetween to allow the scheduler to run.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  arch/powerpc/mm/mem.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index cff947cb2a84..a2758e473d58 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -104,6 +104,27 @@ int __weak remove_section_mapping(unsigned long start, unsigned long end)
>         return -ENODEV;
>  }
>
> +#define FLUSH_CHUNK_SIZE SZ_1G
> +/**
> + * flush_dcache_range_chunked(): Write any modified data cache blocks out to
> + * memory and invalidate them, in chunks of up to FLUSH_CHUNK_SIZE
> + * Does not invalidate the corresponding instruction cache blocks.
> + *
> + * @start: the start address
> + * @stop: the stop address (exclusive)
> + * @chunk: the max size of the chunks
> + */
> +static void flush_dcache_range_chunked(unsigned long start, unsigned long stop,
> +                                      unsigned long chunk)
> +{
> +       unsigned long i;
> +
> +       for (i = start; i < stop; i += FLUSH_CHUNK_SIZE) {
Here you ignore the function parameter "chunk" and use the define
FLUSH_CHUNK_SIZE.
You should do one or the other; use the parameter or remove it.
> +               flush_dcache_range(i, min(stop, start + FLUSH_CHUNK_SIZE));
> +               cond_resched();
> +       }
> +}
> +
>  int __ref arch_add_memory(int nid, u64 start, u64 size,
>                         struct mhp_restrictions *restrictions)
>  {
> @@ -120,7 +141,8 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
>                         start, start + size, rc);
>                 return -EFAULT;
>         }
> -       flush_dcache_range(start, start + size);
> +
> +       flush_dcache_range_chunked(start, start + size, FLUSH_CHUNK_SIZE);
>
>         return __add_pages(nid, start_pfn, nr_pages, restrictions);
>  }
> @@ -137,7 +159,8 @@ void __ref arch_remove_memory(int nid, u64 start, u64 size,
>
>         /* Remove htab bolted mappings for this section of memory */
>         start = (unsigned long)__va(start);
> -       flush_dcache_range(start, start + size);
> +       flush_dcache_range_chunked(start, start + size, FLUSH_CHUNK_SIZE);
> +
>         ret = remove_section_mapping(start, start + size);
>         WARN_ON_ONCE(ret);
>
> --
> 2.21.0
>
