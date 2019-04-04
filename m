Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF89C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017CF20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDDFvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:51:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfDDFvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:51:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A9D833078AAE;
        Thu,  4 Apr 2019 05:50:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE72D5FCC4;
        Thu,  4 Apr 2019 05:50:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 1AE8116E2D; Thu,  4 Apr 2019 07:50:56 +0200 (CEST)
Date:   Thu, 4 Apr 2019 07:50:56 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     David Airlie <airlied@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
Message-ID: <20190404055056.ddc2bdgjbgjj7tby@sirius.home.kraxel.org>
References: <20190403072318.31507-1-kraxel@redhat.com>
 <CAMwc25o=DZSVE5Qf5mow6es06Gk3=+6+8offXPY-JPgUkG_Shw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMwc25o=DZSVE5Qf5mow6es06Gk3=+6+8offXPY-JPgUkG_Shw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 04 Apr 2019 05:51:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 12:58:09PM +1000, David Airlie wrote:
> On Wed, Apr 3, 2019 at 5:23 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Time to kill some bad sample code people are copying from ;)
> >
> > This is a complete rewrite of the cirrus driver.  The cirrus_mode_set()
> > function is pretty much the only function which is carried over largely
> > unmodified.  Everything else is upside down.
> >
> > It is a single monster patch.  But given that it does some pretty
> > fundamental changes to the drivers workflow and also reduces the code
> > size by roughly 70% I think it'll still be alot easier to review than a
> > longish baby-step patch series.
> >
> > Changes summary:
> >  - Given the small amout of video memory (4 MB) the cirrus device has
> >    the rewritten driver doesn't try to manage buffers there.  Instead
> >    it will blit (memcpy) the active framebuffer to video memory.
> 
> Does it get any slower, with TTM I just wrote it to migrate just the
> frontbuffer in/out of VRAM on modeset, won't we end up with more
> copies now?

I didn't benchmark it, but if you care about performance you should not
be using cirrus anyway ...

For fbcon it probably doesn't make much of a difference, fbcon used a
shadow framebuffer before (for fbdev mmap and dirty tracking).

xorg probably ends up with more copying.

Anything doing display updates with page flips (i.e wayland) should end
up with less copying, because you have one copy (blit) instead of two
copies (migrate old frontbuffer out of vram, migrate new frontbuffer
into vram) on pageflip.

Speaking of wayland:  Seems at least gnome-shell insists on using XR24.

> >  - Only DRM_FORMAT_RGB565 (depth 16) is supported.  The old driver does
> >    that too by default.  There was a module parameter which enables 24/32
> >    bpp support and disables higher resolutions (due to cirrus hardware
> >    constrains).  That parameter wasn't reimplemented.

> This might be the big sticking point, this is a userspace regression
> for a feature that was explicitly added a few years ago, can we really
> get away without it?

Well, I can reintroduce the module option.  I don't see any other
reasonable way to support 32bpp.  If the driver reports XR24 as
supported and also adds the higher resolutions (which work with RG16
only) to the mode list userspace will of course try the higher
resolutions with XR24 and struggle ...

cheers,
  Gerd

