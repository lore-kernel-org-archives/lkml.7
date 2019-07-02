Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3A3C06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D5F2082F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfGBOSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:18:41 -0400
Received: from foss.arm.com ([217.140.110.172]:50634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfGBOSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:18:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5EFD28;
        Tue,  2 Jul 2019 07:18:39 -0700 (PDT)
Received: from ostrya.localdomain (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EEF43F703;
        Tue,  2 Jul 2019 07:18:38 -0700 (PDT)
Date:   Tue, 2 Jul 2019 15:18:03 +0100
From:   Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, joro@8bytes.org
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Message-ID: <20190702141803.GA13685@ostrya.localdomain>
References: <20190701190940.7f23ac15@canb.auug.org.au>
 <20190701200418.GA72724@archlinux-epyc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701200418.GA72724@archlinux-epyc>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[Adding Joerg]

On Mon, Jul 01, 2019 at 09:04:18PM +0100, Nathan Chancellor wrote:
> On Mon, Jul 01, 2019 at 07:09:40PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the char-misc tree got a conflict in:
> > 
> >   drivers/hwtracing/coresight/of_coresight.c
> > 
> > between commit:
> > 
> >   418e3ea157ef ("bus_find_device: Unify the match callback with class_find_device")
> > 
> > from the driver-core tree and commits:
> > 
> >   22aa495a6477 ("coresight: Rename of_coresight to coresight-platform")
> >   20961aea982e ("coresight: platform: Use fwnode handle for device search")
> > 
> > from the char-misc tree.
> > 
> > I fixed it up (I removed the file and added the following merge fix patch)
> > and can carry the fix as necessary. This is now fixed as far as linux-next
> > is concerned, but any non trivial conflicts should be mentioned to your
> > upstream maintainer when your tree is submitted for merging.  You may
> > also want to consider cooperating with the maintainer of the conflicting
> > tree to minimise any particularly complex conflicts.
> > 
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 1 Jul 2019 19:07:20 +1000
> > Subject: [PATCH] coresight: fix for "bus_find_device: Unify the match callback
> >  with class_find_device"
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/hwtracing/coresight/coresight-platform.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> > index 3c5ceda8db24..fc67f6ae0b3e 100644
> > --- a/drivers/hwtracing/coresight/coresight-platform.c
> > +++ b/drivers/hwtracing/coresight/coresight-platform.c
> > @@ -37,7 +37,7 @@ static int coresight_alloc_conns(struct device *dev,
> >  	return 0;
> >  }
> >  
> > -int coresight_device_fwnode_match(struct device *dev, void *fwnode)
> > +int coresight_device_fwnode_match(struct device *dev, const void *fwnode)
> >  {
> >  	return dev_fwnode(dev) == fwnode;
> >  }
> > -- 
> > 2.20.1
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> 
> Hi Stephen and Michael,
> 
> It looks like a similar fix is needed for the vhost tree because of
> commit edcd69ab9a32 ("iommu: Add virtio-iommu driver") interacting with
> commit 92ce7e83b4e5 ("driver_find_device: Unify the match function with
> class_find_device()") in the driver-core tree (my patch is attached).

Nathan, thanks for noticing and fixing this.

Joerg, the virtio-iommu driver build failed in next because of a
dependency on driver-core changes for v5.3. I'm not sure what the best
practice is in this case, I guess I will resend the driver as applied
onto the latest driver-core, to have it working in v5.3?

Thanks,
Jean

> From 347a1bbeb8ba757648ceeed1839df101417a3d9f Mon Sep 17 00:00:00 2001
> From: Nathan Chancellor <natechancellor@gmail.com>
> Date: Mon, 1 Jul 2019 12:54:28 -0700
> Subject: [PATCH] iommu/virtio: Constify data parameter in viommu_match_node
> 
> After commit 92ce7e83b4e5 ("driver_find_device: Unify the match
> function with class_find_device()") in the driver-core tree.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/iommu/virtio-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 4620dd221ffd..433f4d2ee956 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -839,7 +839,7 @@ static void viommu_put_resv_regions(struct device *dev, struct list_head *head)
>  static struct iommu_ops viommu_ops;
>  static struct virtio_driver virtio_iommu_drv;
>  
> -static int viommu_match_node(struct device *dev, void *data)
> +static int viommu_match_node(struct device *dev, const void *data)
>  {
>  	return dev->parent->fwnode == data;
>  }
> -- 
> 2.22.0
> 

