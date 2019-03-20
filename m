Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F91CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F2C2186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfCTKmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:42:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfCTKmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:42:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC3692D7E4;
        Wed, 20 Mar 2019 10:42:49 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2B7E5D9C4;
        Wed, 20 Mar 2019 10:42:45 +0000 (UTC)
Date:   Wed, 20 Mar 2019 10:42:43 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Liu Bo <obuil.liubo@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        miklos@szeredi.hu, Stefan Hajnoczi <stefanha@redhat.com>,
        sweil@redhat.com, swhiteho@redhat.com
Subject: Re: [PATCH 18/52] virtio-fs: Map cache using the values from the
 capabilities
Message-ID: <20190320104242.GC2791@work-vm>
References: <20181210171318.16998-1-vgoyal@redhat.com>
 <20181210171318.16998-19-vgoyal@redhat.com>
 <CANQeFDB86oQfE3v4viUOox2O1rkUVu+uGcQjPVkN3Se1ysvshQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANQeFDB86oQfE3v4viUOox2O1rkUVu+uGcQjPVkN3Se1ysvshQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 20 Mar 2019 10:42:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liu Bo (obuil.liubo@gmail.com) wrote:
> On Mon, Dec 10, 2018 at 9:57 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Instead of assuming we had the fixed bar for the cache, use the
> > value from the capabilities.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  fs/fuse/virtio_fs.c | 32 +++++++++++++++++---------------
> >  1 file changed, 17 insertions(+), 15 deletions(-)
> >
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 60d496c16841..55bac1465536 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -14,11 +14,6 @@
> >  #include <uapi/linux/virtio_pci.h>
> >  #include "fuse_i.h"
> >
> > -enum {
> > -       /* PCI BAR number of the virtio-fs DAX window */
> > -       VIRTIO_FS_WINDOW_BAR = 2,
> > -};
> > -
> >  /* List of virtio-fs device instances and a lock for the list */
> >  static DEFINE_MUTEX(virtio_fs_mutex);
> >  static LIST_HEAD(virtio_fs_instances);
> > @@ -518,7 +513,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
> >         struct dev_pagemap *pgmap;
> >         struct pci_dev *pci_dev;
> >         phys_addr_t phys_addr;
> > -       size_t len;
> > +       size_t bar_len;
> >         int ret;
> >         u8 have_cache, cache_bar;
> >         u64 cache_offset, cache_len;
> > @@ -551,17 +546,13 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
> >          }
> >
> >         /* TODO handle case where device doesn't expose BAR? */
> > -       ret = pci_request_region(pci_dev, VIRTIO_FS_WINDOW_BAR,
> > -                                "virtio-fs-window");
> > +       ret = pci_request_region(pci_dev, cache_bar, "virtio-fs-window");
> >         if (ret < 0) {
> >                 dev_err(&vdev->dev, "%s: failed to request window BAR\n",
> >                         __func__);
> >                 return ret;
> >         }
> >
> > -       phys_addr = pci_resource_start(pci_dev, VIRTIO_FS_WINDOW_BAR);
> > -       len = pci_resource_len(pci_dev, VIRTIO_FS_WINDOW_BAR);
> > -
> >         mi = devm_kzalloc(&pci_dev->dev, sizeof(*mi), GFP_KERNEL);
> >         if (!mi)
> >                 return -ENOMEM;
> > @@ -586,6 +577,17 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
> >         pgmap->ref = &mi->ref;
> >         pgmap->type = MEMORY_DEVICE_FS_DAX;
> >
> > +       phys_addr = pci_resource_start(pci_dev, cache_bar);
> > +       bar_len = pci_resource_len(pci_dev, cache_bar);
> > +
> > +       if (cache_offset + cache_len > bar_len) {
> > +               dev_err(&vdev->dev,
> > +                       "%s: cache bar shorter than cap offset+len\n",
> > +                       __func__);
> > +               return -EINVAL;
> > +       }
> > +       phys_addr += cache_offset;
> > +
> >         /* Ideally we would directly use the PCI BAR resource but
> >          * devm_memremap_pages() wants its own copy in pgmap.  So
> >          * initialize a struct resource from scratch (only the start
> > @@ -594,7 +596,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
> >         pgmap->res = (struct resource){
> >                 .name = "virtio-fs dax window",
> >                 .start = phys_addr,
> > -               .end = phys_addr + len,
> > +               .end = phys_addr + cache_len,
> 
> Just in case you haven't noticed/fixed this problem, it should be
> 
> + .end = phys_addr + cache_len - 1,
> 
> because resource_size() counts %size as "end - start + 1".
> The end result of the above is a "conflicting page map" warning when
> specifying a second virtio-fs pci device.

Thanks for spotting this! I think we'd seen that message once but not
noticed where from.

> I'll send a patch for this, and feel free to take it along with the
> patchset if needed.
> 

Dave

> thanks,
> liubo
> 
> >         };
> >
> >         fs->window_kaddr = devm_memremap_pages(&pci_dev->dev, pgmap);
> > @@ -607,10 +609,10 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
> >                 return ret;
> >
> >         fs->window_phys_addr = phys_addr;
> > -       fs->window_len = len;
> > +       fs->window_len = cache_len;
> >
> > -       dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx len %zu\n",
> > -               __func__, fs->window_kaddr, phys_addr, len);
> > +       dev_dbg(&vdev->dev, "%s: cache kaddr 0x%px phys_addr 0x%llx len %llx\n",
> > +               __func__, fs->window_kaddr, phys_addr, cache_len);
> >
> >         fs->dax_dev = alloc_dax(fs, NULL, &virtio_fs_dax_ops);
> >         if (!fs->dax_dev)
> > --
> > 2.13.6
> >
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
