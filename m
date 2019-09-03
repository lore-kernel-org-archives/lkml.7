Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0AFC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831DD217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Od7NQm+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfICJRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:17:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46374 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfICJRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:17:49 -0400
Received: by mail-io1-f66.google.com with SMTP id x4so34173358iog.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 02:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EuENc7crj8rqhon/s/3YCSFArTMbg3aHshy4WFfnKAI=;
        b=Od7NQm+xjFA01cLuFmHtQg+5TCm8UxKX2tGkiw8Mr4ix+wsAC5OqGe+z4RAxvjqQg/
         hOmmsMGgfL9ALOuzShRamJV28nj5bc9nAX+IVwfcCIvdcYByCAo2CXCt3AMWA49czLno
         sGMa721iOqpXpP31sm3p2t8tpiPNVDM2tg89o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuENc7crj8rqhon/s/3YCSFArTMbg3aHshy4WFfnKAI=;
        b=ZKu4bWaSCadU9MpiSQ5+yKl63xAfRSfIYrkxoJHtL/YCrArCvmVVCXetukXVmBMxns
         5btcOhoiETI4nO0JV4eVj4/OacBThHoh0Cu/ykZshpiEJqcSHUNFh0a/VaH67+EBu2vu
         T597QyKBdcZ9OEk51n9i4RaTQzy6n2P9T3Nypq8EiLVUDzuzpMOGgalbx/JHVvOCq/9T
         HF/JMxp18jYRz+kTUms8zqtlm6fLrnTRYoMF7ulOLSylyQGM2Mfg9hm48WSdRwDtQsbJ
         7xieCSSzDjlkx3x482zL+4bb7WVIGyRVRt/T7TScpYYP08CmIv+lIrASiSe0zSPcPhcV
         WqNw==
X-Gm-Message-State: APjAAAWnC2FW6K3khphYsSpNiHG0jZczgf54QhToSa7YiwcXMYbZSNS5
        8WDtSf3iGodWj5XRuv1tXBK8h0+7EtnaN+qzbppfSA==
X-Google-Smtp-Source: APXvYqzSAqgiAZOGqKdxa2ybdBypwTKeZ7jt6jzTE8fFeVXwQ2aRbTvX6cO5BVl/b39XJh9PglydDRoEYuNDaq5h9II=
X-Received: by 2002:a02:c94b:: with SMTP id u11mr34398002jao.35.1567502266965;
 Tue, 03 Sep 2019 02:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190821173742.24574-1-vgoyal@redhat.com> <CAJfpegvPTxkaNhXWhiQSprSJqyW1cLXeZEz6x_f0PxCd-yzHQg@mail.gmail.com>
 <20190903041507-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190903041507-mutt-send-email-mst@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 3 Sep 2019 11:17:35 +0200
Message-ID: <CAJfpeguB6fFhghuFS420ZQ+JuQvTLc5TgsGjoB_RvFrSVf+v5w@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual machines
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 10:31 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> Can the patches themselves be posted to the relevant list(s) please?
> If possible, please also include "v3" in all patches so they are
> easier to find.

I'll post a v4.

> I poked at
> https://lwn.net/ml/linux-kernel/20190821173742.24574-1-vgoyal@redhat.com/
> specifically
> https://lwn.net/ml/linux-kernel/20190821173742.24574-12-vgoyal@redhat.com/
> and things like:
> +       /* TODO lock */
> give me pause.
>
> Cleanup generally seems broken to me - what pauses the FS
>
> What about the rest of TODOs in that file?

AFAICS, some of those are QOI issues, and some are long term
performance items.  I see no blockers or things that would pose a
security concern.

That said, it would be nice to get rid of them at some point.

> use of usleep is hacky - can't we do better e.g. with a
> completion?

Yes.  I have a different implementation, but was planning to leave
this one in until the dust settles.

> Some typos - e.g. "reuests".

Fixed.

> > >  fs/fuse/Kconfig                 |   11 +
> > >  fs/fuse/Makefile                |    1 +
> > >  fs/fuse/control.c               |    4 +-
> > >  fs/fuse/cuse.c                  |    4 +-
> > >  fs/fuse/dev.c                   |   89 ++-
> > >  fs/fuse/dir.c                   |   26 +-
> > >  fs/fuse/file.c                  |   15 +-
> > >  fs/fuse/fuse_i.h                |  120 +++-
> > >  fs/fuse/inode.c                 |  203 +++---
> > >  fs/fuse/virtio_fs.c             | 1061 +++++++++++++++++++++++++++++++
> > >  fs/splice.c                     |    3 +-
> > >  include/linux/fs.h              |    2 +
> > >  include/uapi/linux/virtio_fs.h  |   41 ++
> > >  include/uapi/linux/virtio_ids.h |    1 +
> > >  init/do_mounts.c                |   10 +
> > >  15 files changed, 1462 insertions(+), 129 deletions(-)
> > >  create mode 100644 fs/fuse/virtio_fs.c
> > >  create mode 100644 include/uapi/linux/virtio_fs.h
>
> Don't the new files need a MAINTAINERS entry?
> I think we want virtualization@lists.linux-foundation.org to be
> copied.

Yep.

Stefan, do you want to formally maintain this file?

Thanks,
Miklos
