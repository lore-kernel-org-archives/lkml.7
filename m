Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBC7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA2120880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKDR8dwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfDANik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:38:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38197 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfDANij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:38:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so12113990wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fTyxttZU/VE19XLVeVs1pICVbisqKImO+dVJQ6DD1qo=;
        b=NKDR8dwapm43K417oJRa3hNkvrzq8zjsb8g/Dvj6gxgpnUMy3v5fd0OKmf3JRBpJT9
         Ezl//W27HwygQju5Cwkc3i+ZhEGW18/5/KSxazk6COjfBzzsuAe0wRIajj9IzrOOlIMz
         gZXsLP5Nks1qOHRMRiGaMbItfJhInMBekjDCtn0f4ATlQ92ijlqM64CuTZMuPxdkQINx
         QEzVeMRghDIYKvLrH2uMqPY9Ar++q18A4DPDoJlGUrhnigdewyabTrzGp1blRuxODchc
         iau9kp/PquVbmonKGvNeOLOs+HSeYGGwNuZZzK3FEfR0WYJYesC4dzt1TTwrKzPYWCPA
         dmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=fTyxttZU/VE19XLVeVs1pICVbisqKImO+dVJQ6DD1qo=;
        b=V2/jUThMdSp6YaCRtd5G0xeEWAPHjTqtbyhA3LCe2vk9UuWid0HTCjT7sg21sAMW+U
         AMyKgpJu6TSH3tH+sPN4IByfeJOTDgDXRNsDBnzcqq55hYRj6JbcWFLvbkbXpJA3QbjM
         OvrYXMjL0S3s+l4kaMztSL4o7jegLEgp02A6mrLREn3s4tqmpBcnk1hw1NJv3ZfUGwEG
         l2tSAgOAU7QCGrR3DLBQWd8PaV2fKuuk2MWP+yvp4fwpxQSBwc7hPW5feBVAFzhvfW5P
         TltA53A5+HCU4T200d7oZPm683giXK1qxO07BNEZJy7/2sfFHYBeehN6D5O18PXUFGpP
         g9Ng==
X-Gm-Message-State: APjAAAU2e/qZjEAUQmkGrJdOGjr7GR85Q4GEVBfKK6BFyG9dhv7hvbdy
        fVUqaS7VVWoF3NS2GSlR3dI=
X-Google-Smtp-Source: APXvYqwgLr0ZtGQi54PtuYLI6dL+Wh7/XpTFo67LbDi1NMtzB2Rjs4uUxEzLIHD2sgJ8XiD43cuOBw==
X-Received: by 2002:a5d:4a4d:: with SMTP id v13mr39432927wrs.169.1554125918337;
        Mon, 01 Apr 2019 06:38:38 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id o10sm13970913wru.54.2019.04.01.06.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 06:38:37 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] dma-buf: Make mmap callback actually optional
To:     "Andrew F. Davis" <afd@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20190329165201.16233-1-afd@ti.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <24aa0897-8f23-f747-d9a4-d5272f37beea@gmail.com>
Date:   Mon, 1 Apr 2019 15:38:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190329165201.16233-1-afd@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 29.03.19 um 17:52 schrieb Andrew F. Davis:
> The docs state the callback is optional but it is not, make it optional.
>
> Signed-off-by: Andrew F. Davis <afd@ti.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/dma-buf/dma-buf.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 7c858020d14b..4d4ae9fe9ac8 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -90,6 +90,10 @@ static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
>   
>   	dmabuf = file->private_data;
>   
> +	/* check if buffer supports mmap */
> +	if (!dmabuf->ops->mmap)
> +		return -EINVAL;
> +
>   	/* check for overflowing the buffer's size */
>   	if (vma->vm_pgoff + vma_pages(vma) >
>   	    dmabuf->size >> PAGE_SHIFT)
> @@ -404,8 +408,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>   			  || !exp_info->ops
>   			  || !exp_info->ops->map_dma_buf
>   			  || !exp_info->ops->unmap_dma_buf
> -			  || !exp_info->ops->release
> -			  || !exp_info->ops->mmap)) {
> +			  || !exp_info->ops->release)) {
>   		return ERR_PTR(-EINVAL);
>   	}
>   
> @@ -906,6 +909,10 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
>   	if (WARN_ON(!dmabuf || !vma))
>   		return -EINVAL;
>   
> +	/* check if buffer supports mmap */
> +	if (!dmabuf->ops->mmap)
> +		return -EINVAL;
> +
>   	/* check for offset overflow */
>   	if (pgoff + vma_pages(vma) < pgoff)
>   		return -EOVERFLOW;

