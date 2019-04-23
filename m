Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995C5C10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6EE20685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fwqHDo1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfDWAMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 20:12:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42818 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbfDWAMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 20:12:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id x13so1433078ljd.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 17:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UUmqCcfPZLaQU2X8LOPqoTWw6XtkN6uP70+krzqW0TE=;
        b=fwqHDo1WqONM6UbJ6zB5Xc0dfmDyeRii2GPY+aFKz2Gh+XG9yq3SfFSrB84aNDSjuk
         lu/TE5uNc2QzRahhEgOr4TnvvdDYv4ZM/nPYBeyOB0DMllP3875/DGAOn4dSVryyBNmg
         V+Jbh445PrI0DDN7Vv0zfR0aRmInr4KgYfu+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUmqCcfPZLaQU2X8LOPqoTWw6XtkN6uP70+krzqW0TE=;
        b=sv/mUtuAapHJMr+8S6zTQNX5kdXGluOdK4+ohS6w/TMJxJoVC59C6JFEFCtlTAe6zD
         3T70MynA45cWl7baIFIDhz2RivjDz9TXxYXWeUQhQaAk7jv0IAVDr87HaZKgUBY0QHn0
         oelKB1Bd4w2lKvctGUfbxdSdQVcij21Y2wO1JPtXx0EKWfK3dcLHsHaxIuqWST4ifhK5
         bt5aRGdUZfWS1vYsjG13BSIJ5PWDgnXdRo2owoHYIPl6Wus3BrQhJ6oMdbXQhi/EqE6j
         TbcivgMIJj9nAqa+TjRMf7mg6F+6fJHjBDpeH4p+iY1+GD7ZTudlCzN6TnhiMJAWCtHu
         zUDQ==
X-Gm-Message-State: APjAAAWVIUHJjYDxPlD7aB0dAjtq4BX/P7MJDIcQG21x8A9h/vaTnzRS
        Q5yq4GJZdfXZ5a/Y7XDuG0rfYwVL9q0=
X-Google-Smtp-Source: APXvYqycW5idVOgcIXRcnz5YOR26M+LmkuypblxEVYpifL9g2ioCm5jNeqTdAChJHdsLwr5xfBHSJQ==
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr10511102lja.49.1555978360578;
        Mon, 22 Apr 2019 17:12:40 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id n4sm3282165lfe.15.2019.04.22.17.12.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 17:12:39 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id f18so11771676lja.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 17:12:38 -0700 (PDT)
X-Received: by 2002:a2e:9811:: with SMTP id a17mr12157196ljj.96.1555978357844;
 Mon, 22 Apr 2019 17:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190410114227.25846-1-kraxel@redhat.com> <20190410114227.25846-4-kraxel@redhat.com>
 <CAAfnVBm5XZx8P7k5np823-uRr-kqf0ey9Y3GtoE2Geo4dCdQ=g@mail.gmail.com>
 <20190411050322.mfxo5mrwwzajlz3h@sirius.home.kraxel.org> <CAAfnVB=v+daY0Q+mtdK2Q=F7iS_Ra7jGYfic3twfnUVo=tz3Yg@mail.gmail.com>
 <20190412054924.dvh6bfxfrbgvezxr@sirius.home.kraxel.org> <CAPaKu7QsDp=kRsMzMf0YcvafsXBsr_m4bstuZiWAcmYiV_AxnQ@mail.gmail.com>
 <20190417095750.lre3xrg4dlgskfjg@sirius.home.kraxel.org>
In-Reply-To: <20190417095750.lre3xrg4dlgskfjg@sirius.home.kraxel.org>
From:   Gurchetan Singh <gurchetansingh@chromium.org>
Date:   Mon, 22 Apr 2019 17:12:26 -0700
X-Gmail-Original-Message-ID: <CAAfnVBkmpQ5VcUtbiqsZQSv7bmejjOHj3MkG2Cjah9Q4DOTv-Q@mail.gmail.com>
Message-ID: <CAAfnVBkmpQ5VcUtbiqsZQSv7bmejjOHj3MkG2Cjah9Q4DOTv-Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] virtio-gpu api: VIRTIO_GPU_F_RESSOURCE_V2
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Chia-I Wu <olvaffe@gmail.com>,
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
>
> Hmm, maybe we need a flag indicating that host storage is not needed,
> for resources where we want establish some kind of shared mapping later
> on.
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
>
> > But one needs to create the resource first to know which memory types can
> > be attached to it.  I think the metadata needs to be returned with
> > resource_create_v2.
>
> There is a resource_info reply for that.

The memory type should probably be in resource_create_v2, not in the
reply.  The metadata will be different based on the memory heap it's
allocated from.

Also, not all heaps need to be exposed to the guest kernel.  For
example, device local memory in Vulkan could be un-mappable.  In fact,
for resources that are not host visible we might be better off
sidestepping the kernel altogether and tracking allocation in guest
userspace.

Here is an example of memory types the guest kernel may be interested
in (based on i965):

Type 0 --> DEVICE_LOCAL_BIT | HOST_VISIBLE_BIT | HOST_COHERENT_BIT |
HOST_CACHED_BIT | RENDERER_ALLOCATED (Vulkan)
Type 1 --> HOST_VISIBLE_BIT | HOST_COHERENT_BIT | EXTERNAL_ALLOCATED
(gbm write combine)
Type 2 --> HOST_VISIBLE_BIT | HOST_COHERENT_BIT | GUEST_ALLOCATED
(guest allocated memory, which I assume is also write combine)
Type 3 --> HOST_VISIBLE_BIT | HOST_CACHED | EXTERNAL_ALLOCATED (gbm
cached memory)



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
