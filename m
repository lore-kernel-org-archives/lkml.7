Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE454C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB23A20663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVrx2hyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbfDQSGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:06:30 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37016 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDQSG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:06:29 -0400
Received: by mail-it1-f194.google.com with SMTP id u65so5897266itc.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivMa+ybPpD2KsvvjrcpbeauKLe55Ky4VkAKG13FO8Io=;
        b=rVrx2hyRcLVlGagFejkXXE3y+RztYrKGMLAByTjxCSikwhVXq9a0BBHmwcO0WN2BeY
         aZ1Rcd5Nsa/Qn/U9QkWwo9enrFrvaZQ0Ur9zSgWH3yfDOPnpMUe7sYNKptpUz0KDNDXP
         NsBbI/9ZX3u5987dQFFGtjjotzePBRqKyhG1q7Ra3z7lBjZ3XV22UUyQ2U7tkpm/QeIX
         4ApuNSAPf2oAFUlhhSbit65dMlDP96CsoDYfGMN7xiMlQEmjEaECbsEh/dESgousgC30
         jXGYiNplkr/kwMJW8WPpwv1Db096EFiDaKcln+MWBpzsf6W4v9/Q0G5hjC466f5tAOev
         Updg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivMa+ybPpD2KsvvjrcpbeauKLe55Ky4VkAKG13FO8Io=;
        b=oDgabe5+X0fGQAxgIkuiqR0aHOGA+l5KEN9bIRHPXIMBsNWZ+aMNUglSz792cV5oWY
         AxZep9hTq4JBYh4v2Qa/BP7hIjV26okgxiIt9cOGribQz68aM5PHcW72nMFcNoy9hMV6
         XLQUCyz2RD8sWdJjShtUrUdvjVWE0+vMx5V9aKDg4jhNNlOE5iFvlzwcz5p4lOzt0dKZ
         e6J7XJfrdJftpKUPjF7Ou7nbxmA5lMzpPFuXFrZV3d1zdPr8vppgjMGYNDKAGeuJwWwV
         pqetOlaXV59SL0zD7cE8gLxcxMqj086Idsh3XF6eyVv2oZvMHg42PG2JFZrhD8s1ySaD
         XlJQ==
X-Gm-Message-State: APjAAAWHa2JAcTD4WeKwAZkOyIPA9Xu3HiHb2U9vB7LLVON7syL7vbEh
        Vq7iU/O/+lwzgq58YOWalQvi8x9imQC4/g7KmHo=
X-Google-Smtp-Source: APXvYqzjKvN7Ylw/V4E/s63ffbR5uzZo4rzoZgb7wXiRRC7U9Hs1viJaGKG1r3AyJ6I8Et3YDqXpUE62l2GG5sTyUeY=
X-Received: by 2002:a24:43cf:: with SMTP id s198mr832232itb.113.1555524388551;
 Wed, 17 Apr 2019 11:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190410114227.25846-1-kraxel@redhat.com> <20190410114227.25846-4-kraxel@redhat.com>
 <CAAfnVBm5XZx8P7k5np823-uRr-kqf0ey9Y3GtoE2Geo4dCdQ=g@mail.gmail.com>
 <20190411050322.mfxo5mrwwzajlz3h@sirius.home.kraxel.org> <CAAfnVB=v+daY0Q+mtdK2Q=F7iS_Ra7jGYfic3twfnUVo=tz3Yg@mail.gmail.com>
 <20190412054924.dvh6bfxfrbgvezxr@sirius.home.kraxel.org> <CAPaKu7QsDp=kRsMzMf0YcvafsXBsr_m4bstuZiWAcmYiV_AxnQ@mail.gmail.com>
 <20190417095750.lre3xrg4dlgskfjg@sirius.home.kraxel.org>
In-Reply-To: <20190417095750.lre3xrg4dlgskfjg@sirius.home.kraxel.org>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 17 Apr 2019 11:06:17 -0700
Message-ID: <CAPaKu7S+QarGDig8fsc1xDyg3z=22ntcCtVMxWh1H3bEzEwZ3A@mail.gmail.com>
Subject: Re: [PATCH 3/3] virtio-gpu api: VIRTIO_GPU_F_RESSOURCE_V2
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Jason Wang <jasowang@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO CORE, NET AND BLOCK DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        David Airlie <airlied@redhat.com>, virtio@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 2:57 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Apr 12, 2019 at 04:34:20PM -0700, Chia-I Wu wrote:
> > Hi,
> >
> > I am still new to virgl, and missed the last round of discussion about
> > resource_create_v2.
> >
> > From the discussion below, semantically resource_create_v2 creates a host
> > resource object _without_ any storage; memory_create creates a host memory
> > object which provides the storage.  Is that correct?
>
> Right now all resource_create_* variants create a resource object with
> host storage.  memory_create creates guest storage, and
> resource_attach_memory binds things together.  Then you have to transfer
> the data.
In Gurchetan's Vulkan example,  the host storage allocation happens in
(some variant of) memory_create, not in resource_create_v2.  Maybe
that's what got me confused.

>
> Hmm, maybe we need a flag indicating that host storage is not needed,
> for resources where we want establish some kind of shared mapping later
> on.
This makes sense, to support both Vulkan and non-Vulkan models.

This differs from this patch, but I think a full-fledged resource
should logically have three components

 - a RESOURCE component that has not storage
 - a MEMORY component that provides the storage
 - a BACKING component that is for transfers

resource_attach_backing sets the BACKING component.  BACKING always
uses guest pages and supports only transfers into or out of MEMORY.

resource_attach_memory sets the MEMORY component.  MEMORY can use host
or guest pages, and must always support GPU operations.  When a MEMORY
is mappable in the guest, we can skip BACKING and achieve zero-copy.

resource_create_* can then get a flag to indicate whether only
RESOURCE is created or RESOURCE+MEMORY is created.


>
> > Do we expect these new commands to be supported by OpenGL, which does not
> > separate resources and memories?
>
> Well, for opengl you need a 1:1 relationship between memory region and
> resource.
>
> > > Yes, even though it is not clear yet how we are going to handle
> > > host-allocated buffers in the vhost-user case ...
> >
> > This might be another dumb question, but is this only an issue for
> > vhost-user(-gpu) case?  What mechanisms are used to map host dma-buf into
> > the guest address space?
>
> qemu can change the address space, that includes mmap()ing stuff there.
> An external vhost-user process can't do this, it can only read the
> address space layout, and read/write from/to guest memory.
I thought vhost-user process can work with the host-allocated dmabuf
directly.  That is,

  qemu: injects dmabuf pages into guest address space
  vhost-user: work with the dmabuf
  guest: can read/write those pages

>
> > But one needs to create the resource first to know which memory types can
> > be attached to it.  I think the metadata needs to be returned with
> > resource_create_v2.
>
> There is a resource_info reply for that.
>
> > That should be good enough.  But by returning alignments, we can minimize
> > the gaps when attaching multiple resources, especially when the resources
> > are only used by GPU.
>
> We can add alignments to the resource_info reply.
>
> cheers,
>   Gerd
>
