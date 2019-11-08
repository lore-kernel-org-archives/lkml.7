Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8928C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB75C207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbW+Calw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbfKHKj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:39:27 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41092 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfKHKj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:39:27 -0500
Received: by mail-ot1-f67.google.com with SMTP id 94so4786422oty.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 02:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xknlmhQ8bTxSjbDHhHqkCt9p0L6pwub3YwGQVtWNFCM=;
        b=jbW+Calw/0AIF+TO89q3qI9FJuV1dfDbJMi3iRUkKu8Jzdxj5J5AkF0rZMUTqfEfbz
         jp8LPBnf7uJ9OPlVZfi6zcsYBVy5DN1VGqhfuubP9BhZJL7PBn/2L+6CD/5YyfvJ2+2l
         44+SXmMLOzWbGgjDRibfVv13MbeRRjFsyvwDdRIL9Ob918JYiL8S02lw8BszfeC9CpIH
         RJowFJTECEKxyR6bE9gdgypLI4aOcX25lFX9wAp8fTiQmchhOVrYLKxFCg4DI/GzwB+z
         wvBgswYniCpR90X3zMmx4925MIDNrjGAyjXZu2o4FsEwtxj7PMv+5x5XGx7H68AjNLbQ
         +Cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xknlmhQ8bTxSjbDHhHqkCt9p0L6pwub3YwGQVtWNFCM=;
        b=fY5bmQh/qcpKqazcX7s7H3kNiu3uoF8RxFJ2GrEy9aoECr58qN1uZBrz7EfL5qfPff
         AgMYLjHCW5fKzyZFhZBEZSzIEDtL7e/ZYbwNIU1/hDITbnk8a+AF9hS4DkoGCMDsUlm0
         Ynb05WY9H7Y/5BaXVUoba15diZxTMyHmVZGQ+V4gjJ10yaZdzZy8ww7kKBUQXHNeGlu0
         uELRWRhQIWEChHV82a6bv2f91sHkIcCWimWbRC/IgxHHKzrV49G9Qht8AEUyO89b38g8
         O0yhV3Bk6FUro9dhXmt0OxAoEI5T05FJxD1XRS313ozKbuupcu8prHRJ33Kh6453luNn
         RbIQ==
X-Gm-Message-State: APjAAAXqn54G0OeoLqBQW8gnMpV8YKWkNwABGL7Gk1Y5K7xXCgDILDCG
        xlSy8r9XpjgiDCA5gYBIKdMprPOuZW75iXLBNulJ3g==
X-Google-Smtp-Source: APXvYqyLZBxmR71fhmdJVJcUa6fCSRpNkLwG762yXhO18tCAh1bm29lOIgeNygv6PD59cS3J6bMkjvM+xaJPZ5K/n7w=
X-Received: by 2002:a05:6830:1e53:: with SMTP id e19mr8122533otj.161.1573209566001;
 Fri, 08 Nov 2019 02:39:26 -0800 (PST)
MIME-Version: 1.0
References: <1572527274-21925-1-git-send-email-sumit.garg@linaro.org>
 <20191107110603.GA8790@jax> <CAFA6WYMuHqNZTtoda=P4-pweNOKXw_TLKNcBa-XuR5yBV3uRDw@mail.gmail.com>
In-Reply-To: <CAFA6WYMuHqNZTtoda=P4-pweNOKXw_TLKNcBa-XuR5yBV3uRDw@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 8 Nov 2019 11:39:15 +0100
Message-ID: <CAHUa44Hk0LtCsbOcLq=of_pGSAYOnaod13N88ZMQOymmCGEJ6g@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Fix dynamic shm pool allocations
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Carriere Etienne <etienne.carriere@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Thu, Nov 7, 2019 at 1:41 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Jens,
>
> On Thu, 7 Nov 2019 at 16:36, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Hi Sumit,
> >
> > On Thu, Oct 31, 2019 at 06:37:54PM +0530, Sumit Garg wrote:
> > > In case of dynamic shared memory pool, kernel memory allocated using
> > > dmabuf_mgr pool needs to be registered with OP-TEE prior to its usage
> > > during optee_open_session() or optee_invoke_func().
> > >
> > > So fix dmabuf_mgr pool allocations via an additional call to
> > > optee_shm_register().
> > >
> > > Fixes: 9733b072a12a ("optee: allow to work without static shared memory")
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > Looks good, I'm picking this up. Etienne told me has tested this on some
> > of his hardware so I'll add:
> > Tested-by: Etienne Carriere <etienne.carriere@linaro.org>
> >
>
> Thanks for picking this up.
>
> >
> > > ---
> > >
> > > Depends on patch: https://lkml.org/lkml/2019/7/30/506 that adds support
> > > to allow registration of kernel buffers with OP-TEE.
>
> You also need to pick up the dependency patch too. The latest v3 of
> this patch is here [1] although its unchanged from v2. Also, If you
> pick that up I will drop it from future revisions of Trusted Keys
> patchset [2].
>
> [1] https://lkml.org/lkml/2019/10/31/431
> [2] https://lkml.org/lkml/2019/10/31/430

So I missed taking [1] into account. I think that it would make more
sense to merge this patch ("tee: optee: Fix dynamic shm pool
allocations") with [1] ("tee: optee: allow kernel pages to register as
shm") into a new patch.

Cheers,
Jens

>
> -Sumit
>
> > >
> > >  drivers/tee/optee/shm_pool.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> > > index de1d9b8..0332a53 100644
> > > --- a/drivers/tee/optee/shm_pool.c
> > > +++ b/drivers/tee/optee/shm_pool.c
> > > @@ -17,6 +17,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> > >  {
> > >       unsigned int order = get_order(size);
> > >       struct page *page;
> > > +     int rc = 0;
> > >
> > >       page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> > >       if (!page)
> > > @@ -26,12 +27,21 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> > >       shm->paddr = page_to_phys(page);
> > >       shm->size = PAGE_SIZE << order;
> > >
> > > -     return 0;
> > > +     if (shm->flags & TEE_SHM_DMA_BUF) {
> > > +             shm->flags |= TEE_SHM_REGISTER;
> > > +             rc = optee_shm_register(shm->ctx, shm, &page, 1 << order,
> > > +                                     (unsigned long)shm->kaddr);
> > > +     }
> > > +
> > > +     return rc;
> > >  }
> > >
> > >  static void pool_op_free(struct tee_shm_pool_mgr *poolm,
> > >                        struct tee_shm *shm)
> > >  {
> > > +     if (shm->flags & TEE_SHM_DMA_BUF)
> > > +             optee_shm_unregister(shm->ctx, shm);
> > > +
> > >       free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> > >       shm->kaddr = NULL;
> > >  }
> > > --
> > > 2.7.4
> > >
