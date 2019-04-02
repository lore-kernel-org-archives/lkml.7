Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400B3C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B19B2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfDBTOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:14:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfDBTOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:14:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9AD6308FF17;
        Tue,  2 Apr 2019 19:14:42 +0000 (UTC)
Received: from [10.36.117.163] (ovpn-117-163.ams2.redhat.com [10.36.117.163])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A2E21001DF1;
        Tue,  2 Apr 2019 19:14:35 +0000 (UTC)
Subject: Re: [PATCH v2] vfio/type1: Limit DMA mappings per container
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, peterx@redhat.com
References: <155422160029.16896.1992475589398080933.stgit@gimli.home>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <926e2e52-2fbd-9342-ed1f-920322985d68@redhat.com>
Date:   Tue, 2 Apr 2019 21:14:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <155422160029.16896.1992475589398080933.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 02 Apr 2019 19:14:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 4/2/19 6:15 PM, Alex Williamson wrote:
> Memory backed DMA mappings are accounted against a user's locked
> memory limit, including multiple mappings of the same memory.  This
> accounting bounds the number of such mappings that a user can create.
> However, DMA mappings that are not backed by memory, such as DMA
> mappings of device MMIO via mmaps, do not make use of page pinning
> and therefore do not count against the user's locked memory limit.
> These mappings still consume memory, but the memory is not well
> associated to the process for the purpose of oom killing a task.
> 
> To add bounding on this use case, we introduce a limit to the total
> number of concurrent DMA mappings that a user is allowed to create.
> This limit is exposed as a tunable module option where the default
> value of 64K is expected to be well in excess of any reasonable use
> case (a large virtual machine configuration would typically only make
> use of tens of concurrent mappings).
> 
> This fixes CVE-2019-3882.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
> 
> v2: Remove unnecessary atomic, all runtime access occurs while
>     holding vfio_iommu.lock.  Change to unsigned int since we're
>     no longer bound by the atomic_t.
> 
>  drivers/vfio/vfio_iommu_type1.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 73652e21efec..d0f731c9920a 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -58,12 +58,18 @@ module_param_named(disable_hugepages,
>  MODULE_PARM_DESC(disable_hugepages,
>  		 "Disable VFIO IOMMU support for IOMMU hugepages.");
>  
> +static unsigned int dma_entry_limit __read_mostly = U16_MAX;
> +module_param_named(dma_entry_limit, dma_entry_limit, uint, 0644);
> +MODULE_PARM_DESC(dma_entry_limit,
> +		 "Maximum number of user DMA mappings per container (65535).");
> +
>  struct vfio_iommu {
>  	struct list_head	domain_list;
>  	struct vfio_domain	*external_domain; /* domain for external user */
>  	struct mutex		lock;
>  	struct rb_root		dma_list;
>  	struct blocking_notifier_head notifier;
> +	unsigned int		dma_avail;
>  	bool			v2;
>  	bool			nesting;
>  };
> @@ -836,6 +842,7 @@ static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
>  	vfio_unlink_dma(iommu, dma);
>  	put_task_struct(dma->task);
>  	kfree(dma);
> +	iommu->dma_avail++;
>  }
>  
>  static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
> @@ -1081,12 +1088,18 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
>  		goto out_unlock;
>  	}
>  
> +	if (!iommu->dma_avail) {
> +		ret = -ENOSPC;
> +		goto out_unlock;
> +	}
> +
>  	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
>  	if (!dma) {
>  		ret = -ENOMEM;
>  		goto out_unlock;
>  	}
>  
> +	iommu->dma_avail--;
>  	dma->iova = iova;
>  	dma->vaddr = vaddr;
>  	dma->prot = prot;
> @@ -1583,6 +1596,7 @@ static void *vfio_iommu_type1_open(unsigned long arg)
>  
>  	INIT_LIST_HEAD(&iommu->domain_list);
>  	iommu->dma_list = RB_ROOT;
> +	iommu->dma_avail = dma_entry_limit;
>  	mutex_init(&iommu->lock);
>  	BLOCKING_INIT_NOTIFIER_HEAD(&iommu->notifier);
>  
> 
