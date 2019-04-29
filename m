Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DA6C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251AE2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="D8ZGXuNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfD2H62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 03:58:28 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53143 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfD2H61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:58:27 -0400
Received: by mail-it1-f195.google.com with SMTP id x132so14901105itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UeOi90RYK8x7ozYD+9mGxr1il4jAoIstt7bREKCu3cA=;
        b=D8ZGXuNPj9TpGPOtq1s2SfKPo8/hGGiu/RdCPTwWh9MfYk3OL8KyrOZNnRvCz92Rb2
         d0PMJUqsi8lwo6mK4r6I+8T+rcP2qoGPi52PcZkxlJ3J4OwpJ9igf36ba1TNmUPvpj5b
         QhnTTh0tqGm70lA32HYjSGl8FLFMHP2IhsoxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UeOi90RYK8x7ozYD+9mGxr1il4jAoIstt7bREKCu3cA=;
        b=rH3KOQ+CJg10Q7ZJoKGQmS3CJGBU0NEcTB9qrX2H1vbdsRlkHdS4YjnEdh8xu2K04B
         roB2p7ZT/9bayZd9r0fU+jVpzzA5aGG9oo0gaprcCzXNQXOh+8EQpXVicgUVXoByvK/l
         /S+qu0jwEWKS5+cot/Z3GFejv74xZuf6mRoOFZyS2D5nJwDS2TkJI9T7Pc8tWEPzKbAG
         nO4ACIBPJLrvHN3x5GAghvzOVm6V1bZh6V2Ne46JX4vpgWKKEiYnzaZMxKhcvWwQzS+z
         uCI3TkxEQQcgEo3EBL7zCoKBIVRs2bj1Bg+ffLB+Eup/LyydEOpsgUMJsJZHcPI0ubzk
         s3sw==
X-Gm-Message-State: APjAAAV8fKif4VaNQjo+aXv8FbC0Z7eB/f1O9mlgWI6ogd2Dqpb9fRXI
        +UE0UHJrNwY0WkcFkg/kRQmt0uXBGEX8+19xMIZYWQ==
X-Google-Smtp-Source: APXvYqzsp6G7y3NwOVHRY09+SdwkQewuFMAtJSUys7eWw4XEfjH4ln4GMV5tBZs2ifQs0xWG/14owrutG4AoiC3M114=
X-Received: by 2002:a02:a394:: with SMTP id y20mr19482883jak.96.1556524706956;
 Mon, 29 Apr 2019 00:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190426053324.26443-1-kraxel@redhat.com> <CAKMK7uG+vMU0hqqiKAswu=LqpkcXtLPqbYLRWgoAPpsQQV4qzA@mail.gmail.com>
 <20190429075413.smcocftjd2viznhv@sirius.home.kraxel.org>
In-Reply-To: <20190429075413.smcocftjd2viznhv@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 29 Apr 2019 09:58:14 +0200
Message-ID: <CAKMK7uFB8deXDMP9cT634p_dK5LsM37R1v_vGhAEY1ZLZ+WBVA@mail.gmail.com>
Subject: Re: [Spice-devel] [PATCH] Revert "drm/qxl: drop prime import/export callbacks"
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        David Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 9:54 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Apr 26, 2019 at 04:21:37PM +0200, Daniel Vetter wrote:
> > On Fri, Apr 26, 2019 at 7:33 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > This reverts commit f4c34b1e2a37d5676180901fa6ff188bcb6371f8.
> > >
> > > Simliar to commit a0cecc23cfcb Revert "drm/virtio: drop prime
> > > import/export callbacks".  We have to do the same with qxl,
> > > for the same reasons (it breaks DRI3).
> > >
> > > Drop the WARN_ON_ONCE().
> > >
> > > Fixes: f4c34b1e2a37d5676180901fa6ff188bcb6371f8
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >
> > Maybe we need some helpers for virtual drivers which only allow
> > self-reimport and nothing else at all?
>
> The current gem prime helpers handle this reasonable well,
> I don't see a need for that.
>
> More useful would be some way to signal this self-reimport capability
> to userspace somehow.  See DRM_PRIME_CAP_LOCAL patch.

Userspace is supposed to test whether import/export works for a
specific combo, not blindly assume it does and then keel over. I think
we need to fix that, not add more flags - there's lots of reasons why
a given pair of devices can't share buffers (e.g. all the contiguous
allocations stuff on socs).

> Right now I have the choice to set DRM_PRIME_CAP_{IMPORT,EXPORT}, in
> which case some userspace assumes it can do cross-driver export/import
> and trips over that not working.  Or I do not set
> DRM_PRIME_CAP_{IMPORT,EXPORT}, which breaks DRI3 ...

Yeah that's not an option.
-Daniel

> > I think there's qxl, virgl,
>
> export is implemented for virgl, and import should be possible too.
>
> qxl/bochs is simliar to vmgfx, it could be done but dma-bufs would
> basically be bounce buffers (need copy from/to vram) so probably not
> worth the effort.
>
> cheers,
>   Gerd
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
