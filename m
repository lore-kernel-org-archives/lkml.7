Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D03C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B46321D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZmjxpx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfLQOYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:24:48 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36154 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfLQOYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:24:48 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so11168049ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 06:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bstu96ywEe66Xoi2KUqjM0aZhxq6QvJxA4i4KaebxAg=;
        b=iZmjxpx+aqAGjHG+wG9EvdZ0CMPCjsF8TJFvE/PW3NczjHYDDrw/LJiy0+/dvzg6b4
         oGEdFTUc5zM0oNxUwuVdpkC5h23Rbs3hf8pRLrRnuQq4dV2KYX0UAN2oQEWQkig7owOL
         ONF3rvBs/9az4dzadaE5qFfy+wmS8XV13WgJQIWlKJ973/w4+ckKGTR9F7r61dREaDHg
         Gcx67AldREYe7Ge0rxerq29K5SaDmyl6c9CGDH5gE/885a/naULIOC+bEAZlBF7CUcnp
         p4/LxPngiJFwPOrwVFlG8zhyC+ZgIdEYV5HkAECVWLIEbz8gerx4tPW1eRj4Tl6rT9NL
         XdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bstu96ywEe66Xoi2KUqjM0aZhxq6QvJxA4i4KaebxAg=;
        b=rtwXQJnWygCczWp735Yt3L4O351UZhyrW+JoToWBvoixqDUfxOedqKbfMuIfJlc2am
         /TQNHH4PGTe9xXl8JkV6CCDAmYpxEiHWxr0RgaO+W4IM55Ay33UVIjpUJpfnuIpTxnEv
         IVu1jGpILNFnIPRmNkjiGB3MZH3QXCWR7jm18732E8s7XADPpdElXDnJxftoZLvrVRIA
         0i6YYCK1SFeLnGCxVSCRuqhfJ3z1ORhdeke94TIcP/adUsGEa14+HepYLlnow5BZZIbe
         o7MF6QBJXe2U3Uy8cu83tOMR4514TejXqILzD9XuZaDJd9o7uWjmcbBMRHAB1hGVtt0E
         IxVg==
X-Gm-Message-State: APjAAAXHsfy+jINi5xhnlINj27sPaxFk5bfUwEFEsrxHjzcHKPf5zP2K
        1suN1P+yn0/sbJRjTAAMKkWUrjseDWtu/QYERuq7cA==
X-Google-Smtp-Source: APXvYqyEYVE76VKPW+ZLDoFj9Ls+sbsf5me/6jiw2DFD9LnAL6/4UUu8JDRa/cCLq9f5ZXCRrQSdtdpNmr32p/6n3nc=
X-Received: by 2002:a05:651c:2046:: with SMTP id t6mr3030884ljo.180.1576592686380;
 Tue, 17 Dec 2019 06:24:46 -0800 (PST)
MIME-Version: 1.0
References: <1574147666-19356-1-git-send-email-sumit.garg@linaro.org> <20191217072729.GA9507@jax>
In-Reply-To: <20191217072729.GA9507@jax>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 17 Dec 2019 19:54:35 +0530
Message-ID: <CAFA6WYN0CC395gbn8teiHGFRKwCnXJ8taX0=FWKw8vf6ef5nyA@mail.gmail.com>
Subject: Re: [PATCH] optee: Fix multi page dynamic shm pool alloc
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        vincent.t.cao@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Tue, 17 Dec 2019 at 12:57, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi Sumit,
>
> On Tue, Nov 19, 2019 at 12:44:26PM +0530, Sumit Garg wrote:
> > optee_shm_register() expected pages to be passed as an array of page
> > pointers rather than as an array of contiguous pages. So fix that via
> > correctly passing pages as per expectation.
> >
> > Fixes: a249dd200d03 ("tee: optee: Fix dynamic shm pool allocations")
> > Reported-by: Vincent Cao <vincent.t.cao@intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Tested-by: Vincent Cao <vincent.t.cao@intel.com>
> > ---
> >  drivers/tee/optee/shm_pool.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> > index 0332a53..85aa5bb 100644
> > --- a/drivers/tee/optee/shm_pool.c
> > +++ b/drivers/tee/optee/shm_pool.c
> > @@ -28,8 +28,20 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> >       shm->size = PAGE_SIZE << order;
> >
> >       if (shm->flags & TEE_SHM_DMA_BUF) {
> > +             unsigned int nr_pages = 1 << order, i;
> > +             struct page **pages;
> > +
> > +             pages = kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
> > +             if (!pages)
> > +                     return -ENOMEM;
> > +
> > +             for (i = 0; i < nr_pages; i++) {
> > +                     pages[i] = page;
> > +                     page++;
> > +             }
> > +
> >               shm->flags |= TEE_SHM_REGISTER;
> > -             rc = optee_shm_register(shm->ctx, shm, &page, 1 << order,
> > +             rc = optee_shm_register(shm->ctx, shm, pages, nr_pages,
> >                                       (unsigned long)shm->kaddr);
> >       }
>
> Apoligies for the later reply.

No worries.

> It seems that this will leak memory.
> The pointer pages isn't freed after the call to optee_shm_register().
>

Will fix it in v2.

-Sumit

> Thanks,
> Jens
