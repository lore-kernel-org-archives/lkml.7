Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4620AC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0F920835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbfDQJ54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:57:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfDQJ5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:57:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BD613082A27;
        Wed, 17 Apr 2019 09:57:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80B285D71E;
        Wed, 17 Apr 2019 09:57:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B636D1747B; Wed, 17 Apr 2019 11:57:50 +0200 (CEST)
Date:   Wed, 17 Apr 2019 11:57:50 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Chia-I Wu <olvaffe@gmail.com>
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
Subject: Re: [PATCH 3/3] virtio-gpu api: VIRTIO_GPU_F_RESSOURCE_V2
Message-ID: <20190417095750.lre3xrg4dlgskfjg@sirius.home.kraxel.org>
References: <20190410114227.25846-1-kraxel@redhat.com>
 <20190410114227.25846-4-kraxel@redhat.com>
 <CAAfnVBm5XZx8P7k5np823-uRr-kqf0ey9Y3GtoE2Geo4dCdQ=g@mail.gmail.com>
 <20190411050322.mfxo5mrwwzajlz3h@sirius.home.kraxel.org>
 <CAAfnVB=v+daY0Q+mtdK2Q=F7iS_Ra7jGYfic3twfnUVo=tz3Yg@mail.gmail.com>
 <20190412054924.dvh6bfxfrbgvezxr@sirius.home.kraxel.org>
 <CAPaKu7QsDp=kRsMzMf0YcvafsXBsr_m4bstuZiWAcmYiV_AxnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPaKu7QsDp=kRsMzMf0YcvafsXBsr_m4bstuZiWAcmYiV_AxnQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 17 Apr 2019 09:57:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 04:34:20PM -0700, Chia-I Wu wrote:
> Hi,
> 
> I am still new to virgl, and missed the last round of discussion about
> resource_create_v2.
> 
> From the discussion below, semantically resource_create_v2 creates a host
> resource object _without_ any storage; memory_create creates a host memory
> object which provides the storage.  Is that correct?

Right now all resource_create_* variants create a resource object with
host storage.  memory_create creates guest storage, and
resource_attach_memory binds things together.  Then you have to transfer
the data.

Hmm, maybe we need a flag indicating that host storage is not needed,
for resources where we want establish some kind of shared mapping later
on.

> Do we expect these new commands to be supported by OpenGL, which does not
> separate resources and memories?

Well, for opengl you need a 1:1 relationship between memory region and
resource.

> > Yes, even though it is not clear yet how we are going to handle
> > host-allocated buffers in the vhost-user case ...
> 
> This might be another dumb question, but is this only an issue for
> vhost-user(-gpu) case?  What mechanisms are used to map host dma-buf into
> the guest address space?

qemu can change the address space, that includes mmap()ing stuff there.
An external vhost-user process can't do this, it can only read the
address space layout, and read/write from/to guest memory.

> But one needs to create the resource first to know which memory types can
> be attached to it.  I think the metadata needs to be returned with
> resource_create_v2.

There is a resource_info reply for that.

> That should be good enough.  But by returning alignments, we can minimize
> the gaps when attaching multiple resources, especially when the resources
> are only used by GPU.

We can add alignments to the resource_info reply.

cheers,
  Gerd

