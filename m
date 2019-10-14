Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974D3C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5664E2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FVKPK+Fc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfJNIpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:45:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38056 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbfJNIpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:45:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id l21so14093018edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 01:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qfgrbYH1+Qt6+4oZT3BPWRVcTmbUQJZWhnOi/NpBY/4=;
        b=FVKPK+Fc3WT2iladk3fxhpqANtN8IWklmkrylPuR/vKDuX04/NiuzR5mDdRCcufjoM
         g/pwRVuRLc0GLqQcnnBg+lWu/WTSrzZovsRQtzQbjm3HZwp5JF098kLwpJGXb52o5wEs
         x0AYnJu4yuMIOT/n+l5F+OSNJTUoDT0zJfMM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qfgrbYH1+Qt6+4oZT3BPWRVcTmbUQJZWhnOi/NpBY/4=;
        b=I2hmT5U8JDh5RVKtTNPYJ2i/a2nseWGj9UOWOpjallUcWRQPZ/xBYxieWIKbvkEIo+
         Jus24Xlw5yRgpt5KunSL5XJDL2t5CnyAsX3gCBbmS4NedWRMTJAS+hZyXI9KLMksEvPb
         0ecmWpWFT42zwFzuAnCA/UcGLjKchFVaSbRHHME9cf4dfgZXflQPxQqP2C/AWBTAIKvx
         MOy4YjDlO9MyPXTidEZwTsjGUfyD0YfYn918tD60Nx6HVZ97fVtGPpR8wlt7sE4I69mI
         8iT1X2lEPndiDP0Qt63kxPvhTmnsZ+MiJiA7WXJ7ci5yJUAZU2g4CYPAZopxMLdVVCel
         Ly7g==
X-Gm-Message-State: APjAAAXPShdUcimdkwC7zRXJYM83js2CWctiYXhH4j/xGWg6I370tpgH
        ScNH9oLTDObIdNHB6YVXp/8Uag==
X-Google-Smtp-Source: APXvYqxMYI9P+ELFrNEs6vU+Obg/0CR90yO1CX8yikQurVmanWbIPtM+hfjhnpszkt+MYSlR3cHx8A==
X-Received: by 2002:a50:f296:: with SMTP id f22mr27071657edm.69.1571042750453;
        Mon, 14 Oct 2019 01:45:50 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id q9sm2233587eja.31.2019.10.14.01.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 01:45:49 -0700 (PDT)
Date:   Mon, 14 Oct 2019 10:45:47 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        amd-gfx@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] drm/amdgpu/dm/mst: Report possible_crtcs
 incorrectly, for now
Message-ID: <20191014084547.GC11828@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        Sean Paul <sean@poorly.run>, amd-gfx@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190926225122.31455-1-lyude@redhat.com>
 <20190926225122.31455-6-lyude@redhat.com>
 <20190927152741.GU218215@art_vandelay>
 <20191009150155.GD16989@phenom.ffwll.local>
 <2d813b2fdf39756ebee087d97f9ee4b2965f4193.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d813b2fdf39756ebee087d97f9ee4b2965f4193.camel@redhat.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 04:51:13PM -0400, Lyude Paul wrote:
> a little late but: i915 does have this hack (or rather-possible_crtcs with MST
> in i915 has been broken for a while and got fixed, but had to get reverted
> because of this issue), it's where this originally came from.

Hm since this is widespread I think we should check for this when we
register connectors (either in drm_dev_register, or hotplugged ones). I
think just validating that all encoder->possible_crtc match and WARN_ON if
not would be really good.

2nd option would be to do that in the GETENCODERS ioctl. That would at
least keep the encoders useful for driver-internal stuff. We could then
un-revert the i915 patch again.

Either way I think we should have this hack + comment with links to the
offending userspace in common code, not duplicated over all drivers.
-Daniel

> 
> On Wed, 2019-10-09 at 17:01 +0200, Daniel Vetter wrote:
> > On Fri, Sep 27, 2019 at 11:27:41AM -0400, Sean Paul wrote:
> > > On Thu, Sep 26, 2019 at 06:51:07PM -0400, Lyude Paul wrote:
> > > > This commit is seperate from the previous one to make it easier to
> > > > revert in the future. Basically, there's multiple userspace applications
> > > > that interpret possible_crtcs very wrong:
> > > > 
> > > > https://gitlab.freedesktop.org/xorg/xserver/merge_requests/277
> > > > https://gitlab.gnome.org/GNOME/mutter/issues/759
> > > > 
> > > > While work is ongoing to fix these issues in userspace, we need to
> > > > report ->possible_crtcs incorrectly for now in order to avoid
> > > > introducing a regression in in userspace. Once these issues get fixed,
> > > > this commit should be reverted.
> > > > 
> > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > index b404f1ae6df7..fe8ac801d7a5 100644
> > > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > @@ -4807,6 +4807,17 @@ static int amdgpu_dm_crtc_init(struct
> > > > amdgpu_display_manager *dm,
> > > >  	if (!acrtc->mst_encoder)
> > > >  		goto fail;
> > > >  
> > > > +	/*
> > > > +	 * FIXME: This is a hack to workaround the following issues:
> > > > +	 *
> > > > +	 * https://gitlab.gnome.org/GNOME/mutter/issues/759
> > > > +	 * https://gitlab.freedesktop.org/xorg/xserver/merge_requests/277
> > > > +	 *
> > > > +	 * One these issues are closed, this should be removed
> > > 
> > > Even when these issues are closed, we'll still be introducing a regression
> > > if we
> > > revert this change. Time for actually_possible_crtcs? :)
> > > 
> > > You also might want to briefly explain the u/s bug in case the links go
> > > sour.
> > > 
> > > > +	 */
> > > > +	acrtc->mst_encoder->base.possible_crtcs =
> > > > +		amdgpu_dm_get_encoder_crtc_mask(dm->adev);
> > > 
> > > Why don't we put this hack in amdgpu_dm_dp_create_fake_mst_encoder()?
> > 
> > If we don't have the same hack for i915 mst I think we shouldn't merge
> > this ... broken userspace is broken.
> > -Daniel
> -- 
> Cheers,
> 	Lyude Paul
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
