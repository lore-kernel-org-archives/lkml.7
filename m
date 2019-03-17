Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D9DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 00:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F722186A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 00:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOG+M916"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfCQAdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 20:33:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40240 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCQAdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 20:33:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id f11so14201438qti.7;
        Sat, 16 Mar 2019 17:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mopi9pYcuk5FgbIWQDOVaPV2FyH+POS3o4i2Hyc89Qs=;
        b=HOG+M916fO/a44kAAbke/eNCtkxVTKX1h87cn8+wQBS1F5I46vwtYrB0ZWD1ulOMAa
         /2MjgsLmV5vbCI/n9DtMPGfA2WUDGV2jHZ57y2qIh1W3QlmmcH0E9Nyc3Bcl6eUqGgdS
         ku2jzHXmLLGq9Of9ke0ZZCoJSAwlky0ENa9OrWgi9LGru9GWBsy9Liw98FKx3ibr9raC
         1DkGjgI7huOWOfE4f7vfPuDxLmO4FcjRexBxW0HDhioZcxpzkUwli3mtIOhTS8UCAMKn
         j8HurfSGeor2aLD70GqzzMirJ+3tnMxD25iYhUT34gUBK8F1DL4ZZF5kHmShzys5tLCt
         DUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mopi9pYcuk5FgbIWQDOVaPV2FyH+POS3o4i2Hyc89Qs=;
        b=F5l06HEfqpcxAz99DVtlwVPegmbJhOPrPtm9PMweNY2xOuhLwRu+PQ2/fcqkahlRAY
         l/8rg23EhxKv44+GG93FR4J/2ts0nS+yztZdgSmiERaz60xA5AkbvqOee20jO/a6kAuI
         8bI5GrDLFVSMz51X8C9ijybU6zlufMNrmemLu1DEH+hKJWf1RmyYqO+MUnsg8y2mMaZs
         zaJlGKpYdvfMeAluQbWvCqY9zrAMc1D5bD8vWUiM7LUxIJIQr8dHJCG99HA4VYiCuQFh
         yDeQuH7FYpcf67q7zp0zB2dangBJAvrHNeeD10aS7a0J1rywMoZ0S85k9LlPatFQNxtS
         Ab8A==
X-Gm-Message-State: APjAAAXi5k69zNycyPwccvCQ3oFW3siS4/wNAlhYzbiYeoteYoqouvRn
        Oxy6sob4WO+HRk23Ph1cHACZtQ0wxNw4bt7QRv7dXF6M
X-Google-Smtp-Source: APXvYqxdKEV+7D6Rs+WTRdMH7/WmB9xFXR8n5rZnD+p4Pl1I6+lMfHRH3zCnqtkIcYMY3dgNYe7Y/XuoaIVm3HJv4xs=
X-Received: by 2002:a0c:8a61:: with SMTP id 30mr7916599qvu.110.1552782816292;
 Sat, 16 Mar 2019 17:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181210171318.16998-1-vgoyal@redhat.com> <20181210171318.16998-19-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-19-vgoyal@redhat.com>
From:   Liu Bo <obuil.liubo@gmail.com>
Date:   Sat, 16 Mar 2019 17:33:25 -0700
Message-ID: <CANQeFDB86oQfE3v4viUOox2O1rkUVu+uGcQjPVkN3Se1ysvshQ@mail.gmail.com>
Subject: Re: [PATCH 18/52] virtio-fs: Map cache using the values from the capabilities
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, miklos@szeredi.hu,
        Stefan Hajnoczi <stefanha@redhat.com>, dgilbert@redhat.com,
        sweil@redhat.com, swhiteho@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 9:57 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Instead of assuming we had the fixed bar for the cache, use the
> value from the capabilities.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 60d496c16841..55bac1465536 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -14,11 +14,6 @@
>  #include <uapi/linux/virtio_pci.h>
>  #include "fuse_i.h"
>
> -enum {
> -       /* PCI BAR number of the virtio-fs DAX window */
> -       VIRTIO_FS_WINDOW_BAR = 2,
> -};
> -
>  /* List of virtio-fs device instances and a lock for the list */
>  static DEFINE_MUTEX(virtio_fs_mutex);
>  static LIST_HEAD(virtio_fs_instances);
> @@ -518,7 +513,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>         struct dev_pagemap *pgmap;
>         struct pci_dev *pci_dev;
>         phys_addr_t phys_addr;
> -       size_t len;
> +       size_t bar_len;
>         int ret;
>         u8 have_cache, cache_bar;
>         u64 cache_offset, cache_len;
> @@ -551,17 +546,13 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>          }
>
>         /* TODO handle case where device doesn't expose BAR? */
> -       ret = pci_request_region(pci_dev, VIRTIO_FS_WINDOW_BAR,
> -                                "virtio-fs-window");
> +       ret = pci_request_region(pci_dev, cache_bar, "virtio-fs-window");
>         if (ret < 0) {
>                 dev_err(&vdev->dev, "%s: failed to request window BAR\n",
>                         __func__);
>                 return ret;
>         }
>
> -       phys_addr = pci_resource_start(pci_dev, VIRTIO_FS_WINDOW_BAR);
> -       len = pci_resource_len(pci_dev, VIRTIO_FS_WINDOW_BAR);
> -
>         mi = devm_kzalloc(&pci_dev->dev, sizeof(*mi), GFP_KERNEL);
>         if (!mi)
>                 return -ENOMEM;
> @@ -586,6 +577,17 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>         pgmap->ref = &mi->ref;
>         pgmap->type = MEMORY_DEVICE_FS_DAX;
>
> +       phys_addr = pci_resource_start(pci_dev, cache_bar);
> +       bar_len = pci_resource_len(pci_dev, cache_bar);
> +
> +       if (cache_offset + cache_len > bar_len) {
> +               dev_err(&vdev->dev,
> +                       "%s: cache bar shorter than cap offset+len\n",
> +                       __func__);
> +               return -EINVAL;
> +       }
> +       phys_addr += cache_offset;
> +
>         /* Ideally we would directly use the PCI BAR resource but
>          * devm_memremap_pages() wants its own copy in pgmap.  So
>          * initialize a struct resource from scratch (only the start
> @@ -594,7 +596,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>         pgmap->res = (struct resource){
>                 .name = "virtio-fs dax window",
>                 .start = phys_addr,
> -               .end = phys_addr + len,
> +               .end = phys_addr + cache_len,

Just in case you haven't noticed/fixed this problem, it should be

+ .end = phys_addr + cache_len - 1,

because resource_size() counts %size as "end - start + 1".
The end result of the above is a "conflicting page map" warning when
specifying a second virtio-fs pci device.

I'll send a patch for this, and feel free to take it along with the
patchset if needed.

thanks,
liubo

>         };
>
>         fs->window_kaddr = devm_memremap_pages(&pci_dev->dev, pgmap);
> @@ -607,10 +609,10 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>                 return ret;
>
>         fs->window_phys_addr = phys_addr;
> -       fs->window_len = len;
> +       fs->window_len = cache_len;
>
> -       dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx len %zu\n",
> -               __func__, fs->window_kaddr, phys_addr, len);
> +       dev_dbg(&vdev->dev, "%s: cache kaddr 0x%px phys_addr 0x%llx len %llx\n",
> +               __func__, fs->window_kaddr, phys_addr, cache_len);
>
>         fs->dax_dev = alloc_dax(fs, NULL, &virtio_fs_dax_ops);
>         if (!fs->dax_dev)
> --
> 2.13.6
>
