Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BBBC2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484F52073D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YsQksu/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfLMKAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:00:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36946 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMKAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:00:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so5891858wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 02:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wNP4rI1DOEGJNKJHekEUoF6Vehge/dTvDIo4/5mFf6E=;
        b=YsQksu/cONoPVHsqBo+Ol3YlvExGinuQQnGqL/9wnK6ssNjv2acpOzR/mF/5xjb0JC
         lLz2XwymDkMLftIpGSrkhlMGozPL55W9NaqX4oKer3AnYFXzByRAb9+fmwOtw3+Oqi0Q
         sRod9k8H6GnE0c2uXvhE2BaddqdnXk2tHRlqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=wNP4rI1DOEGJNKJHekEUoF6Vehge/dTvDIo4/5mFf6E=;
        b=qAGfB8BJp1Y8ifDV898898INWlCwhuhI3NyKztmdS9/P1xUY8kRahooCGubQRUEKri
         Tq6geTbCr0/qkCXDUSpuNs1xhKAYvpGd5LlEF9YWsjqThVAuxIeKURmw0vKsshAb4mNA
         EZcfUMirit++W0ITl5zI8wZxHIp+fJGZ0qZZr/nbt+98g9tc/J0m2v1dCjD9f6Xh/pyg
         QFzS8GmZT09KhLiPHyDYmN7Ww1ctzNhmaeDt02I9KBYX0dH9SLtMqKNlJ/aDGiMDJhCV
         EAWNA1wuxH2UoYXNG1XEpzq8SMNX06iMdHOAyg3cJXs8Fwg5KQvmfjrHreLDBhogX9tN
         4ODA==
X-Gm-Message-State: APjAAAW0puIpPTWQvuDBeLGpLHWSeUfXzOTxhrBFvyMS0kz3kiIlVqn6
        fZPeTc8Vv9djlRSd/3x7hI3lBA==
X-Google-Smtp-Source: APXvYqzHj5Vgx4Q+eg2SkNOJ4kzSiCtnnqAp5kkKYacZ9gRqcN7iTxNesueCnGqcTcvmU+NnrlE1Zw==
X-Received: by 2002:a1c:8116:: with SMTP id c22mr11985885wmd.27.1576231202109;
        Fri, 13 Dec 2019 02:00:02 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:564b:0:7567:bb67:3d7f:f863])
        by smtp.gmail.com with ESMTPSA id n67sm3084493wmf.46.2019.12.13.02.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 02:00:01 -0800 (PST)
Date:   Fri, 13 Dec 2019 10:59:59 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        gurchetansingh@chromium.org
Subject: Re: [PATCH v2 1/2] drm/shmem: add support for per object caching
 attributes
Message-ID: <20191213095959.GA624164@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        gurchetansingh@chromium.org
References: <20191211081810.20079-1-kraxel@redhat.com>
 <20191211081810.20079-2-kraxel@redhat.com>
 <0b64e917-48f7-487e-9335-2838b6c62808@suse.de>
 <ed9142da-ce10-7df2-8a85-ba9ad0c26551@suse.de>
 <20191211123635.GY624164@phenom.ffwll.local>
 <20191211131830.iz3a2o4xzmmkjsp7@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211131830.iz3a2o4xzmmkjsp7@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 02:18:30PM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > btw on why udl does this: Imported bo are usually rendered by real hw, and
> > reading it uncached/wc is the more defensive setting. It would be kinda
> > nice if dma-buf would expose this, but I fear dma-api maintainers would
> > murder us if we even just propose that ... so it's a mess right now.
> 
> I suspect for imported dma-bufs we should leave the mmap() to the
> exporter instead of pulling the pages out of the sgt and map them
> ourself.

Uh yes. If we still do that, then yes very much we shouldn't. Even better
would be to just not do that, because the semantics of dumb gem mmap and
dma-buf mmap differ (the latter has the begin/end access ioctl).

If we can't ditch the mmap I think we should at least improve the helpers
to do the redirect to dma_buf_mmap directly and stop drivers from doing
silly stuff.

> > btw the issue extends to dma access by devices too, e.g. both i915 and
> > amdgpu can select the coherency mode at runtime (using e.g. the pcie
> > no-snoop transaction mode), and we have similar uncoordinated hacks in
> > there too, like in udl.
> 
> Hmm.  Ok.  I guess I'm not going to try solve all that properly just for
> the little virtio fix.
> 
> Just curious:  How do you tell your hardware?  Are there bits for that
> in the gtt, simliar to the caching bits in the x86 page tables?

Brace for contact ...

- on amdgpu it's a bit in the gpu pagetable. I think (but not sure, not an
  expert on these chips) that's the only way.

- on i915 it's a also a bit in the gpu pagetables, but userspace can
  override the caching/coherency mode on a per-texture/render target/*BO
  level in the command stream.

This is why gpus and dma-api don't mix well, since dma-api's goal is to
hide all this even from the driver. gpus otoh leak it all the way to
userspace. The trouble is as old as AGP from 1999 or so, I've become
somewhat cynic at trying to fix this for real and not just with hacks. The
disconnect between what we need and what dma-api kernel people want to
give us is too big to bridge it seems.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
