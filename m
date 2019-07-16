Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42798C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C7C206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="H3xiEqss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbfGPIhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 04:37:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40606 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfGPIhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:37:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so18693584eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 01:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Lu9sRd1aI6UIpjDrZ2p4aWEktj3PaeleYO2nmBnUknY=;
        b=H3xiEqssY10pUNcLjsNxN9Rm4cfC3DQa/eWlOx+z0RLGOkodG/TlgyFHhyh+243WbJ
         K3YHlWKFg1ekYU1GAYI9rd/+yFgfLvc9CO3Pwb8aYVHxukJx61QkEPz2EL3ivkEqxj2S
         YekSvQpVQ+F4sCLlYsDvgdEfHlSm9ww8S9q0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Lu9sRd1aI6UIpjDrZ2p4aWEktj3PaeleYO2nmBnUknY=;
        b=ZIgh24baSWEV8d/QqphS3+ThtH1VrGS0y6gW/FYDdy6UbL8Isikmu3EhWsp4TQ1f99
         ivw+L6QU7qRwyUaVz8YUDOecpbSV9mLwJUP8AwyyvdfY8CN4tTLJAJ6g6kvt4fGfsh36
         p0U+m/uO0iPfZgnZZn1FB7T8qicv/0y7r5x19u8aTdjZ9jj9L0ArmPWrUYNR5XSAWGZ2
         nwLMARjgK+AQvTFqQYAMmB5wTNhUgOXfdJ1fysFSVJvBZ8N3a7fb3LUACN2MLeX0F8Dk
         KV9r/2KXr+X9m9r+NHXFY3OVfIJTROTsDT3pxJVFLr4YHZzJnxAmRHeBENSQQBSU5JuN
         OBLA==
X-Gm-Message-State: APjAAAVpO6flh6x85WnoF+f2+mN7o4xSuym5iT+Yphsf5xrP8G30F01F
        UKwpspZpK+3U1zVaF8ztM+c=
X-Google-Smtp-Source: APXvYqyvJpRvDIT8BzwNR3Iq4s2IMaXRfjqLdxv4drE3X09YwMDQ8fieRUmatyVZSZ3+E01AJkaxtw==
X-Received: by 2002:a17:906:edcb:: with SMTP id sb11mr24525752ejb.260.1563266239018;
        Tue, 16 Jul 2019 01:37:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id m25sm4283382ejs.85.2019.07.16.01.37.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 01:37:17 -0700 (PDT)
Date:   Tue, 16 Jul 2019 10:37:15 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/5] drm/vkms: Compute CRC without change input data
Message-ID: <20190716083715.GT15868@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
 <ea7e3a0daa4ee502d8ec67a010120d53f88fa06b.1561491964.git.rodrigosiqueiramelo@gmail.com>
 <20190711082105.GI15868@phenom.ffwll.local>
 <20190712031449.3pmeimkcde2hrxxh@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190712031449.3pmeimkcde2hrxxh@smtp.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 12:14:49AM -0300, Rodrigo Siqueira wrote:
> On 07/11, Daniel Vetter wrote:
> > On Tue, Jun 25, 2019 at 10:38:31PM -0300, Rodrigo Siqueira wrote:
> > > The compute_crc() function is responsible for calculating the
> > > framebuffer CRC value; due to the XRGB format, this function has to
> > > ignore the alpha channel during the CRC computation. Therefore,
> > > compute_crc() set zero to the alpha channel directly in the input
> > > framebuffer, which is not a problem since this function receives a copy
> > > of the original buffer. However, if we want to use this function in a
> > > context without a buffer copy, it will change the initial value. This
> > > patch makes compute_crc() calculate the CRC value without modifying the
> > > input framebuffer.
> > 
> > Uh why? For writeback we're writing the output too, so we can write
> > whatever we want to into the alpha channel. For writeback we should never
> > accept a pixel format where alpha actually matters, that doesn't make
> > sense. You can't see through a real screen either, they are all opaque :-)
> > -Daniel
> 
> Hmmm,
> 
> I see your point and I agree, but even though we can write whatever we
> want in the output, don’t you think that is weird to change the
> framebuffer value in the compute_crc() function?

Not sure what you mean here ... ? From a quick look the memset only sets
our temporary buffer, so we're not changing the input framebuffer here.
And we have to somehow get rid of the X bits, since there's no alpha
value. For CRC computation, all we need is some value which is the same
for every frame (so that the CRC stays constant for the same visible
output). For writeback we could write whatever we want (which includes
whatever is there already). But there's no guarantee and definitely no
expectation that the X bits survive. Writing 0 is imo the most reasonable
thing to do. I'm not even sure whether modern gpus can still do channel
masking (i.e. only write out specific channels, instead of the entire
color). That was a "feature" of bitop blitters of the 80s/90s :-)
-Daniel

> 
> Thanks
>  
> > > 
> > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > ---
> > >  drivers/gpu/drm/vkms/vkms_composer.c | 31 +++++++++++++++++-----------
> > >  1 file changed, 19 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> > > index 51a270514219..8126aa0f968f 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> > > @@ -6,33 +6,40 @@
> > >  #include <drm/drm_atomic_helper.h>
> > >  #include <drm/drm_gem_framebuffer_helper.h>
> > >  
> > > +static u32 get_pixel_from_buffer(int x, int y, const u8 *buffer,
> > > +				 const struct vkms_composer *composer)
> > > +{
> > > +	int src_offset = composer->offset + (y * composer->pitch)
> > > +					  + (x * composer->cpp);
> > > +
> > > +	return *(u32 *)&buffer[src_offset];
> > > +}
> > > +
> > >  /**
> > >   * compute_crc - Compute CRC value on output frame
> > >   *
> > > - * @vaddr_out: address to final framebuffer
> > > + * @vaddr: address to final framebuffer
> > >   * @composer: framebuffer's metadata
> > >   *
> > >   * returns CRC value computed using crc32 on the visible portion of
> > >   * the final framebuffer at vaddr_out
> > >   */
> > > -static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
> > > +static uint32_t compute_crc(const u8 *vaddr,
> > > +			    const struct vkms_composer *composer)
> > >  {
> > > -	int i, j, src_offset;
> > > +	int x, y;
> > >  	int x_src = composer->src.x1 >> 16;
> > >  	int y_src = composer->src.y1 >> 16;
> > >  	int h_src = drm_rect_height(&composer->src) >> 16;
> > >  	int w_src = drm_rect_width(&composer->src) >> 16;
> > > -	u32 crc = 0;
> > > +	u32 crc = 0, pixel = 0;
> > >  
> > > -	for (i = y_src; i < y_src + h_src; ++i) {
> > > -		for (j = x_src; j < x_src + w_src; ++j) {
> > > -			src_offset = composer->offset
> > > -				     + (i * composer->pitch)
> > > -				     + (j * composer->cpp);
> > > +	for (y = y_src; y < y_src + h_src; ++y) {
> > > +		for (x = x_src; x < x_src + w_src; ++x) {
> > >  			/* XRGB format ignores Alpha channel */
> > > -			memset(vaddr_out + src_offset + 24, 0,  8);
> > > -			crc = crc32_le(crc, vaddr_out + src_offset,
> > > -				       sizeof(u32));
> > > +			pixel = get_pixel_from_buffer(x, y, vaddr, composer);
> > > +			bitmap_clear((void *)&pixel, 0, 8);
> > > +			crc = crc32_le(crc, (void *)&pixel, sizeof(u32));
> > >  		}
> > >  	}
> > >  
> > > -- 
> > > 2.21.0
> > 
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> 
> -- 
> Rodrigo Siqueira
> https://siqueira.tech



> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
