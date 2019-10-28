Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3871CA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733E021479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mFJrUbF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfJ1W0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:26:41 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45196 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfJ1W0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:26:40 -0400
Received: by mail-ot1-f65.google.com with SMTP id 41so8049826oti.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 15:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjaKLyekYNHPXZ7Zh1mNGLtxL0unaQdEBwCVJlgaZ8w=;
        b=mFJrUbF9SJh4NwZ1grLzSIg8GB0cbVWo9erluO3H5ch6mTmkstZOZ//IrIeSyR9Yva
         vU5niR2ibGiMQyhT+KkdFZvWX/mcM4xaO+XVsGVzQZCHWUbQfZE5HgjqO48jxtJ+VWwV
         xeJClmrCQwM+LyV9CTe+zH7j7599bBsEgjW1a9z5eb/xgM/hObBqRsD2bpPqEw0TjQNe
         GQA/U9GsYTCE1jZUpWCEwYZKYxVRF4mi8w14jGNPY9NDWDhWwewcuVBhnPS6miSsi152
         CJIPUCT5+JFktOIsaA3gYoq/HtHT60fsnjwzxHTfmiEYUxQdL+zTybLZ4n2L9/C+tWrb
         /Ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjaKLyekYNHPXZ7Zh1mNGLtxL0unaQdEBwCVJlgaZ8w=;
        b=ImlGn54nEjuDiIaxcx/pF8B6q5FhZedxhxmfeL5H/aHFGX9m3C9OXmvDnyBrNW7fb2
         /TRauu1aDqvlqg2i77UpuJw/oSGMaFfBRjLnKZ3v+CNrS250ofFEwcMuJ425mTQmWbG2
         OvYrDVAVt1kc3gZVuN7qHAZuEH2CmyCLCvfBz0EjJXFZ38E7US60LIfWHVam5624Tr3D
         kfj4M9Qtd/H9ewVYTKXBFc/fHvXUJmgPU54i7vmJ5My5QhmWJ9ojtxbRXaqb5SMdmJ9D
         9AS2SRDsPidSTgrci7MFEHLDXdDIMBWyHlXTwuCwR9CYcBTjUwxyPzN2IxmFMURhSGzB
         QJ9g==
X-Gm-Message-State: APjAAAVA2W7PhnfdO7lWmXDpr02uaQf9JY05ZAMly2vmzfW+c9FUiQHJ
        6+ODUuhdkOmIWGHMY2XFKV+CsY1nQwdy3FY64zDAgA==
X-Google-Smtp-Source: APXvYqwaeIGafbzLyvtKwrzN2AssHSZQ3DHbhJ57doQ/HodEQyYbtIaq12npBm2CtcZ4G7Pyz3slNCD8r9A/pLQfEJo=
X-Received: by 2002:a05:6830:ca:: with SMTP id x10mr14637591oto.221.1572301599265;
 Mon, 28 Oct 2019 15:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191025234834.28214-1-john.stultz@linaro.org>
 <20191025234834.28214-2-john.stultz@linaro.org> <20191028191231.GJ125958@google.com>
 <CALAqxLVEwTjNe6y9xLLv9ib8qnp6hFXsT+XS2bJT0jRTzZVdsg@mail.gmail.com>
In-Reply-To: <CALAqxLVEwTjNe6y9xLLv9ib8qnp6hFXsT+XS2bJT0jRTzZVdsg@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 28 Oct 2019 15:26:28 -0700
Message-ID: <CALAqxLWp3F-_uKrtW06CApyqajL-DK0Rujku8YjHe8QEUcXU6w@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] mm: cma: Export cma symbols for cma heap as a module
To:     Sandeep Patil <sspatil@google.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chenbo Feng <fengc@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Andrew F . Davis" <afd@ti.com>, Yue Hu <huyue2@yulong.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Alistair Strachan <astrachan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 1:03 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Mon, Oct 28, 2019 at 12:12 PM <sspatil@google.com> wrote:
> > On Fri, Oct 25, 2019 at 11:48:33PM +0000, John Stultz wrote:
> > > --- a/kernel/dma/contiguous.c
> > > +++ b/kernel/dma/contiguous.c
> > > @@ -31,6 +31,7 @@
> > >  #endif
> > >
> > >  struct cma *dma_contiguous_default_area;
> > > +EXPORT_SYMBOL(dma_contiguous_default_area);
> >
> > I didn't need to do this for the (out-of-tree) ion cma heap [1].
> > Any reason why you had to?
>
> Its likely due to the changes I made in the separate
> non-default-CMA-region patch set. Earlier I had gotten away with just
> your change, but in testing before I sent this series, I hit the build
> error and quickly added the export before sending.

And just to clarify this point, I was mistaken and it wasn't the
non-default-CMA-region patch set, but the fact that I'm using
dev_get_cma_area(NULL) to get the default CMA area to register, rather
then trying to register every CMA area via cma_for_each_area() as is
done in ION.  I actually could probably drop the cma_for_each_area
export for the dmabuf heaps usage.

thanks
-john
