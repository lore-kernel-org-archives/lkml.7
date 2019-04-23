Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863AAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5719021841
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YbcBmxrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfDWOCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:02:45 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34006 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDWOCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:02:45 -0400
Received: by mail-it1-f193.google.com with SMTP id z17so2065568itc.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 07:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GQ5sD8gQEIkSpJXMewaAlMH3xJOLjDgfWrtY63eJJRQ=;
        b=YbcBmxrdwAizJ47NfdXGc32ozaUMRYMJhC2X8I2cz8E5YJ3Nsztl2hZcJfyIQMMd6G
         PtEw55JDv8JAnGyXSXO4rapZeUn/ygZ32gp5aND/8zkysBcVg+WdQixlNXmTAjDaeTI3
         o+R0dkXkDNER2R4/aTHkoQTPz3kqeJ+Xz4iiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GQ5sD8gQEIkSpJXMewaAlMH3xJOLjDgfWrtY63eJJRQ=;
        b=ScAjDJKUVkNNW0g6mudnDPfaNKhJ+MiBO5rrB3B4TotAwGyMaBJ5QSUTzsrJf8sGCC
         D40df9zGlCbCeWdJ3RBITBHlg6XXYerPtwyiz4GoP08LFxv4t8KZThMblFkcjAMJd8kC
         jSsIe7ZtFpHfbgRZ+pqBy7sAwXvPxP7dVrWZda11hiZP7SnxTgz0TKD0kF27fsB+jkIn
         f9BMwSua5Q53eIMYXbJc4zQjWtpe9koi+vOrVlJR2bmeCNFmJOH8Ib+2ZVKshQlHVh+J
         RCCOvP1aLiNfoqclWtDzMfGNJYJeiBgQB9kduZEEENqh2XzSgibI3Rhxg289/8ONBYAS
         VAcQ==
X-Gm-Message-State: APjAAAWTIORx87cBwk386dOcSx6X3H5t2gcVjd8c0Y3bM1/MOfJn+pAC
        iFHG1fHgq1OWLab/ihqm5VzJO58Y/Wi5/AU9NIiPIA==
X-Google-Smtp-Source: APXvYqySkKFpA7mmDb4NHr627kE7vGYSalK7Vi9pTqVxsnUt3RUCqcD7eKxXTJcBksIvlSiQesHNgZGei3ZjhevKu8M=
X-Received: by 2002:a02:c4cf:: with SMTP id h15mr17663381jaj.96.1556028164133;
 Tue, 23 Apr 2019 07:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <1556016490-6906-1-git-send-email-ben.davis@arm.com>
 <CAKMK7uE=m4dYodGp34Twcs-HEV4rExvvguM5m1Qt9HzUD8ZYEw@mail.gmail.com> <20190423130013.GX15144@e110455-lin.cambridge.arm.com>
In-Reply-To: <20190423130013.GX15144@e110455-lin.cambridge.arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 23 Apr 2019 16:02:31 +0200
Message-ID: <CAKMK7uHwZ_XZCEyvU0LUnya-2+Z80yP9_EOoAc5UrR45tZ8fPw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add writeback scaling
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     Ben Davis <Ben.Davis@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>, Brian Starkey <Brian.Starkey@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 3:00 PM Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>
> On Tue, Apr 23, 2019 at 02:24:11PM +0200, Daniel Vetter wrote:
> > On Tue, Apr 23, 2019 at 12:48 PM Ben Davis <Ben.Davis@arm.com> wrote:
> > >
> > > Add support for scaling on writeback. To do this add writeback_dest_w
> > > and writeback_dest_h as writeback connector properties to specify the
> > > desired output dimensions.
> > > Then implement downscaling on writeback for Malidp-550 and Malidp-650
> > > (upscaling on writeback is not supported on these devices).
> > >
> > > v2: Use 0 as default for writeback_w,h and so update range to use 1 a=
s
> > >     minimum.
> >
> > Hm I missed that, I don't think that's good, since it prevents
> > userspace from blindly writing back the properties it's read. We've
> > tried hard to avoid that, since we're suggesting compositor can take a
> > snapshot of all kms properties (including the ones they don't
> > understand) and restore that on vt switching. Hence stuff like fence
> > fds returning -1, and accepting -1 as NULL to make this work.
>
> Is that they way it should work, though? I remember a few good years
> back, before KMS, there were lots of issues with X server hanging and
> not restoring the vt mode correctly. Should it not be that on getting
> back control of a DRM master, an application sets it last known good
> mode that it had, before it lost (or gave away) control?

Given that we've recommended both approaches I expect there's a mix of
both approaches out there in the real world, with people just hacking
things up until it works. That's also what we're doing with the
in-kernel fbdev emulation. I'd say defacto this means it's all
ill-defined, but also that we imo should make a best effort to support
either approach.

> > tldr; I think range needs to include 0, and we need make that a
> > special thing, maybe enforced with a
> > drm_connector_state_compute_writeback_dst_h/w, which takes
> > crtc_state->mode.v/hdisplay into account if the writeback_dst_h/w is
> > 0.
>
> Repeating just to make sure we're on the same page: we allow 0 as valid
> range value, but writeback_dst_h/w ultimately gets updated before the
> commit gets passed on to the driver to use crtc_state->mode.v/hdisplay
> so as not to trigger any scaling. Correct?

That would also break stuff, since then you'd scale the next time
v/hdisplay are different. Except if we again clear them back to 0 on
duplicate_state, which I guess would work since writeback is one-shot.
I was thinking more of a helper function, but your approach +
resetting always to 0 on duplicate_state + lots of comments/kerneldoc
should work too. And I guess would be more robust, since driver
authors can't accidentally use the wrong state since it's fixed up.
-Daniel

>
> Best regards,
> Liviu
>
>
> > -Daniel
> >
> > >
> > > v3: Rename properties to specify they are destination width/height.
> > >     Make sure the values from the properties are passed to
> > >     enable_memwrite rather than the framebuffer dimensions
> > >
> > > Ben Davis (2):
> > >   drm: Add writeback_dest_w,h properties
> > >   drm/malidp: Enable writeback scaling
> > >
> > >  drivers/gpu/drm/arm/malidp_crtc.c | 49 +++++++++++---------
> > >  drivers/gpu/drm/arm/malidp_crtc.h | 12 +++++
> > >  drivers/gpu/drm/arm/malidp_drv.c  | 10 +++--
> > >  drivers/gpu/drm/arm/malidp_hw.c   | 45 +++++++++++++------
> > >  drivers/gpu/drm/arm/malidp_hw.h   | 19 ++++++--
> > >  drivers/gpu/drm/arm/malidp_mw.c   | 94 +++++++++++++++++++++++++++++=
+---------
> > >  drivers/gpu/drm/arm/malidp_regs.h |  1 +
> > >  drivers/gpu/drm/drm_atomic_uapi.c |  8 ++++
> > >  drivers/gpu/drm/drm_writeback.c   | 30 +++++++++++++
> > >  include/drm/drm_connector.h       |  4 ++
> > >  include/drm/drm_mode_config.h     | 10 +++++
> > >  11 files changed, 220 insertions(+), 62 deletions(-)
> > >  create mode 100644 drivers/gpu/drm/arm/malidp_crtc.h
> > >
> > > --
> > > 2.7.4
> > >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>
> --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     =C2=AF\_(=E3=83=84)_/=C2=AF



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
