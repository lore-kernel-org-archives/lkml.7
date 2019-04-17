Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763CAC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3889520645
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OoqqQgsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbfDQOkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:40:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38669 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQOkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:40:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id d13so21208989edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vnZw0SSjJ3DGwdjiuT9gom0vb9bCFfWqxZmhOmgPi1Y=;
        b=OoqqQgsFtD6QFOKMzuOxOE95UBdEfg96U8oHr3SVDZsD0I7Ug8T3UQj13xdumna7hA
         t9wgfchLVs4hzz+kmGmiDj4PJsp5065FE4YnwZUSGK5z51EmvvpLF32FcDhc1+SZQ5Au
         g3KJ9cj7J5hqNXwTy0Yc+XOLX0zoDy3jK91JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vnZw0SSjJ3DGwdjiuT9gom0vb9bCFfWqxZmhOmgPi1Y=;
        b=jIaa9JL4G1EldSvb65SMCN8RkXSfngnykLpim0JJWZhFcbgB3EpOhp+gHxRNsidPjy
         /UqwrNIVaBnAwMDPSTARWbfrTcGMhtGa6SN07kBct0j3fNE61Z84ZAIPw+DX1uwqZJfw
         rTIvx58mLkcG2GuyndfVk5+y6mA70F5nVjx0FXZ1LXVQPQ7wkFjIqOomCHhfTKz3rkro
         qjG4yIN1M6jAJ870M0Uew658swo1h8dMdmvzCn8uID3CCCKg/KPRDwEU0aZ7KusZxi9P
         Tt1CuTWGMPugISatIyFGHOls2nBsL1qHsL3mJrssyEnAF+8QAGC0FYdJ6DJx+bdOGTzl
         rXUg==
X-Gm-Message-State: APjAAAUgVWU1LfEMzrQ2e5w+nfYIrBStLrCjzbRQlKaQrLpF0b5SyhrG
        O3vGpKQWpcTs6UgxF+kMrOtjWQ==
X-Google-Smtp-Source: APXvYqw7yj7H4kVO6FgE2pWQsv5RvYqXLaTA7UenOJ0JA/KSFWjclJQZ9YqY3vPyOq8/ykazA14kaA==
X-Received: by 2002:a50:aea1:: with SMTP id e30mr19648428edd.137.1555512014087;
        Wed, 17 Apr 2019 07:40:14 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id h10sm2578502ede.21.2019.04.17.07.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 07:40:13 -0700 (PDT)
Date:   Wed, 17 Apr 2019 16:40:11 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, sumit.semwal@linaro.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 05/12] dma-buf: add explicit buffer pinning
Message-ID: <20190417144011.GI13337@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <20190416183841.1577-6-christian.koenig@amd.com>
 <20190417142002.GE13337@phenom.ffwll.local>
 <20190417143051.GG13337@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190417143051.GG13337@phenom.ffwll.local>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:30:51PM +0200, Daniel Vetter wrote:
> On Wed, Apr 17, 2019 at 04:20:02PM +0200, Daniel Vetter wrote:
> > On Tue, Apr 16, 2019 at 08:38:34PM +0200, Christian König wrote:
> > > Add optional explicit pinning callbacks instead of implicitly assume the
> > > exporter pins the buffer when a mapping is created.
> > > 
> > > Signed-off-by: Christian König <christian.koenig@amd.com>
> > 
> > Don't we need this together with the invalidate callback and the dynamic
> > stuff? Also I'm assuming that pin/unpin is pretty much required for
> > dynamic bo, so could we look at these callbacks instead of the dynamic
> > flag you add in patch 1.
> > 
> > I'm assuming following rules hold:
> > no pin/upin from exporter:
> > 
> > dma-buf is not dynamic, and pinned for the duration of map/unmap. I'm
> > not 100% sure whether really everyone wants the mapping to be cached for
> > the entire attachment, only drm_prime does that. And that's not the only
> > dma-buf importer.
> > 
> > pin/unpin calls are noops.
> > 
> > pin/unpin exist in the exporter, but importer has not provided an
> > invalidate callback:
> > 
> > We map at attach time, and we also have to pin, since the importer can't
> > handle the buffer disappearing, at attach time. We unmap/unpin at detach.
> 
> For this case we should have a WARN in pin/unpin, to make sure importers
> don't do something stupid. One more thought below on pin/unpin.
> 
> > pin/unpin from exporter, invalidate from importer:
> > 
> > Full dynamic mapping. We assume the importer will do caching, attach
> > fences as needed, and pin the underlying bo when it needs it it
> > permanently, without attaching fences (i.e. the scanout case).
> > 
> > Assuming I'm not terribly off with my understanding, then I think it'd be
> > best to introduce the entire new dma-buf api in the first patch, and flesh
> > it out later. Instead of spread over a few patches. Plus the above (maybe
> > prettier) as a nice kerneldoc overview comment for how dynamic dma-buf is
> > supposed to work really.
> > -Daniel
> > 
> > > ---
> > >  drivers/dma-buf/dma-buf.c | 39 +++++++++++++++++++++++++++++++++++++++
> > >  include/linux/dma-buf.h   | 37 +++++++++++++++++++++++++++++++------
> > >  2 files changed, 70 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > > index a3738fab3927..f23ff8355505 100644
> > > --- a/drivers/dma-buf/dma-buf.c
> > > +++ b/drivers/dma-buf/dma-buf.c
> > > @@ -630,6 +630,41 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dma_buf_detach);
> > >  
> > > +/**
> > > + * dma_buf_pin - Lock down the DMA-buf
> > > + *
> > > + * @dmabuf:	[in]	DMA-buf to lock down.
> > > + *
> > > + * Returns:
> > > + * 0 on success, negative error code on failure.
> > > + */
> > > +int dma_buf_pin(struct dma_buf *dmabuf)
> 
> Hm, I think it'd be better to pin the attachment, not the underlying
> buffer. Attachment is the thin the importer will have to pin, and it's at
> attach/detach time where dma-buf needs to pin for importers who don't
> understand dynamic buffer sharing.
> 
> Plus when we put that onto attachments, we can do a
> 
> 	WARN_ON(!attach->invalidate);
> 
> sanity check. I think that would be good to have.

Another validation idea: dma-buf.c could track the pin_count on the struct
dma_buf, and if an exporter tries to invalidate while pinned WARN and bail
out. Because that's clearly a driver bug.

All in the interest in making the contract between importers and exporters
as clear as possible.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
