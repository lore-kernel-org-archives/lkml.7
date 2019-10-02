Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315ECC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E6F21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giR0dB73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfJBTzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:55:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45576 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfJBTzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:55:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id h33so255134edh.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 12:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xkIPEeBh6Q97IvXGn4hjLXlT8I4asAfynX43MLqWSPQ=;
        b=giR0dB73oo9Hev8XpA4FIuuMUIUAo+fUm46PmKWy/t1grR8nLOEBy7KCmuMVBIhpgu
         DqZZeaB0KYxkD/l2l7XxNtcWmq7enjmcp/2jXBbjSIX8AU503H/mKpZQXxL6yRQ5TO33
         B8QEZatRcv+rJjm+U6tmafDvI9USkQNQ9Ux0Q37GX5upAgpsR1g+m1EHKB5A2kA4cy1t
         CTUHuYWYl1EmhaxFnDFjasXylpc9W4iwZ93dlZ27PjGUuGhBBHGX7AAJYHewPra+sJ3Q
         0QLFjvn1KhuAQmn7rtCHmQjVb8nK3lbzu1O6WQHerx0+p39rod/W2ym+kdT+TdToa1Ap
         FF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xkIPEeBh6Q97IvXGn4hjLXlT8I4asAfynX43MLqWSPQ=;
        b=VOa2c8vHuS99mKi9gnhl4Q1oZCfDN/lJRGqklnqm9vfEs/EYULGDIA6nK5YRTiQ7Xm
         npLYBXbg/TcBd0Ty/DEm6F1hLUF3IDgr27R03mMdV7H1BZNNto2b3BA107U9DHNmzTHl
         KMiQl2Lspxz0HbFnK+C0oVeL7p0EnkLuGXN/beEoW0RghZEOBd0Qau+8n7HPmDEhInJi
         mTrw+6cnAIFhNNPtGLMC8Dsz40L6lQX9/XuFl/aqNYfdNuOKsLsbM+OhsXwpmV15XPWn
         cwjfgfRIyqAtnOi59Y6PFKS+ezHiaT39JolFz6guA2vHLbwiPyXTv6rSBDNnRkQ9VFa1
         7m9w==
X-Gm-Message-State: APjAAAWnPN5PCAidWvkOV25piOzE267WNNheU3kECYCJNMjuQgS440KR
        G42dTnzUHeZUxyQv5Yj7tZ+59M3znicSilLecI0=
X-Google-Smtp-Source: APXvYqyBZL/DpNeTN5iSVkVr1dDOZLljTZyNX5ooanHL1zA0OBrgXa2VJbpQr5JScE8i4pEBDoDLrK/oJaRcHaqRNBg=
X-Received: by 2002:a17:906:4c4c:: with SMTP id d12mr4652655ejw.174.1570046120024;
 Wed, 02 Oct 2019 12:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <1569634131-13875-1-git-send-email-jsanka@codeaurora.org>
 <1569634131-13875-2-git-send-email-jsanka@codeaurora.org> <20190930103931.GZ1208@intel.com>
 <f6d3c2b6ad897ce8b2fdcaab44993eed@codeaurora.org> <20191002134535.GU1208@intel.com>
In-Reply-To: <20191002134535.GU1208@intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 2 Oct 2019 15:55:10 -0400
Message-ID: <CAF6AEGtETiKLggNEKm+YyH8PMzpXpp119PjV2f6jdbU4UYxiAQ@mail.gmail.com>
Subject: Re: [PATCH] drm: add fb max width/height fields to drm_mode_config
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Jeykumar Sankaran <jsanka@codeaurora.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sean Paul <seanpaul@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 9:45 AM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Tue, Oct 01, 2019 at 02:20:55PM -0700, Jeykumar Sankaran wrote:
> > On 2019-09-30 03:39, Ville Syrj=C3=A4l=C3=A4 wrote:
> > > On Fri, Sep 27, 2019 at 06:28:51PM -0700, Jeykumar Sankaran wrote:
> > >> The mode_config max width/height values determine the maximum
> > >> resolution the pixel reader can handle.
> > >
> > > Not according to the docs I "fixed" a while ago.
> > >
> > >> But the same values are
> > >> used to restrict the size of the framebuffer creation. Hardware's
> > >> with scaling blocks can operate on framebuffers larger/smaller than
> > >> that of the pixel reader resolutions by scaling them down/up before
> > >> rendering.
> > >>
> > >> This changes adds a separate framebuffer max width/height fields
> > >> in drm_mode_config to allow vendors to set if they are different
> > >> than that of the default max resolution values.
> > >
> > > If you're going to change the meaning of the old values you need
> > > to fix the drivers too.
> > >
> > > Personally I don't see too much point in this since you most likely
> > > want to validate all the other timings as well, and so likely need
> > > some kind of mode_valid implementation anyway. Hence to validate
> > > modes there's not much benefit of having global min/max values.
> > >
> > https://patchwork.kernel.org/patch/10467155/
> >
> > I believe you are referring to this patch.
> >
> > I am primarily interested in the scaling scenario mentioned here. MSM
> > and a few other hardware have scaling block that are used both ways:
> >
> > 1) Where FB limits are larger than the display limits. Scalar blocks ar=
e
> > used to
> >     downscale the framebuffers and render within display limits.
> >
> > In this scenario, with your patch, are you suggesting the drivers
> > maintain the
> > display limits locally and use those values in fill_modes() /
> > mode_valid() to filter
> > out invalid modes explicitly instead of mode_config.max_width/height?
> >
> > 2) Where FB limits are smaller than display limits. Enforced for
> > performance reasons on low tier hardware.
> > It reduces the fetch bandwidth and uses post blending scalar block to
> > scale up the pixel stream
> > to match the display resolution.
>
> As Daniel mentioned in that discussion your typical userspace
> assumes that it can use a single unscaled framebuffer with any
> advertised mode. Hence I believe limiting the mode list based
> on the max framebuffer size is pretty much required unless
> you want to break existing userspace.
>
> In i915 I went a bit further than that recently and now we
> filter the mode list based on the maximum plane size [1]
> (which can be less than the max fb size and less than the
> maximum crtc dimensions). And again that's because userspace
> assumes that it can just use a single unscaled fullscreen
> plane to cover the entire crtc.
>
> These assumption are also carved into the legacy setcrtc uapi
> where you can't even specify multiple framebuffers. In theory
> a driver could internally use multiple planes to overcome some
> of the limitations, but in i915 at least we don't.
>
> [1] https://cgit.freedesktop.org/drm/drm-intel/commit/?id=3D2d20411e25a3b=
f3d2914a2219f47ed48dc57aed5
>
> >
> > Any suggestions on how this topology can be handled with a single set o=
f
> > max/min values?
> >
>
> I think a safe way to relax these rules would be to either:
> a) Add a client cap by which userspace can inform the kernel
>    it understands there are more complicated limits at play
>    and thus can't assume that everything will just work
> b) Maybe we could just tie that in with the atomic cap since
>    atomic clients are pretty much required to do the TEST_ONLY
>    dance anyway, so one might hope they have a working fallback
>    strategy. Though I suspect eg. the modesetting ddx wouldn't
>    like this. But we no longer allow atomic with X anyway so
>    that partcular argument may not hold much weight anymore.

What was the conclusion of the hack to not expose atomic to
modesetting ddx, due to the brokenness of it's atomic use?  I guess
that could also make the modesetting case go away..

BR,
-R
