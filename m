Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51588C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A6320663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Y4BN43Jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfJNIYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:24:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41336 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbfJNIYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:24:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id f20so14014127edv.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 01:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=j6O20ev7OAGuxzIa80e5vDAXtGyW2LTnu77UaffpJCE=;
        b=Y4BN43Jpv0jfoCynOGvEDGKo3T6kpHMLPm53oR14RzhJHTd72+n1dQ0OGJ9I2DF8nB
         nUKRKB13dTXGGk1RRtEVF+rvE18LGdvkNZX0pMhlUVzriDowDxd348l4hTZUMEyOeGgL
         s6JbWIbh6q5eB8PT/rnkOECWPPfoI++bA31+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=j6O20ev7OAGuxzIa80e5vDAXtGyW2LTnu77UaffpJCE=;
        b=lAwST8zm1sRDpbCm0XO2CdLl/nRQ3u+lLc9u8NB6Rb88UUIQ+P40wr+DSaSIafZeG4
         9qQqrUyepS0oAx/JOk5iRsAPk3+DQwoCIHNY0QgkUFp+p2glU4ZKk9s++hWP/57ybMhH
         6+XEKu9nyUqEK0bTYGYCgpyojpmdMqCv2+icRlN/c6l7G5OMoL29qkCiXSDRzzhiUQ21
         m06xu1N+7cIEp0XTtu/CRzWRqKwVIL+DpIOxlQt6gXsyloA0LyL/r4hNPSjYUIXmfAOZ
         wUqjFAZOFFkNKjzmS0bdmaZH9Vf5eW+cxhXtnecLe0Y0+HnuVsyr9qXjiVJ+xWLZ459x
         GtjQ==
X-Gm-Message-State: APjAAAU2RDuzH7G14V9GWmhqJk/iQfVuWJSs7mA1TBACsjf6elKyrw8M
        tEwky7/4HCYt/5Rip7cSc2KUf+Vkdys=
X-Google-Smtp-Source: APXvYqwXYHlLsNH8IZ0yHVKT+WNEtOwUbzIAoI04sPQqxR0KrJVKvhaWJIh+WyCfN2js9VOglylnJA==
X-Received: by 2002:a17:906:3b10:: with SMTP id g16mr27774667ejf.34.1571041483656;
        Mon, 14 Oct 2019 01:24:43 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id k18sm2218817ejc.16.2019.10.14.01.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 01:24:42 -0700 (PDT)
Date:   Mon, 14 Oct 2019 10:24:33 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drm: add fb max width/height fields to drm_mode_config
Message-ID: <20191014082433.GA11828@phenom.ffwll.local>
Mail-Followup-To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <1569634131-13875-1-git-send-email-jsanka@codeaurora.org>
 <1569634131-13875-2-git-send-email-jsanka@codeaurora.org>
 <20190930103931.GZ1208@intel.com>
 <f6d3c2b6ad897ce8b2fdcaab44993eed@codeaurora.org>
 <20191002134535.GU1208@intel.com>
 <CAF6AEGtETiKLggNEKm+YyH8PMzpXpp119PjV2f6jdbU4UYxiAQ@mail.gmail.com>
 <20191003102718.GC1208@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191003102718.GC1208@intel.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 01:27:18PM +0300, Ville Syrjälä wrote:
> On Wed, Oct 02, 2019 at 03:55:10PM -0400, Rob Clark wrote:
> > On Wed, Oct 2, 2019 at 9:45 AM Ville Syrjälä
> > <ville.syrjala@linux.intel.com> wrote:
> > >
> > > On Tue, Oct 01, 2019 at 02:20:55PM -0700, Jeykumar Sankaran wrote:
> > > > On 2019-09-30 03:39, Ville Syrjälä wrote:
> > > > > On Fri, Sep 27, 2019 at 06:28:51PM -0700, Jeykumar Sankaran wrote:
> > > > >> The mode_config max width/height values determine the maximum
> > > > >> resolution the pixel reader can handle.
> > > > >
> > > > > Not according to the docs I "fixed" a while ago.
> > > > >
> > > > >> But the same values are
> > > > >> used to restrict the size of the framebuffer creation. Hardware's
> > > > >> with scaling blocks can operate on framebuffers larger/smaller than
> > > > >> that of the pixel reader resolutions by scaling them down/up before
> > > > >> rendering.
> > > > >>
> > > > >> This changes adds a separate framebuffer max width/height fields
> > > > >> in drm_mode_config to allow vendors to set if they are different
> > > > >> than that of the default max resolution values.
> > > > >
> > > > > If you're going to change the meaning of the old values you need
> > > > > to fix the drivers too.
> > > > >
> > > > > Personally I don't see too much point in this since you most likely
> > > > > want to validate all the other timings as well, and so likely need
> > > > > some kind of mode_valid implementation anyway. Hence to validate
> > > > > modes there's not much benefit of having global min/max values.
> > > > >
> > > > https://patchwork.kernel.org/patch/10467155/
> > > >
> > > > I believe you are referring to this patch.
> > > >
> > > > I am primarily interested in the scaling scenario mentioned here. MSM
> > > > and a few other hardware have scaling block that are used both ways:
> > > >
> > > > 1) Where FB limits are larger than the display limits. Scalar blocks are
> > > > used to
> > > >     downscale the framebuffers and render within display limits.
> > > >
> > > > In this scenario, with your patch, are you suggesting the drivers
> > > > maintain the
> > > > display limits locally and use those values in fill_modes() /
> > > > mode_valid() to filter
> > > > out invalid modes explicitly instead of mode_config.max_width/height?
> > > >
> > > > 2) Where FB limits are smaller than display limits. Enforced for
> > > > performance reasons on low tier hardware.
> > > > It reduces the fetch bandwidth and uses post blending scalar block to
> > > > scale up the pixel stream
> > > > to match the display resolution.
> > >
> > > As Daniel mentioned in that discussion your typical userspace
> > > assumes that it can use a single unscaled framebuffer with any
> > > advertised mode. Hence I believe limiting the mode list based
> > > on the max framebuffer size is pretty much required unless
> > > you want to break existing userspace.
> > >
> > > In i915 I went a bit further than that recently and now we
> > > filter the mode list based on the maximum plane size [1]
> > > (which can be less than the max fb size and less than the
> > > maximum crtc dimensions). And again that's because userspace
> > > assumes that it can just use a single unscaled fullscreen
> > > plane to cover the entire crtc.
> > >
> > > These assumption are also carved into the legacy setcrtc uapi
> > > where you can't even specify multiple framebuffers. In theory
> > > a driver could internally use multiple planes to overcome some
> > > of the limitations, but in i915 at least we don't.
> > >
> > > [1] https://cgit.freedesktop.org/drm/drm-intel/commit/?id=2d20411e25a3bf3d2914a2219f47ed48dc57aed5
> > >
> > > >
> > > > Any suggestions on how this topology can be handled with a single set of
> > > > max/min values?
> > > >
> > >
> > > I think a safe way to relax these rules would be to either:
> > > a) Add a client cap by which userspace can inform the kernel
> > >    it understands there are more complicated limits at play
> > >    and thus can't assume that everything will just work

+1 on this approach. We already have that for 3d modes, another client cap
for "modes bigger than max fb" sounds like a good idea.

For "max plane size" I'm leaning towards drivers should virtualize at
least the primary plane if that's needed to scan out the biggest
resolution. Since there's way too much userspace which will simply not
work otherwise (iirc that's what a bunch of dual-pipe dsi drivers did).

> > > b) Maybe we could just tie that in with the atomic cap since
> > >    atomic clients are pretty much required to do the TEST_ONLY
> > >    dance anyway, so one might hope they have a working fallback
> > >    strategy. Though I suspect eg. the modesetting ddx wouldn't
> > >    like this. But we no longer allow atomic with X anyway so
> > >    that partcular argument may not hold much weight anymore.
> > 
> > What was the conclusion of the hack to not expose atomic to
> > modesetting ddx, due to the brokenness of it's atomic use?  I guess
> > that could also make the modesetting case go away..
> 
> I thought it went in? Maybe I'm mistaken.

I did:

commit 26b1d3b527e7bf3e24b814d617866ac5199ce68d
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu Sep 5 20:53:18 2019 +0200

    drm/atomic: Take the atomic toys away from X

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
