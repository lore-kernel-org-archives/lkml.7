Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A53AC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C952187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q7mof4I7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388640AbfKGMlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:41:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33107 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfKGMlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:41:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id t5so2127370ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 04:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e2XfEnWtfgJ6guYxPo+ALFnkJVTOUcEM3sbl6pL7pOE=;
        b=Q7mof4I7FOaxy3d+UFM0BB9pfgpIP3AyAFwHi9KEOqPChO4Kqi8JBZZTu2iAj3OvDj
         HFBY+cKHBFOasbUFe4BIkNtfwOu3bzZDaslcwoZBTVpYTREHHpK1OM8rvRBg/TWlAkke
         GV5I1pIEljfinoxgo9SFFi+9rG9squV334ktjUTClh6ieeu/gOicpnrlP6lqgY0PDegS
         B9b3YfFvIiMA7Sszif6u/upfutt7Ldu+vLiV9D5urpTQbX+6jO8ZTNzENlt87SNIDKsj
         edhWy1BXJS5xMt9GZ4iYjxfWd8wi7YTin0/oyHqxOdlMfnfkDZkwxX1IaoF96oD/69Gg
         VWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2XfEnWtfgJ6guYxPo+ALFnkJVTOUcEM3sbl6pL7pOE=;
        b=sEerY5qa5cknQ4eXTMdNIuVjbaS3Ka96Hc9s0ksmn4CdjXA3ALKEd/RX2EBhPkiCbO
         tlDS6GPYLjNBGZ5mD+jW7+jJJtPYmQCsJ3MECdj67Ld7KZapoL24zvZ37JpttWbLo4OR
         cT/S1gkMe2FTUe7VP2noKXoSpI69MSSR64+suL8c3hY6dVunlLjKBuJvh6A+cDpOzmC9
         6NJ8UI/abkbRRRgTztUEc29dCdiBBewVjd5CSEL35jRDmUaGIYVpWwXhlhTC9/LO2Etd
         ZeK2kR2CkoCCs2fw9SNJGq28KXpnhp0pyK0CFxRhjlb0apGaNZsr7aksHe5rKFy8SJT7
         YJfw==
X-Gm-Message-State: APjAAAW3a96AKbodAHKbpuSst+B9BRuQZU++FkoGR9mmWrvVCZX/Eoe4
        wn3oBXRV4/UFdMhLjr/8K0wmNY/elgAYrAzdJE3f8g==
X-Google-Smtp-Source: APXvYqzQsGf3lRKhF5F/h8hDWqVsPGYawSImG2ui3D0iu+FOTegCaudNUxxMLoUqzshJaX1Eea9gOiNNjlB92kwgNlk=
X-Received: by 2002:a2e:898a:: with SMTP id c10mr2253609lji.177.1573130503712;
 Thu, 07 Nov 2019 04:41:43 -0800 (PST)
MIME-Version: 1.0
References: <1572527274-21925-1-git-send-email-sumit.garg@linaro.org> <20191107110603.GA8790@jax>
In-Reply-To: <20191107110603.GA8790@jax>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 7 Nov 2019 18:11:32 +0530
Message-ID: <CAFA6WYMuHqNZTtoda=P4-pweNOKXw_TLKNcBa-XuR5yBV3uRDw@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Fix dynamic shm pool allocations
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        etienne.carriere@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Thu, 7 Nov 2019 at 16:36, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi Sumit,
>
> On Thu, Oct 31, 2019 at 06:37:54PM +0530, Sumit Garg wrote:
> > In case of dynamic shared memory pool, kernel memory allocated using
> > dmabuf_mgr pool needs to be registered with OP-TEE prior to its usage
> > during optee_open_session() or optee_invoke_func().
> >
> > So fix dmabuf_mgr pool allocations via an additional call to
> > optee_shm_register().
> >
> > Fixes: 9733b072a12a ("optee: allow to work without static shared memory")
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> Looks good, I'm picking this up. Etienne told me has tested this on some
> of his hardware so I'll add:
> Tested-by: Etienne Carriere <etienne.carriere@linaro.org>
>

Thanks for picking this up.

>
> > ---
> >
> > Depends on patch: https://lkml.org/lkml/2019/7/30/506 that adds support
> > to allow registration of kernel buffers with OP-TEE.

You also need to pick up the dependency patch too. The latest v3 of
this patch is here [1] although its unchanged from v2. Also, If you
pick that up I will drop it from future revisions of Trusted Keys
patchset [2].

[1] https://lkml.org/lkml/2019/10/31/431
[2] https://lkml.org/lkml/2019/10/31/430

-Sumit

> >
> >  drivers/tee/optee/shm_pool.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> > index de1d9b8..0332a53 100644
> > --- a/drivers/tee/optee/shm_pool.c
> > +++ b/drivers/tee/optee/shm_pool.c
> > @@ -17,6 +17,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> >  {
> >       unsigned int order = get_order(size);
> >       struct page *page;
> > +     int rc = 0;
> >
> >       page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> >       if (!page)
> > @@ -26,12 +27,21 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> >       shm->paddr = page_to_phys(page);
> >       shm->size = PAGE_SIZE << order;
> >
> > -     return 0;
> > +     if (shm->flags & TEE_SHM_DMA_BUF) {
> > +             shm->flags |= TEE_SHM_REGISTER;
> > +             rc = optee_shm_register(shm->ctx, shm, &page, 1 << order,
> > +                                     (unsigned long)shm->kaddr);
> > +     }
> > +
> > +     return rc;
> >  }
> >
> >  static void pool_op_free(struct tee_shm_pool_mgr *poolm,
> >                        struct tee_shm *shm)
> >  {
> > +     if (shm->flags & TEE_SHM_DMA_BUF)
> > +             optee_shm_unregister(shm->ctx, shm);
> > +
> >       free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> >       shm->kaddr = NULL;
> >  }
> > --
> > 2.7.4
> >
