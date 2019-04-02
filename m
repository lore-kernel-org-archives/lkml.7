Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA5DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713E320857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="S7fiR2+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfDBH5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:57:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36002 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfDBH5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:57:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id s16so10750785edr.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 00:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f3Si4Fa+Q8qbMJeREZwRFoWLVwOwgdb7bXze6YqcO34=;
        b=S7fiR2+RnddLlB1H+aqV8p1bCuvJ3cvYdChLVFEc2tfNNA+BNGplYH2YlcNDV3Jqjr
         9CMVGfb8Qp17gLazN2EBjuLvcuWyPMWpx6WtDSRsX0DxQOL55KU8q8GP7z8EtODtgL8s
         1jjB1FHSNscRhpmxOyYtw+xUe4KeD9aAPAiCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=f3Si4Fa+Q8qbMJeREZwRFoWLVwOwgdb7bXze6YqcO34=;
        b=s9c4dSk8c7xN/gAxg3EwmBnRI9sTosX/LPfD8/4ofQ3hwlbalHcQJitFsB2fFTEm17
         WWgyB7vVa80spde+cpFBqupw/yDSrLaRdj8WY0fXpu4eOmdBw58ChmKhxDFVp9abaUJd
         xx4thZLaWVfRLWpjbcxksBq8BQ+6OsPsmWYqR9KPgbv6N+pgMz3cbCwGo99/mguTyYmU
         p0t9tnFoWOqByGHK9vHmeKYJgl59GXsl7W8cv2RBNm7U87ilu51Y1kB5dXgTBxeeP7QM
         aL/tRunwaVLBPgxGzzAzFtsjstCAksnytQyKq7OeG4PyDOLZk8P1E3pgvdZpVRFUpauS
         z4sg==
X-Gm-Message-State: APjAAAVutYgczbd9Ev2qh0z5ZL0oV/j/5eK9BHzRdNDadlynqt4FpRFb
        BAxvbJP8r5SWUy+QdtBY3YbcAAJCwgg=
X-Google-Smtp-Source: APXvYqw9EPUhB/RSW/A7/NRbw+JiogzZho9VSnCO7NGRmG7UClxmp8BxITPJMq84Gg6r1znlVlx7AQ==
X-Received: by 2002:a50:8561:: with SMTP id 88mr30693770edr.101.1554191867385;
        Tue, 02 Apr 2019 00:57:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e3sm3842318edb.22.2019.04.02.00.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 00:57:46 -0700 (PDT)
Date:   Tue, 2 Apr 2019 09:57:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Qiang Yu <yuq825@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20190402075744.GC2665@phenom.ffwll.local>
Mail-Followup-To: Qiang Yu <yuq825@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>, Matthew Wilcox <willy@infradead.org>
References: <20190402105006.48f93e53@canb.auug.org.au>
 <CAKGbVbvj9cZnJuey_ra7U+xm-JhoB17bpTgcXKiKaHWbjB9Sxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKGbVbvj9cZnJuey_ra7U+xm-JhoB17bpTgcXKiKaHWbjB9Sxw@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 01:55:03PM +0800, Qiang Yu wrote:
> Thanks, patch is:
> Reviewed-by: Qiang Yu <yuq825@gmail.com>

Good time to get started with committing patches? In general it's kinda
confusing if the maintainer r-bs a patch, but doesn't say whether/when/how
it gets merged. Big chance the patch will get lost in limbo and fall
through cracks.
-Daniel

> 
> Regards,
> Qiang
> 
> On Tue, Apr 2, 2019 at 7:50 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > After merging the drm-misc tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > In file included from include/linux/kernel.h:7,
> >                  from include/asm-generic/bug.h:18,
> >                  from arch/x86/include/asm/bug.h:83,
> >                  from include/linux/bug.h:5,
> >                  from include/linux/mmdebug.h:5,
> >                  from include/linux/gfp.h:5,
> >                  from include/linux/slab.h:15,
> >                  from drivers/gpu/drm/lima/lima_ctx.c:4:
> > drivers/gpu/drm/lima/lima_ctx.c: In function 'lima_ctx_create':
> > include/linux/limits.h:13:18: warning: passing argument 3 of 'xa_alloc' makes pointer from integer without a cast [-Wint-conversion]
> >  #define UINT_MAX (~0U)
> >                   ^~~~~
> > drivers/gpu/drm/lima/lima_ctx.c:26:36: note: in expansion of macro 'UINT_MAX'
> >   err = xa_alloc(&mgr->handles, id, UINT_MAX, ctx, GFP_KERNEL);
> >                                     ^~~~~~~~
> > In file included from include/linux/radix-tree.h:31,
> >                  from include/linux/idr.h:15,
> >                  from include/drm/drm_device.h:7,
> >                  from drivers/gpu/drm/lima/lima_device.h:7,
> >                  from drivers/gpu/drm/lima/lima_ctx.c:6:
> > include/linux/xarray.h:817:9: note: expected 'void *' but argument is of type 'unsigned int'
> >    void *entry, struct xa_limit limit, gfp_t gfp)
> >    ~~~~~~^~~~~
> > drivers/gpu/drm/lima/lima_ctx.c:26:46: error: incompatible type for argument 4 of 'xa_alloc'
> >   err = xa_alloc(&mgr->handles, id, UINT_MAX, ctx, GFP_KERNEL);
> >                                               ^~~
> > In file included from include/linux/radix-tree.h:31,
> >                  from include/linux/idr.h:15,
> >                  from include/drm/drm_device.h:7,
> >                  from drivers/gpu/drm/lima/lima_device.h:7,
> >                  from drivers/gpu/drm/lima/lima_ctx.c:6:
> > include/linux/xarray.h:817:32: note: expected 'struct xa_limit' but argument is of type 'struct lima_ctx *'
> >    void *entry, struct xa_limit limit, gfp_t gfp)
> >                 ~~~~~~~~~~~~~~~~^~~~~
> >
> > Caused by commit
> >
> >   a1d2a6339961 ("drm/lima: driver for ARM Mali4xx GPUs")
> >
> > interacting with commit
> >
> >   a3e4d3f97ec8 ("XArray: Redesign xa_alloc API")
> >
> > from Linus' tree (v5.1-rc1).
> >
> > I have applied the following patch for today.  It could be applied as
> > part of a merge of v5.1-rc1 into drm-misc.
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Tue, 2 Apr 2019 10:45:32 +1100
> > Subject: [PATCH] drm/lima: update for xa_alloc API change
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/gpu/drm/lima/lima_ctx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/lima/lima_ctx.c b/drivers/gpu/drm/lima/lima_ctx.c
> > index c8d12f7c6894..bafa00d74cc5 100644
> > --- a/drivers/gpu/drm/lima/lima_ctx.c
> > +++ b/drivers/gpu/drm/lima/lima_ctx.c
> > @@ -23,7 +23,7 @@ int lima_ctx_create(struct lima_device *dev, struct lima_ctx_mgr *mgr, u32 *id)
> >                         goto err_out0;
> >         }
> >
> > -       err = xa_alloc(&mgr->handles, id, UINT_MAX, ctx, GFP_KERNEL);
> > +       err = xa_alloc(&mgr->handles, id, ctx, XA_LIMIT(*id, UINT_MAX), GFP_KERNEL);
> >         if (err < 0)
> >                 goto err_out0;
> >
> > --
> > 2.20.1
> >
> > --
> > Cheers,
> > Stephen Rothwell

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
