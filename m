Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B36DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2F9206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="iDyhOkns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbfCZScD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:32:03 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43008 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732320AbfCZScD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:32:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id u15so12407362otq.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u9cBhSbjRv1xQudBuTMuesrbRGum1j3N1ZJZeMtgdtk=;
        b=iDyhOknsw3bbEnuVKhHD6yYtpuDy1dz8nuJBY4NtkyI2iiiCjG85hoz4yM6lSHolhF
         9dZWhO0sjS+cE0VQCUtFon2FEh/kGPA0UMXMVnLXrRmmDdpWVp0fjJ9+X2ZhcRvAI+gU
         1Dq6gHbaBLbFXeaobM8577uQY3qgW/MZIia3SQ8IIOZX1Om3SyAIBaEGOUS26qWht1Nb
         TAjAKs6PgDSaFRkgM8rLxUqbCKpgh/zwkx5t2qqoM8SxRh1occsqVX5xCOkHM3bueH+f
         exbGwGwikMvc/A5OMXrLDQnO0ISrHmoQ7lCMihVXk+VbnU+JT0qnn2lo3m7TPhDv7U8V
         MTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u9cBhSbjRv1xQudBuTMuesrbRGum1j3N1ZJZeMtgdtk=;
        b=XlmLn9ku3Gy83RCqq42aWqJmcoZv4jbQq71VybjoJnZ5xzItAxO2r90hHAOWBnyWUR
         IxDMXDMngYYOoupOAlxT/MrJJLLEyrn9q/qpZ/zvbEVGqwr87wepmjy6JifB1aFV3CoG
         NkGKb6f9JGRJwFR/XFCi8nLtK+qpKLw5MYkDFnnLMw/9DNDYZUX6EGHhsYKv2iPsy61W
         rVx8jnwyv/ljnYt2TqyHbqRzMOidDC4crzTUVCvb9lilk0WDWm3Pla/AtV1EZx2JIK8i
         qea+693sgVAn3qm9kR8Y0KRYzGiHIW4pkE7WOrFodP7YPa/UEFSUYfKsrgW9QtlKwIVk
         1k2w==
X-Gm-Message-State: APjAAAXS/htraCbNUY1T8t4/PafHmjhZ6g6uSaz/OWVTVHO0oUSQIMHn
        sJ/ebSVAoHbjj2zpYeIJhmixs5bWP/CQUUGMVvHIC5c4
X-Google-Smtp-Source: APXvYqxuYRvJ4UKGKlRAc+EDiJGcF2wEBnBpCou1CN3pKYtNl1PBpTi3+1mIKP1jZRjM/dnGuIqgtC0ak8z7HfG2Xkg=
X-Received: by 2002:a9d:4d0b:: with SMTP id n11mr21748602otf.98.1553625122516;
 Tue, 26 Mar 2019 11:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190325215527.12574-1-pakki001@umn.edu> <5fa84f18-7253-2543-57e4-6a9e2b2da716@codeaurora.org>
In-Reply-To: <5fa84f18-7253-2543-57e4-6a9e2b2da716@codeaurora.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 26 Mar 2019 11:31:51 -0700
Message-ID: <CAPcyv4jMrU4n1fOv31TOZ-8Re4-7mwG_C_d6WzxZbjnu91UVeQ@mail.gmail.com>
Subject: Re: [PATCH v4] nvdimm: btt_devs: fix a NULL pointer dereference
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 3:23 AM Mukesh Ojha <mojha@codeaurora.org> wrote:
>
>
> On 3/26/2019 3:25 AM, Aditya Pakki wrote:
> > In case kmemdup fails, the fix releases resources and returns to
> > avoid the NULL pointer dereference.
> >
> > Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> >
> > ---
> > v3: Move kfree(nd_btt) to goto block.
> > v2: Replace incorrect kfree with ida_simple_remove, suggested by
> > Johannes Thumshirn
> > v1: Free nd_btt->id in case of failure and avoid double free, suggested
> > by Dan Williams
> > ---
> >   drivers/nvdimm/btt_devs.c | 18 +++++++++++++-----
> >   1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
> > index b72a303176c7..9486acc08402 100644
> > --- a/drivers/nvdimm/btt_devs.c
> > +++ b/drivers/nvdimm/btt_devs.c
> > @@ -198,14 +198,15 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
> >               return NULL;
> >
> >       nd_btt->id = ida_simple_get(&nd_region->btt_ida, 0, 0, GFP_KERNEL);
> > -     if (nd_btt->id < 0) {
> > -             kfree(nd_btt);
> > -             return NULL;
> > -     }
> > +     if (nd_btt->id < 0)
> > +             goto out_nd_btt;
> >
> >       nd_btt->lbasize = lbasize;
> > -     if (uuid)
> > +     if (uuid) {
> >               uuid = kmemdup(uuid, 16, GFP_KERNEL);
> > +             if (!uuid)
> > +                     goto out_put_id;
> > +     }
> >       nd_btt->uuid = uuid;
> >       dev = &nd_btt->dev;
> >       dev_set_name(dev, "btt%d.%d", nd_region->id, nd_btt->id);
> > @@ -220,6 +221,13 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
> >               return NULL;
> >       }
> >       return dev;
> > +
> > +out_put_id:
> > +     ida_simple_remove(&nd_region->btt_ida, nd_btt->id);
> > +
> > +out_nd_btt:
> > +     kfree(nd_btt);
> > +     return NULL;
> >   }
> >
> >   struct device *nd_btt_create(struct nd_region *nd_region)
>
>
> you have to take care of this below if block(true) as well as you are
> touching the function.
>   if (ndns && !__nd_attach_ndns(&nd_btt->dev, ndns, &nd_btt->ndns)) {

No, once the device is successfully initialized then put_device()
takes care of the rest.
