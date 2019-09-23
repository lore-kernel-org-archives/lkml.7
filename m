Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1505DC4740C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C4820882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k42kXdpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393318AbfIWGvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 02:51:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:47031 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393269AbfIWGvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 02:51:19 -0400
Received: by mail-io1-f66.google.com with SMTP id c6so17612472ioo.13;
        Sun, 22 Sep 2019 23:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=evwzKkn5TJ8V/5p8U1GA5lnr2fQciYS7Ye2nzlu/Ar0=;
        b=k42kXdpEzpJIgiprOwLFh1cwZ7Yys+0E1k4wofFz3IuJs4wWXaFe4JeJh15Ha/ekpH
         WI/bj3taqJE1PD5I+geYoVLCxlLk0XuLG3m0y2kX/2PZhuGWV+4QvOT9zMMdTmCrQMMt
         0pALJMqQn0OBD8xISo/RWq6z6LfVxJTncDdVWUN/U8FT/m4oLnmrtEK26QRpNFt/tMiF
         7Xv4V2MntqeOtGO3BXBGCqqvG1CqwddbzwbOn4TTVK/IWcQbqqrNsOwKxBo4NzysbZrL
         n9Lmr8aEt6jtGqL81UaeoUaelEXCXIKC8HkO1QnP6wt7RaC5MRkiyilWwufMzBj95MiH
         qYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=evwzKkn5TJ8V/5p8U1GA5lnr2fQciYS7Ye2nzlu/Ar0=;
        b=jFHsdBDSdCMwh6FB3xexl1hFWaDGfLRULnIdEF5OObd3fT5rbxMZ3j9DooKE320gyH
         qcj0dOM/IMM53wSy/pHil1PXfEbu73njTtQRiTZzakYfgq/HNICVeuQ5l5oBWXlc+ZXb
         nMz0z/b/zeyXR4BupYR5gZLLNOYsZ/HPTmUWzEbDB9KBFd99lpJl9SefZnPv9aKwWdD2
         JWa9zgPUkArcS3TJDVcFSQ7Dvi3SHDGcxJcRnDF1408ZOM+6yQzgsQkopBb0+PDqICS1
         d1zWXRM2Hn9IaHQ6fIEcFQ+NQBfJAcJ+yrryarnLctqzWH3Rw4i9HdSuZyOtOATIjnWb
         vevg==
X-Gm-Message-State: APjAAAUrQln765J01aJtRGOjxUk2/5KbUvsQ/iSSJTR+jkeoL38JTfmk
        OCnYwNwCHW5YlmV2FLgGihusWgDAM3YdBrgdYiA=
X-Google-Smtp-Source: APXvYqwHJLJqkepkero16CeFnVT2p/BRJnGlNyIoVpnrwyU/cIXQnIS9UN2pJqBGUqfPEiA0WorKHiMZRRy9rEkEMlE=
X-Received: by 2002:a5d:8b07:: with SMTP id k7mr27637147ion.20.1569221478478;
 Sun, 22 Sep 2019 23:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190907090534.GB1712@pc-sasha.localdomain> <20190920194450.GA3970@pc-sasha.localdomain>
 <CAKMK7uECOW2YigBe7aeCDPYXoXJ8TVh65xvKBjJXXRt5Y7HngA@mail.gmail.com> <20190923063803.c7zpqwcqq5f2acq5@sirius.home.kraxel.org>
In-Reply-To: <20190923063803.c7zpqwcqq5f2acq5@sirius.home.kraxel.org>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Mon, 23 Sep 2019 09:50:41 +0300
Message-ID: <CAJ1xhMV2ikra9udRhhLLntLxZKO23jLkU=9AeP=denALhw8r_w@mail.gmail.com>
Subject: Re: Kernel panic during drm/nouveau init 5.3.0-rc7-next-20190903
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Dave Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 9:38 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > > 'Git bisect' has identified the following commits as being 'bad'.
> > >
> > > b96f3e7c8069b749a40ca3a33c97835d57dd45d2 is the first bad commit
> > > commit b96f3e7c8069b749a40ca3a33c97835d57dd45d2
> > > Author: Gerd Hoffmann <kraxel@redhat.com>
> > > Date:   Mon Aug 5 16:01:10 2019 +0200
> > >
> > >     drm/ttm: use gem vma_node
> > >
> > >     Drop vma_node from ttm_buffer_object, use the gem struct
> > >     (base.vma_node) instead.
> > >
> > >     Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > >     Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > >     Link: http://patchwork.freedesktop.org/patch/msgid/20190805140119=
.7337-9-kraxel@redhat.com
>
> > > Today, I upgraded the kernel to 5.3.0-next-20190919, which booted fin=
e
> > > with no Xorg regressions to report.
> > >
> > > Just wondering if the earlier kernels would not boot for me because o=
f
> > > the changes introduced by the 'bad' commits being perhaps incomplete?
>
> Yes, we had a regression in nouveau, fixed by this patch (in drm-misc-nex=
t):
>
> commit 019cbd4a4feb3aa3a917d78e7110e3011bbff6d5
> Author: Thierry Reding <treding@nvidia.com>
> Date:   Wed Aug 14 11:00:48 2019 +0200
>
>     drm/nouveau: Initialize GEM object before TTM object
>
>     TTM assumes that drivers initialize the embedded GEM object before
>     calling the ttm_bo_init() function. This is not currently the case
>     in the Nouveau driver. Fix this by splitting up nouveau_bo_new()
>     into nouveau_bo_alloc() and nouveau_bo_init() so that the GEM can
>     be initialized before TTM BO initialization when necessary.
>
>     Fixes: b96f3e7c8069 ("drm/ttm: use gem vma_node")
>     Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>     Acked-by: Ben Skeggs <bskeggs@redhat.com>
>     Signed-off-by: Thierry Reding <treding@nvidia.com>
>     Link: https://patchwork.freedesktop.org/patch/msgid/20190814093524.GA=
31345@ulmo
>
> HTH,
>   Gerd
>

Terrific.
Thanks for the info.
