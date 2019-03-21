Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7465C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848B3218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wxYc+sM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfCUUB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:01:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40356 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbfCUUBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:01:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id t5so8010859wri.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 13:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1onto69JfOi03nkyfcMMs0TGjQavCF+XTqLUFtGG5Zg=;
        b=wxYc+sM2zKEOSLsHZycdm+ChzhdUS7dW1AfoMJVV33nrTxyeNpN/rDK9+82rfIFKRH
         S7To3zC3qIitysREKDbd83c0icPeJh75I2uuxqYcZuC0OlOYnHGkQmTr0LKQ7/Og6CRq
         igGD4cpo09NCWLcpTQk7J0OYGMD7f8GRraAyw2KY9FibBPP2MVNboxEwtj6zCgdzZOOT
         SaNOpCCo62Y+ODJSwX4iI96UoZksyh4oHG6EFdLDGgk05IJcWNMi41VrUgKIW4diZaaj
         EkaMK2R5SjbtjwJmU6orq6tB42sON3SVM5MD0aju/jKKhO5wzb0pXVZ9h9WJ18sT3GLo
         9ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1onto69JfOi03nkyfcMMs0TGjQavCF+XTqLUFtGG5Zg=;
        b=V+UzFmTdggHVjDlP9dtw9dRov2UoL6MpBDum56sihtlhhc6p5FUwOLIGN9L2GQ1MUh
         nfS5rWUTk/vKy36SNFlfjtRnI808U1YDv9PrGF9/HIs6mYCfyzEA+eL2wmtSBejTgB6v
         TTC0xkVgwrqpvR5g7xO1oFtygSJ5y32iLuwyVvpahCTuNaZls45hfR0uj1xHQgAUtb87
         Px5wkterFOXy90w9XuYXo42DDR3bDrKQEIlDv07srqHrxWCuby9WA8Fq2dS3DtSOp4tz
         xKofE2ZjAd8x7Uu5M++JSndQlZgl0ev3EyRiyKFan2iWkm79P74yOb3TAf2Fydc3v9v4
         ZeRw==
X-Gm-Message-State: APjAAAV3AjoznfVrl/JFaib2kDRivCq8nqUW6R2wDkuZk9PFMaYVsYD8
        sTzyceCpAG2f8K7DeFsMadXv3rP2M91O91YvQsrP7g==
X-Google-Smtp-Source: APXvYqz2Zo90LVYc/4henDqwtZla1Hzt8meC2q5Yh8Il1COz74SQ4d5jiduUTP6qWX0x8efZF6Y5MZkaP1IJP5qOq0s=
X-Received: by 2002:adf:ea0b:: with SMTP id q11mr2379965wrm.233.1553198483893;
 Thu, 21 Mar 2019 13:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-3-git-send-email-john.stultz@linaro.org> <20190315090646.GC4470@infradead.org>
In-Reply-To: <20190315090646.GC4470@infradead.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 21 Mar 2019 13:01:12 -0700
Message-ID: <CALAqxLXBC1x230qNgtxFdJ46tqqR8b_4o7rakH3GWjm--xX2=A@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/5 v2] dma-buf: heaps: Add heap helpers
To:     Christoph Hellwig <hch@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 2:06 AM Christoph Hellwig <hch@infradead.org> wrote:
> > +     if (buffer->kmap_cnt) {
> > +             buffer->kmap_cnt++;
> > +             return buffer->vaddr;
> > +     }
> > +     vaddr = dma_heap_map_kernel(buffer);
> > +     if (WARN_ONCE(!vaddr,
> > +                   "heap->ops->map_kernel should return ERR_PTR on error"))
> > +             return ERR_PTR(-EINVAL);
> > +     if (IS_ERR(vaddr))
> > +             return vaddr;
> > +     buffer->vaddr = vaddr;
> > +     buffer->kmap_cnt++;
>
> The cnt manioulation is odd.  The normal way to make this readable
> is to use a postfix op on the check, as that makes it clear to everyone,
> e.g.:
>
>         if (buffer->kmap_cnt++)
>                 return buffer->vaddr;
>         ..

Thanks again on the feedback, I have had some other distractions
recently, so just getting around to these details again now.

The trouble w/ the suggestion here, if we increment in the check, then
if we trip on any of the other error paths, the cnt value will be
wrong when we return (and doing the extra decrementing in the error
paths feels as ugly as just doing the increment at the end of the
success paths)

> > +     buffer->kmap_cnt--;
> > +     if (!buffer->kmap_cnt) {
> > +             vunmap(buffer->vaddr);
> > +             buffer->vaddr = NULL;
> > +     }
>
> Same here, just with an infix.
>
> > +static inline void INIT_HEAP_HELPER_BUFFER(struct heap_helper_buffer *buffer,
> > +                              void (*free)(struct heap_helper_buffer *))
> > +{
> > +     buffer->private_flags = 0;
> > +     buffer->priv_virt = NULL;
> > +     mutex_init(&buffer->lock);
> > +     buffer->kmap_cnt = 0;
> > +     buffer->vaddr = NULL;
> > +     buffer->sg_table = NULL;
> > +     INIT_LIST_HEAD(&buffer->attachments);
> > +     buffer->free = free;
> > +}
>
> There is absolutely no reason to inlines this as far as I can tell.

Yea, I think I was mimicing some of the helpers like INIT_LIST_HEAD()
But sounds good. I can uninline it.

> Also it would seem much simpler to simply let the caller assign the
> free callback.

Yea, its a bit ugly but I worry the caller might forget?

Thanks again for the feedback!
-john
