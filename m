Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5A8CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD4D20869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aXylMG+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfKDQzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:55:04 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:32925 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbfKDQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:55:02 -0500
Received: by mail-wm1-f45.google.com with SMTP id 6so14502489wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 08:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qbydSBqseaw/lQj0nQ/gQN6CVr9wzBelvAaWVLCPwUc=;
        b=aXylMG+y/bVQLTKpkPecMubi5xk8neo1TPugA58jbdUqDzUO5t+mCleDMf6m0aiXcc
         bd1rkbzogwK7Ja/TtVsHcU1F9zp1DzrDSw3c7t4IWSNcfO5XJJH8higwdCL15KW8ubpZ
         iDdcFEO7G4ECVLB2pdN8FjG2wQwn/hv1P+0Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=qbydSBqseaw/lQj0nQ/gQN6CVr9wzBelvAaWVLCPwUc=;
        b=iRsgiTe6BI8iotgCBwFPr0TD7LxW9hbPQqORm1nQuK5ScMMp4W5toXZDK0VzqMUD6x
         VMXK2w2L3/G9DYNlYmAnJPoWI2QvzVDLwmX2sA2TD3kBgJnWtg4vsiLK9Fgqa7FLn9Qg
         dBobWXl+AunpdgVWVfBh5SANfWW9Dvqz5KcPPVzB47Lea2n5lsIrycVWxpI2jyH+sLmd
         h4da1OWvyj+HGOq2ZjcdbPmP8FWloOnM5/c1/uXmwEGp9X+XbimIOoLX7uxiZcP3LyPN
         8IWdOwsAc07A+O31dUUhhQnRpVaZRtLCqssKqPGSXehFD+oa1g2bsWeOzhB6FxreJf3W
         RxkQ==
X-Gm-Message-State: APjAAAVfvK/M6dfPog+zLNQGy8pqRpMBt5Cepb8whb1Md8PlvBUmIKx6
        JqFtlpTDmgHlRQeZ7PyQ5p1cUA==
X-Google-Smtp-Source: APXvYqz94I0pfBllsuYuxRIRg5mazNojaJ6pU1GUBJRxZPr5hP+NbTslnm9nyaVAmkAjo/sjHk6k8A==
X-Received: by 2002:a1c:f011:: with SMTP id a17mr86381wmb.18.1572886500036;
        Mon, 04 Nov 2019 08:55:00 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id r19sm20025253wrr.47.2019.11.04.08.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 08:54:59 -0800 (PST)
Date:   Mon, 4 Nov 2019 17:54:57 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: drm/amd/display: Add HDCP module - static analysis bug report
Message-ID: <20191104165457.GH10326@phenom.ffwll.local>
Mail-Followup-To: Harry Wentland <hwentlan@amd.com>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <951eb7dc-bebe-5049-4998-f199e18b0bf3@canonical.com>
 <20191009163235.GT16989@phenom.ffwll.local>
 <a0d5f3a3-a2b3-5367-42f9-bde514571e25@amd.com>
 <CAKMK7uEtJRDhibWDv2TB2WrFzFooMWPSbveDD2N-rudAwvzVFA@mail.gmail.com>
 <c8f96b46-e81e-1e41-aafc-5f6ec236d66f@amd.com>
 <CAKMK7uHr3aeJRqJAscDDfsuBBnVXCeN9SS36-1UGuK84NyOD5Q@mail.gmail.com>
 <CAKMK7uH6EoY9MkzjSjU+Fe=E-XB4Tf9d2VsW=Tr=tFy1J-dJgg@mail.gmail.com>
 <53bf910b-5f9c-946b-17ee-602c24c0fa96@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53bf910b-5f9c-946b-17ee-602c24c0fa96@amd.com>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 03:23:09PM +0000, Harry Wentland wrote:
> On 2019-11-04 5:53 a.m., Daniel Vetter wrote:
> > On Wed, Oct 9, 2019 at 10:58 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >> On Wed, Oct 9, 2019 at 10:46 PM Lakha, Bhawanpreet
> >> <Bhawanpreet.Lakha@amd.com> wrote:
> >>>
> >>> I misunderstood and was talking about the ksv validation specifically
> >>> (usage of drm_hdcp_check_ksvs_revoked()).
> >>
> >> Hm for that specifically I think you want to do both, i.e. both
> >> consult your psp, but also check for revoked ksvs with the core
> >> helper. At least on some platforms only the core helper might have the
> >> updated revoke list.
> >>
> 
> I think it's an either/or. Either we use an HDCP implementation that's
> fully running in x86 kernel space (still not sure how that's compliant)
> or we fully rely on our PSP FW to do what it's designed to do. I don't
> think it makes sense to mix and match here.

Then you need to somehow tie the revoke list that's in the psp to the
revoke list update logic we have. That's what we've done for hdcp2 (which
is similarly to yours implemented in hw). The point is that on linux we
now have a standard way to get these revoke lists updated/handled.

I guess it wasn't clear how exactly I think you're supposed to combine
them?
-Daniel


> 
> >>> For the defines I will create patches to use drm_hdcp where it is usable.
> >>
> >> Thanks a lot. Ime once we have shared definitions it's much easier to
> >> also share some helpers, where it makes sense.
> >>
> >> Aside I think the hdcp code could also use a bit of demidlayering. At
> >> least I'm not understanding why you add a 2nd abstraction layer for
> >> i2c/dpcd, dm_helper already has that. That seems like one abstraction
> >> layer too much.
> > 
> > I haven't seen anything fly by or in the latest pull request ... you
> > folks still working on this or more put on the "maybe, probably never"
> > pile?
> > 
> 
> Following up with Bhawan.
> 
> Harry
> 
> > -Daniel
> > 
> > 
> >> -Daniel
> >>
> >>>
> >>>
> >>> Bhawan
> >>>
> >>> On 2019-10-09 2:43 p.m., Daniel Vetter wrote:
> >>>> On Wed, Oct 9, 2019 at 8:23 PM Lakha, Bhawanpreet
> >>>> <Bhawanpreet.Lakha@amd.com> wrote:
> >>>>> Hi,
> >>>>>
> >>>>> The reason we don't use drm_hdcp is because our policy is to do hdcp
> >>>>> verification using PSP/HW (onboard secure processor).
> >>>> i915 also uses hw to auth, we still use the parts from drm_hdcp ...
> >>>> Did you actually look at what's in there? It's essentially just shared
> >>>> defines and data structures from the standard, plus a few minimal
> >>>> helpers to en/decode some bits. Just from a quick read the entire
> >>>> patch very much looks like midlayer everywhere design that we
> >>>> discussed back when DC landed ...
> >>>> -Daniel
> >>>>
> >>>>> Bhawan
> >>>>>
> >>>>> On 2019-10-09 12:32 p.m., Daniel Vetter wrote:
> >>>>>> On Thu, Oct 03, 2019 at 11:08:03PM +0100, Colin Ian King wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> Static analysis with Coverity has detected a potential issue with
> >>>>>>> function validate_bksv in
> >>>>>>> drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c with recent
> >>>>>>> commit:
> >>>>>>>
> >>>>>>> commit ed9d8e2bcb003ec94658cafe9b1bb3960e2139ec
> >>>>>>> Author: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> >>>>>>> Date:   Tue Aug 6 17:52:01 2019 -0400
> >>>>>>>
> >>>>>>>       drm/amd/display: Add HDCP module
> >>>>>> I think the real question here is ... why is this not using drm_hdcp?
> >>>>>> -Daniel
> >>>>>>
> >>>>>>> The analysis is as follows:
> >>>>>>>
> >>>>>>>    28 static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
> >>>>>>>    29 {
> >>>>>>>
> >>>>>>> CID 89852 (#1 of 1): Out-of-bounds read (OVERRUN)
> >>>>>>>
> >>>>>>> 1. overrun-local:
> >>>>>>> Overrunning array of 5 bytes at byte offset 7 by dereferencing pointer
> >>>>>>> (uint64_t *)hdcp->auth.msg.hdcp1.bksv.
> >>>>>>>
> >>>>>>>    30        uint64_t n = *(uint64_t *)hdcp->auth.msg.hdcp1.bksv;
> >>>>>>>    31        uint8_t count = 0;
> >>>>>>>    32
> >>>>>>>    33        while (n) {
> >>>>>>>    34                count++;
> >>>>>>>    35                n &= (n - 1);
> >>>>>>>    36        }
> >>>>>>>
> >>>>>>> hdcp->auth.msg.hdcp1.bksv is an array of 5 uint8_t as defined in
> >>>>>>> drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h as follows:
> >>>>>>>
> >>>>>>> struct mod_hdcp_message_hdcp1 {
> >>>>>>>           uint8_t         an[8];
> >>>>>>>           uint8_t         aksv[5];
> >>>>>>>           uint8_t         ainfo;
> >>>>>>>           uint8_t         bksv[5];
> >>>>>>>           uint16_t        r0p;
> >>>>>>>           uint8_t         bcaps;
> >>>>>>>           uint16_t        bstatus;
> >>>>>>>           uint8_t         ksvlist[635];
> >>>>>>>           uint16_t        ksvlist_size;
> >>>>>>>           uint8_t         vp[20];
> >>>>>>>
> >>>>>>>           uint16_t        binfo_dp;
> >>>>>>> };
> >>>>>>>
> >>>>>>> variable n is going to contain the contains of r0p and bcaps. I'm not
> >>>>>>> sure if that is intentional. If not, then the count is going to be
> >>>>>>> incorrect if these are non-zero.
> >>>>>>>
> >>>>>>> Colin
> >>>>> _______________________________________________
> >>>>> dri-devel mailing list
> >>>>> dri-devel@lists.freedesktop.org
> >>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >>>>
> >>>>
> >>
> >>
> >>
> >> --
> >> Daniel Vetter
> >> Software Engineer, Intel Corporation
> >> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> > 
> > 
> > 
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
