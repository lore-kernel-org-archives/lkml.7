Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E147BC10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9070720850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NqEELSZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDMAuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 20:50:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38624 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDMAuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 20:50:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so10411132ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 17:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6Nu7jyoiteZ9Zz4vz/Bh9BPZB1D+inwaSr4E9XIT/E=;
        b=NqEELSZ3QUASCK884SN8logeULAjB5EAwSsJyWZ6O213f8TETtlpLw9lQgAdJqpewY
         eyfu5Wj0HCqV1TCMRHmUzHgmRIF/t/rQm+xjcFHC5on30iK4gHG3u8J4fEiuxw2u1VO8
         Q6AyAEhV6tV0Af+z1tsuWzK2hQIvjJvmviXfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6Nu7jyoiteZ9Zz4vz/Bh9BPZB1D+inwaSr4E9XIT/E=;
        b=Es2dAMb402tGM10Udo06hP6+ekwmPyVtqrWDAiAsIubMPtrWHly62jdkFZzGUGbYTv
         PwwP2fpN7Cwb004MiCXcd2GC6EE4JsCImqDAignzysp1xote8oca9pTri05c45l5CpP+
         tEGsP2hbeB3fEfWKJEi6AJzF4pnssG1ZNNeWmFjlaIscTD0QmZ0aHFeg7ryHYhRT8QLn
         hlQAwiTCKWtIcHzZllSmtaXSEVrr5Sxcr11UJ5Tko8aqs5XfwYkQmoksy4lzT4BCe/l1
         8CMG1z6YDqzpjxq30IbYCueZAJ+5IyCQREXqGKR94dJVFXZHjbRNL3oMAvMTFtzT+KEZ
         iqmA==
X-Gm-Message-State: APjAAAUaePC7S126Me4lBlD6m34d1QqTYfobofMJBqmRwlvtGSvcpFCv
        GEudX1qvGSE8UZA91uV9zIv/CDcMNow=
X-Google-Smtp-Source: APXvYqxQmgjW26ANlKhVkKMb+kZFV7Fwge0QoqTuXahRgoha4Oie1Hk0kSq5wkWFINLrFCSK2q212Q==
X-Received: by 2002:a2e:9e47:: with SMTP id g7mr34197445ljk.48.1555116599691;
        Fri, 12 Apr 2019 17:49:59 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id u3sm8651761lju.51.2019.04.12.17.49.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 17:49:58 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id f18so10409544lja.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 17:49:58 -0700 (PDT)
X-Received: by 2002:a2e:8316:: with SMTP id a22mr31625188ljh.171.1555116598146;
 Fri, 12 Apr 2019 17:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190410114227.25846-1-kraxel@redhat.com> <20190410114227.25846-4-kraxel@redhat.com>
 <CAAfnVBm5XZx8P7k5np823-uRr-kqf0ey9Y3GtoE2Geo4dCdQ=g@mail.gmail.com>
 <20190411050322.mfxo5mrwwzajlz3h@sirius.home.kraxel.org> <CAAfnVB=v+daY0Q+mtdK2Q=F7iS_Ra7jGYfic3twfnUVo=tz3Yg@mail.gmail.com>
 <20190412054924.dvh6bfxfrbgvezxr@sirius.home.kraxel.org>
In-Reply-To: <20190412054924.dvh6bfxfrbgvezxr@sirius.home.kraxel.org>
From:   Gurchetan Singh <gurchetansingh@chromium.org>
Date:   Fri, 12 Apr 2019 17:49:46 -0700
X-Gmail-Original-Message-ID: <CAAfnVBnG2yAkmantf9uCdCf7ur2tkVKgrQCpD78FHBnLTv62VA@mail.gmail.com>
Message-ID: <CAAfnVBnG2yAkmantf9uCdCf7ur2tkVKgrQCpD78FHBnLTv62VA@mail.gmail.com>
Subject: Re: [PATCH 3/3] virtio-gpu api: VIRTIO_GPU_F_RESSOURCE_V2
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        virtio@lists.oasis-open.org, David Airlie <airlied@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Jason Wang <jasowang@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:VIRTIO CORE, NET AND BLOCK DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 10:49 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Apr 11, 2019 at 06:36:15PM -0700, Gurchetan Singh wrote:
> > On Wed, Apr 10, 2019 at 10:03 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > > > +/* VIRTIO_GPU_CMD_RESOURCE_CREATE_V2 */
> > > > > +struct virtio_gpu_cmd_resource_create_v2 {
> > > > > +       struct virtio_gpu_ctrl_hdr hdr;
> > > > > +       __le32 resource_id;
> > > > > +       __le32 format;
> > > > > +       __le32 width;
> > > > > +       __le32 height;
> > > > > +       /* 3d only */
> > > > > +       __le32 target;
> > > > > +       __le32 bind;
> > > > > +       __le32 depth;
> > > > > +       __le32 array_size;
> > > > > +       __le32 last_level;
> > > > > +       __le32 nr_samples;
> > > > > +       __le32 flags;
> > > > > +};
> > > >
> > > >
> > > > I assume this is always backed by some host side allocation, without any
> > > > guest side pages associated with it?
> > >
> > > No.  It is not backed at all yet.  Workflow would be like this:
> > >
> > >   (1) VIRTIO_GPU_CMD_RESOURCE_CREATE_V2
> > >   (2) VIRTIO_GPU_CMD_MEMORY_CREATE (see patch 2)
> > >   (3) VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH (see patch 2)
> >
> > Thanks for the clarification.
> >
> > >
> > > You could also create a larger pool with VIRTIO_GPU_CMD_MEMORY_CREATE,
> > > then go attach multiple resources to it.
> > >
> > > > If so, do we want the option for the guest allocate?
> > >
> > > Allocation options are handled by VIRTIO_GPU_CMD_MEMORY_CREATE
> > > (initially guest allocated only, i.e. what virtio-gpu supports today,
> > > the plan is to add other allocation types later on).
> >
> > You want to cover Vulkan, host-allocated dma-bufs, and guest-allocated
> > dma-bufs with this, correct?  Let me know if it's a non-goal :-)
>
> Yes, even though it is not clear yet how we are going to handle
> host-allocated buffers in the vhost-user case ...

For Vulkan, VK_EXT_external_memory_dma_buf +
VK_EXT_image_drm_format_modifier should do the trick on Linux devices
that support these extensions.

For GL, I don't see any way forward given the current KVM api.

> > If so, we might want to distinguish between memory types (kind of like
> > memoryTypeIndex in Vulkan). [Assuming memory_id is like resource_id]
>
> For the host-allocated buffers we surely want that, yes.
> For guest-allocated memory regions it isn't useful I think ...

Are guest memory regions always write combine, or can they be (read)
cached?  Is this something we can control in the virtgpu kernel
driver?

>
> > 1) Vulkan seems the most straightforward
> >
> > virtio_gpu_cmd_memory_create --> create kernel data structure,
> > vkAllocateMemory on the host or import guest memory into Vulkan,
> > depending on the memory type
> > virtio_gpu_cmd_resource_create_v2 -->  vkCreateImage +
> > vkGetImageMemoryRequirements on host
> > virtio_gpu_cmd_resource_attach_memory -->  vkBindImageMemory on host
>
> Yes.
>
> Note 1: virtio_gpu_cmd_memory_create + virtio_gpu_cmd_resource_create_v2
> ordering doesn't matter, so you can virtio_gpu_cmd_resource_create_v2
> first to figure stride and size, then adjust memory size accordingly.
>
> Note 2: The old virtio_gpu_cmd_resource_create variants can be used
> too if you don't need the _v2 features.
>
> Note 3: If I understand things correctly it would be valid to create a
> memory pool (allocate one big chunk of memory) with vkAllocateMemory,
> then bind multiple images at different offsets to it.
>
> > 2) With a guest allocated dma-buf using some new allocation library,
> >
> > virtio_gpu_cmd_resource_create_v2 --> host returns metadata describing
> > optimal allocation
> > virtio_gpu_cmd_memory_create --> allocate guest memory pages since
> > it's guest memory type
> > virtio_gpu_cmd_resource_attach_memory --> associate guest pages with
> > resource in kernel, send iovecs to host for bookkeeping
>
> virtio_gpu_cmd_memory_create sends the iovecs.  Otherwise correct.
>
> > 3) With gbm it's a little trickier,
> >
> > virtio_gpu_cmd_resource_create_v2 --> gbm_bo_create_with_modifiers,
> > get metadata in return
>
> Only get metadata in return.

With the current gbm API, metadata is only returned after the
allocation is complete.

We're fine with changing this for minigbm (i.e, having
gbm_get_allocation_metadata(width, height, modifier, *out_metadata).
Not sure what the plan is for Mesa gbm, or the Unix Device Memory
Allocator.

>
> > virtio_gpu_cmd_memory_create --> create kernel data structure, but
> > don't allocate pages, nothing on the host
>
> Memory allocation happens here.  Probably makes sense to have a
> virtio_gpu_cmd_memory_create_host command here, because the parameters
> we need are quite different from the guest-allocated case.
>
> Maybe we even need a virtio_gpu_cmd_memory_create_host_for_resource
> variant, given that gbm doesn't have raw memory buffers without any
> format attached to it.

We should create VIRTIO_GPU_F_RESOURCE_V2  with what gbm should be in
mind, not what gbm currently is.

>
> > > > > +/* VIRTIO_GPU_RESP_OK_RESOURCE_INFO */
> > > > > +struct virtio_gpu_resp_resource_info {
> > > > > +       struct virtio_gpu_ctrl_hdr hdr;
> > > > > +       __le32 stride[4];
> > > > > +       __le32 size[4];
> > > > > +};
> > > >
> > > > offsets[4] needed too
> > >
> > > That is in VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH ...
> >
> > I assume the offsets aren't returned by
> > VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH.
>
> Yes, they are send by the guest.
>
> > How does the guest know at which offsets in memory will be compatible
> > to share with display, camera, etc?
>
> Is is good enough to align offsets to page boundaries?

Do you mean ((offset - stride * height) <= PAGE_SIZE))?  If so, no.
For example, do the calculation here with a 256 x 256 NV12 buffer:

https://chromium.googlesource.com/chromiumos/platform/minigbm/+/master/rockchip.c#166

Is the offset generally divisible by PAGE_SIZE?  Yes, in the cases I've seen.


On Thu, Apr 11, 2019 at 10:49 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Apr 11, 2019 at 06:36:15PM -0700, Gurchetan Singh wrote:
> > On Wed, Apr 10, 2019 at 10:03 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > > > +/* VIRTIO_GPU_CMD_RESOURCE_CREATE_V2 */
> > > > > +struct virtio_gpu_cmd_resource_create_v2 {
> > > > > +       struct virtio_gpu_ctrl_hdr hdr;
> > > > > +       __le32 resource_id;
> > > > > +       __le32 format;
> > > > > +       __le32 width;
> > > > > +       __le32 height;
> > > > > +       /* 3d only */
> > > > > +       __le32 target;
> > > > > +       __le32 bind;
> > > > > +       __le32 depth;
> > > > > +       __le32 array_size;
> > > > > +       __le32 last_level;
> > > > > +       __le32 nr_samples;
> > > > > +       __le32 flags;
> > > > > +};
> > > >
> > > >
> > > > I assume this is always backed by some host side allocation, without any
> > > > guest side pages associated with it?
> > >
> > > No.  It is not backed at all yet.  Workflow would be like this:
> > >
> > >   (1) VIRTIO_GPU_CMD_RESOURCE_CREATE_V2
> > >   (2) VIRTIO_GPU_CMD_MEMORY_CREATE (see patch 2)
> > >   (3) VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH (see patch 2)
> >
> > Thanks for the clarification.
> >
> > >
> > > You could also create a larger pool with VIRTIO_GPU_CMD_MEMORY_CREATE,
> > > then go attach multiple resources to it.
> > >
> > > > If so, do we want the option for the guest allocate?
> > >
> > > Allocation options are handled by VIRTIO_GPU_CMD_MEMORY_CREATE
> > > (initially guest allocated only, i.e. what virtio-gpu supports today,
> > > the plan is to add other allocation types later on).
> >
> > You want to cover Vulkan, host-allocated dma-bufs, and guest-allocated
> > dma-bufs with this, correct?  Let me know if it's a non-goal :-)
>
> Yes, even though it is not clear yet how we are going to handle
> host-allocated buffers in the vhost-user case ...
>
> > If so, we might want to distinguish between memory types (kind of like
> > memoryTypeIndex in Vulkan). [Assuming memory_id is like resource_id]
>
> For the host-allocated buffers we surely want that, yes.
> For guest-allocated memory regions it isn't useful I think ...
>
> > 1) Vulkan seems the most straightforward
> >
> > virtio_gpu_cmd_memory_create --> create kernel data structure,
> > vkAllocateMemory on the host or import guest memory into Vulkan,
> > depending on the memory type
> > virtio_gpu_cmd_resource_create_v2 -->  vkCreateImage +
> > vkGetImageMemoryRequirements on host
> > virtio_gpu_cmd_resource_attach_memory -->  vkBindImageMemory on host
>
> Yes.
>
> Note 1: virtio_gpu_cmd_memory_create + virtio_gpu_cmd_resource_create_v2
> ordering doesn't matter, so you can virtio_gpu_cmd_resource_create_v2
> first to figure stride and size, then adjust memory size accordingly.
>
> Note 2: The old virtio_gpu_cmd_resource_create variants can be used
> too if you don't need the _v2 features.
>
> Note 3: If I understand things correctly it would be valid to create a
> memory pool (allocate one big chunk of memory) with vkAllocateMemory,
> then bind multiple images at different offsets to it.
>
> > 2) With a guest allocated dma-buf using some new allocation library,
> >
> > virtio_gpu_cmd_resource_create_v2 --> host returns metadata describing
> > optimal allocation
> > virtio_gpu_cmd_memory_create --> allocate guest memory pages since
> > it's guest memory type
> > virtio_gpu_cmd_resource_attach_memory --> associate guest pages with
> > resource in kernel, send iovecs to host for bookkeeping
>
> virtio_gpu_cmd_memory_create sends the iovecs.  Otherwise correct.
>
> > 3) With gbm it's a little trickier,
> >
> > virtio_gpu_cmd_resource_create_v2 --> gbm_bo_create_with_modifiers,
> > get metadata in return
>
> Only get metadata in return.
>
> > virtio_gpu_cmd_memory_create --> create kernel data structure, but
> > don't allocate pages, nothing on the host
>
> Memory allocation happens here.  Probably makes sense to have a
> virtio_gpu_cmd_memory_create_host command here, because the parameters
> we need are quite different from the guest-allocated case.
>
> Maybe we even need a virtio_gpu_cmd_memory_create_host_for_resource
> variant, given that gbm doesn't have raw memory buffers without any
> format attached to it.
>
> > > > > +/* VIRTIO_GPU_RESP_OK_RESOURCE_INFO */
> > > > > +struct virtio_gpu_resp_resource_info {
> > > > > +       struct virtio_gpu_ctrl_hdr hdr;
> > > > > +       __le32 stride[4];
> > > > > +       __le32 size[4];
> > > > > +};
> > > >
> > > > offsets[4] needed too
> > >
> > > That is in VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH ...
> >
> > I assume the offsets aren't returned by
> > VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH.
>
> Yes, they are send by the guest.
>
> > How does the guest know at which offsets in memory will be compatible
> > to share with display, camera, etc?
>
> Is is good enough to align offsets to page boundaries?
>
> > Also, do you want to cover the case where the resource is backed by
> > three separate memory regions (VK_IMAGE_CREATE_DISJOINT_BIT)?
>
> Good point.  I guess we should make memory_id in
> virtio_gpu_cmd_resource_attach_memory an array then,
> so you can specify a different memory region for each plane.
>
> cheers,
>   Gerd
>
