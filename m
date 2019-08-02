Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC267C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49BE2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mijUeY9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393162AbfHBNPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:15:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37203 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfHBNPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:15:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so36034982pfa.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ifLzeiN7RdoV2uCNP+IfzGizfQ9wvDhB0/Kk7Ly+1nw=;
        b=mijUeY9+6MiYDPyljJ3fpJLl5Awygf8JLF+LiHnz5X4Xw2WV6OinFyjc3LEyPf8elk
         FRSfdIrxlCaUXybHyrHLv3BaSsaRfBCZ5NW4hmRO6z0t/uyifEQyjKWORmHLqmdr9l9i
         XtmS7TGRcdnAdHxlviZdi0iBPjCflSOWFkkWQa5KSueiVKMFXuYly4sfizxxVENcuWvh
         dCocnAC6zUmQY2H55pO0OB3cP/zyh+HIlQNYQr5IHF1CJf0tBnBwk/U/xbizNCYUeGkW
         fWLp6HYrBzKPaXemGRK4YMUgjz8cIFemmKeTWG+WuPSGwKZ1aP6ca/O1U3dd/0uGOglH
         g1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ifLzeiN7RdoV2uCNP+IfzGizfQ9wvDhB0/Kk7Ly+1nw=;
        b=ktLSnH07Mevtb+2JZWCzUij0pdPzOU4/vnZLzgzhLHfMdbyNJriVo6VxtBBapjNUCD
         hMUWU9xBzDUBmyvwCQNbly3yS3Vsa7q0ZgmpyZ93jNkuyYusnlxbLGrowjaeQFPYh/2g
         Rz6MT0QcEG4v4rmUD49IueaTdeSrXTtfILP10pJXVqEZ2b+PNgunnKABRE+dC4kmkb9g
         c/fdmxCSpLDsrOlWsiy0D3Ndxwu7dq+p7AC3GNX0RTIRUwBAxJRHXygo0jICgYAntgEi
         CQgKSlRlZxN59Ka2ZBNzsW7MjCi5HYLMDsXcbOxIBJ4IsJyDD/zFIMxs1GuTwSz3PzXV
         K6Hg==
X-Gm-Message-State: APjAAAWbtre2krCg1kSLoYDUsQd8MtWI8fYvMm69qlcnwAbRTwt8bD8Y
        dYdGAMYHBNqaXNfdwMFRjw0=
X-Google-Smtp-Source: APXvYqxSa24tdlPjUU4ROAhn9QcEDkxcpmypjCQZoXQjxwLTalItXRTxEMj4hn5NQ/b8SHAhsCjt/w==
X-Received: by 2002:a17:90a:d343:: with SMTP id i3mr4480771pjx.15.1564751729134;
        Fri, 02 Aug 2019 06:15:29 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id y12sm85622219pfn.187.2019.08.02.06.15.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 06:15:28 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 2 Aug 2019 22:15:23 +0900
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i915: do not leak module ref counter
Message-ID: <20190802131523.GB466@tigerII.localdomain>
References: <20190802123956.2450-1-sergey.senozhatsky@gmail.com>
 <20190802123956.2450-2-sergey.senozhatsky@gmail.com>
 <156475071634.6598.8668583907388398632@skylake-alporthouse-com>
 <156475141863.6598.6809215010139776043@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156475141863.6598.6809215010139776043@skylake-alporthouse-com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/02/19 14:10), Chris Wilson wrote:
> > >  drivers/gpu/drm/i915/gem/i915_gemfs.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
> > > index cf05ba72df9d..d437188d1736 100644
> > > --- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
> > > +++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
> > > @@ -24,8 +24,10 @@ int i915_gemfs_init(struct drm_i915_private *i915)
> > >                 return -ENODEV;
> > >  
> > >         gemfs = kern_mount(type);
> > 
> > Looking around, it looks like we always need to drop type after
> > mounting. Should the
> >         put_filesystem(type);
> > be here instead?
> > 
> > Anyway, nice catch.
> 
> Sigh. put_filesystem() is part of fs internals. I'd be tempted to add

Good catch!

So we can switch to vfs_kern_mount(), I guess, but pass different options,
depending on has_transparent_hugepage().

	-ss
