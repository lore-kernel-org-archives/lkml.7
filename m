Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E84BC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F2421882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TSpRi0Z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfGCUqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:46:07 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1531 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfGCUqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:46:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1d140a0007>; Wed, 03 Jul 2019 13:46:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 03 Jul 2019 13:46:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 03 Jul 2019 13:46:03 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Jul
 2019 20:46:02 +0000
Subject: Re: [PATCH 4/5] nouveau: unlock mmap_sem on all errors from
 nouveau_range_fault
To:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20190703184502.16234-1-hch@lst.de>
 <20190703184502.16234-5-hch@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <ec5e86a4-4a60-0dd5-797c-41b21e3a091a@nvidia.com>
Date:   Wed, 3 Jul 2019 13:46:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703184502.16234-5-hch@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562186762; bh=HwGmCz10Ci8GwJ1IjwMoUJAJeEMJSYtD2O20Ed/Ggn0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TSpRi0Z2SY1PHzP7KqCWwxKUB7G7m2aHuiHMaA+9zP4+plxdtT8gQdk4j/bAX75jR
         ie5dx3Vb3i48qambjEboni/xwCBSBYFfWIVo7DXI/FiT8Ul+vFRdVDMeGda752Ju2A
         /faZi69iPodzzziBC24xask8p2w8tOrV67rfXnwmepxxW9gqMmKv8bpJ2kHbtImsld
         paeawUfZJ1OaKL7ImUmpDFGnWOkmofheb70vsKR3CJ1F3qa7X4zWMBap07oQfA7/l1
         edHl7WUUACR964z3YaQirWTw8Cyvej6xdanAN7TJ3NW3ryuhpXhblUsxTU4iuod6sZ
         CFn2uVwfp3Juw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/3/19 11:45 AM, Christoph Hellwig wrote:
> Currently nouveau_svm_fault expects nouveau_range_fault to never unlock
> mmap_sem, but the latter unlocks it for a random selection of error
> codes. Fix this up by always unlocking mmap_sem for non-zero return
> values in nouveau_range_fault, and only unlocking it in the caller
> for successful returns.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   drivers/gpu/drm/nouveau/nouveau_svm.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index e831f4184a17..c0cf7aeaefb3 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -500,8 +500,10 @@ nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range,

You can delete the comment "With the old API the driver must ..."
(not visible in the patch here).
I suggest moving the two assignments:
	range->default_flags = 0;
	range->pfn_flags_mask = -1UL;
to just above the "again:" where the other range.xxx fields are
initialized in nouveau_svm_fault().

>   	ret = hmm_range_register(range, mirror,
>   				 range->start, range->end,
>   				 PAGE_SHIFT);
> -	if (ret)
> +	if (ret) {
> +		up_read(&range->vma->vm_mm->mmap_sem; >   		return (int)ret;
> +	}
>   
>   	if (!hmm_range_wait_until_valid(range, NOUVEAU_RANGE_FAULT_TIMEOUT)) {
>   		/*

You can delete this comment (only the first line is visible here)
since it is about the "old API".
Also, it should return -EBUSY not -EAGAIN since it means there was a
range invalidation collision (similar to hmm_range_fault() if
!range->valid).

> @@ -515,15 +517,14 @@ nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range,
>   
>   	ret = hmm_range_fault(range, block);

nouveau_range_fault() is only called with "block = true" so
could eliminate the block parameter and pass true here.

>   	if (ret <= 0) {
> -		if (ret == -EBUSY || !ret) {
> -			/* Same as above, drop mmap_sem to match old API. */
> -			up_read(&range->vma->vm_mm->mmap_sem);
> -			ret = -EBUSY;
> -		} else if (ret == -EAGAIN)
> +		if (ret == 0)
>   			ret = -EBUSY;
> +		if (ret != -EAGAIN)
> +			up_read(&range->vma->vm_mm->mmap_sem);

Can ret == -EAGAIN happen if "block = true"?
Generally, I prefer the read_down()/read_up() in the same function
(i.e., nouveau_svm_fault()) but I can see why it should be here
if hmm_range_fault() can return with mmap_sem unlocked.

>   		hmm_range_unregister(range);
>   		return ret;
>   	}
> +
>   	return 0;
>   }
>   
> @@ -718,8 +719,8 @@ nouveau_svm_fault(struct nvif_notify *notify)
>   						NULL);
>   			svmm->vmm->vmm.object.client->super = false;
>   			mutex_unlock(&svmm->mutex);
> +			up_read(&svmm->mm->mmap_sem);
>   		}
> -		up_read(&svmm->mm->mmap_sem);
>   

The "else" case should check for -EBUSY and goto again.

>   		/* Cancel any faults in the window whose pages didn't manage
>   		 * to keep their valid bit, or stay writeable when required.
> 
