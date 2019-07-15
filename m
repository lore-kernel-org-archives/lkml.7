Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1497C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B828A21530
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kiTItl6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390167AbfGOOTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:19:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43071 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389784AbfGOOTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:19:39 -0400
Received: by mail-oi1-f194.google.com with SMTP id w79so12754180oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=74LWTKonskxRfxiDYwVD7OpNsKbfOfYFfTZAvmrPFJg=;
        b=kiTItl6xyrG9FywIDRfcy4DIFgA9n5FQMjm2wL9mdgzuKSnbt3nESPsNKfqPBueZBs
         RaocmVPDYXFtDrI4ysRzoObj0qDrpjOvB+wDyHYfLEV64FkHNR3uH95XLhXfJ6ufu+HZ
         p8X+m5T0N8pujQ2DcVZL1lXs5oJQY92Qy3HYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74LWTKonskxRfxiDYwVD7OpNsKbfOfYFfTZAvmrPFJg=;
        b=ilJaMVzI9jgIXqMFOcJLKFQwIoHJabfQuvSz+3vc6RkV8//+oTMXaRLVolFeYnfl2t
         DngMgk1zxQ8MhXa/W8Et9hVMzZbSpvp++9lp976v4QiaB6HQBJq7r+z/uLjPmI/+O/nm
         wWnaJ6uqpaEiXJThHUt7A4pcBKE1Afd/fWx4q+jBhLZ2m3fX39BuDUc6d8D3T2HyuASm
         /giisC9JJghyCTvu11wr6/j1hYnoUxlvnpdr2x+y4VdUpNqxBWrw/upjk9n7LhztOWFJ
         Jw95csgmB1z8TPnEjB3SipRjBFY2O2pZRqEy5epULY9xOW8BofrFyZsUPqc4fAXd7dZv
         evdw==
X-Gm-Message-State: APjAAAWr3DmI5+PMw5M7FWybZo1p11wJkPp9A0P5C0MNvBo4wLr9X7kR
        1E28jNX/MnrtLwlaUDB91vYzPvVYEDzfGkNqh70=
X-Google-Smtp-Source: APXvYqx9+tVgh5v+w5/XYZec+gr4t4ZX0LQfnl+mzXMZ66oi07oxVvsNmRa3kHVSBsjT45GtQ+mVBCop0D+NIq3ehcA=
X-Received: by 2002:aca:b2d5:: with SMTP id b204mr11927663oif.101.1563200378969;
 Mon, 15 Jul 2019 07:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9tx+CEkzmLZ-93GZmde9xzJ_rw3PJZxFu_pjZJc7KM5f-w@mail.gmail.com> <20190715122924.GA15202@mellanox.com>
In-Reply-To: <20190715122924.GA15202@mellanox.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 15 Jul 2019 16:19:26 +0200
Message-ID: <CAKMK7uHvjuQ5Dqm0LPrtQxdHh5Z6Pt2mg4AnpRRR0gWb1Wp05g@mail.gmail.com>
Subject: Re: DRM pull for v5.3-rc1
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 2:29 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> [urk, html email.. forgive the mess]
>
> On Mon, Jul 15, 2019 at 04:59:39PM +1000, Dave Airlie wrote:
>
> >      VMware had some mm helpers go in via my tree (looking back I'm
> >      not sure Thomas really secured enough acks on these, but I'm
>
> I saw those patches, honestly I couldn't entirely understand what
> problem they were trying to address..
>
> >      going with it for now until I get push back). They conflicted
> >      with one of the mm cleanups in the hmm tree, I've pushed a
> >      patch to the top of my next to fix most of the fallout in my
> >      tree, and the resulting fixup is to pick the closure->ptefn
> >      hunk and apply something like in mm/memory.c
>
> Did I mess a notification from StephenR in linux-next? I was unwaware
> of this conflict?
>
> The 'hmm' tree is something I ran to try and help workflow issues like
> this, as it could be merged to DRM as a topic branch - maybe consider
> this flow in future?
>
> Linus, do you have any advice on how best to handle sharing mm
> patches? The hmm.git was mildly painful as it sits between quilt on
> the -mm side and what seems like 'a world of interesting git things'
> on the DRM side (but maybe I just don't know enough about DRM).

I think the approach in this merge window worked fairly well:
- refactor/rework core mm stuff in (h)mm.git
- handle all the gpu stuff in drm.git
- make the clashes workable through some clever prep patches like
we've done this time around

I think Linus wants to be able to look through core mm stuff quite
closely, so not a good idea if we deeply intertwin it with one of the
biggest subsystems there is. And I don't think there will be a real
conflict like this every merge window, this should be the exception.
Worst case we have to stage some work 1 release cycle apart, i.e.
merge mm stuff first, then drm 3 months later. Usually that's not
going to slow things down noticeable given average merge latency for
core mm features :-)
-Daniel

> > @@ -2201,7 +2162,7 @@ static int apply_to_page_range_wrapper(pte_t
> >      *pte,
> >              struct page_range_apply *pra =
> >                      container_of(pter, typeof(*pra), pter);
> >      -       return pra->fn(pte, NULL, addr, pra->data);
> >      +       return pra->fn(pte, addr, pra->data);
> >       }
>
> I looked through this and it looks OK to me, thanks
>
> Jason



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
