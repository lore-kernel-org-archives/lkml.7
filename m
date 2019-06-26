Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3C7C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766BE2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ATxugIl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfFZOaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:30:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42124 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfFZOa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:30:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id z25so3642704edq.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oycxIMhWeOjgRZ0/QzcUw1Wm4NjGiCorky0TzSRYEqE=;
        b=ATxugIl2SCaT9srbmP+Rni5GHifDKlPGbXR7cYJH8NZJPoLZdG+YoE+KGlga5ijBjN
         0IaYYsPbZbhlbZ+tgs7ixOM0KKMv+5E5aECiVHH+fBYMy1syTxMjneNp9IDNlk7a/jbe
         M++g+/H/ce1vcxRfKzoZWLaBkn7ISoij6+edI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oycxIMhWeOjgRZ0/QzcUw1Wm4NjGiCorky0TzSRYEqE=;
        b=fqtp5kKhnsm4QoZ076fQSrHaM/h00cKv6Dpxv7iTXLEdAyd/WLZZBKmOcMTyjz/8Ju
         qqY07czqMzP7GUNetl3X8iWtXnl/JG/dc20CoAeSycEuYRorslr+UMCIh3V33ym0mcMp
         uj0imyDFUne5Y86JFyBJ8B++ph92dpqLEMyey7N0dPKsJJ0L0m0euTy5CR1FP4hJHLy3
         6ameplSw9bz6nXAczvBKgGs2LY+35oWbsy8P7cuHt+yE8CSI3RYNnZdpb4xnNmvuA6wB
         bxyGEaXLo/V4PFeiQbxLwL8QLSkWbQKWSWd9fLno0+9k20IjxkIKtif5Ky6iTtMddOrj
         T2JQ==
X-Gm-Message-State: APjAAAUdC3L+pLn6IT0+9NJa11uWeCyjAlHpFX80dGfI7yTeLfdXIvsY
        j4Hg8M7b9eeEkjfVy8yOdAu/Cw==
X-Google-Smtp-Source: APXvYqzNFt6g8HxgwDJyHbLTfRt/7BCAd97Ph8ib/VE+AghliKNlIAXkR9U7cf7MH6mNrMRncjwmSA==
X-Received: by 2002:a05:6402:2cb:: with SMTP id b11mr5612295edx.281.1561559427848;
        Wed, 26 Jun 2019 07:30:27 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j10sm3037251ejk.23.2019.06.26.07.30.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 07:30:27 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:30:25 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Robert Beckett <bob.beckett@collabora.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] drm/vblank: estimate vblank while disabling
 vblank if interrupt disabled
Message-ID: <20190626143025.GN12905@phenom.ffwll.local>
Mail-Followup-To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <cover.1561483965.git.bob.beckett@collabora.com>
 <b96132cef4b63118df1026a99b3c345692e3de26.1561483965.git.bob.beckett@collabora.com>
 <20190626132732.GP5942@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190626132732.GP5942@intel.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 04:27:32PM +0300, Ville Syrjälä wrote:
> On Tue, Jun 25, 2019 at 06:59:14PM +0100, Robert Beckett wrote:
> > If interrupts are disabled (e.g. via vblank_disable_fn) and we come to
> > disable vblank, update the vblank count to best guess as to what it
> > would be had the interrupts remained enabled, and update the timesamp to
> > now.
> > 
> > This avoids a stale vblank event being sent while disabling crtcs during
> > atomic modeset.
> > 
> > Fixes: 68036b08b91bc ("drm/vblank: Do not update vblank count if interrupts
> > are already disabled.")
> 
> I don't understand that commit. drm_vblank_off() should be called
> when the power is still present, so it looks to me like that
> commit is actually wrong. So I think we may want to just revert
> it and figure out what the actual bug was.

Hm yeah we might need a power domain get/put around our
drm_crtc_vblank_off() call to make sure it dtrt. Revert sounds like a good
idea instead of adding more kludges ... a-b: me on the revert, even though
I did ack the original patch too.
-Daniel

> 
> > 
> > Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> > ---
> >  drivers/gpu/drm/drm_vblank.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> > index 7dabb2bdb733..db68b8cbf797 100644
> > --- a/drivers/gpu/drm/drm_vblank.c
> > +++ b/drivers/gpu/drm/drm_vblank.c
> > @@ -375,9 +375,23 @@ void drm_vblank_disable_and_save(struct drm_device *dev, unsigned int pipe)
> >  	 * interrupts were enabled. This avoids calling the ->disable_vblank()
> >  	 * operation in atomic context with the hardware potentially runtime
> >  	 * suspended.
> > +	 * If interrupts are disabled (e.g. via blank_disable_fn) then make
> > +	 * best guess as to what it would be now and make sure we have an up
> > +	 * to date timestamp.
> >  	 */
> > -	if (!vblank->enabled)
> > +	if (!vblank->enabled) {
> > +		ktime_t now = ktime_get();
> > +		u32 diff = 0;
> > +		if (vblank->framedur_ns) {
> > +			u64 diff_ns = ktime_to_ns(ktime_sub(now, vblank->time));
> > +			diff = DIV_ROUND_CLOSEST_ULL(diff_ns,
> > +						     vblank->framedur_ns);
> > +		}
> > +
> > +		store_vblank(dev, pipe, diff, now, vblank->count);
> > +
> >  		goto out;
> > +	}
> >  
> >  	/*
> >  	 * Update the count and timestamp to maintain the
> > -- 
> > 2.18.0
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Ville Syrjälä
> Intel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
