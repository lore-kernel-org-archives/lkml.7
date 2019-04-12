Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3387C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB2421721
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VBSEr4JT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfDLBgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:36:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33606 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfDLBgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:36:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id f23so7341464ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 18:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPCwRPH4gaObJMDjbw17FcWfdaCNXB4H2vbtWZc0D2I=;
        b=VBSEr4JT3nM3wVIXDvBCU18Oezm7wfxk+0x8PNJ3ODCdI49JbhV7iLjPF6SYzl4JZK
         ouZ/smJ2TjSoc1CPH/hkAc7oG/oLVZmexDleKyg7Df0sSXfD7NPE5IFLhPKx35EJJfXZ
         PGA8iO0IEm0D0Wx+xLsvXC5dcNH1uhypITHlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPCwRPH4gaObJMDjbw17FcWfdaCNXB4H2vbtWZc0D2I=;
        b=Wd2NpLrc1ZIsWiNEZANhPnUMHUA0h1uUcKYLsHMjkPkyX2BN1wqzcWt/J5Pr+0sOvH
         FioogCnoKw8gYc+YLtBG4f2TOOaVu+Ee+KCo218f+2pzVgTwTQwamI8I+AiZ8maswKKK
         PY1NRNwYU7+usflKpy25CRFrs1GsHhOgeqwBbcIcY/hzwMHfAW705zVlfk68+HfWC/hU
         5fxzD/ecaU0wvgZZSgxY/PbZYm8WInYTV0jsTcrF5a+s5WY/kxqtoLshFDLy8kJjM35Z
         4ZGpcx2LKTt4tdEVLzmbik2XE7F5Zm5BmrXFGg8nFHG74ui1pYVFNkKTMrEyyf9N4AIF
         o+Lg==
X-Gm-Message-State: APjAAAVot5xeoJORPrXk00Lg+vER8FlqDaUij8P5argLxUy0u6Qo03Di
        MV0huUo9XdwzcGEeuzb/FweTdpl5I70=
X-Google-Smtp-Source: APXvYqxQJwHc3DRqMLOa6DHbEdJQfLtpOsW+L0i3YuP/aKgTPqAO7Egv+UNCSIkaytP3YNGneuGsGQ==
X-Received: by 2002:a2e:84ce:: with SMTP id q14mr27956208ljh.80.1555032988887;
        Thu, 11 Apr 2019 18:36:28 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id j10sm2968183lfc.56.2019.04.11.18.36.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 18:36:28 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id p14so7301389ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 18:36:27 -0700 (PDT)
X-Received: by 2002:a2e:808e:: with SMTP id i14mr29794761ljg.103.1555032987370;
 Thu, 11 Apr 2019 18:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190410114227.25846-1-kraxel@redhat.com> <20190410114227.25846-4-kraxel@redhat.com>
 <CAAfnVBm5XZx8P7k5np823-uRr-kqf0ey9Y3GtoE2Geo4dCdQ=g@mail.gmail.com> <20190411050322.mfxo5mrwwzajlz3h@sirius.home.kraxel.org>
In-Reply-To: <20190411050322.mfxo5mrwwzajlz3h@sirius.home.kraxel.org>
From:   Gurchetan Singh <gurchetansingh@chromium.org>
Date:   Thu, 11 Apr 2019 18:36:15 -0700
X-Gmail-Original-Message-ID: <CAAfnVB=v+daY0Q+mtdK2Q=F7iS_Ra7jGYfic3twfnUVo=tz3Yg@mail.gmail.com>
Message-ID: <CAAfnVB=v+daY0Q+mtdK2Q=F7iS_Ra7jGYfic3twfnUVo=tz3Yg@mail.gmail.com>
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

On Wed, Apr 10, 2019 at 10:03 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > > +/* VIRTIO_GPU_CMD_RESOURCE_CREATE_V2 */
> > > +struct virtio_gpu_cmd_resource_create_v2 {
> > > +       struct virtio_gpu_ctrl_hdr hdr;
> > > +       __le32 resource_id;
> > > +       __le32 format;
> > > +       __le32 width;
> > > +       __le32 height;
> > > +       /* 3d only */
> > > +       __le32 target;
> > > +       __le32 bind;
> > > +       __le32 depth;
> > > +       __le32 array_size;
> > > +       __le32 last_level;
> > > +       __le32 nr_samples;
> > > +       __le32 flags;
> > > +};
> >
> >
> > I assume this is always backed by some host side allocation, without any
> > guest side pages associated with it?
>
> No.  It is not backed at all yet.  Workflow would be like this:
>
>   (1) VIRTIO_GPU_CMD_RESOURCE_CREATE_V2
>   (2) VIRTIO_GPU_CMD_MEMORY_CREATE (see patch 2)
>   (3) VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH (see patch 2)

Thanks for the clarification.

>
> You could also create a larger pool with VIRTIO_GPU_CMD_MEMORY_CREATE,
> then go attach multiple resources to it.
>
> > If so, do we want the option for the guest allocate?
>
> Allocation options are handled by VIRTIO_GPU_CMD_MEMORY_CREATE
> (initially guest allocated only, i.e. what virtio-gpu supports today,
> the plan is to add other allocation types later on).

You want to cover Vulkan, host-allocated dma-bufs, and guest-allocated
dma-bufs with this, correct?  Let me know if it's a non-goal :-)

If so, we might want to distinguish between memory types (kind of like
memoryTypeIndex in Vulkan). [Assuming memory_id is like resource_id]

Here's some host-side APIs Chromium might want to use this with workflow:

1) Vulkan seems the most straightforward

virtio_gpu_cmd_memory_create --> create kernel data structure,
vkAllocateMemory on the host or import guest memory into Vulkan,
depending on the memory type
virtio_gpu_cmd_resource_create_v2 -->  vkCreateImage +
vkGetImageMemoryRequirements on host
virtio_gpu_cmd_resource_attach_memory -->  vkBindImageMemory on host

2) With a guest allocated dma-buf using some new allocation library,

virtio_gpu_cmd_resource_create_v2 --> host returns metadata describing
optimal allocation
virtio_gpu_cmd_memory_create --> allocate guest memory pages since
it's guest memory type
virtio_gpu_cmd_resource_attach_memory --> associate guest pages with
resource in kernel, send iovecs to host for bookkeeping

3) With gbm it's a little trickier,

virtio_gpu_cmd_resource_create_v2 --> gbm_bo_create_with_modifiers,
get metadata in return
virtio_gpu_cmd_memory_create --> create kernel data structure, but
don't allocate pages, nothing on the host
virtio_gpu_cmd_resource_attach_memory --> associate memory structure
with resource in kernel, nothing on the host

Is this what you have in mind?

>
> > > +/* VIRTIO_GPU_RESP_OK_RESOURCE_INFO */
> > > +struct virtio_gpu_resp_resource_info {
> > > +       struct virtio_gpu_ctrl_hdr hdr;
> > > +       __le32 stride[4];
> > > +       __le32 size[4];
> > > +};
> >
> > offsets[4] needed too
>
> That is in VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH ...

I assume the offsets aren't returned by
VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH.  How does the guest know at
which offsets in memory will be compatible to share with display,
camera, etc?

Also, do you want to cover the case where the resource is backed by
three separate memory regions (VK_IMAGE_CREATE_DISJOINT_BIT)?  If so,
we might want to make resource_create_v2 more opaque like
VkImageMemoryRequirementsInfo2.

>
> cheers,
>   Gerd
>
