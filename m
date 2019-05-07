Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F015C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11454205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557250056;
	bh=kZ68m/h7Fj2ebrbcHkKK2fb5u98xtgAOdaWhzuLlzAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VUKG8URSqFJy7QNmtjVkVxnbrvvjaDaxLAGD5f0d+Wg5RF28RDR7Ld5/RS/k2otNw
	 05M7veKqQ6JnQDX9RzkBzWzMUy4NiZcLtkIck4eR1ZSZ4w5DyRqaI3UzAnxS5HR7lN
	 5oBc6+sXJreVKK520CGgO3QnJA234kNico+W+fUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfEGR1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:27:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40747 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfEGR1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:27:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so8507644plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2GznVx19aBlSBwrY4k/2U/6uFTPH38asKDdyd9v7fLM=;
        b=FxXidNKmX148t8giKiuVZ0xyCPAZ9CauiqWZf39yRWId7G9pWYy1KWNHPHzmRaUQuz
         eg8EyGuePynECK6hA+Nc/Lmg8PYe0J96WBkBXzqj9s7KoNCkfrTVW0iEkauDvRRbTH2c
         TUhW+l/gH7Q8WYY2+6DscrMiw6mC8dKFswWUDpOZZBMWOVEtwVAlSQYNsa7j0D8Rg3L/
         Qaa5748BpcCyhDYR3xTLr8fTdmPlAQ0nBE39jg/H0dcNlmGcJqy/Iaq3f9yRkJvGYc5B
         bRSL10fqQxiqBi16oQMtjqYD6A7vJGkvrGm894MkWlF0W8N9HJxDzLCMVF/XivqiT3u5
         b3jA==
X-Gm-Message-State: APjAAAXr2UqVLSxh1ZvsuPhoPbC6TZ9+MwdToNU4sxs42v6+7Vjte6Yp
        XwZ9L/McKpYjbKJUv41sSBpESg==
X-Google-Smtp-Source: APXvYqxUpLLcdT6fy8v+mso0WDW3BBsgS4L5Z3JtBQ2F2YruBQUpMC1dM86GInYA0WCXOP2JhVj7qg==
X-Received: by 2002:a17:902:100a:: with SMTP id b10mr36618902pla.239.1557250054263;
        Tue, 07 May 2019 10:27:34 -0700 (PDT)
Received: from localhost ([2601:647:4700:2953:ec49:968:583:9f8])
        by smtp.gmail.com with ESMTPSA id y3sm22725826pge.7.2019.05.07.10.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 10:27:33 -0700 (PDT)
Date:   Tue, 7 May 2019 10:27:32 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v2 03/18] fpga: dfl: fme: align PR buffer size per PR
 datawidth
Message-ID: <20190507172732.GB26690@archbox>
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
 <1556528151-17221-4-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556528151-17221-4-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 04:55:36PM +0800, Wu Hao wrote:
> Current driver checks if input bitstream file size is aligned or
> not per PR data width (default 32bits). It requires one additional
> step for end user when they generate the bitstream file, padding
> extra zeros to bitstream file to align its size per PR data width,
> but they don't have to as hardware will drop extra padding bytes
> automatically.
> 
> In order to simplify the user steps, this patch aligns PR buffer
> size per PR data width in driver, to allow user to pass unaligned
> size bitstream files to driver.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl-fme-pr.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> index 6ec0f09..3c71dc3 100644
> --- a/drivers/fpga/dfl-fme-pr.c
> +++ b/drivers/fpga/dfl-fme-pr.c
> @@ -74,6 +74,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>  	struct dfl_fme *fme;
>  	unsigned long minsz;
>  	void *buf = NULL;
> +	size_t length;
>  	int ret = 0;
>  	u64 v;
>  
> @@ -85,9 +86,6 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>  	if (port_pr.argsz < minsz || port_pr.flags)
>  		return -EINVAL;
>  
> -	if (!IS_ALIGNED(port_pr.buffer_size, 4))
> -		return -EINVAL;
> -
>  	/* get fme header region */
>  	fme_hdr = dfl_get_feature_ioaddr_by_id(&pdev->dev,
>  					       FME_FEATURE_ID_HEADER);
> @@ -103,7 +101,13 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>  		       port_pr.buffer_size))
>  		return -EFAULT;
>  
> -	buf = vmalloc(port_pr.buffer_size);
> +	/*
> +	 * align PR buffer per PR bandwidth, as HW ignores the extra padding
> +	 * data automatically.
> +	 */
> +	length = ALIGN(port_pr.buffer_size, 4);
> +
> +	buf = vmalloc(length);
>  	if (!buf)
>  		return -ENOMEM;
>  
> @@ -140,7 +144,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>  	fpga_image_info_free(region->info);
>  
>  	info->buf = buf;
> -	info->count = port_pr.buffer_size;
> +	info->count = length;
>  	info->region_id = port_pr.port_id;
>  	region->info = info;
>  
> -- 
> 1.8.3.1
> 
