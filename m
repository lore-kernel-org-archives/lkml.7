Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1EAC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2492229A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="coS07tBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbfGWFEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 01:04:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54052 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfGWFEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 01:04:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so37141201wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 22:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8oVnWnzi5t2ouuMP0eGavMEOYBbckZs3soRWMye7A3o=;
        b=coS07tBPBC7wYQb0eVBCkLCJHa4uo26V40PmAD1PciVsJ9+1hh8Sm5UEYObGVO9BS8
         fYSi/QHlhVoWMRoubXXhjAb0XeKWwvUKRxoDlnFaMRplWhdjd9PpR7S84tE/HxAJh3FG
         WydE/5pV6kYzUGuIlLDDCOOMAjLLEnakhWMOls8hMz8lJqj4rnEcrEKIF9OwwYFH260M
         yklxy5IVbUa66uso0MGCvPw4QdLDNT9A+/y39rvSm4nqLHSwh0O+hUaxivHVz7JNka6X
         iMRMF5Nou7E0g8FGl7rRGa6uP0e/j9AiyujcAcKjZBeLatsFzNa6vTOx+hth40ePL85e
         b+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8oVnWnzi5t2ouuMP0eGavMEOYBbckZs3soRWMye7A3o=;
        b=QUwn/eQnDI4hk0uBjt3+4cQbFTLwW1Beh8Tq/2JRPjvFQp2I3vkCp+GAVPJK9vUIMK
         Vd3LBguffquWQucFr6gtORIW8iC/mGtyramQJCx+NR5wkNRoZ0eD1JjHyt7mBN0awhce
         w/8s4GYFRA2A5GKAu+oxfL11oDsebE4AXVOCs8mDYSzDlGLPMOLwgWdSB2jO98sV+1AH
         AnfeWxIPW6OtaTkJASjt4FIGLaZcRAtzpvupUMrTKvkoxuAt9VVY9V4Peuw7inFxTH9y
         dhY5MmUkdN9hw5Q2rvsZLyaJAnnhVCegR5GLmuzHag1Z0TwN+Z2sd4hVspf1rmZBS6zQ
         uQsQ==
X-Gm-Message-State: APjAAAXreoeV0kKzyT8fIERndBUM1D1ivDYzRyDE+p3kcMgw3Get0XxJ
        7wFOAcuNJhsDGSuCDZAhorESLpt0bklD3b8iDsdKpg==
X-Google-Smtp-Source: APXvYqwLaS2TIIfJuchAuhHJsud5rGFa5EqNh0YWUyPNMsJANOOfza+5SubRnk7NDi1uUYWJdsfQ7Nag1k0pT6fZe/8=
X-Received: by 2002:a1c:d10c:: with SMTP id i12mr66789877wmg.152.1563858259317;
 Mon, 22 Jul 2019 22:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org> <20190718100840.GB19666@infradead.org>
In-Reply-To: <20190718100840.GB19666@infradead.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 22 Jul 2019 22:04:06 -0700
Message-ID: <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
To:     Christoph Hellwig <hch@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 3:08 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> This and the previous one seem very much duplicated boilerplate
> code.

So yes, there is some duplicate boilerplate between the system and cma
heaps particularly in the allocation function, where we allocate and
set up the helper buffer structure, allocate the pages, then create
and export the dmabuf. I took a pass at trying to minimize some of
this earlier, but those efforts ended up adding helper functions that
take a ton of arguments, and had some trouble properly handling error
paths without leaking memory, so I left it as is.

I'll try to take another pass myself but if you have specific
suggestions for improving here, I'd be happy to try them.

> Why can't just normal branches for allocating and freeing
> normal pages vs cma?  We even have an existing helper for that
> with dma_alloc_contiguous().

Apologies, I'm not sure I'm understanding your suggestion here.
dma_alloc_contiguous() does have some interesting optimizations
(avoiding allocating single page from cma), though its focus on
default area vs specific device area doesn't quite match up the usage
model for dma heaps.  Instead of allocating memory for a single
device, we want to be able to allow userland, for a given usage mode,
to be able to allocate a dmabuf from a specific heap of memory which
will satisfy the usage mode for that buffer pipeline (across multiple
devices).

Now, indeed, the system and cma heaps in this patchset are a bit
simple/trivial (though useful with my devices that require contiguous
buffers for the display driver), but more complex ION heaps have
traditionally stayed out of tree in vendor code, in many cases making
incompatible tweaks to the ION core dmabuf exporter logic. That's why
dmabuf heaps is trying to destage ION in a way that allows heaps to
implement their exporter logic themselves, so we can start pulling
those more complicated heaps out of their vendor hidey-holes and get
some proper upstream review.

But I suspect I just am confused as to what your suggesting. Maybe
could you expand a bit? Apologies for being a bit dense.

Thanks again for the input!
-john
