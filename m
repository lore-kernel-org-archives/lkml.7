Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE9BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79054217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SfvuzQIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfKDKxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:53:23 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41471 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfKDKxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:53:22 -0500
Received: by mail-ot1-f43.google.com with SMTP id 94so13949251oty.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 02:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8b3P8qSRLFrLqsJhrugxMu45LMgVnh54YgowLiHTTEY=;
        b=SfvuzQIMcQyCEi/tFArbrm1tA3MimYlzVNQ2OpksRBktQt6kvex6MyJy29vXdBE7k9
         9O9b6kS7P2rK+0lA6EU9VBpduz4w6rqkB8zmJPRIJhO+I4okI0hMzk6QdSrJPAXrC6pb
         xq2Ty1ll2cBNnr1cOpgMtqRMh1BGaHPoyQafs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8b3P8qSRLFrLqsJhrugxMu45LMgVnh54YgowLiHTTEY=;
        b=Xfl3I6u9Tv8RZa0PSxPKGFKBqFBBszmPzcQEShbw2q5pXelcpqssPyRIzDViSjdAEt
         +Fp6qN9I+44jBKYWgdP1wL8E3niB/3ag2ZyAP5tb4tjVD2Esfp8MQAGL1Ugtr4sFRuuS
         rRBP6FRtJ1YZWvA800eyD4XPISZVC2MQexhKmHamanJCrpXyrw0QAv/az6AZhUm/nfYS
         zisHJqnj2ghmfyH3dvw8rND29QHoSU7vOX0FHXZ+s5ZQwSquHcE3ztUZ4VHheSVtyfqz
         8s37eWyFBChvc3eHrrYG1nB/hDAyPRjYAxcuSfplcedkh7QGTKpZIM4u9m2E5c0zV1t6
         /bjQ==
X-Gm-Message-State: APjAAAUOw01/diabZg7Sg1C+aL5Sx/wL2egRsGDHwgdD5M9TdwnnPjjb
        Mh3mj0T8wMjSXANqu4aoTP5Ndnb+DEraP7W6DQqxMQ==
X-Google-Smtp-Source: APXvYqz6WVL7OBTKVEPcymiWt8gzTKXVen6HxWF5YajvZa1C3BsMVL79Ef8zxZaTB9D5z2KzH8WyC0o0aYRL1QZLY2s=
X-Received: by 2002:a9d:62d8:: with SMTP id z24mr19027276otk.188.1572864801061;
 Mon, 04 Nov 2019 02:53:21 -0800 (PST)
MIME-Version: 1.0
References: <951eb7dc-bebe-5049-4998-f199e18b0bf3@canonical.com>
 <20191009163235.GT16989@phenom.ffwll.local> <a0d5f3a3-a2b3-5367-42f9-bde514571e25@amd.com>
 <CAKMK7uEtJRDhibWDv2TB2WrFzFooMWPSbveDD2N-rudAwvzVFA@mail.gmail.com>
 <c8f96b46-e81e-1e41-aafc-5f6ec236d66f@amd.com> <CAKMK7uHr3aeJRqJAscDDfsuBBnVXCeN9SS36-1UGuK84NyOD5Q@mail.gmail.com>
In-Reply-To: <CAKMK7uHr3aeJRqJAscDDfsuBBnVXCeN9SS36-1UGuK84NyOD5Q@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 4 Nov 2019 11:53:09 +0100
Message-ID: <CAKMK7uH6EoY9MkzjSjU+Fe=E-XB4Tf9d2VsW=Tr=tFy1J-dJgg@mail.gmail.com>
Subject: Re: drm/amd/display: Add HDCP module - static analysis bug report
To:     "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 10:58 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, Oct 9, 2019 at 10:46 PM Lakha, Bhawanpreet
> <Bhawanpreet.Lakha@amd.com> wrote:
> >
> > I misunderstood and was talking about the ksv validation specifically
> > (usage of drm_hdcp_check_ksvs_revoked()).
>
> Hm for that specifically I think you want to do both, i.e. both
> consult your psp, but also check for revoked ksvs with the core
> helper. At least on some platforms only the core helper might have the
> updated revoke list.
>
> > For the defines I will create patches to use drm_hdcp where it is usable.
>
> Thanks a lot. Ime once we have shared definitions it's much easier to
> also share some helpers, where it makes sense.
>
> Aside I think the hdcp code could also use a bit of demidlayering. At
> least I'm not understanding why you add a 2nd abstraction layer for
> i2c/dpcd, dm_helper already has that. That seems like one abstraction
> layer too much.

I haven't seen anything fly by or in the latest pull request ... you
folks still working on this or more put on the "maybe, probably never"
pile?

-Daniel


> -Daniel
>
> >
> >
> > Bhawan
> >
> > On 2019-10-09 2:43 p.m., Daniel Vetter wrote:
> > > On Wed, Oct 9, 2019 at 8:23 PM Lakha, Bhawanpreet
> > > <Bhawanpreet.Lakha@amd.com> wrote:
> > >> Hi,
> > >>
> > >> The reason we don't use drm_hdcp is because our policy is to do hdcp
> > >> verification using PSP/HW (onboard secure processor).
> > > i915 also uses hw to auth, we still use the parts from drm_hdcp ...
> > > Did you actually look at what's in there? It's essentially just shared
> > > defines and data structures from the standard, plus a few minimal
> > > helpers to en/decode some bits. Just from a quick read the entire
> > > patch very much looks like midlayer everywhere design that we
> > > discussed back when DC landed ...
> > > -Daniel
> > >
> > >> Bhawan
> > >>
> > >> On 2019-10-09 12:32 p.m., Daniel Vetter wrote:
> > >>> On Thu, Oct 03, 2019 at 11:08:03PM +0100, Colin Ian King wrote:
> > >>>> Hi,
> > >>>>
> > >>>> Static analysis with Coverity has detected a potential issue with
> > >>>> function validate_bksv in
> > >>>> drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c with recent
> > >>>> commit:
> > >>>>
> > >>>> commit ed9d8e2bcb003ec94658cafe9b1bb3960e2139ec
> > >>>> Author: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> > >>>> Date:   Tue Aug 6 17:52:01 2019 -0400
> > >>>>
> > >>>>       drm/amd/display: Add HDCP module
> > >>> I think the real question here is ... why is this not using drm_hdcp?
> > >>> -Daniel
> > >>>
> > >>>> The analysis is as follows:
> > >>>>
> > >>>>    28 static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
> > >>>>    29 {
> > >>>>
> > >>>> CID 89852 (#1 of 1): Out-of-bounds read (OVERRUN)
> > >>>>
> > >>>> 1. overrun-local:
> > >>>> Overrunning array of 5 bytes at byte offset 7 by dereferencing pointer
> > >>>> (uint64_t *)hdcp->auth.msg.hdcp1.bksv.
> > >>>>
> > >>>>    30        uint64_t n = *(uint64_t *)hdcp->auth.msg.hdcp1.bksv;
> > >>>>    31        uint8_t count = 0;
> > >>>>    32
> > >>>>    33        while (n) {
> > >>>>    34                count++;
> > >>>>    35                n &= (n - 1);
> > >>>>    36        }
> > >>>>
> > >>>> hdcp->auth.msg.hdcp1.bksv is an array of 5 uint8_t as defined in
> > >>>> drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h as follows:
> > >>>>
> > >>>> struct mod_hdcp_message_hdcp1 {
> > >>>>           uint8_t         an[8];
> > >>>>           uint8_t         aksv[5];
> > >>>>           uint8_t         ainfo;
> > >>>>           uint8_t         bksv[5];
> > >>>>           uint16_t        r0p;
> > >>>>           uint8_t         bcaps;
> > >>>>           uint16_t        bstatus;
> > >>>>           uint8_t         ksvlist[635];
> > >>>>           uint16_t        ksvlist_size;
> > >>>>           uint8_t         vp[20];
> > >>>>
> > >>>>           uint16_t        binfo_dp;
> > >>>> };
> > >>>>
> > >>>> variable n is going to contain the contains of r0p and bcaps. I'm not
> > >>>> sure if that is intentional. If not, then the count is going to be
> > >>>> incorrect if these are non-zero.
> > >>>>
> > >>>> Colin
> > >> _______________________________________________
> > >> dri-devel mailing list
> > >> dri-devel@lists.freedesktop.org
> > >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >
> > >
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch



--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
