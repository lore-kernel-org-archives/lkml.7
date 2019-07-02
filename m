Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D09C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3A92089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfGBSAd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 14:00:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGBSAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 14:00:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A69B67FDCA;
        Tue,  2 Jul 2019 18:00:32 +0000 (UTC)
Received: from x1.home (ovpn-116-83.phx2.redhat.com [10.3.116.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 768415C29A;
        Tue,  2 Jul 2019 18:00:30 +0000 (UTC)
Date:   Tue, 2 Jul 2019 12:00:29 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "richard.peng@oppo.com" <richard.peng@oppo.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio: vfio_pci_nvlink2: use a vma helper function
Message-ID: <20190702120029.74b1dc8f@x1.home>
In-Reply-To: <2019051620382477288130@oppo.com>
References: <2019051620382477288130@oppo.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 02 Jul 2019 18:00:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2019 20:38:26 +0800
"richard.peng@oppo.com" <richard.peng@oppo.com> wrote:

> Use a vma helper function to simply code.
> 
> Signed-off-by: Peng Hao <richard.peng@oppo.com>
> ---
>  drivers/vfio/pci/vfio_pci_nvlink2.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
> index 32f695ffe128..dc42aa0e47f6 100644
> --- a/drivers/vfio/pci/vfio_pci_nvlink2.c
> +++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
> @@ -161,8 +161,7 @@ static int vfio_pci_nvgpu_mmap(struct vfio_pci_device *vdev,
>  
>  	atomic_inc(&data->mm->mm_count);
>  	ret = (int) mm_iommu_newdev(data->mm, data->useraddr,
> -			(vma->vm_end - vma->vm_start) >> PAGE_SHIFT,
> -			data->gpu_hpa, &data->mem);
> +			vma_pages(vma), data->gpu_hpa, &data->mem);
>  
>  	trace_vfio_pci_nvgpu_mmap(vdev->pdev, data->gpu_hpa, data->useraddr,
>  			vma->vm_end - vma->vm_start, ret);
> -- 
> 2.20.1

Applied to vfio next branch for 5.3 with Alexey's R-b.  Thanks!

Alex
