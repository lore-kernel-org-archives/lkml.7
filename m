Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF0EC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4402073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="foIBsiTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733242AbfDQTFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:05:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37822 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730230AbfDQTFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:05:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id f53so20354362ede.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 12:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0YYVUyTp7bZJjOudIsM1eZKTNWjxCMbZjahz2HqT2DU=;
        b=foIBsiTN8kK5vCTsgGQlhPm2uC2Zk778sHRbMm8AFpJegEJuL8zg4DOPHPovE3pk5X
         8saCFgJRp6DYuebV5c2EvkhJlzWieZoVLbOIspm6gg/LfBKI26lZfDMWtcYoaXKzPBhG
         zg5FATJdpg2VpOk7CgyFVYLMPws/t82nrpU4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=0YYVUyTp7bZJjOudIsM1eZKTNWjxCMbZjahz2HqT2DU=;
        b=l6PDFoFpR0aLQEq7KFxPBE2lOKetlxgVlOVcw1sa42uLKiNyNibiOxcBaynMekrft7
         WuaeazmTTZ69E8jJ9vqrDYgljIcgoVgixEUWTNz8GzToPWUl4BAalzoK0NjTQT2ET0xg
         cTKKeEcQNZ0SnujkSGZwS5OU4CAZVH8Tnc5QxMd26ETGVTkSCdb3k1hCkZ08zmEt5pp9
         LWneCrtjIfZWXrAqNa8gVCNjm5JNXpyp6Fspvo1ESXueqlYK8n1rvPIDoU5DbMQisMA/
         Jd8QNgrze7ann7cbCRscLNucboKmhn7ZK7bvqsI3Tcf+naonfC/4odeW1ZfwbGowyGTG
         q0OA==
X-Gm-Message-State: APjAAAWvmzQz9eBUdqnhegAafr8F8tI6xECtqk1Ev2GSFDUL0pXAew68
        4mlc5+4PF2CLjf3MCMVfSVMtSg==
X-Google-Smtp-Source: APXvYqzPSB3W5793s9LfSNedfU+GFog62qzl23SjtskIFvtYVAqFS7oeH8LKfLtPQmuosj/qbeicpw==
X-Received: by 2002:a50:ac02:: with SMTP id v2mr30309461edc.86.1555527949052;
        Wed, 17 Apr 2019 12:05:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e9sm10245062ejl.14.2019.04.17.12.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 12:05:48 -0700 (PDT)
Date:   Wed, 17 Apr 2019 21:05:46 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, sumit.semwal@linaro.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 05/12] dma-buf: add explicit buffer pinning
Message-ID: <20190417190546.GK13337@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <20190416183841.1577-6-christian.koenig@amd.com>
 <20190417142002.GE13337@phenom.ffwll.local>
 <20190417143051.GG13337@phenom.ffwll.local>
 <20190417144011.GI13337@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190417144011.GI13337@phenom.ffwll.local>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:40:11PM +0200, Daniel Vetter wrote:
> On Wed, Apr 17, 2019 at 04:30:51PM +0200, Daniel Vetter wrote:
> > On Wed, Apr 17, 2019 at 04:20:02PM +0200, Daniel Vetter wrote:
> > > On Tue, Apr 16, 2019 at 08:38:34PM +0200, Christian König wrote:
> > > > Add optional explicit pinning callbacks instead of implicitly assume the
> > > > exporter pins the buffer when a mapping is created.
> > > > 
> > > > Signed-off-by: Christian König <christian.koenig@amd.com>
> > > 
> > > Don't we need this together with the invalidate callback and the dynamic
> > > stuff? Also I'm assuming that pin/unpin is pretty much required for
> > > dynamic bo, so could we look at these callbacks instead of the dynamic
> > > flag you add in patch 1.
> > > 
> > > I'm assuming following rules hold:
> > > no pin/upin from exporter:
> > > 
> > > dma-buf is not dynamic, and pinned for the duration of map/unmap. I'm
> > > not 100% sure whether really everyone wants the mapping to be cached for
> > > the entire attachment, only drm_prime does that. And that's not the only
> > > dma-buf importer.
> > > 
> > > pin/unpin calls are noops.
> > > 
> > > pin/unpin exist in the exporter, but importer has not provided an
> > > invalidate callback:
> > > 
> > > We map at attach time, and we also have to pin, since the importer can't
> > > handle the buffer disappearing, at attach time. We unmap/unpin at detach.
> > 
> > For this case we should have a WARN in pin/unpin, to make sure importers
> > don't do something stupid. One more thought below on pin/unpin.

btw just realized that you already have the pin/unpin here. I think even
more reasons to squash the invalidate/pin bits together, since they
don't really work separately.
-Daniel

> > 
> > > pin/unpin from exporter, invalidate from importer:
> > > 
> > > Full dynamic mapping. We assume the importer will do caching, attach
> > > fences as needed, and pin the underlying bo when it needs it it
> > > permanently, without attaching fences (i.e. the scanout case).
> > > 
> > > Assuming I'm not terribly off with my understanding, then I think it'd be
> > > best to introduce the entire new dma-buf api in the first patch, and flesh
> > > it out later. Instead of spread over a few patches. Plus the above (maybe
> > > prettier) as a nice kerneldoc overview comment for how dynamic dma-buf is
> > > supposed to work really.
> > > -Daniel
> > > 
> > > > ---
> > > >  drivers/dma-buf/dma-buf.c | 39 +++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/dma-buf.h   | 37 +++++++++++++++++++++++++++++++------
> > > >  2 files changed, 70 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > > > index a3738fab3927..f23ff8355505 100644
> > > > --- a/drivers/dma-buf/dma-buf.c
> > > > +++ b/drivers/dma-buf/dma-buf.c
> > > > @@ -630,6 +630,41 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dma_buf_detach);
> > > >  
> > > > +/**
> > > > + * dma_buf_pin - Lock down the DMA-buf
> > > > + *
> > > > + * @dmabuf:	[in]	DMA-buf to lock down.
> > > > + *
> > > > + * Returns:
> > > > + * 0 on success, negative error code on failure.
> > > > + */
> > > > +int dma_buf_pin(struct dma_buf *dmabuf)
> > 
> > Hm, I think it'd be better to pin the attachment, not the underlying
> > buffer. Attachment is the thin the importer will have to pin, and it's at
> > attach/detach time where dma-buf needs to pin for importers who don't
> > understand dynamic buffer sharing.
> > 
> > Plus when we put that onto attachments, we can do a
> > 
> > 	WARN_ON(!attach->invalidate);
> > 
> > sanity check. I think that would be good to have.
> 
> Another validation idea: dma-buf.c could track the pin_count on the struct
> dma_buf, and if an exporter tries to invalidate while pinned WARN and bail
> out. Because that's clearly a driver bug.
> 
> All in the interest in making the contract between importers and exporters
> as clear as possible.
> -Daniel
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
