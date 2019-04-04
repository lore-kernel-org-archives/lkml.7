Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABE5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8241F20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YrfFHhxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfDDGbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:31:52 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54048 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfDDGbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:31:51 -0400
Received: by mail-it1-f193.google.com with SMTP id y204so1966200itf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 23:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1rT7cfdGTAKxZ0s5KNwvJVhwQTjQls7apnGG8IwBys=;
        b=YrfFHhxoV9TDfAxq8cxsgkK+2azGanIYQipRF8aZgDHCoK0LQmo/UyhKlaIoz7RElL
         JONo+QzYlAN4lgx+7DI5sjas74qGs4Oo0oCnjZYdqEeMWsmQuw6yP1pNAyydi1aWBkL/
         kF9ooyhS+gdlpB+6A6i6PTkdbAE1+VG210nhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1rT7cfdGTAKxZ0s5KNwvJVhwQTjQls7apnGG8IwBys=;
        b=mmhSPdnWVPstWyDejXKWnpv6gwcw/Ap3CPlEjIHFJh+tRtLlbtdmph4sYcHU3i9602
         zy7DHZXLNlKl9OQg0gEMYg9Rv15qYzpQW5JUWbOyBIAcd4HO02In+8piSj5yoYUBuWqe
         zu/1pJ4W5Rhwc2KuyKF7NV6q0XViZMQYrbU8TuduqBn9vTRq3SFjlDZGi5uWYtPj6Bqi
         22BhZjXE0tiXwBhXT1ywMliWsW2n7/EQ4+Ns6FnpNEYCsJ1scyD0VhpJqHUkWpTx8T/v
         i5jhooNYbuKTllu2nosXiZP4h214gJVVw1RHIht8XptRqZfr7s/2mv72aVbHiL8rjoCK
         j4zQ==
X-Gm-Message-State: APjAAAVo2l1HJnJ9Sv/RWQ4+UCoaqS6/Ziz+qr/7MHKUDIn3uJD7Gbk4
        Xb7AMh/QPlnmIVyzap+L5By0AojsMawrkWkl/JgeJg==
X-Google-Smtp-Source: APXvYqx20QWMxFDJ18EgHqmKQZXgs481vVoa318+Yg9FKNogyshQXeXrvovyiht21BrHfv5oxj235+pDHWU9YdIkz2c=
X-Received: by 2002:a24:480e:: with SMTP id p14mr3799657ita.61.1554359511061;
 Wed, 03 Apr 2019 23:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190403072318.31507-1-kraxel@redhat.com> <CAMwc25o=DZSVE5Qf5mow6es06Gk3=+6+8offXPY-JPgUkG_Shw@mail.gmail.com>
 <20190404055056.ddc2bdgjbgjj7tby@sirius.home.kraxel.org>
In-Reply-To: <20190404055056.ddc2bdgjbgjj7tby@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 4 Apr 2019 08:31:39 +0200
Message-ID: <CAKMK7uFbLcziLXrwds9QZBBPFiBDC_O+X9fiuutNjsutaPW+sQ@mail.gmail.com>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 7:51 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Apr 04, 2019 at 12:58:09PM +1000, David Airlie wrote:
> > On Wed, Apr 3, 2019 at 5:23 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > Time to kill some bad sample code people are copying from ;)
> > >
> > > This is a complete rewrite of the cirrus driver.  The cirrus_mode_set()
> > > function is pretty much the only function which is carried over largely
> > > unmodified.  Everything else is upside down.
> > >
> > > It is a single monster patch.  But given that it does some pretty
> > > fundamental changes to the drivers workflow and also reduces the code
> > > size by roughly 70% I think it'll still be alot easier to review than a
> > > longish baby-step patch series.
> > >
> > > Changes summary:
> > >  - Given the small amout of video memory (4 MB) the cirrus device has
> > >    the rewritten driver doesn't try to manage buffers there.  Instead
> > >    it will blit (memcpy) the active framebuffer to video memory.
> >
> > Does it get any slower, with TTM I just wrote it to migrate just the
> > frontbuffer in/out of VRAM on modeset, won't we end up with more
> > copies now?
>
> I didn't benchmark it, but if you care about performance you should not
> be using cirrus anyway ...
>
> For fbcon it probably doesn't make much of a difference, fbcon used a
> shadow framebuffer before (for fbdev mmap and dirty tracking).
>
> xorg probably ends up with more copying.
>
> Anything doing display updates with page flips (i.e wayland) should end
> up with less copying, because you have one copy (blit) instead of two
> copies (migrate old frontbuffer out of vram, migrate new frontbuffer
> into vram) on pageflip.
>
> Speaking of wayland:  Seems at least gnome-shell insists on using XR24.

Yeah XR24 is pretty much mandatory. Noralf added a few helpers to
convert XR24 to other formats, for display not supporting anything
else. Because userspace.

> > >  - Only DRM_FORMAT_RGB565 (depth 16) is supported.  The old driver does
> > >    that too by default.  There was a module parameter which enables 24/32
> > >    bpp support and disables higher resolutions (due to cirrus hardware
> > >    constrains).  That parameter wasn't reimplemented.
>
> > This might be the big sticking point, this is a userspace regression
> > for a feature that was explicitly added a few years ago, can we really
> > get away without it?
>
> Well, I can reintroduce the module option.  I don't see any other
> reasonable way to support 32bpp.  If the driver reports XR24 as
> supported and also adds the higher resolutions (which work with RG16
> only) to the mode list userspace will of course try the higher
> resolutions with XR24 and struggle ...

Maybe atomic userspace is better (it should be, it can do TEST_ONLY),
but I'm not so sure that exposing all modes for atomic clients would
work. Also, currently not possible with our probe helpers (we don't
refilter the list per client).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
