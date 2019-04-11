Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62378C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391BC2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfDKFD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:03:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfDKFD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:03:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FE6E307B481;
        Thu, 11 Apr 2019 05:03:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 900FF5D9C4;
        Thu, 11 Apr 2019 05:03:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BB40E16E08; Thu, 11 Apr 2019 07:03:22 +0200 (CEST)
Date:   Thu, 11 Apr 2019 07:03:22 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Gurchetan Singh <gurchetansingh@chromium.org>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        virtio@lists.oasis-open.org, David Airlie <airlied@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Jason Wang <jasowang@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:VIRTIO CORE, NET AND BLOCK DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] virtio-gpu api: VIRTIO_GPU_F_RESSOURCE_V2
Message-ID: <20190411050322.mfxo5mrwwzajlz3h@sirius.home.kraxel.org>
References: <20190410114227.25846-1-kraxel@redhat.com>
 <20190410114227.25846-4-kraxel@redhat.com>
 <CAAfnVBm5XZx8P7k5np823-uRr-kqf0ey9Y3GtoE2Geo4dCdQ=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfnVBm5XZx8P7k5np823-uRr-kqf0ey9Y3GtoE2Geo4dCdQ=g@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 11 Apr 2019 05:03:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +/* VIRTIO_GPU_CMD_RESOURCE_CREATE_V2 */
> > +struct virtio_gpu_cmd_resource_create_v2 {
> > +       struct virtio_gpu_ctrl_hdr hdr;
> > +       __le32 resource_id;
> > +       __le32 format;
> > +       __le32 width;
> > +       __le32 height;
> > +       /* 3d only */
> > +       __le32 target;
> > +       __le32 bind;
> > +       __le32 depth;
> > +       __le32 array_size;
> > +       __le32 last_level;
> > +       __le32 nr_samples;
> > +       __le32 flags;
> > +};
> 
> 
> I assume this is always backed by some host side allocation, without any
> guest side pages associated with it?

No.  It is not backed at all yet.  Workflow would be like this:

  (1) VIRTIO_GPU_CMD_RESOURCE_CREATE_V2
  (2) VIRTIO_GPU_CMD_MEMORY_CREATE (see patch 2)
  (3) VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH (see patch 2)

You could also create a larger pool with VIRTIO_GPU_CMD_MEMORY_CREATE,
then go attach multiple resources to it.

> If so, do we want the option for the guest allocate?

Allocation options are handled by VIRTIO_GPU_CMD_MEMORY_CREATE
(initially guest allocated only, i.e. what virtio-gpu supports today,
the plan is to add other allocation types later on).

> > +/* VIRTIO_GPU_RESP_OK_RESOURCE_INFO */
> > +struct virtio_gpu_resp_resource_info {
> > +       struct virtio_gpu_ctrl_hdr hdr;
> > +       __le32 stride[4];
> > +       __le32 size[4];
> > +};
> 
> offsets[4] needed too

That is in VIRTIO_GPU_CMD_RESOURCE_MEMORY_ATTACH ...

cheers,
  Gerd

