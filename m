Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7132EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA032075D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfDDC6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:58:23 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:37175 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDDC6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:58:22 -0400
Received: by mail-vk1-f193.google.com with SMTP id o187so290621vkg.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 19:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6cotQbwFsk2qIDHYtzr/C8+Nk1eKu83AkZtm4cvBq2s=;
        b=GKVumT6Of/tu04Z6zYqnMoPs+bVHT580C9FlTX0x6+E/m+ZCMtPs01uLmvbbOtba3G
         ND0mT5wgRVfkqvT3uB70s1yfaiwlXrI8HG6y4HE1sxjsYbyZ64CnjOzmyuScMpQJIFwm
         dWC94SybDcTUaoqIN7yxX12YLZ/ELvngYVmOcb66O6rlOmNs6aCUWZ6mG+BJCszo2MV9
         8lKaRqicv0Q8t5d33x8aRRa3VZZNdhmFlIA5AxEfNpBLc8Bbis9HmNTXK6z5m6ryZ3fw
         hZGpdrYdxCCkrb9jQzejePCQ82mepx6VoujeSBq+D8y7QzhgTIGjyw6lhIXk0S9jbJxg
         t3sg==
X-Gm-Message-State: APjAAAXW/xz+P0KEHipe5Dc9kDUWB2DRYKrCrdl5b9nLGjNRZoEw6tDg
        Hz9rBY6Tzp/5Xc+3rbgvgCKrKU/+R207e5BdJvvFtQ==
X-Google-Smtp-Source: APXvYqziQuLiexL1lPu9PXrR3i8mSED3RriMvvSCSeLWNTFN+dwmJM0kWuYo0yFqrFHbz+BwUHtRQoRBwWOE2nj6Yy4=
X-Received: by 2002:a1f:9991:: with SMTP id b139mr2330772vke.73.1554346701563;
 Wed, 03 Apr 2019 19:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190403072318.31507-1-kraxel@redhat.com>
In-Reply-To: <20190403072318.31507-1-kraxel@redhat.com>
From:   David Airlie <airlied@redhat.com>
Date:   Thu, 4 Apr 2019 12:58:09 +1000
Message-ID: <CAMwc25o=DZSVE5Qf5mow6es06Gk3=+6+8offXPY-JPgUkG_Shw@mail.gmail.com>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 5:23 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Time to kill some bad sample code people are copying from ;)
>
> This is a complete rewrite of the cirrus driver.  The cirrus_mode_set()
> function is pretty much the only function which is carried over largely
> unmodified.  Everything else is upside down.
>
> It is a single monster patch.  But given that it does some pretty
> fundamental changes to the drivers workflow and also reduces the code
> size by roughly 70% I think it'll still be alot easier to review than a
> longish baby-step patch series.
>
> Changes summary:
>  - Given the small amout of video memory (4 MB) the cirrus device has
>    the rewritten driver doesn't try to manage buffers there.  Instead
>    it will blit (memcpy) the active framebuffer to video memory.

Does it get any slower, with TTM I just wrote it to migrate just the
frontbuffer in/out of VRAM on modeset, won't we end up with more
copies now?

>  - All gem objects are stored in main memory and are manged using the
>    new shmem helpers.  ttm is out.
>  - Only DRM_FORMAT_RGB565 (depth 16) is supported.  The old driver does
>    that too by default.  There was a module parameter which enables 24/32
>    bpp support and disables higher resolutions (due to cirrus hardware
>    constrains).  That parameter wasn't reimplemented.
This might be the big sticking point, this is a userspace regression
for a feature that was explicitly added a few years ago, can we really
get away without it?

The rest looks good though!
Dave.

>  - The simple display pipeline is used.
>  - The generic fbdev emulation is used.
>  - It's a atomic driver now.
>
