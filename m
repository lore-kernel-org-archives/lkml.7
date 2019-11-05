Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A68BC17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398F421882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMZD30g6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388863AbfKEMwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:52:10 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:55201 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388008AbfKEMwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:52:10 -0500
Received: by mail-wm1-f48.google.com with SMTP id z26so7589097wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 04:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFYopcO3PFCKHU+Ab5BtRZ2O4qTmiri57ei62Zqn5xA=;
        b=gMZD30g6KhhSlfMvLFEkcGL30kjN9TPKWF4uODZuQKIidvnLvdn/5krkpvLrtJdSxx
         WjAECruPNBAvxdlFuA7BLG8A+LaTFWU2RgH3DgseQNT+ON1e6Q7EQ+pFwieWD2MYCy+/
         YEtrzjOM5pZZSDwHSAS3jaY4y93gh10fpNTi4gTsebxsfLZOWbBzVoZ+QfuScn6lfRgP
         Nugq5xTKFYGjwSIXsALeGEyGgNKyUoZhDjd6WdeM60b2k3KuXRRKih0wmdjJ8L0GmM+h
         033HUUHfv/Sbm92SzTqgcsGTuV9MlD2jIP+ysGtAO5pUdgd5Wf1VcUiZPu3gXh/xh7R0
         krQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFYopcO3PFCKHU+Ab5BtRZ2O4qTmiri57ei62Zqn5xA=;
        b=mk3sLUFK8ydO4+ERRjxp0S85el3J2ZKQcbfcR1QMpwce3yR6ng00EKskyurcCqAXmw
         eIYbc6eCPIxN0Lyrh/yW4IrTiOTYZnDeqDe7E2KBoxszFEDDrENqKdB/jjv3kQoLE2Ct
         C4cwTJm1Aeb2dk4m9DxjCskke3TSXNI2rzqxpzf779Vr8O9eEMprsVQZeHCjKzsST3pl
         vQbcJ5j4P5UIKG6186PVdmPLLT1+6W7zSgkrE6nzJQYspBV8d41lcJs1Ajpwk6Il9jWV
         1jDf5m8nAzWuTvch+/NR/iU8743SuF14WhzMrr3WWSMT3e2DY99C1bZdCONDVIzdg+Fx
         z56Q==
X-Gm-Message-State: APjAAAVY6a+Z3Y136mSwnW4MexzT+37v9LAzi8zbP7T0WZZ7y1q2Xm9b
        I+Dpil+B3BXG1FFAWzgzklQP8/+XXZ25ogZvjS8=
X-Google-Smtp-Source: APXvYqyj2GBQLPnsEzSXkflcG+ZpzYHQ+WBTM+AXfFVYtiXeVuc53o1gfZZoKoWgi91oeEd+aBAeksLpOO2rzeqlenM=
X-Received: by 2002:a7b:c408:: with SMTP id k8mr4310229wmi.67.1572958325008;
 Tue, 05 Nov 2019 04:52:05 -0800 (PST)
MIME-Version: 1.0
References: <951eb7dc-bebe-5049-4998-f199e18b0bf3@canonical.com>
 <20191009163235.GT16989@phenom.ffwll.local> <a0d5f3a3-a2b3-5367-42f9-bde514571e25@amd.com>
 <CAKMK7uEtJRDhibWDv2TB2WrFzFooMWPSbveDD2N-rudAwvzVFA@mail.gmail.com>
 <c8f96b46-e81e-1e41-aafc-5f6ec236d66f@amd.com> <CAKMK7uHr3aeJRqJAscDDfsuBBnVXCeN9SS36-1UGuK84NyOD5Q@mail.gmail.com>
 <CAKMK7uH6EoY9MkzjSjU+Fe=E-XB4Tf9d2VsW=Tr=tFy1J-dJgg@mail.gmail.com>
 <53bf910b-5f9c-946b-17ee-602c24c0fa96@amd.com> <20191104165457.GH10326@phenom.ffwll.local>
 <CADnq5_PxMQ_AkBCHXU_YUAMWaPcH-nkOJNGNKnUOJWSTYV6X+A@mail.gmail.com> <20191104172434.GJ10326@phenom.ffwll.local>
In-Reply-To: <20191104172434.GJ10326@phenom.ffwll.local>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Nov 2019 07:51:53 -0500
Message-ID: <CADnq5_NUAfeWscsnj07MpReM3LNwHPSPq3pQDe0waMi4OCatUg@mail.gmail.com>
Subject: Re: drm/amd/display: Add HDCP module - static analysis bug report
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Harry Wentland <hwentlan@amd.com>,
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

On Mon, Nov 4, 2019 at 12:24 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Nov 04, 2019 at 12:05:40PM -0500, Alex Deucher wrote:
> > On Mon, Nov 4, 2019 at 11:55 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Mon, Nov 04, 2019 at 03:23:09PM +0000, Harry Wentland wrote:
> > > > On 2019-11-04 5:53 a.m., Daniel Vetter wrote:
> > > > > On Wed, Oct 9, 2019 at 10:58 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > >> On Wed, Oct 9, 2019 at 10:46 PM Lakha, Bhawanpreet
> > > > >> <Bhawanpreet.Lakha@amd.com> wrote:
> > > > >>>
> > > > >>> I misunderstood and was talking about the ksv validation specifically
> > > > >>> (usage of drm_hdcp_check_ksvs_revoked()).
> > > > >>
> > > > >> Hm for that specifically I think you want to do both, i.e. both
> > > > >> consult your psp, but also check for revoked ksvs with the core
> > > > >> helper. At least on some platforms only the core helper might have the
> > > > >> updated revoke list.
> > > > >>
> > > >
> > > > I think it's an either/or. Either we use an HDCP implementation that's
> > > > fully running in x86 kernel space (still not sure how that's compliant)
> > > > or we fully rely on our PSP FW to do what it's designed to do. I don't
> > > > think it makes sense to mix and match here.
> > >
> > > Then you need to somehow tie the revoke list that's in the psp to the
> > > revoke list update logic we have. That's what we've done for hdcp2 (which
> > > is similarly to yours implemented in hw). The point is that on linux we
> > > now have a standard way to get these revoke lists updated/handled.
> > >
> > > I guess it wasn't clear how exactly I think you're supposed to combine
> > > them?
> >
> > There's no driver sw required at all for our implementation and as far
> > as I know, HDCP 2.x requires that all of the key revoke handling be
> > handled in a secure processor rather than than on the host processor,
> > so I'm not sure how we make use if it.  All the driver sw is
> > responsible for doing is saving/restoring the potentially updated srm
> > at suspend/resume/etc.
>
> Uh, you don't have a permanent store on the chip? I thought another
> requirement is that you can't downgrade.

Right.  That's why the driver has to save and restore the srm when the
GPU is powered down.  I guess that part can be done by the host
processor as long as the srm is signed properly.

>
> And for hw solutions all you do with the updated revoke cert is stuff it
> into the hw, it's purely for updating it. And those updates need to come
> from somewhere else (usually in the media you play), the kernel can't
> fetch them over the internet itself. I thought we already had the function
> to give you the srm directly so you can stuff it into the hw, but looks
> like that part isn't there (yet).

IIRC, the revoke stuff gets gleaned from the stream by the secure
processor somehow when you play back secure content.  I'm not entirely
clear on the details, but from the design, the driver doesn't have to
do anything in our case other than saving and restoring the srm from
the secure processor.

Alex

> -Daniel
>
> >
> > Alex
> >
> > > -Daniel
> > >
> > >
> > > >
> > > > >>> For the defines I will create patches to use drm_hdcp where it is usable.
> > > > >>
> > > > >> Thanks a lot. Ime once we have shared definitions it's much easier to
> > > > >> also share some helpers, where it makes sense.
> > > > >>
> > > > >> Aside I think the hdcp code could also use a bit of demidlayering. At
> > > > >> least I'm not understanding why you add a 2nd abstraction layer for
> > > > >> i2c/dpcd, dm_helper already has that. That seems like one abstraction
> > > > >> layer too much.
> > > > >
> > > > > I haven't seen anything fly by or in the latest pull request ... you
> > > > > folks still working on this or more put on the "maybe, probably never"
> > > > > pile?
> > > > >
> > > >
> > > > Following up with Bhawan.
> > > >
> > > > Harry
> > > >
> > > > > -Daniel
> > > > >
> > > > >
> > > > >> -Daniel
> > > > >>
> > > > >>>
> > > > >>>
> > > > >>> Bhawan
> > > > >>>
> > > > >>> On 2019-10-09 2:43 p.m., Daniel Vetter wrote:
> > > > >>>> On Wed, Oct 9, 2019 at 8:23 PM Lakha, Bhawanpreet
> > > > >>>> <Bhawanpreet.Lakha@amd.com> wrote:
> > > > >>>>> Hi,
> > > > >>>>>
> > > > >>>>> The reason we don't use drm_hdcp is because our policy is to do hdcp
> > > > >>>>> verification using PSP/HW (onboard secure processor).
> > > > >>>> i915 also uses hw to auth, we still use the parts from drm_hdcp ...
> > > > >>>> Did you actually look at what's in there? It's essentially just shared
> > > > >>>> defines and data structures from the standard, plus a few minimal
> > > > >>>> helpers to en/decode some bits. Just from a quick read the entire
> > > > >>>> patch very much looks like midlayer everywhere design that we
> > > > >>>> discussed back when DC landed ...
> > > > >>>> -Daniel
> > > > >>>>
> > > > >>>>> Bhawan
> > > > >>>>>
> > > > >>>>> On 2019-10-09 12:32 p.m., Daniel Vetter wrote:
> > > > >>>>>> On Thu, Oct 03, 2019 at 11:08:03PM +0100, Colin Ian King wrote:
> > > > >>>>>>> Hi,
> > > > >>>>>>>
> > > > >>>>>>> Static analysis with Coverity has detected a potential issue with
> > > > >>>>>>> function validate_bksv in
> > > > >>>>>>> drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c with recent
> > > > >>>>>>> commit:
> > > > >>>>>>>
> > > > >>>>>>> commit ed9d8e2bcb003ec94658cafe9b1bb3960e2139ec
> > > > >>>>>>> Author: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> > > > >>>>>>> Date:   Tue Aug 6 17:52:01 2019 -0400
> > > > >>>>>>>
> > > > >>>>>>>       drm/amd/display: Add HDCP module
> > > > >>>>>> I think the real question here is ... why is this not using drm_hdcp?
> > > > >>>>>> -Daniel
> > > > >>>>>>
> > > > >>>>>>> The analysis is as follows:
> > > > >>>>>>>
> > > > >>>>>>>    28 static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
> > > > >>>>>>>    29 {
> > > > >>>>>>>
> > > > >>>>>>> CID 89852 (#1 of 1): Out-of-bounds read (OVERRUN)
> > > > >>>>>>>
> > > > >>>>>>> 1. overrun-local:
> > > > >>>>>>> Overrunning array of 5 bytes at byte offset 7 by dereferencing pointer
> > > > >>>>>>> (uint64_t *)hdcp->auth.msg.hdcp1.bksv.
> > > > >>>>>>>
> > > > >>>>>>>    30        uint64_t n = *(uint64_t *)hdcp->auth.msg.hdcp1.bksv;
> > > > >>>>>>>    31        uint8_t count = 0;
> > > > >>>>>>>    32
> > > > >>>>>>>    33        while (n) {
> > > > >>>>>>>    34                count++;
> > > > >>>>>>>    35                n &= (n - 1);
> > > > >>>>>>>    36        }
> > > > >>>>>>>
> > > > >>>>>>> hdcp->auth.msg.hdcp1.bksv is an array of 5 uint8_t as defined in
> > > > >>>>>>> drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h as follows:
> > > > >>>>>>>
> > > > >>>>>>> struct mod_hdcp_message_hdcp1 {
> > > > >>>>>>>           uint8_t         an[8];
> > > > >>>>>>>           uint8_t         aksv[5];
> > > > >>>>>>>           uint8_t         ainfo;
> > > > >>>>>>>           uint8_t         bksv[5];
> > > > >>>>>>>           uint16_t        r0p;
> > > > >>>>>>>           uint8_t         bcaps;
> > > > >>>>>>>           uint16_t        bstatus;
> > > > >>>>>>>           uint8_t         ksvlist[635];
> > > > >>>>>>>           uint16_t        ksvlist_size;
> > > > >>>>>>>           uint8_t         vp[20];
> > > > >>>>>>>
> > > > >>>>>>>           uint16_t        binfo_dp;
> > > > >>>>>>> };
> > > > >>>>>>>
> > > > >>>>>>> variable n is going to contain the contains of r0p and bcaps. I'm not
> > > > >>>>>>> sure if that is intentional. If not, then the count is going to be
> > > > >>>>>>> incorrect if these are non-zero.
> > > > >>>>>>>
> > > > >>>>>>> Colin
> > > > >>>>> _______________________________________________
> > > > >>>>> dri-devel mailing list
> > > > >>>>> dri-devel@lists.freedesktop.org
> > > > >>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > >>>>
> > > > >>>>
> > > > >>
> > > > >>
> > > > >>
> > > > >> --
> > > > >> Daniel Vetter
> > > > >> Software Engineer, Intel Corporation
> > > > >> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Daniel Vetter
> > > > > Software Engineer, Intel Corporation
> > > > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> > > > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
