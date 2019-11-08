Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B28EFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B48B206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uoo+Q71g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbfKHLGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:06:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38697 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbfKHLGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:06:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id q28so4146694lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 03:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sy2LP6u2jmHt5m9xRWZK7C9zG0JoW6tUkzFgmde33yU=;
        b=Uoo+Q71g0cxgu2QJpg7+In6A15rgLEBTHByOzyJL97eOk18NJI51sZj2MVQ/S83qnd
         PKMsn/7nn9yx2/zuOFefoYhUO82xdF0PH//iratH+QNhSQP3K5MReZu0S9JM4L8+xR6o
         u1xg4nzdI3kA7WJV5bv/8B/xxMp3YC3o39Bqs/RLx3v7xXV3ub5OpxzmswbJg0IG+1De
         3a6bBNt510nQw5N2VmgnMKCTPwTSXrZjpkAfEThVXifBOky4VtKm7asTs0JtFnQzrYHc
         svgkw0HFx6FwYaLAoQJ0CNKC0WWwYovxtgdbqYVM7ZSjRHFH/v++3N8fhWa8xO+K6fo0
         LolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sy2LP6u2jmHt5m9xRWZK7C9zG0JoW6tUkzFgmde33yU=;
        b=HwS9crx4ongFnUQBtTTsq1qn1gglf2ok3KDRqXfo6xb56j1vgZNPBHaZ7vwTVwvXB4
         KiVFccpx2ZsNpB3pXpyVG3PrpOuABkbWOMJbowqkdvgVm2CBW6RDSryngPrGTuQ63/wS
         Bb4Bng32OUynLb4OqTS/9AWWMx3jXpUDMAu0oPR5lg6LniulK1UfoiaZMcDQTC8KRWas
         DGc49fvVzlqZuotQquvIlE2qCZFAsSa2ll+WcbwZFkTvsTWjowh9L0wa8fRdfJeOXAQK
         pwBnSJ91x+1Z1JeuSvXLFzBQDuGIT+deH92FkvW62RURC5d3mp1Jr+R+Htwghc/PqnJ7
         PbgQ==
X-Gm-Message-State: APjAAAX9pOkV8AO6XDTYlzkYXlwZHZBCUhG2/sYg3Sdt2R3Da4VX9E7c
        2HDbGcw8FWlsq+8RfF6lT6eZw8NbJj+iCEPApNjfFw==
X-Google-Smtp-Source: APXvYqzcWpm0BDc9jz0r5KApYRL1BgeSvlL618R0QFv8ISVvZ+ly31FKQ4Gi0zAdRCgTzXjX9FWctLYEWC0qs7nI7vY=
X-Received: by 2002:ac2:5bca:: with SMTP id u10mr6376774lfn.134.1573211168327;
 Fri, 08 Nov 2019 03:06:08 -0800 (PST)
MIME-Version: 1.0
References: <1572527274-21925-1-git-send-email-sumit.garg@linaro.org>
 <20191107110603.GA8790@jax> <CAFA6WYMuHqNZTtoda=P4-pweNOKXw_TLKNcBa-XuR5yBV3uRDw@mail.gmail.com>
 <CAHUa44Hk0LtCsbOcLq=of_pGSAYOnaod13N88ZMQOymmCGEJ6g@mail.gmail.com>
In-Reply-To: <CAHUa44Hk0LtCsbOcLq=of_pGSAYOnaod13N88ZMQOymmCGEJ6g@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 8 Nov 2019 16:35:56 +0530
Message-ID: <CAFA6WYMvVwEB7H5TDK4BBk_e=vTtY4-X8DDa5PD=ggCQn3PHvg@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Fix dynamic shm pool allocations
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Carriere Etienne <etienne.carriere@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Fri, 8 Nov 2019 at 16:09, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi Sumit,
>
> On Thu, Nov 7, 2019 at 1:41 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Jens,
> >
> > On Thu, 7 Nov 2019 at 16:36, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Thu, Oct 31, 2019 at 06:37:54PM +0530, Sumit Garg wrote:
> > > > In case of dynamic shared memory pool, kernel memory allocated using
> > > > dmabuf_mgr pool needs to be registered with OP-TEE prior to its usage
> > > > during optee_open_session() or optee_invoke_func().
> > > >
> > > > So fix dmabuf_mgr pool allocations via an additional call to
> > > > optee_shm_register().
> > > >
> > > > Fixes: 9733b072a12a ("optee: allow to work without static shared memory")
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > >
> > > Looks good, I'm picking this up. Etienne told me has tested this on some
> > > of his hardware so I'll add:
> > > Tested-by: Etienne Carriere <etienne.carriere@linaro.org>
> > >
> >
> > Thanks for picking this up.
> >
> > >
> > > > ---
> > > >
> > > > Depends on patch: https://lkml.org/lkml/2019/7/30/506 that adds support
> > > > to allow registration of kernel buffers with OP-TEE.
> >
> > You also need to pick up the dependency patch too. The latest v3 of
> > this patch is here [1] although its unchanged from v2. Also, If you
> > pick that up I will drop it from future revisions of Trusted Keys
> > patchset [2].
> >
> > [1] https://lkml.org/lkml/2019/10/31/431
> > [2] https://lkml.org/lkml/2019/10/31/430
>
> So I missed taking [1] into account. I think that it would make more
> sense to merge this patch ("tee: optee: Fix dynamic shm pool
> allocations") with [1] ("tee: optee: allow kernel pages to register as
> shm") into a new patch.

Sure, will send v2 as merged patch instead.

-Sumit

> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > > >
> > > >  drivers/tee/optee/shm_pool.c | 12 +++++++++++-
> > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> > > > index de1d9b8..0332a53 100644
> > > > --- a/drivers/tee/optee/shm_pool.c
> > > > +++ b/drivers/tee/optee/shm_pool.c
> > > > @@ -17,6 +17,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> > > >  {
> > > >       unsigned int order = get_order(size);
> > > >       struct page *page;
> > > > +     int rc = 0;
> > > >
> > > >       page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> > > >       if (!page)
> > > > @@ -26,12 +27,21 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> > > >       shm->paddr = page_to_phys(page);
> > > >       shm->size = PAGE_SIZE << order;
> > > >
> > > > -     return 0;
> > > > +     if (shm->flags & TEE_SHM_DMA_BUF) {
> > > > +             shm->flags |= TEE_SHM_REGISTER;
> > > > +             rc = optee_shm_register(shm->ctx, shm, &page, 1 << order,
> > > > +                                     (unsigned long)shm->kaddr);
> > > > +     }
> > > > +
> > > > +     return rc;
> > > >  }
> > > >
> > > >  static void pool_op_free(struct tee_shm_pool_mgr *poolm,
> > > >                        struct tee_shm *shm)
> > > >  {
> > > > +     if (shm->flags & TEE_SHM_DMA_BUF)
> > > > +             optee_shm_unregister(shm->ctx, shm);
> > > > +
> > > >       free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> > > >       shm->kaddr = NULL;
> > > >  }
> > > > --
> > > > 2.7.4
> > > >
