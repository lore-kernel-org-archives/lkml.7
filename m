Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC86C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811732070D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EjgaTeME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfDAN1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:27:46 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58010 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfDAN1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:27:45 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x31DRhQG064665;
        Mon, 1 Apr 2019 08:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554125263;
        bh=48E4JXp1M9qjd+wRdCA8aF8TMqR18Fseo759ihfXIUc=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=EjgaTeMEAukGUL/We3a2AmuoNUX+v4V4vI+jgDm6YK+n5PUR8HM3jUqWfeoP2KYXM
         m+W2oeOVr5aGCUsdjx4hY/Av1SKskWN38w6x9H4aFGJItW5N1I+AcnDhs9uxDmoqOC
         92BN+lQeQgZACKSFhpNK/Mnxkq0y7Oz90Zsho2/k=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x31DRh9R103255
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Apr 2019 08:27:43 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Apr
 2019 08:27:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Apr 2019 08:27:43 -0500
Received: from [10.250.67.168] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x31DRh89038496;
        Mon, 1 Apr 2019 08:27:43 -0500
Subject: Re: [PATCH] dma-buf: Make mmap callback actually optional
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <20190329165201.16233-1-afd@ti.com>
 <20190401071346.GR2665@phenom.ffwll.local>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <5d206b28-a8fc-4a3e-a75b-c91106b1f232@ti.com>
Date:   Mon, 1 Apr 2019 08:27:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401071346.GR2665@phenom.ffwll.local>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 2:13 AM, Daniel Vetter wrote:
> On Fri, Mar 29, 2019 at 11:52:01AM -0500, Andrew F. Davis wrote:
>> The docs state the callback is optional but it is not, make it optional.
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
> 
> There's a bunch of dummy mmap implementations we could remove with this,
> would be nice to follow up.
> 

Was cleaning up some dummy kmap implementations when I found that many
had dummy mmap also, so plan was if this goes in I'll be able to zap
them both in one go. That or actually add valid kmap where appropriate.
Either way will be following up.

Andrew

> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
>> ---
>>  drivers/dma-buf/dma-buf.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>> index 7c858020d14b..4d4ae9fe9ac8 100644
>> --- a/drivers/dma-buf/dma-buf.c
>> +++ b/drivers/dma-buf/dma-buf.c
>> @@ -90,6 +90,10 @@ static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
>>  
>>  	dmabuf = file->private_data;
>>  
>> +	/* check if buffer supports mmap */
>> +	if (!dmabuf->ops->mmap)
>> +		return -EINVAL;
>> +
>>  	/* check for overflowing the buffer's size */
>>  	if (vma->vm_pgoff + vma_pages(vma) >
>>  	    dmabuf->size >> PAGE_SHIFT)
>> @@ -404,8 +408,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>>  			  || !exp_info->ops
>>  			  || !exp_info->ops->map_dma_buf
>>  			  || !exp_info->ops->unmap_dma_buf
>> -			  || !exp_info->ops->release
>> -			  || !exp_info->ops->mmap)) {
>> +			  || !exp_info->ops->release)) {
>>  		return ERR_PTR(-EINVAL);
>>  	}
>>  
>> @@ -906,6 +909,10 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
>>  	if (WARN_ON(!dmabuf || !vma))
>>  		return -EINVAL;
>>  
>> +	/* check if buffer supports mmap */
>> +	if (!dmabuf->ops->mmap)
>> +		return -EINVAL;
>> +
>>  	/* check for offset overflow */
>>  	if (pgoff + vma_pages(vma) < pgoff)
>>  		return -EOVERFLOW;
>> -- 
>> 2.21.0
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
