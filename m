Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207B2C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E717F214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576108149;
	bh=f0rMuDibQwxhGxUg6uCBllNAF042fhNbWR73lcnFA0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tj8EGigUQxnMuac4IBKD02JkaDkdIGRmo5EXOPsDwByXyuEll7EyL5jLbzsFkfpIn
	 Z6qAqT1Bt6erkZzvVGg5c6WRHMItp3BoHUjhkcV2GiC4BFS/IA6mjukE96W/TTsuRJ
	 wzdjDM28CRc4Gy3WZdHRDcn+HdGdkwHK7/jmz5CY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfLKXtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:49:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfLKXtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 18:49:07 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A64322527;
        Wed, 11 Dec 2019 23:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576108146;
        bh=f0rMuDibQwxhGxUg6uCBllNAF042fhNbWR73lcnFA0s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tOQAAN2yPQE77usTWwPzLjvFzL7kgJNKo2v80h0m193+YlCOdgA7eXX7/ytci5LDA
         hii5vGrI23lJWPFZhX49AD2kwaZkeR/seuajCWRW9TEhC1sE20/qoIokJdZFL8Sfl0
         CMJy5m8+9+0vgLOm1lXj09+47pSeXQy2Oi1y08p8=
Received: by mail-qv1-f46.google.com with SMTP id b18so208325qvo.8;
        Wed, 11 Dec 2019 15:49:06 -0800 (PST)
X-Gm-Message-State: APjAAAWBccKOPYZDkkYHgkTXf7tFgdr1J3m3NcWR0dHyzMUaweZVRWtA
        VGeyuZx+jTpesnBjVviSJwnpm+bbLzXxPxftQQ==
X-Google-Smtp-Source: APXvYqyAtcvaKLnFbjGmpBBTnIi8tjdx6h1ib4i2dfveW/ALXlUBKsl5hTyKms4SutCfdrYnxMCs1YSJ54xgO/8xlmU=
X-Received: by 2002:ad4:450a:: with SMTP id k10mr5348785qvu.136.1576108145643;
 Wed, 11 Dec 2019 15:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20191211232345.24810-1-robh@kernel.org>
In-Reply-To: <20191211232345.24810-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 11 Dec 2019 17:48:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKfV-4mx_uidUupQJT4qfq+y+qx1=S=Du-Qsaweh4CPUQ@mail.gmail.com>
Message-ID: <CAL_JsqKfV-4mx_uidUupQJT4qfq+y+qx1=S=Du-Qsaweh4CPUQ@mail.gmail.com>
Subject: Re: [PATCH] of: Rework and simplify phandle cache to use a fixed size
To:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 5:23 PM Rob Herring <robh@kernel.org> wrote:
>
> The phandle cache was added to speed up of_find_node_by_phandle() by
> avoiding walking the whole DT to find a matching phandle. The
> implementation has several shortcomings:
>
>   - The cache is designed to work on a linear set of phandle values.
>     This is true for dtc generated DTs, but not for other cases such as
>     Power.
>   - The cache isn't enabled until of_core_init() and a typical system
>     may see hundreds of calls to of_find_node_by_phandle() before that
>     point.
>   - The cache is freed and re-allocated when the number of phandles
>     changes.
>   - It takes a raw spinlock around a memory allocation which breaks on
>     RT.
>
> Change the implementation to a fixed size and use hash_32() as the
> cache index. This greatly simplifies the implementation. It avoids
> the need for any re-alloc of the cache and taking a reference on nodes
> in the cache. We only have a single source of removing cache entries
> which is of_detach_node().
>
> Using hash_32() removes any assumption on phandle values improving
> the hit rate for non-linear phandle values. The effect on linear values
> using hash_32() is about a 10% collision. The chances of thrashing on
> colliding values seems to be low.
>
> To compare performance, I used a RK3399 board which is a pretty typical
> system. I found that just measuring boot time as done previously is
> noisy and may be impacted by other things. Also bringing up secondary
> cores causes some issues with measuring, so I booted with 'nr_cpus=1'.
> With no caching, calls to of_find_node_by_phandle() take about 20124 us
> for 1248 calls. There's an additional 288 calls before time keeping is
> up. Using the average time per hit/miss with the cache, we can calculate
> these calls to take 690 us (277 hit / 11 miss) with a 128 entry cache
> and 13319 us with no cache or an uninitialized cache.
>
> Comparing the 3 implementations the time spent in
> of_find_node_by_phandle() is:
>
> no cache:        20124 us (+ 13319 us)
> 128 entry cache:  5134 us (+ 690 us)
> current cache:     819 us (+ 13319 us)
>
> We could move the allocation of the cache earlier to improve the
> current cache, but that just further complicates the situation as it
> needs to be after slab is up, so we can't do it when unflattening (which
> uses memblock).
>
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/base.c       | 133 ++++++++--------------------------------
>  drivers/of/dynamic.c    |   2 +-
>  drivers/of/of_private.h |   4 +-
>  drivers/of/overlay.c    |  10 ---
>  4 files changed, 28 insertions(+), 121 deletions(-)

[...]

> -       if (phandle_cache) {
> -               if (phandle_cache[masked_handle] &&
> -                   handle == phandle_cache[masked_handle]->phandle)
> -                       np = phandle_cache[masked_handle];
> -               if (np && of_node_check_flag(np, OF_DETACHED)) {
> -                       WARN_ON(1); /* did not uncache np on node removal */
> -                       of_node_put(np);
> -                       phandle_cache[masked_handle] = NULL;
> -                       np = NULL;
> -               }
> +       if (phandle_cache[handle_hash] &&
> +           handle == phandle_cache[handle_hash]->phandle)
> +               np = phandle_cache[handle_hash];
> +       if (np && of_node_check_flag(np, OF_DETACHED)) {
> +               WARN_ON(1); /* did not uncache np on node removal */

BTW, I don't think this check is even valid. If we failed to detach
and remove the node from the cache, then we could be accessing np
after freeing it.

Rob
