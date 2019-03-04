Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFD1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8744F206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551717474;
	bh=8yGVLS1LxVVUdXYLfXvFFljHTIlg3YAGJFdQ7WJ8YBA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1Qu2wCutrqdk5IKIJJLWGzbWVNPMZ4i7K0FaSUKr0Kpes37ioI1uhGgVR7vDGDPZv
	 B5MjjzMxd/m1ReJP/ld2Cexr6s5EQeG5DDQfOTyUPg0qigasbN/Tq4zS3evuOYhWnB
	 0U33MyE9xrNzw9hOXQcBRm+pGLMKC59KGOtCYFPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfCDQhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:37:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfCDQhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:37:52 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C7DA20830;
        Mon,  4 Mar 2019 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551717471;
        bh=8yGVLS1LxVVUdXYLfXvFFljHTIlg3YAGJFdQ7WJ8YBA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PadjDR29WYdFe5qKzePeT2by0abbfwOU4+xjvf7fS2x/qWG8ajsVh/9E/B+qjyKSX
         9lIFqw+2oVrlCHW/Q9HuDQbrY9f964i9mUL5W9E5Oq5/tPTAt0+KTuQvv54sORKZuF
         oekdjNXqGxmpllSToqlDL9BmAM5o4NbijpdAEy0A=
Received: by mail-qk1-f179.google.com with SMTP id y15so3129223qki.8;
        Mon, 04 Mar 2019 08:37:51 -0800 (PST)
X-Gm-Message-State: APjAAAWIrPCwVrjbsuLe0tB5rb7iiCgQOUTT9fweAZZl6l6ZmoxxM2KK
        es4ISQDZgCSkLdEE5ynjpJQ/X++hxf7fa7J0yQ==
X-Google-Smtp-Source: APXvYqxxewLDjBzHPVE+G9yCN0nsYfx4WiZjFjUmCIhZYtERDgNAi6ITvXI2zyi4TyRk5az9HTYIHL0/hFN51n5lvaM=
X-Received: by 2002:a37:674c:: with SMTP id b73mr13753505qkc.184.1551717470393;
 Mon, 04 Mar 2019 08:37:50 -0800 (PST)
MIME-Version: 1.0
References: <20190219074500.16454-1-vichy.kuo@gmail.com>
In-Reply-To: <20190219074500.16454-1-vichy.kuo@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 4 Mar 2019 10:37:39 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+wUGxeQUMJd0eu52QadvLvkkT=36q9e1Qbru2gEsUGCw@mail.gmail.com>
Message-ID: <CAL_Jsq+wUGxeQUMJd0eu52QadvLvkkT=36q9e1Qbru2gEsUGCw@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: reserved_mem: fix reserve memory leak
To:     pierre Kuo <vichy.kuo@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You should Cc the author(s) of this code. I've added Marek.

On Tue, Feb 19, 2019 at 1:47 AM pierre Kuo <vichy.kuo@gmail.com> wrote:
>
> The __reserved_mem_init_node will call region specific reserved memory
> init codes, but once all compatibled init codes failed, the memory region
> will left in memory.reserved and cause leakage.
>
> Take cma reserve memory DTS for example, if user declare 1MB size,
> which is not align to (PAGE_SIZE << max(MAX_ORDER - 1,
> pageblock_order)), rmem_cma_setup will return -EINVAL.
> Meanwhile, rmem_dma_setup will also return -EINVAL since "reusable"
> property is not set. If finally there is no reserved memory init pick up
> this memory, kernel will left the 1MB leak in memory.reserved.
>
> This patch will remove this kind of memory from memory.reserved, only
> when __reserved_mem_init_node return neither 0 nor -ENOENT.

I'm not sure that un-reserving memory on error is the correct
behavior. It may be fine for something like CMA, but if it is some
shared memory used by another processor in the system not reserving it
would probably never be correct.

>
> Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
> ---
>  drivers/of/of_reserved_mem.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 1977ee0adcb1..d3bde057ec46 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -181,6 +181,7 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
>  {
>         extern const struct of_device_id __reservedmem_of_table[];
>         const struct of_device_id *i;
> +       int ret = -ENOENT;
>
>         for (i = __reservedmem_of_table; i < &__rmem_of_table_sentinel; i++) {
>                 reservedmem_of_init_fn initfn = i->data;
> @@ -189,13 +190,14 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
>                 if (!of_flat_dt_is_compatible(rmem->fdt_node, compat))
>                         continue;
>
> -               if (initfn(rmem) == 0) {
> +               ret = initfn(rmem);
> +               if (ret == 0) {
>                         pr_info("initialized node %s, compatible id %s\n",
>                                 rmem->name, compat);
> -                       return 0;
> +                       break;
>                 }
>         }
> -       return -ENOENT;
> +       return ret;
>  }
>
>  static int __init __rmem_cmp(const void *a, const void *b)
> @@ -255,7 +257,9 @@ void __init fdt_init_reserved_mem(void)
>                 int len;
>                 const __be32 *prop;
>                 int err = 0;
> +               int nomap;
>
> +               nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
>                 prop = of_get_flat_dt_prop(node, "phandle", &len);
>                 if (!prop)
>                         prop = of_get_flat_dt_prop(node, "linux,phandle", &len);
> @@ -265,8 +269,16 @@ void __init fdt_init_reserved_mem(void)
>                 if (rmem->size == 0)
>                         err = __reserved_mem_alloc_size(node, rmem->name,
>                                                  &rmem->base, &rmem->size);
> -               if (err == 0)
> -                       __reserved_mem_init_node(rmem);
> +               if (err == 0) {
> +                       err = __reserved_mem_init_node(rmem);
> +                       if (err != 0 && err != -ENOENT) {
> +                               pr_info("node %s compatible matching fail\n",
> +                                       rmem->name);
> +                               memblock_free(rmem->base, rmem->size);
> +                               if (nomap)
> +                                       memblock_add(rmem->base, rmem->size);
> +                       }
> +               }
>         }
>  }
>
> --
> 2.17.1
>
