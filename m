Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184ACC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE88620850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dUQmnU03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbfDAHNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:13:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39806 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDAHNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:13:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id p20so7199416eds.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 00:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9HnkonaAlmrccrey07qta+LCMWeipy1uK1wNObYokO4=;
        b=dUQmnU03ftW5t5Z7bDkMFqzbBob0AnSSxTVun3vvQ8qd+zNuvZCQZp03Ga1As0ARJN
         xArEdC273dSXaPIw9z7HOFqCravnIzSjx/dLTtQNK1kcIO9EhL/FDiQropyIFYEed1C6
         +v8lxX55IjCfOB7Ec8cQc8XjQeYZ9+Wzs5ZV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9HnkonaAlmrccrey07qta+LCMWeipy1uK1wNObYokO4=;
        b=Yjq9Rw5FsO0j0A+EkZpx9Nw5Rp+uIA77gS11xVu/OGlW+x5hJu9OhKB3fV7J3efkKH
         AtZ0jfuNs/1CLWp3cIhppr5si6HrEkoGMYAKHsyOAU66PqXL9mjIiSpLZ96BkrTeFZH0
         OlJy/xvWCjRe85QXoVboPpyNnPMMymDBdpIrq8SylAWaEk5IRf6tG1aDW8NxcI6MJIDS
         VAhK5K0pfFN2iBR/juNNT8mfGCk/X4p3vQMJTidg/NE2bPi7/0Ezx797CB1/X/LkhHxG
         QNqTDYL6duckPUO04TYoqb0Yp+oT83R55EKyyflOfxM5APB3BDDbQbwYWxMrItF7oSnU
         WB0w==
X-Gm-Message-State: APjAAAWGc5ZKOLGY3BO7Xcn+URPb5XgtIaHGzo8BgowqhrzI/EKdQLcm
        pXRaJPyXuD5NitGoVuYwTNkRdw==
X-Google-Smtp-Source: APXvYqxUhwrXjO68S9g54we0pXDTb1VV+ayZPsru7s0ECpQplBoboY9GmZMngSYs0fJySDh4pSX0vA==
X-Received: by 2002:aa7:d945:: with SMTP id l5mr41498841eds.263.1554102829782;
        Mon, 01 Apr 2019 00:13:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id m6sm1722129eja.23.2019.04.01.00.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 00:13:48 -0700 (PDT)
Date:   Mon, 1 Apr 2019 09:13:46 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] dma-buf: Make mmap callback actually optional
Message-ID: <20190401071346.GR2665@phenom.ffwll.local>
Mail-Followup-To: "Andrew F. Davis" <afd@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20190329165201.16233-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329165201.16233-1-afd@ti.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 11:52:01AM -0500, Andrew F. Davis wrote:
> The docs state the callback is optional but it is not, make it optional.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>

There's a bunch of dummy mmap implementations we could remove with this,
would be nice to follow up.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/dma-buf/dma-buf.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 7c858020d14b..4d4ae9fe9ac8 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -90,6 +90,10 @@ static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
>  
>  	dmabuf = file->private_data;
>  
> +	/* check if buffer supports mmap */
> +	if (!dmabuf->ops->mmap)
> +		return -EINVAL;
> +
>  	/* check for overflowing the buffer's size */
>  	if (vma->vm_pgoff + vma_pages(vma) >
>  	    dmabuf->size >> PAGE_SHIFT)
> @@ -404,8 +408,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>  			  || !exp_info->ops
>  			  || !exp_info->ops->map_dma_buf
>  			  || !exp_info->ops->unmap_dma_buf
> -			  || !exp_info->ops->release
> -			  || !exp_info->ops->mmap)) {
> +			  || !exp_info->ops->release)) {
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> @@ -906,6 +909,10 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
>  	if (WARN_ON(!dmabuf || !vma))
>  		return -EINVAL;
>  
> +	/* check if buffer supports mmap */
> +	if (!dmabuf->ops->mmap)
> +		return -EINVAL;
> +
>  	/* check for offset overflow */
>  	if (pgoff + vma_pages(vma) < pgoff)
>  		return -EOVERFLOW;
> -- 
> 2.21.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
