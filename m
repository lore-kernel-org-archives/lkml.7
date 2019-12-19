Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2674C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639DE227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OG0zKHFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfLSMmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:42:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45005 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSMmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:42:46 -0500
Received: by mail-ot1-f66.google.com with SMTP id h9so4511948otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 04:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bYF5D8OyCxsifRan1VNFDw31YCOJxCs5X35xN2Xsu9c=;
        b=OG0zKHFbfaEQmlUoP8o3p3ZUiQjwQ5QzZJmv79u1eQfazk7ZeVXvgqICOzW9MLuciY
         7ERjSOGUHu7XqWG87h9vXirzpuudaFMsQXZS7pMry7t/niao9X0WXqiUtlKOI46MVHRu
         Dg/qVGrRrHeT/AXCXrwWDqgD9VtuvVkPSYiHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bYF5D8OyCxsifRan1VNFDw31YCOJxCs5X35xN2Xsu9c=;
        b=TeCeCd2sHmNwd/TMnjJ2nqgdsu6ONT/oNFgEP9kLL06cODShVnOnACrD0KYY4Qojy9
         xujio3pl5CgGB1sGCTDDpPJNk3tTveOqNKzqllu7iSFNzyUaP6ocn49r2LkzrFRXt7Yk
         OuQ0XHJ6T7CcRWSuq70jr8+a+KNP82DU5TjBIRvF1YMsNDiB+XM5zHJF6fFiUwmqjD+2
         BCw3L8sZRy4qBiBW1P55r8ZpUEqHQ47dNlwTW3GDQvyL/nh7wkbZJsZcnBagByzZlCg5
         g/xY+r5zL+iPnwHPq4rqIzpzj5aWlJ4r8/EKZ4NJYVbBQperSPqByeXQKg4py+2IP4Vd
         97dg==
X-Gm-Message-State: APjAAAXugtTbHgASZJ+G9VMYKHEux10LKHvZxM4sMa60QhcMT7NAA30h
        7K2dIUnPSptDatZKAMWUhyknoQ/oQold95FxOBI0vA==
X-Google-Smtp-Source: APXvYqwC4oTQJQT47ypqRnpTBZmyJTlKmHL17s0WvbC6jXR6ef19PMFuIxeZsGL9iHIGpAikF+RiJyv/heqQGtxVkBo=
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr8979147otq.281.1576759365177;
 Thu, 19 Dec 2019 04:42:45 -0800 (PST)
MIME-Version: 1.0
References: <07899bd5-e9a5-cff0-395f-b4fb3f0f7f6c@huawei.com>
 <f867543cf5d0fc3fdd0534749326411bcfc5e363.camel@collabora.com>
 <c2e5f5a5-5839-42a9-2140-903e99e166db@huawei.com> <fde72f73-d678-2b77-3950-d465f0afe904@huawei.com>
 <CAKMK7uFr03euoB6rY8z9zmRyznP41vwfdaKApZ_0HfYZT4Hq_w@mail.gmail.com>
 <fcca5732-c7dc-6e1d-dcbe-bfd914a4295b@huawei.com> <CAKMK7uE+nfR2hv1ybfv1ZApZbGnnX7ZHfjFCv5K72ZaAmdtfug@mail.gmail.com>
 <20191219113151.sytkoi3m7rrxzps2@sirius.home.kraxel.org>
In-Reply-To: <20191219113151.sytkoi3m7rrxzps2@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 19 Dec 2019 13:42:33 +0100
Message-ID: <CAKMK7uHEL3WzSHDM3XdLwOBtQUtygK6x-md8W1MVsAryDDgFog@mail.gmail.com>
Subject: Re: Warnings in DRM code when removing/unbinding a driver
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     John Garry <john.garry@huawei.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        "kongxinwei (A)" <kong.kongxinwei@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linuxarm <linuxarm@huawei.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dbueso@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 12:32 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > >   Like I said, for most drivers
> > > > you can pretty much assume that their unload sequence has been broken
> > > > since forever. It's not often tested, and especially the hotunbind
> > > > from a device (as opposed to driver unload) stuff wasn't even possible
> > > > to get right until just recently.
> > >
> > > Do you think it's worth trying to fix this for 5.5 and earlier, or just
> > > switch to the device-managed interface for 5.6 and forget about 5.5 and
> > > earlier?
> >
> > I suspect it's going to be quite some trickery to fix this properly
> > and everywhere, even for just one driver. Lots of drm drivers
> > unfortunately use anti-patterns with wrong lifetimes (e.g. you can't
> > use devm_kmalloc for anything that hangs of a drm_device, like
> > plane/crtc/connector). Except when it's for a real hotunpluggable
> > device (usb) we've never bothered backporting these fixes. Too much
> > broken stuff unfortunately.
>
> While being at it:  How would a driver cleanup properly cleanup gem
> objects created by userspace on hotunbind?  Specifically a gem object
> pinned to vram?

Two things:
- the mmap needs to be torn down and replaced by something which will
sigbus. Probably should have that as a helper (plus vram fault code
should use drm_dev_enter/exit to plug races).
- otherwise all datastructures need to be properly refcounted.
drm_device now is (if your driver isn't broken), but any dma_fence or
dma_buf we create and export has an independent lifetime, and
currently the refcounting for is still wobbly I think.

So some work to do, both in helpers/core code and in drivers to get updated.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
