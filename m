Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37906C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD520206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MOhY9rEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbfGORxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:53:19 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42303 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbfGORxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:53:19 -0400
Received: by mail-ot1-f66.google.com with SMTP id l15so17937860otn.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 10:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SkesM2hcGDDC/kg0C8a48VrcxIoXJLz8YVcZEfvwMQk=;
        b=MOhY9rEYJYtAIzvC5D6fXjtfUVSaXojQfImzFzO+46Vzca6hHSNrEMx0k66k5v/wDe
         nPBmDyHcApfQ2B5SEJnT8Jcca2Oxl4BnGbfwH82xMK84+X9/1U5pRmbdH4CW2L0OkItc
         gOz8vN2j1h9rhYbPKYnsQCo0gjNVDaVHJA464=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SkesM2hcGDDC/kg0C8a48VrcxIoXJLz8YVcZEfvwMQk=;
        b=o8qO8wp9zuhFiGcakm5DCQk2EZyS+Y9g7UWm/h1gz1ffU0uPNOLyjUOT0uILNmGIfL
         KwgRpnoOBo0VnJvg+KjNygPHIK+yf7pnUBaEAq2wc5Ncf8slVUfkK2ar++sTPvQAzcD6
         9ezeeA5IV7IEIC20rHvIr+EwY/J5ac0qn/aQHGx6rQpId62pnDQMP8yGwSs8JZSMs4rC
         0VOG3A2xPVjPDaPAvWKlHPmHDZqQQ1DqwN9MIDl1tdQvvC+8RCLH67B5bZMvW8cxWMWn
         Gn5z4sUdSSGHDGYctGYFp6kKq4IuiHU+QlbX08jpTBT2MZuI8Wzh4tPQydRpdL74mW4d
         ig5A==
X-Gm-Message-State: APjAAAWs8hPlTgxU4C6nNvtTSGl7PYpQhM2ikEQt4LT9xD7mo+05fPOT
        IZ2x5aN72P1sKW3kvD8qfLfxVaMPiGXVqy1DHVo=
X-Google-Smtp-Source: APXvYqy86jUsS2LwxBfyqRFPJw2NOpF0TWdvRy8hqG/tO31njyEG+mHtALbfcQPIjY5Ler8d6pBpGEIHHsbdTwwDBd0=
X-Received: by 2002:a05:6830:ce:: with SMTP id x14mr1039567oto.188.1563213198135;
 Mon, 15 Jul 2019 10:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9tx+CEkzmLZ-93GZmde9xzJ_rw3PJZxFu_pjZJc7KM5f-w@mail.gmail.com>
 <20190715122924.GA15202@mellanox.com> <CAKMK7uHvjuQ5Dqm0LPrtQxdHh5Z6Pt2mg4AnpRRR0gWb1Wp05g@mail.gmail.com>
 <20190715150402.GD15202@mellanox.com>
In-Reply-To: <20190715150402.GD15202@mellanox.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 15 Jul 2019 19:53:06 +0200
Message-ID: <CAKMK7uGbNuA_pN=r9XKGz2MTVVJWm6q8tKBT3WJPa93nKEe4iA@mail.gmail.com>
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

On Mon, Jul 15, 2019 at 5:04 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Mon, Jul 15, 2019 at 04:19:26PM +0200, Daniel Vetter wrote:
>
> > > Linus, do you have any advice on how best to handle sharing mm
> > > patches? The hmm.git was mildly painful as it sits between quilt on
> > > the -mm side and what seems like 'a world of interesting git things'
> > > on the DRM side (but maybe I just don't know enough about DRM).
> >
> > I think the approach in this merge window worked fairly well:
> > - refactor/rework core mm stuff in (h)mm.git
> > - handle all the gpu stuff in drm.git
> > - make the clashes workable through some clever prep patches like
> >   we've done this time around
>
> Okay, as long as we agree.
>
> I think part of the challenge with hmm.git was setting some
> expectation for managing conflicts - there is some happy middle ground
> between none & scary we need to navigate to make this work.
>
> > I think Linus wants to be able to look through core mm stuff quite
> > closely, so not a good idea if we deeply intertwin it with one of the
> > biggest subsystems there is.
>
> There is definately a bunch of stuff that is under the mm/ directory
> but is not quite 'core mm' - it would be good if we could rely on
> mailing list review of that part and use a topic workflow to manage
> things. This was/is more or less my plan with hmm.git
>
> Otherwise yes, as much as reasonable we should avoid topic merges
> between the trees.
>
> However, I again see conflict risk coming this cycle ..
>
> >  And I don't think there will be a real conflict like this every
> > merge window, this should be the exception.  Worst case we have to
> > stage some work 1 release cycle apart, i.e.  merge mm stuff first,
> > then drm 3 months later.
>
> I really dislike this idea. Not being able to provide users for core
> APIs is a huge process/review problem. Worse it tends to create a
> 'ladder' where in-flight changes to drivers (to implement the new
> core) now block any changes to the core APIs on alternating cycles. So
> 'the big pitcture' starts to fall a part if we can't co-ordinate cross
> tree changes in some way.
>
> .. and honestly, splitting a review process across a 9 week gap is one
> of the best ways I've seen to get a poor quality review :(
>
> I'm pretty familiar with this problem, we had it in spades between RDMA
> and netdev for a long time, and it is finally fully resolved now
> through a careful use of topic branches and merges.
>
> For example, next week I'll queue CH's patches that shift the last
> batch of hmm 'conflict management' shims into nouveau, and tries to
> fix them:
>
>   https://patchwork.kernel.org/project/linux-mm/list/?series=141835
>
> This is something uncontroversial that really should go into the DRM
> world as a topic so it doesn't interfere with ongoing nouveau dev. But
> I want to keep the hmm.c/.h bits in the hmm.git to avoid conflicts.
>
> So, I'll put it on a topic and send you two a note next week to decide
> if you want to merge it or not. I'm really unclear how nouveau's and
> AMD's patchflow works..

DRM is 2-level for pretty much everything. First it lands in a driver
tree (or a collectiv of drivers, like in drm-misc). Then those send
pull requests to drm.git for integration. Busy trees do that every 1-2
weeks (e.g. amdgpu), slower trees once per merge window (e.g. nouveau)
for drm-next, similar for drm-fixes.
-Daniel




--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
