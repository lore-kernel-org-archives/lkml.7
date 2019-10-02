Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFC6C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E553621920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gaS1xDR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfJBQPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:15:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35851 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfJBQPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:15:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id m18so7608831wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 09:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S3qu0q538RdqSW4iMWABBq0n0em/qJFZBK3KeAdAIbs=;
        b=gaS1xDR/MCIrEusKsbIz4cW1CiyfwYYMFFlkJTvXLn2FJnDVlxHH+o6O9QSz539jQf
         poU9tqSSIT4rhJv1AqqOp2P/GBzRSdKDr1zpPLCepPY39P9h12Aas1W0n2QKwiAjaB07
         KadfdYgX6OlzrAoGlXRjYCckxXgkFIXm4A7C7XWyWqn+fu8OKDEYWyyn1guKySmitHEr
         sz5J6n8LQlK1iLVLi0fGU7c3TCAukTofg0++XZrbTN0LuCaOUVLSODBPfO5HrKhAVlgw
         Ac9sOb8KSGmKoUV1bngrp/iZ4VKk1n6ReF8WiDhlrDmvRPwhr2zZ2/e9wQ+JHOzopqxj
         Lwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S3qu0q538RdqSW4iMWABBq0n0em/qJFZBK3KeAdAIbs=;
        b=UoM+mgT12EQ/a+CIbSVLJ7VOcy4GUx7sv/LfG7g0jReb/pVxfKy13PbGISsnnMFAyq
         bOoO6G/WuOaSPjMw8hYNip1t0YWWg+iEUuw3lU7wbQjutQyK0/eLfFsRZS2Jux6XINN+
         AxmAkX6a8IYbThqPx/tPkHiCecZxn7ABXaCa9pwHZgC+jWxv/pFo0Ub766ivIbZS5s5O
         EAbn2zQ5WwIxThezGtBkaNBqHioIXxed1BY/4VUr+Cwl8AldeitXTNRWxvcBTpdFgNZX
         M0ZF1nY23kR+aCUiZzHbaHZKpWfK3+mUURptU1uV6JLW8pGmKMRVtJHjUg2as+RjTjmN
         TiWQ==
X-Gm-Message-State: APjAAAWqD0yUp+e15HvAAooLd5e1hmZBZKvgtKRXXkk40rLrnZuGJYBG
        X5jk0tltS6h0f+VsB3d3cp8vzebR+wlqhSJ99PPKQQ==
X-Google-Smtp-Source: APXvYqyieH3bcPGZ8ZGnvZSIPloD2Ks23buLv3XJ69DXuZuuMbDJs6JnsU4f1gYrymTj4IHZVbRl7iWyVN1kwnw8k2A=
X-Received: by 2002:a1c:9988:: with SMTP id b130mr3697022wme.164.1570032946489;
 Wed, 02 Oct 2019 09:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190906184712.91980-1-john.stultz@linaro.org> <20190930081434.248-1-hdanton@sina.com>
In-Reply-To: <20190930081434.248-1-hdanton@sina.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 2 Oct 2019 09:15:35 -0700
Message-ID: <CALAqxLUPjtfOmK7Dc9y+vZ6iw9dbUzu5pbRKes7i5jaysz4yXA@mail.gmail.com>
Subject: Re: [RESEND][PATCH v8 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
To:     Hillf Danton <hdanton@sina.com>
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
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 1:14 AM Hillf Danton <hdanton@sina.com> wrote:
> On Fri,  6 Sep 2019 18:47:09 +0000 John Stultz wrote:
> >
> > +     cma_pages = cma_alloc(cma_heap->cma, nr_pages, align, false);
> > +     if (!cma_pages)
> > +             goto free_buf;
> > +
> > +     if (PageHighMem(cma_pages)) {
> > +             unsigned long nr_clear_pages = nr_pages;
> > +             struct page *page = cma_pages;
> > +
> > +             while (nr_clear_pages > 0) {
> > +                     void *vaddr = kmap_atomic(page);
> > +
> > +                     memset(vaddr, 0, PAGE_SIZE);
> > +                     kunmap_atomic(vaddr);
> > +                     page++;
> > +                     nr_clear_pages--;
> > +             }
> > +     } else {
> > +             memset(page_address(cma_pages), 0, size);
> > +     }
>
> Take a breath after zeroing a page, and a peep at pending signal.

Ok. Took a swing at this. It will be in the next revision.

Thanks again for the review!
-john
