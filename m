Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5B3C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7F22075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjsqeKDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbfDBI7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:59:50 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42880 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbfDBI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:59:50 -0400
Received: by mail-io1-f66.google.com with SMTP id c4so10227577ioh.9;
        Tue, 02 Apr 2019 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VS4HDk7UIBBwogBeMspGyfkAQhYGbx8dMY7OzLwxPWg=;
        b=WjsqeKDelFGLdRjeABF+Qrtz9rYLKORiwGBMMtLymx/eb1EO0cURukXWVdGKsngAeY
         XNCXm2Wml/YpeHJPu57m5nsNAskdVVGcbfTkJQw7i4yMwQ/G1cLk84p4NJo5LVFlOJsh
         5Aj7T2WjvviXjApqlK4ogwaslS3jzEMBc5krzHvGEZaR1/M0s+OrzzfCRO+ZPa85cDde
         N1d4HJeUdQBZsMdb2Y2kE1JpF4rT9EQlcQJEmcKeTwm9USSQinH/KZ0Kd5IO4YkFSELK
         xQA26QzgeRoSeL08L0IvWWLXjp1p6F2pvE4QJwtcvtnYsIx8k0eI8RZWVmB9GipUJzo9
         xawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VS4HDk7UIBBwogBeMspGyfkAQhYGbx8dMY7OzLwxPWg=;
        b=hqGipsRmlBgoUkWJUaX7xBVYI4JjQ2Iu7RrCbZC+1cwiKf0OjhRksXwf4ibos/shhY
         6Um7CQAuE9ILgX2nbty6c5+4/PuLtgCeFtZ88bpPzaZlgh6fXaoXcg0kDZiJLR8QDPUI
         5HKdnZATGIGz1Ue7MibM2zAcRmmGeOI/mDiYDR/4nVYqjaycq1i9d5d0GVJRJGOmIRy2
         5QZ59tVA3yA7v5oc3CPcrDs920G8oRB5sCRTwwT88pVm3YyUmk3YsODQgOOih5M7VNng
         xvD4Rx/Da6RqEhjFGxWvLOSa0YYFZTV2VqaKZbJKYPJ3d3oIKW6DgdJKABlWAOOon2j3
         VmVg==
X-Gm-Message-State: APjAAAXM4vyjjcp7zYgfKL3NKKwcaomfNk77v9QcZj49mpj3wSZWtD2i
        MH21haY55zTfUOPX14rgSUdFxtVYL6qAcHKSiY0=
X-Google-Smtp-Source: APXvYqwRU954oR0D173H/sWqIiqsiwDnOsR1T58QCuV4YCkSPY2wB6/46DmgCwvYwLb8QFXfTXioa67z+J3hBjwfebQ=
X-Received: by 2002:a6b:660e:: with SMTP id a14mr45429200ioc.136.1554195588912;
 Tue, 02 Apr 2019 01:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190402105006.48f93e53@canb.auug.org.au> <CAKGbVbvj9cZnJuey_ra7U+xm-JhoB17bpTgcXKiKaHWbjB9Sxw@mail.gmail.com>
 <20190402075744.GC2665@phenom.ffwll.local>
In-Reply-To: <20190402075744.GC2665@phenom.ffwll.local>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Tue, 2 Apr 2019 16:59:37 +0800
Message-ID: <CAKGbVbsn9BpbMZCshxzj=d38wHpBhBo7wrZDQnC01hB30B9-mA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To:     Qiang Yu <yuq825@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 3:57 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Apr 02, 2019 at 01:55:03PM +0800, Qiang Yu wrote:
> > Thanks, patch is:
> > Reviewed-by: Qiang Yu <yuq825@gmail.com>
>
> Good time to get started with committing patches? In general it's kinda
> confusing if the maintainer r-bs a patch, but doesn't say whether/when/how
> it gets merged. Big chance the patch will get lost in limbo and fall
> through cracks.

Thanks for the remind, this patch should only be applied to drm-misc-next
branch when 5.1-rcx branch gets merged to drm-misc-next for the new
xa_alloc API. So I expect the guy who do the 5.1-rcx merge should apply
this patch. Who will do the merge?

Regards,
Qiang

>
> >
> > Regards,
> > Qiang
> >
> > On Tue, Apr 2, 2019 at 7:50 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > After merging the drm-misc tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > >
> > > In file included from include/linux/kernel.h:7,
> > >                  from include/asm-generic/bug.h:18,
> > >                  from arch/x86/include/asm/bug.h:83,
> > >                  from include/linux/bug.h:5,
> > >                  from include/linux/mmdebug.h:5,
> > >                  from include/linux/gfp.h:5,
> > >                  from include/linux/slab.h:15,
> > >                  from drivers/gpu/drm/lima/lima_ctx.c:4:
> > > drivers/gpu/drm/lima/lima_ctx.c: In function 'lima_ctx_create':
> > > include/linux/limits.h:13:18: warning: passing argument 3 of 'xa_alloc' makes pointer from integer without a cast [-Wint-conversion]
> > >  #define UINT_MAX (~0U)
> > >                   ^~~~~
> > > drivers/gpu/drm/lima/lima_ctx.c:26:36: note: in expansion of macro 'UINT_MAX'
> > >   err = xa_alloc(&mgr->handles, id, UINT_MAX, ctx, GFP_KERNEL);
> > >                                     ^~~~~~~~
> > > In file included from include/linux/radix-tree.h:31,
> > >                  from include/linux/idr.h:15,
> > >                  from include/drm/drm_device.h:7,
> > >                  from drivers/gpu/drm/lima/lima_device.h:7,
> > >                  from drivers/gpu/drm/lima/lima_ctx.c:6:
> > > include/linux/xarray.h:817:9: note: expected 'void *' but argument is of type 'unsigned int'
> > >    void *entry, struct xa_limit limit, gfp_t gfp)
> > >    ~~~~~~^~~~~
> > > drivers/gpu/drm/lima/lima_ctx.c:26:46: error: incompatible type for argument 4 of 'xa_alloc'
> > >   err = xa_alloc(&mgr->handles, id, UINT_MAX, ctx, GFP_KERNEL);
> > >                                               ^~~
> > > In file included from include/linux/radix-tree.h:31,
> > >                  from include/linux/idr.h:15,
> > >                  from include/drm/drm_device.h:7,
> > >                  from drivers/gpu/drm/lima/lima_device.h:7,
> > >                  from drivers/gpu/drm/lima/lima_ctx.c:6:
> > > include/linux/xarray.h:817:32: note: expected 'struct xa_limit' but argument is of type 'struct lima_ctx *'
> > >    void *entry, struct xa_limit limit, gfp_t gfp)
> > >                 ~~~~~~~~~~~~~~~~^~~~~
> > >
> > > Caused by commit
> > >
> > >   a1d2a6339961 ("drm/lima: driver for ARM Mali4xx GPUs")
> > >
> > > interacting with commit
> > >
> > >   a3e4d3f97ec8 ("XArray: Redesign xa_alloc API")
> > >
> > > from Linus' tree (v5.1-rc1).
> > >
> > > I have applied the following patch for today.  It could be applied as
> > > part of a merge of v5.1-rc1 into drm-misc.
> > >
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Date: Tue, 2 Apr 2019 10:45:32 +1100
> > > Subject: [PATCH] drm/lima: update for xa_alloc API change
> > >
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > ---
> > >  drivers/gpu/drm/lima/lima_ctx.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/lima/lima_ctx.c b/drivers/gpu/drm/lima/lima_ctx.c
> > > index c8d12f7c6894..bafa00d74cc5 100644
> > > --- a/drivers/gpu/drm/lima/lima_ctx.c
> > > +++ b/drivers/gpu/drm/lima/lima_ctx.c
> > > @@ -23,7 +23,7 @@ int lima_ctx_create(struct lima_device *dev, struct lima_ctx_mgr *mgr, u32 *id)
> > >                         goto err_out0;
> > >         }
> > >
> > > -       err = xa_alloc(&mgr->handles, id, UINT_MAX, ctx, GFP_KERNEL);
> > > +       err = xa_alloc(&mgr->handles, id, ctx, XA_LIMIT(*id, UINT_MAX), GFP_KERNEL);
> > >         if (err < 0)
> > >                 goto err_out0;
> > >
> > > --
> > > 2.20.1
> > >
> > > --
> > > Cheers,
> > > Stephen Rothwell
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
