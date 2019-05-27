Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B32EC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C555205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfE0OEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:04:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfE0OEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:04:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B88047EBC1;
        Mon, 27 May 2019 14:04:04 +0000 (UTC)
Received: from gondolin (ovpn-204-109.brq.redhat.com [10.40.204.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E18BF7854F;
        Mon, 27 May 2019 14:03:58 +0000 (UTC)
Date:   Mon, 27 May 2019 16:03:55 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Thomas Meyer" <thomas@m3y3r.de>
Cc:     alex.williamson@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: your patch
Message-ID: <20190527160355.1cd446c4.cohuck@redhat.com>
In-Reply-To: <E1hUrZM-0007qA-Q8@sslproxy01.your-server.de>
References: <E1hUrZM-0007qA-Q8@sslproxy01.your-server.de>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 27 May 2019 14:04:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 May 2019 13:44:04 +0200
"Thomas Meyer" <thomas@m3y3r.de> wrote:

> From thomas@m3y3r.de Sun May 26 00:13:26 2019
> Subject: [PATCH] vfio-pci/nvlink2: Use vma_pages function instead of explicit
>  computation
> To: alex.williamson@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
> Content-Type: text/plain; charset="UTF-8"
> Mime-Version: 1.0
> Content-Transfer-Encoding: 8bit
> X-Patch: Cocci
> X-Mailer: DiffSplit
> Message-ID: <1558822461341-1674464153-1-diffsplit-thomas@m3y3r.de>
> References: <1558822461331-726613767-0-diffsplit-thomas@m3y3r.de>
> In-Reply-To: <1558822461331-726613767-0-diffsplit-thomas@m3y3r.de>
> X-Serial-No: 1

Hi,

some kind of accident seems to have happened to your patch... maybe the
missing colon after the 'From'?

> 
> Use vma_pages function on vma object instead of explicit computation.
> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
> 
> diff -u -p a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
> --- a/drivers/vfio/pci/vfio_pci_nvlink2.c
> +++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
> @@ -161,7 +161,7 @@ static int vfio_pci_nvgpu_mmap(struct vf
>  
>  	atomic_inc(&data->mm->mm_count);
>  	ret = (int) mm_iommu_newdev(data->mm, data->useraddr,
> -			(vma->vm_end - vma->vm_start) >> PAGE_SHIFT,
> +			vma_pages(vma),
>  			data->gpu_hpa, &data->mem);
>  
>  	trace_vfio_pci_nvgpu_mmap(vdev->pdev, data->gpu_hpa, data->useraddr,

The change looks good to me.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
