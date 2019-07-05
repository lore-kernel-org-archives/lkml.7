Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC7CC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14AA218C3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Lk1UmBN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfGEHXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 03:23:34 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35710 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfGEHXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 03:23:33 -0400
Received: by mail-ot1-f66.google.com with SMTP id j19so8164440otq.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 00:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A102i8j/c6lC5C01RSv3ody0ryOHoTnT6iUkJTeGXxw=;
        b=Lk1UmBN7ICE73lE35npciaG+9WxAHguzmvflVkEBKzAYUOlo1ybGrp75Ed7EvNgfhB
         p0DvLaQC9p0R7DT0H3pF/vc3kQKzA1qytRSKgvNkvNDo/hwHg2+Y01TKLtYoey8+P0G8
         QfuxWq+PEuu/IRkwDW1nVJJtivveWCalffjhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A102i8j/c6lC5C01RSv3ody0ryOHoTnT6iUkJTeGXxw=;
        b=OBoTmcvLUlvluMEwJbHRsEV1gTnMEPNfCxETYuxq7Nl8Q5syTyhfnhjVTP4faV1Z+k
         +pApPZxHv6Px0QoeBIq1Sdh1NKVEVt/WnNu5GLmlyFoRu4FbEBPqtDdp5G3bOUqluZNY
         kvCXz87Q8MTYjeS0ztiGGd6CjnSs/NXOEDA3jbBgJcFx4MEkTye9GxkamJGz3bNF8iTE
         LeqnRbQGGpyRapk+S/ccHgbE5msTmZ1zHiDI/CLeNwEjnbN0La8ZQIRf5Dg5jU9Cob02
         GMDlIWPn36gpbvdDnnVgpiJJyI+vj8ES5iEOOn/QEKoybuOczgaMs9iHOzjGpSr2XcF4
         nfhg==
X-Gm-Message-State: APjAAAVntFje+kDBzUYyy57tBWKy6KZ7Ezxu6A+RyZ21TeIbiR/SRyF/
        s+eV8alrfUTUpQlQHhilGWr8qPGByQhJymRMuqS5jQ==
X-Google-Smtp-Source: APXvYqzgvHheT+lruyLhCu/4NN9eSCAjyyerGjXWUlbQtWsp2jxpxYednQWNcCWai6V3HcEBV6tGKuqDmnJBKiX0WRU=
X-Received: by 2002:a05:6830:4b:: with SMTP id d11mr1692971otp.106.1562311412764;
 Fri, 05 Jul 2019 00:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <1562138723-29546-1-git-send-email-lowry.li@arm.com>
 <20190703100149.GF15868@phenom.ffwll.local> <20190704105653.GB9747@jamwan02-TSP300>
 <20190704154136.gib3puo7dzivnasu@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190704154136.gib3puo7dzivnasu@DESKTOP-E1NTVVP.localdomain>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 5 Jul 2019 09:23:20 +0200
Message-ID: <CAKMK7uF14_B8uJL+o_BnWvUMk3BBXRrr+aipK3A9mt+0v2W_4g@mail.gmail.com>
Subject: Re: [PATCH] drm/komeda: Adds VRR support
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        nd <nd@arm.com>, Ayan Halder <Ayan.Halder@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 5:41 PM Brian Starkey <Brian.Starkey@arm.com> wrote:
>
> Hi,
>
> On Thu, Jul 04, 2019 at 11:57:00AM +0100, james qian wang (Arm Technology China) wrote:
> > On Wed, Jul 03, 2019 at 12:01:49PM +0200, Daniel Vetter wrote:
> > >
> > > Uh, what exactly are you doing reinventing uapi properties that we already
> > > standardized?
> > >
> >
> > Sorry, Will use the mode_config->VRR_ENABLED
>
> Let's have a chat about what you're planning here. The upstream VRR
> properties aren't a direct match for our HW (which we discussed
> before) - so either we need to hide that in the kernel with some frame
> timing heuristics, or we shouldn't expose our feature via the existing
> properties.
>
> IMO, it's better for Komeda to just allow setting a new CRTC mode to
> one with a different VFP (but everything else the same) without a full
> modeset.
>
> You could try and implement the upstream VRR properties too - but you
> can get the functionality added by this patch without changing any
> UAPI.
>
> (Note the only reason we ever added the idea of passing in VFP by
> itself is because in ADF, modeset was a separate ioctl entirely, so we
> couldn't do it atomically)

If you want to see an example of how to do changes in the display mode
(like refresh rate, I have no idea what you mean with VFP, just
guessing) look at i915. We clear drm_crtc_state->mode_changed if it's
a mode change we can handle without a full modeset. That gives you
userspace-controlled variable refresh rate.

The VRR properties are for true VRR, i.e. the hw (with or without help
of the kernel) decides how long to make each vblank for every frame
individually, within certain limitats set by the monitor in its EDID
(or for panels maybe in DT).

> > we use this private property because we're switching to in-tree, before
> > finish the switch, we still need to maintain our out-of-tree driver which
> > depend on a older and doesn't have the VRR_ENABLED property. for avoid
> > diverging the two branch. my old plan is first switch to in-tree, then drop
> > the out-of-tree driver and then unify the usage.
> >
> > > > + if (!prop)
> > > > +         return -ENOMEM;
> > > > +
> > > > + drm_object_attach_property(&crtc->base, prop, 0);
> > > > + kcrtc->vrr_enable_property = prop;
> > > > +
> > > > + return 0;
> > > > +}
> > > > +
> > > >  static struct drm_plane *
> > > >  get_crtc_primary(struct komeda_kms_dev *kms, struct komeda_crtc *crtc)
> > > >  {
> > > > @@ -659,6 +717,10 @@ static int komeda_crtc_add(struct komeda_kms_dev *kms,
> > > >   if (err)
> > > >           return err;
> > > >
> > > > + err = komeda_crtc_create_vrr_property(kcrtc);
> > > > + if (err)
> > > > +         return err;
> > > > +
> > > >   return err;
> > > >  }
> > > >
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > > index dc1d436..d0cf838 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > > @@ -98,6 +98,12 @@ struct komeda_crtc {
> > > >
> > > >   /** @slave_planes_property: property for slaves of the planes */
> > > >   struct drm_property *slave_planes_property;
> > >
> > > And this seems to not be the first time this happened. Looking at komeda
> > > with a quick git grep on properties you've actually accumulated quite a
> > > pile of such driver properties already. Where's the userspace for this?
> > > Where's the uapi discussions for this stuff? Where's the igt tests for
> > > this (yes a bunch are after we agreed to have testcases for this).
> > >
> > > I know that in the past we've been somewhat sloppy properties, but that
> > > was a mistake and we've cranked down on this hard. Probably need to fix
> > > this with a pile of reverts and start over.
> > > -Daniel
> >
> > Sorry again.
> >
> > First I'll send some patches to remove these private properties.
> >
> > and then discuss for how to impelement them.
> >
> > The current komeda privates are:
> >
> > crtc:
> >    clock_ratio
> >    slave_planes
> >
> > plane:
> >    img_enhancement
> >    layer_split
> >
> > Layer_split: it can be deleted and computed in kernel.
> >
> > img_enhancement:
> >   it is for image enhancement, can be removed and computed in kernel.
> >   but I'd like to have it, since it's a seperated function (NOT only
> >   for scaling or YUV format), I think only user can real know if need
> >   to enable it.
> >
> >
> > img_enhancement:
> >   it is for image enhancement, can be removed and computed in kernel.
> >   but I'd like to have it, since it's a seperated function (NOT only
> >   for scaling or YUV format), I think only user can real know if need
> >   to enable it.
> >   I think maybe we can add it CORE as an optional drm_plane property.
>
> I really don't think we should be exposing this. It's purely there to
> help improve an image after scaling (effectively, sharpening). It's
> not a general purpose "image enhancer". Exposing a property which says
> "image enhancement" isn't useful to any application - what kind of
> enhancement is it doing?
>
> >
> > clock_ratio:
> >   It's the clock ratio of (main engine lock/output pixel clk) for
> >   komeda HW's downscaling restriction, as below:
> >
> >   D71 downscaling must satisfy the following equation
> >
> >   MCLK                   h_in * v_in
> >  ------- >= ---------------------------------------------
> >  PXLCLK     (h_total - (1 + 2 * v_in / v_out)) * v_out
> >
> >  In only horizontal downscaling situation, the right side should be
> >  multiplied by (h_total - 3) / (h_active - 3), then equation becomes
> >
> >   MCLK          h_in
> >  ------- >= ----------------
> >   PXLCLK     (h_active - 3)
> >
> > slave_planes:
> >   it's not only for the zpos, but most importantly for notify the user
> >   to group the planes to two resource sets (pipeline-0 resources and pipeline1).
> >   Per our HW design the two pipelines can be dynamic assigned to CRTC
> >   according to the usage.
> >   - like user only enable one CRTC which can use all two pipelines
> >     (two resource resource sets)
> >   - but if enabled two CRTCs, only one resource set available for
> >     each CRTC.
> >
> > komeda user need to known the clock_ratio and slave_planes, but how
> > to expose them: private_property, sysfs or other ways, seems we need
> > to disscuss. :)
>
> @Daniel,
>
> These two are a symptom of a fundamental impedance mismatch between
> how KMS works and actually making optimal use of HW (or: how Android
> works).
>
> HWComposer is expected to have good knowledge of how the underlying HW
> operates, so that it can effectively schedule a scene. "TEST_ONLY til
> it works" isn't a viable strategy, and it absolutely shouldn't be
> needed for a piece of code which has been written _specifically_ to
> drive komeda.
>
> It's acknowledged that HW-specific planners may be needed even in
> drm-hwcomposer, and those planners are going to need to get told some
> stuff about the HW. Whether that info should go through atomic
> properties or not is up for debate (adding properties without
> following the rules notwithstanding).
>
> What's certain is that debugfs is not workable, because it's not
> available in a production Android device (nor should it be).
>
> And of course, there's room for making the information more generic as
> far as possible, at which point they might be better candidates for
> DRM UAPI.

If you write a specific userspace, you can just hardcode assumptions
about what the kernel/hw can/cannot do. That's essentially what all
the gl drivers do between kernel/userspace: They just know what the
other side expects.

Wrt making this more generically useful as hints: I've shared a patch
series with Liviu about what I think should be done here instead:

https://cgit.freedesktop.org/~danvet/drm/log/?h=for-nashpa

Commit message each have a bunch of thoughts. But fundamentally atomic
is meant to be used together with TEST_ONLY and following hints from
the driver. So if you never want to use TEST_ONLY (it's only needed
for transitions, not for every frame) in your stack, then life is
going to be very painful indeed.
-Daniel

> Thanks,
> -Brian
>
> >
> > Thanks
> > James
> >
> > > > +
> > > > + /** @vrr_property: property for variable refresh rate */
> > > > + struct drm_property *vrr_property;
> > > > +
> > > > + /** @vrr_enable_property: property for enable/disable the vrr */
> > > > + struct drm_property *vrr_enable_property;
> > > >  };
> > > >
> > > >  /**
> > > > @@ -126,6 +132,12 @@ struct komeda_crtc_state {
> > > >
> > > >   /** @max_slave_zorder: the maximum of slave zorder */
> > > >   u32 max_slave_zorder;
> > > > +
> > > > + /** @vfp: the value of vertical front porch */
> > > > + u32 vfp;
> > > > +
> > > > + /** @en_vrr: enable status of variable refresh rate */
> > > > + u8 en_vrr : 1;
> > > >  };
> > > >
> > > >  /** struct komeda_kms_dev - for gather KMS related things */
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > index 00e8083..66d7664 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > @@ -336,7 +336,9 @@ struct komeda_improc_state {
> > > >  /* display timing controller */
> > > >  struct komeda_timing_ctrlr {
> > > >   struct komeda_component base;
> > > > - u8 supports_dual_link : 1;
> > > > + u8 supports_dual_link : 1,
> > > > +    supports_vrr : 1;
> > > > + struct malidp_range vfp_range;
> > > >  };
> > > >
> > > >  struct komeda_timing_ctrlr_state {
> > > > --
> > > > 1.9.1
> > > >
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
