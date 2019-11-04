Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BF9C47E49
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9502080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdJp5X//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfKDRFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:05:55 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:36392 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDRFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:05:54 -0500
Received: by mail-wr1-f51.google.com with SMTP id w18so18006291wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 09:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgmPX58MUCCzS/Wp5+ouodF7SS9hfD1PG/MQAFDnQ+8=;
        b=OdJp5X//aEusepfz2XHF0g/z/AA8FBRtO2F9NS9+a3iSjdTtCnV/ucR1ucMH/JloUL
         IohtyPPQzk7ufhWkjTxmsiKMpL4IcUH0MpvHiKOwJsbUqCZzwxk9/XKRYlyY644Ow5qo
         Uq5IZHURmOjXlINTo0EMWXuBUNfi9bbtWMRzOe8/HBfixTHHb4sr6MWi/exDIp+1S0TC
         gMzffKMt+AEHbUg22OQI+NcMmWHu5Ik6rqDPhMapgodUk9epv5G18BL5iy2UGHAS+u6u
         JDqIAUHucuoriANhoikXbfGVdReDs+VFq84nKnt6ZyzpMmNRy6U1cFmUykZow5iLGyA/
         CrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgmPX58MUCCzS/Wp5+ouodF7SS9hfD1PG/MQAFDnQ+8=;
        b=EY2+mWGu8a/XFyCg+swnUk2cwXUg4NQlH9PHRxrG8tjhmSznfEnO+5Hy3DxXnmh8/4
         YqN64q6sEuvbd5Auy/KHNzdxiCGcwxvYCr6c7jRLO8+VoxRqvon26iSZiVS5crNVNwkb
         uyCx6SxNLdsHIlLw9AAFq9svVHscL8+2KHmCvJ5b9cnVEPjosS1VpMw+L6UXGvAwy7q8
         zlvOSThPmyT+PviRDRRxpmyeFGimGJ9oNZTqykxg4LUBw3Tn1eEWeZ+R3fzF2hiC3eyx
         tAbdPfhtX/s7K7fwi2KdKBfqw/XUwNn5HvNC4alfUoxTFGuBBjeOPwRjZUerwK3rVvdp
         9OKQ==
X-Gm-Message-State: APjAAAVAiA4CyYKtwRaoust0wNO1J2/+puJ/vbuxtYLm4Y8Ed+lXh6f6
        sFTq47OrKVw2V+paMkNIjJH2nG4nXaRVUPSvoJk=
X-Google-Smtp-Source: APXvYqxbgJgBJn/5sjB0AEz89DsLzVJyRbGzVziIWuzdDo3GJt6rIWE2PQkgRpOH4pcQpZFpYg0nENYRXCFejFSn8ck=
X-Received: by 2002:a5d:4688:: with SMTP id u8mr7087306wrq.40.1572887152089;
 Mon, 04 Nov 2019 09:05:52 -0800 (PST)
MIME-Version: 1.0
References: <951eb7dc-bebe-5049-4998-f199e18b0bf3@canonical.com>
 <20191009163235.GT16989@phenom.ffwll.local> <a0d5f3a3-a2b3-5367-42f9-bde514571e25@amd.com>
 <CAKMK7uEtJRDhibWDv2TB2WrFzFooMWPSbveDD2N-rudAwvzVFA@mail.gmail.com>
 <c8f96b46-e81e-1e41-aafc-5f6ec236d66f@amd.com> <CAKMK7uHr3aeJRqJAscDDfsuBBnVXCeN9SS36-1UGuK84NyOD5Q@mail.gmail.com>
 <CAKMK7uH6EoY9MkzjSjU+Fe=E-XB4Tf9d2VsW=Tr=tFy1J-dJgg@mail.gmail.com>
 <53bf910b-5f9c-946b-17ee-602c24c0fa96@amd.com> <20191104165457.GH10326@phenom.ffwll.local>
In-Reply-To: <20191104165457.GH10326@phenom.ffwll.local>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 4 Nov 2019 12:05:40 -0500
Message-ID: <CADnq5_PxMQ_AkBCHXU_YUAMWaPcH-nkOJNGNKnUOJWSTYV6X+A@mail.gmail.com>
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

On Mon, Nov 4, 2019 at 11:55 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Nov 04, 2019 at 03:23:09PM +0000, Harry Wentland wrote:
> > On 2019-11-04 5:53 a.m., Daniel Vetter wrote:
> > > On Wed, Oct 9, 2019 at 10:58 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >> On Wed, Oct 9, 2019 at 10:46 PM Lakha, Bhawanpreet
> > >> <Bhawanpreet.Lakha@amd.com> wrote:
> > >>>
> > >>> I misunderstood and was talking about the ksv validation specifically
> > >>> (usage of drm_hdcp_check_ksvs_revoked()).
> > >>
> > >> Hm for that specifically I think you want to do both, i.e. both
> > >> consult your psp, but also check for revoked ksvs with the core
> > >> helper. At least on some platforms only the core helper might have the
> > >> updated revoke list.
> > >>
> >
> > I think it's an either/or. Either we use an HDCP implementation that's
> > fully running in x86 kernel space (still not sure how that's compliant)
> > or we fully rely on our PSP FW to do what it's designed to do. I don't
> > think it makes sense to mix and match here.
>
> Then you need to somehow tie the revoke list that's in the psp to the
> revoke list update logic we have. That's what we've done for hdcp2 (which
> is similarly to yours implemented in hw). The point is that on linux we
> now have a standard way to get these revoke lists updated/handled.
>
> I guess it wasn't clear how exactly I think you're supposed to combine
> them?

There's no driver sw required at all for our implementation and as far
as I know, HDCP 2.x requires that all of the key revoke handling be
handled in a secure processor rather than than on the host processor,
so I'm not sure how we make use if it.  All the driver sw is
responsible for doing is saving/restoring the potentially updated srm
at suspend/resume/etc.

Alex

> -Daniel
>
>
> >
> > >>> For the defines I will create patches to use drm_hdcp where it is usable.
> > >>
> > >> Thanks a lot. Ime once we have shared definitions it's much easier to
> > >> also share some helpers, where it makes sense.
> > >>
> > >> Aside I think the hdcp code could also use a bit of demidlayering. At
> > >> least I'm not understanding why you add a 2nd abstraction layer for
> > >> i2c/dpcd, dm_helper already has that. That seems like one abstraction
> > >> layer too much.
> > >
> > > I haven't seen anything fly by or in the latest pull request ... you
> > > folks still working on this or more put on the "maybe, probably never"
> > > pile?
> > >
> >
> > Following up with Bhawan.
> >
> > Harry
> >
> > > -Daniel
> > >
> > >
> > >> -Daniel
> > >>
> > >>>
> > >>>
> > >>> Bhawan
> > >>>
> > >>> On 2019-10-09 2:43 p.m., Daniel Vetter wrote:
> > >>>> On Wed, Oct 9, 2019 at 8:23 PM Lakha, Bhawanpreet
> > >>>> <Bhawanpreet.Lakha@amd.com> wrote:
> > >>>>> Hi,
> > >>>>>
> > >>>>> The reason we don't use drm_hdcp is because our policy is to do hdcp
> > >>>>> verification using PSP/HW (onboard secure processor).
> > >>>> i915 also uses hw to auth, we still use the parts from drm_hdcp ...
> > >>>> Did you actually look at what's in there? It's essentially just shared
> > >>>> defines and data structures from the standard, plus a few minimal
> > >>>> helpers to en/decode some bits. Just from a quick read the entire
> > >>>> patch very much looks like midlayer everywhere design that we
> > >>>> discussed back when DC landed ...
> > >>>> -Daniel
> > >>>>
> > >>>>> Bhawan
> > >>>>>
> > >>>>> On 2019-10-09 12:32 p.m., Daniel Vetter wrote:
> > >>>>>> On Thu, Oct 03, 2019 at 11:08:03PM +0100, Colin Ian King wrote:
> > >>>>>>> Hi,
> > >>>>>>>
> > >>>>>>> Static analysis with Coverity has detected a potential issue with
> > >>>>>>> function validate_bksv in
> > >>>>>>> drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c with recent
> > >>>>>>> commit:
> > >>>>>>>
> > >>>>>>> commit ed9d8e2bcb003ec94658cafe9b1bb3960e2139ec
> > >>>>>>> Author: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> > >>>>>>> Date:   Tue Aug 6 17:52:01 2019 -0400
> > >>>>>>>
> > >>>>>>>       drm/amd/display: Add HDCP module
> > >>>>>> I think the real question here is ... why is this not using drm_hdcp?
> > >>>>>> -Daniel
> > >>>>>>
> > >>>>>>> The analysis is as follows:
> > >>>>>>>
> > >>>>>>>    28 static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
> > >>>>>>>    29 {
> > >>>>>>>
> > >>>>>>> CID 89852 (#1 of 1): Out-of-bounds read (OVERRUN)
> > >>>>>>>
> > >>>>>>> 1. overrun-local:
> > >>>>>>> Overrunning array of 5 bytes at byte offset 7 by dereferencing pointer
> > >>>>>>> (uint64_t *)hdcp->auth.msg.hdcp1.bksv.
> > >>>>>>>
> > >>>>>>>    30        uint64_t n = *(uint64_t *)hdcp->auth.msg.hdcp1.bksv;
> > >>>>>>>    31        uint8_t count = 0;
> > >>>>>>>    32
> > >>>>>>>    33        while (n) {
> > >>>>>>>    34                count++;
> > >>>>>>>    35                n &= (n - 1);
> > >>>>>>>    36        }
> > >>>>>>>
> > >>>>>>> hdcp->auth.msg.hdcp1.bksv is an array of 5 uint8_t as defined in
> > >>>>>>> drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h as follows:
> > >>>>>>>
> > >>>>>>> struct mod_hdcp_message_hdcp1 {
> > >>>>>>>           uint8_t         an[8];
> > >>>>>>>           uint8_t         aksv[5];
> > >>>>>>>           uint8_t         ainfo;
> > >>>>>>>           uint8_t         bksv[5];
> > >>>>>>>           uint16_t        r0p;
> > >>>>>>>           uint8_t         bcaps;
> > >>>>>>>           uint16_t        bstatus;
> > >>>>>>>           uint8_t         ksvlist[635];
> > >>>>>>>           uint16_t        ksvlist_size;
> > >>>>>>>           uint8_t         vp[20];
> > >>>>>>>
> > >>>>>>>           uint16_t        binfo_dp;
> > >>>>>>> };
> > >>>>>>>
> > >>>>>>> variable n is going to contain the contains of r0p and bcaps. I'm not
> > >>>>>>> sure if that is intentional. If not, then the count is going to be
> > >>>>>>> incorrect if these are non-zero.
> > >>>>>>>
> > >>>>>>> Colin
> > >>>>> _______________________________________________
> > >>>>> dri-devel mailing list
> > >>>>> dri-devel@lists.freedesktop.org
> > >>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >>>>
> > >>>>
> > >>
> > >>
> > >>
> > >> --
> > >> Daniel Vetter
> > >> Software Engineer, Intel Corporation
> > >> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> > >
> > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> > >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
