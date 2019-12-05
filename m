Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A766C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F880206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isAPFlCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfLEXzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:55:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49968 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725926AbfLEXzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 18:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575590121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e3JjvtBETMSq5X8ccPeP+yWghLInl+q64B1bKihIixk=;
        b=isAPFlCyX3aM+VaIiLOt/YEpf1eSSO8AjER56xCxKD6WbN8rzLQndxapgh4DD/xVc716o1
        YsEzPUfSpI/Z3ZPhioA0P24KBUbRBwAfe3RXjhzTLysx4hqIXkh2zxWGiAgHM9qrFeuqG2
        izf2Z77+seytvOmd6Ax/oLwY9/tsWqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-0we2EaDoMcuog2U-Xez0fg-1; Thu, 05 Dec 2019 18:55:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10B5E19057A2;
        Thu,  5 Dec 2019 23:55:19 +0000 (UTC)
Received: from x1.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0A1E5C1C3;
        Thu,  5 Dec 2019 23:55:15 +0000 (UTC)
Date:   Thu, 5 Dec 2019 16:55:15 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        libvir-list@redhat.com, qemu-devel@nongnu.org, cohuck@redhat.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        kevin.tian@intel.com, shaopeng.he@intel.com
Subject: Re: [RFC PATCH 3/9] vfio/pci: register a default migration region
Message-ID: <20191205165515.3a9ac7b6@x1.home>
In-Reply-To: <20191205032638.29747-1-yan.y.zhao@intel.com>
References: <20191205032419.29606-1-yan.y.zhao@intel.com>
        <20191205032638.29747-1-yan.y.zhao@intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 0we2EaDoMcuog2U-Xez0fg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Dec 2019 22:26:38 -0500
Yan Zhao <yan.y.zhao@intel.com> wrote:

> Vendor driver specifies when to support a migration region through cap
> VFIO_PCI_DEVICE_CAP_MIGRATION in vfio_pci_mediate_ops->open().
> 
> If vfio-pci detects this cap, it creates a default migration region on
> behalf of vendor driver with region len=0 and region->ops=null.
> Vendor driver should override this region's len, flags, rw, mmap in
> its vfio_pci_mediate_ops.
> 
> This migration region definition is aligned to QEMU vfio migration code v8:
> (https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg05542.html)
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci.c |  15 ++++
>  include/linux/vfio.h        |   1 +
>  include/uapi/linux/vfio.h   | 149 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 165 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index f3730252ee82..059660328be2 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -115,6 +115,18 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>  	return (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
>  }
>  
> +/**
> + * init a region to hold migration ctl & data
> + */
> +void init_migration_region(struct vfio_pci_device *vdev)
> +{
> +	vfio_pci_register_dev_region(vdev, VFIO_REGION_TYPE_MIGRATION,
> +		VFIO_REGION_SUBTYPE_MIGRATION,
> +		NULL, 0,
> +		VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE,
> +		NULL);
> +}
> +
>  static void vfio_pci_probe_mmaps(struct vfio_pci_device *vdev)
>  {
>  	struct resource *res;
> @@ -523,6 +535,9 @@ static int vfio_pci_open(void *device_data)
>  				vdev->mediate_ops = mentry->ops;
>  				vdev->mediate_handle = handle;
>  
> +				if (caps & VFIO_PCI_DEVICE_CAP_MIGRATION)
> +					init_migration_region(vdev);

No.  We're not going to add a cap flag for every region the mediation
driver wants to add.  The mediation driver should have the ability to
add regions and irqs to the device itself.  Thanks,

Alex

> +
>  				pr_info("vfio pci found mediate_ops %s, caps=%llx, handle=%x for %x:%x\n",
>  						vdev->mediate_ops->name, caps,
>  						handle, vdev->pdev->vendor,

