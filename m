Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66780C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADEC20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfDIGGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:06:34 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44784 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfDIGGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:06:32 -0400
Received: by mail-vs1-f66.google.com with SMTP id j184so9081698vsd.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 23:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QghUGeU0lUIj1ypciruVkJezIKMuwoGPNeUayMnA2X0=;
        b=MVDjLZXfobAw9Y5aWvc7vaa6UbnUNiowUaWXeK4YUCb3clyep93QzwemxnskfPI0g9
         7aClz1VHKBfhqkUX1DEBuHMeUgHsfTI9QpH7lPkqBxQXczwuBgVVcT4tzLCm7V9K5YaU
         Jn/ODdphokIAGcdazkkAIT0o1YeMy3t2NJn7spH2ItvY0apa0YmC0hDjl7TirzS+etMC
         Xk6ZSPKpi5PL93Jx3KsTudVDG4qEP/+zjgewgfy2pqI8HsbpBZfhahfIJ0VYc2nzqv0a
         2t2p1IEz+iUjC90EIyl7IKUNqFHO84OEmXGj3LTeB0Q0ct/fvYUx7/Rffik1WRe/o6fT
         9+fQ==
X-Gm-Message-State: APjAAAWmGJzVp5w2IawUA7mHHY0geKV+KDi1/Iw4qX4zVDUkDUExsLuz
        noXvfGuK/4jIkWKDJealTY+X3ktWDJKjJ+jJ+2i9iA==
X-Google-Smtp-Source: APXvYqwTyH4B5DHaUuHob3hn0CCd0qn9wA1SAGDeSuiKXcQtAmaxlaWzMuGV40Xy/+IGy0xai3bZbbQqwIkbuBpNjiU=
X-Received: by 2002:a67:ec47:: with SMTP id z7mr17098629vso.142.1554789990778;
 Mon, 08 Apr 2019 23:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190110081750.11358-1-kraxel@redhat.com> <CAPM=9tx8N6jxVzsT-RqtQFrFb9qLK4qUUje+d=fpTYZ6+PnYpg@mail.gmail.com>
 <CAPM=9tyEmn2LXhNmPSOi7JAgBc3QZwNtM+8FT8CWebz4GztaJA@mail.gmail.com> <20190409060323.xrw3fwj3yvcxsx3t@sirius.home.kraxel.org>
In-Reply-To: <20190409060323.xrw3fwj3yvcxsx3t@sirius.home.kraxel.org>
From:   David Airlie <airlied@redhat.com>
Date:   Tue, 9 Apr 2019 16:06:19 +1000
Message-ID: <CAMwc25q-7rfR=31R=FEVC47z2HvDK5xN+aOKqq00yoXSpudusQ@mail.gmail.com>
Subject: Re: [PATCH] drm/qxl: drop prime import/export callbacks
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 4:03 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Apr 09, 2019 at 02:01:33PM +1000, Dave Airlie wrote:
> > On Sat, 12 Jan 2019 at 07:13, Dave Airlie <airlied@gmail.com> wrote:
> > >
> > > On Thu, 10 Jan 2019 at 18:17, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > >
> > > > Also set prime_handle_to_fd and prime_fd_to_handle to NULL,
> > > > so drm will not advertive DRM_PRIME_CAP_{IMPORT,EXPORT} to
> > > > userspace.
> >
> > It's been pointed out to me that disables DRI3 for these devices, I'm
> > not sure that is the solution we actually wanted.
> >
> > any ideas?
>
> Well.  Lets have a look at where we stand:
>
>  * drm_gem_prime_export() works with qxl, you'll get a dma-buf handle.
>
>  * Other drivers trying to map that dma-buf (drm_gem_map_dma_buf()
>    callback) will not work, due to the ->gem_prime_get_sg_table()
>    callback not being there.
>
>  * drm_gem_prime_import() will work with buffers from the same qxl
>    device, there is a shortcut for this special case.  Otherwise it
>    will not work, due to the ->gem_prime_import_sg_table() callback
>    not being there.
>
> Bottom line: you can use prime to pass qxl object handles from one
> application to another.  But you can't actually export/import qxl
> buffer objects from/to other devices.
>
> Problem is that we have no way to signal to userspace that prime can
> be used that way.
>
> Setting DRM_PRIME_CAP_{IMPORT,EXPORT} even though the driver can't
> do that leads to other problems.  Userspace thinks it can have other
> devices (intel vgpu for example) handle the rendering, then import
> the rendered buffer into qxl for scanout.
>
> Should we add something like DRM_PRIME_CAP_SAME_DEVICE?

Yeah I expect we need some sort of same device only capability, so
that dri3 userspace can work.

If we just fail importing in these cases what happens? userspace just
gets confused, I know we used to print a backtrace if we hit the mmap
path, but if we didn't do that what happens?

Dave.
