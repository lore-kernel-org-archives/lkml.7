Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0320EC17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AC2214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dcPr62mx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389486AbfKEOXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:23:36 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45304 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389083AbfKEOXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:23:36 -0500
Received: by mail-oi1-f193.google.com with SMTP id k2so17623586oij.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 06:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vTc6z+lgbpPBjZDtFGHC/pl1LyGpmoK3Uy/7NRsdhrs=;
        b=dcPr62mxBXZmcl6httqeRjrv4xT+/8IkFeBiDSTGZ1Es2ydCPN+zkb6QaywBbbVZbj
         sV/86d5EbkceY1NJnUZk3avQ/xyPx3GeYWZ3HRHB6leK5FQCcvzHXAiGSGsUYdtbjiI9
         d4NTWqZgZsSAeq0QOsgV1ye1m1AAx4eEc5YXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTc6z+lgbpPBjZDtFGHC/pl1LyGpmoK3Uy/7NRsdhrs=;
        b=VyLwdLiYLO2azXg67Yp8kuAMzjBqqCUd2zU8OixKtVUwBdk+ENQd3qdGZ+uJ+Eyj9M
         98aYnclDtkOTvJfjdg1BwZAOigrWmMBOBwVNCP7ZlwqLeQmcbx57x1tczvRUAj+8aiuA
         wb1MYfNifpENplvLTCiWiljVoI8C8DtEm0ExukzgqxeEic3pcTUshpYEGyRbPBe+9kCt
         QUYX4Z40SO6I19zFoohGB7qQkU7Zjuwo/SX/VwDgHA787YgDvnCcp2Qu1gpvoODE7JnR
         dlhh3Oog4ygijVDuAr7yMSOqZKX1bFubSeBHJvRoNM3pLy3fMhCBrrHwzfxKugWWcWCj
         SQog==
X-Gm-Message-State: APjAAAVoBNWSiftibkyqAmi6k9qRGqBCPeqG1NrXF44ygMg6AqmHbQRt
        BjSrR2sWyMBzTY8GpKzzAz9VNr/ES4TaTGQ5JWEwPQ==
X-Google-Smtp-Source: APXvYqzyGMsBwNgz8Yo9yz9NA9TlXtEthoaSm0QC9OJYYjpBBuvwn1HXh+yOGJm6cJzfKN1iQtI9fw/GMEVDucwtfEg=
X-Received: by 2002:a54:4e8a:: with SMTP id c10mr4246893oiy.14.1572963815067;
 Tue, 05 Nov 2019 06:23:35 -0800 (PST)
MIME-Version: 1.0
References: <951eb7dc-bebe-5049-4998-f199e18b0bf3@canonical.com>
 <20191009163235.GT16989@phenom.ffwll.local> <a0d5f3a3-a2b3-5367-42f9-bde514571e25@amd.com>
 <CAKMK7uEtJRDhibWDv2TB2WrFzFooMWPSbveDD2N-rudAwvzVFA@mail.gmail.com>
 <c8f96b46-e81e-1e41-aafc-5f6ec236d66f@amd.com> <CAKMK7uHr3aeJRqJAscDDfsuBBnVXCeN9SS36-1UGuK84NyOD5Q@mail.gmail.com>
 <CAKMK7uH6EoY9MkzjSjU+Fe=E-XB4Tf9d2VsW=Tr=tFy1J-dJgg@mail.gmail.com>
 <53bf910b-5f9c-946b-17ee-602c24c0fa96@amd.com> <20191104165457.GH10326@phenom.ffwll.local>
 <CADnq5_PxMQ_AkBCHXU_YUAMWaPcH-nkOJNGNKnUOJWSTYV6X+A@mail.gmail.com>
 <20191104172434.GJ10326@phenom.ffwll.local> <CADnq5_NUAfeWscsnj07MpReM3LNwHPSPq3pQDe0waMi4OCatUg@mail.gmail.com>
 <CAKMK7uGPuYcPf+e_AL1PrH8Croydg3JcBNORCNAFgj4E72EtZQ@mail.gmail.com> <75a77843-7c2d-9e74-b508-5df000a9b646@amd.com>
In-Reply-To: <75a77843-7c2d-9e74-b508-5df000a9b646@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 5 Nov 2019 15:23:23 +0100
Message-ID: <CAKMK7uHkARNtvjrqcjzayVGkrCTOt4tQyaZ=_g+4Ljwex8xV3A@mail.gmail.com>
Subject: Re: drm/amd/display: Add HDCP module - static analysis bug report
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 3:17 PM Harry Wentland <hwentlan@amd.com> wrote:
>
>
>
> On 2019-11-05 8:14 a.m., Daniel Vetter wrote:
> > On Tue, Nov 5, 2019 at 1:52 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >>
> >> On Mon, Nov 4, 2019 at 12:24 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >>>
> >>> On Mon, Nov 04, 2019 at 12:05:40PM -0500, Alex Deucher wrote:
> >>>> On Mon, Nov 4, 2019 at 11:55 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >>>>>
> >>>>> On Mon, Nov 04, 2019 at 03:23:09PM +0000, Harry Wentland wrote:
> >>>>>> On 2019-11-04 5:53 a.m., Daniel Vetter wrote:
> >>>>>>> On Wed, Oct 9, 2019 at 10:58 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >>>>>>>> On Wed, Oct 9, 2019 at 10:46 PM Lakha, Bhawanpreet
> >>>>>>>> <Bhawanpreet.Lakha@amd.com> wrote:
> >>>>>>>>>
> >>>>>>>>> I misunderstood and was talking about the ksv validation specifically
> >>>>>>>>> (usage of drm_hdcp_check_ksvs_revoked()).
> >>>>>>>>
> >>>>>>>> Hm for that specifically I think you want to do both, i.e. both
> >>>>>>>> consult your psp, but also check for revoked ksvs with the core
> >>>>>>>> helper. At least on some platforms only the core helper might have the
> >>>>>>>> updated revoke list.
> >>>>>>>>
> >>>>>>
> >>>>>> I think it's an either/or. Either we use an HDCP implementation that's
> >>>>>> fully running in x86 kernel space (still not sure how that's compliant)
> >>>>>> or we fully rely on our PSP FW to do what it's designed to do. I don't
> >>>>>> think it makes sense to mix and match here.
> >>>>>
> >>>>> Then you need to somehow tie the revoke list that's in the psp to the
> >>>>> revoke list update logic we have. That's what we've done for hdcp2 (which
> >>>>> is similarly to yours implemented in hw). The point is that on linux we
> >>>>> now have a standard way to get these revoke lists updated/handled.
> >>>>>
> >>>>> I guess it wasn't clear how exactly I think you're supposed to combine
> >>>>> them?
> >>>>
> >>>> There's no driver sw required at all for our implementation and as far
> >>>> as I know, HDCP 2.x requires that all of the key revoke handling be
> >>>> handled in a secure processor rather than than on the host processor,
> >>>> so I'm not sure how we make use if it.  All the driver sw is
> >>>> responsible for doing is saving/restoring the potentially updated srm
> >>>> at suspend/resume/etc.
> >>>
> >>> Uh, you don't have a permanent store on the chip? I thought another
> >>> requirement is that you can't downgrade.
> >>
> >> Right.  That's why the driver has to save and restore the srm when the
> >> GPU is powered down.  I guess that part can be done by the host
> >> processor as long as the srm is signed properly.
> >>
> >>>
> >>> And for hw solutions all you do with the updated revoke cert is stuff it
> >>> into the hw, it's purely for updating it. And those updates need to come
> >>> from somewhere else (usually in the media you play), the kernel can't
> >>> fetch them over the internet itself. I thought we already had the function
> >>> to give you the srm directly so you can stuff it into the hw, but looks
> >>> like that part isn't there (yet).
> >>
> >> IIRC, the revoke stuff gets gleaned from the stream by the secure
> >> processor somehow when you play back secure content.  I'm not entirely
> >> clear on the details, but from the design, the driver doesn't have to
> >> do anything in our case other than saving and restoring the srm from
> >> the secure processor.
> >
> > Hm, is that implemented in open userspace somewhere? tbh I don't know
> > whether the srm is in the bitstream or somewhere else in the file
> > (they're all containers with lots of stuff), but the current upstream
> > hdcp stuff is done under the assumption that userspace still does the
> > decrypting (so only the lowest content protection level supported
> > right now). Hence the explicit step to update the kernel on the latest
> > srm, which the kernel can then use to either check for revokes or hand
> > to the hardware.
> > -Daniel
> >
>
> Not sure I follow your questions about whether this is implemented in
> open userspace.
>
> The SRM is provided to PSP (our secure processor) through other
> interfaces. I'm currently not sure whether that's directly from the
> bitstream or another interface from the secure userspace that's handling
> content protection (e.g. OEMCrypto or similar).

Well if the full thing needs the blob (otherwise how do you get at the
SRM), then the blob needs to be open, or we need something else.

> The key for HDCP SRM handling is that PSP doesn't have a permanent store
> on the chip and needs us to handle the save and restore at
> boot/shutdown/suspend/resume. Think of it as an initialization and
> teardown step of PSP.
>
> The idea is to provide an amdgpu device-specific sysfs that's used to
> save/restore the SRM without any handling in the kernel (unlike the work
> done by Ramalingam to do the revocation check in DRM). This sysfs will
> be called by a simple init script to store and read the SRM from disk.

Uh that's what I meant, now we'll end up with 2 ways to handle the
SRM. We already have a drm core interface to upload the SRM from disk,
please use that one, not invent a new one. Yes you need to add 1 tiny
function to drm_hdcp.c to get at the raw srm instead of checking for a
revoked ksv.
-Daniel

>
> Harry
>
> >> Alex
> >>
> >>> -Daniel
> >>>
> >>>>
> >>>> Alex
> >>>>
> >>>>> -Daniel
> >>>>>
> >>>>>
> >>>>>>
> >>>>>>>>> For the defines I will create patches to use drm_hdcp where it is usable.
> >>>>>>>>
> >>>>>>>> Thanks a lot. Ime once we have shared definitions it's much easier to
> >>>>>>>> also share some helpers, where it makes sense.
> >>>>>>>>
> >>>>>>>> Aside I think the hdcp code could also use a bit of demidlayering. At
> >>>>>>>> least I'm not understanding why you add a 2nd abstraction layer for
> >>>>>>>> i2c/dpcd, dm_helper already has that. That seems like one abstraction
> >>>>>>>> layer too much.
> >>>>>>>
> >>>>>>> I haven't seen anything fly by or in the latest pull request ... you
> >>>>>>> folks still working on this or more put on the "maybe, probably never"
> >>>>>>> pile?
> >>>>>>>
> >>>>>>
> >>>>>> Following up with Bhawan.
> >>>>>>
> >>>>>> Harry
> >>>>>>
> >>>>>>> -Daniel
> >>>>>>>
> >>>>>>>
> >>>>>>>> -Daniel
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Bhawan
> >>>>>>>>>
> >>>>>>>>> On 2019-10-09 2:43 p.m., Daniel Vetter wrote:
> >>>>>>>>>> On Wed, Oct 9, 2019 at 8:23 PM Lakha, Bhawanpreet
> >>>>>>>>>> <Bhawanpreet.Lakha@amd.com> wrote:
> >>>>>>>>>>> Hi,
> >>>>>>>>>>>
> >>>>>>>>>>> The reason we don't use drm_hdcp is because our policy is to do hdcp
> >>>>>>>>>>> verification using PSP/HW (onboard secure processor).
> >>>>>>>>>> i915 also uses hw to auth, we still use the parts from drm_hdcp ...
> >>>>>>>>>> Did you actually look at what's in there? It's essentially just shared
> >>>>>>>>>> defines and data structures from the standard, plus a few minimal
> >>>>>>>>>> helpers to en/decode some bits. Just from a quick read the entire
> >>>>>>>>>> patch very much looks like midlayer everywhere design that we
> >>>>>>>>>> discussed back when DC landed ...
> >>>>>>>>>> -Daniel
> >>>>>>>>>>
> >>>>>>>>>>> Bhawan
> >>>>>>>>>>>
> >>>>>>>>>>> On 2019-10-09 12:32 p.m., Daniel Vetter wrote:
> >>>>>>>>>>>> On Thu, Oct 03, 2019 at 11:08:03PM +0100, Colin Ian King wrote:
> >>>>>>>>>>>>> Hi,
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Static analysis with Coverity has detected a potential issue with
> >>>>>>>>>>>>> function validate_bksv in
> >>>>>>>>>>>>> drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c with recent
> >>>>>>>>>>>>> commit:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> commit ed9d8e2bcb003ec94658cafe9b1bb3960e2139ec
> >>>>>>>>>>>>> Author: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> >>>>>>>>>>>>> Date:   Tue Aug 6 17:52:01 2019 -0400
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>       drm/amd/display: Add HDCP module
> >>>>>>>>>>>> I think the real question here is ... why is this not using drm_hdcp?
> >>>>>>>>>>>> -Daniel
> >>>>>>>>>>>>
> >>>>>>>>>>>>> The analysis is as follows:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>    28 static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
> >>>>>>>>>>>>>    29 {
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> CID 89852 (#1 of 1): Out-of-bounds read (OVERRUN)
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> 1. overrun-local:
> >>>>>>>>>>>>> Overrunning array of 5 bytes at byte offset 7 by dereferencing pointer
> >>>>>>>>>>>>> (uint64_t *)hdcp->auth.msg.hdcp1.bksv.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>    30        uint64_t n = *(uint64_t *)hdcp->auth.msg.hdcp1.bksv;
> >>>>>>>>>>>>>    31        uint8_t count = 0;
> >>>>>>>>>>>>>    32
> >>>>>>>>>>>>>    33        while (n) {
> >>>>>>>>>>>>>    34                count++;
> >>>>>>>>>>>>>    35                n &= (n - 1);
> >>>>>>>>>>>>>    36        }
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> hdcp->auth.msg.hdcp1.bksv is an array of 5 uint8_t as defined in
> >>>>>>>>>>>>> drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h as follows:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> struct mod_hdcp_message_hdcp1 {
> >>>>>>>>>>>>>           uint8_t         an[8];
> >>>>>>>>>>>>>           uint8_t         aksv[5];
> >>>>>>>>>>>>>           uint8_t         ainfo;
> >>>>>>>>>>>>>           uint8_t         bksv[5];
> >>>>>>>>>>>>>           uint16_t        r0p;
> >>>>>>>>>>>>>           uint8_t         bcaps;
> >>>>>>>>>>>>>           uint16_t        bstatus;
> >>>>>>>>>>>>>           uint8_t         ksvlist[635];
> >>>>>>>>>>>>>           uint16_t        ksvlist_size;
> >>>>>>>>>>>>>           uint8_t         vp[20];
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>           uint16_t        binfo_dp;
> >>>>>>>>>>>>> };
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> variable n is going to contain the contains of r0p and bcaps. I'm not
> >>>>>>>>>>>>> sure if that is intentional. If not, then the count is going to be
> >>>>>>>>>>>>> incorrect if these are non-zero.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Colin
> >>>>>>>>>>> _______________________________________________
> >>>>>>>>>>> dri-devel mailing list
> >>>>>>>>>>> dri-devel@lists.freedesktop.org
> >>>>>>>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> Daniel Vetter
> >>>>>>>> Software Engineer, Intel Corporation
> >>>>>>>> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> --
> >>>>>>> Daniel Vetter
> >>>>>>> Software Engineer, Intel Corporation
> >>>>>>> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> >>>>>>>
> >>>>>
> >>>>> --
> >>>>> Daniel Vetter
> >>>>> Software Engineer, Intel Corporation
> >>>>> http://blog.ffwll.ch
> >>>>> _______________________________________________
> >>>>> amd-gfx mailing list
> >>>>> amd-gfx@lists.freedesktop.org
> >>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >>>
> >>> --
> >>> Daniel Vetter
> >>> Software Engineer, Intel Corporation
> >>> http://blog.ffwll.ch
> >
> >
> >



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
