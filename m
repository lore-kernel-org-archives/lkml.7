Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDDDC3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6152133F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566486426;
	bh=SzxEX/Yygf8Gw0Ena/p30+bCZknRpYIAXRFPYnzeCkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=INL1qw3eGYtz2PLjHTPFLKeu9Fp746PjjwBTwcDb6YB/V7iB4KNYOOFxtJRKBqD/S
	 osYUTMszAQQJSMMIvwCSI478Oh9Si3wal6A7f5/DsbNmpxdXyCXUUN3JP4t7tKZGe9
	 dKLUw4pN0seMGg1qdkj1vtEMNWxggY0n9/Vm+jnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389388AbfHVPHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:07:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39284 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387481AbfHVPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:07:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so3834820pgi.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 08:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DwlPQdW0JeEtIGvgq8R1ceN0wd/Kz610hNpWCu5gwlA=;
        b=n5npKcw1CAfs4aZP6U3NE9l44x+40qfx6dkAC6yrp74rM/NuvYK0m6OfEfiDV8ViGv
         MRYGnpEFomYkUIBrOrVIGoIR9w7VBKiE9N618vd/LAiyHCI9s68ruMZOYXkoJMvmiMUp
         FNrOkSTRvDM2s7KmhGyjAvPGBjpz1fkA77oRZscbQrXeolIAoYYWoHFnrtFFRan8NES/
         lmOBJzFpbN89wiCH+Tvd4YrfUuy+xoBgL4rE25OOSHZH3tRkrlJdhfgtO7nKh4V4I1Kj
         xLaYy1A5fPeeC7G3/7eeUamGdfQm6X74e3Z5Qh+fvChWmZNfXwZbuuEJusrLz9VGa+Rx
         Q8cA==
X-Gm-Message-State: APjAAAX4jOlv3kxIg68omYer5AWzy0lsDVDMYkxsWtx78bwPqQna49X6
        rvVbDpMg5WqYZhixOr1KHxmnm0PHlmU=
X-Google-Smtp-Source: APXvYqxJedFbXqQsR91ygwGRNG5VFsHWjFMw+ey7bYeczu1U3+7RN2or2CgkfKGJex4aCcngRkgHTA==
X-Received: by 2002:aa7:95b8:: with SMTP id a24mr41746708pfk.103.1566486423362;
        Thu, 22 Aug 2019 08:07:03 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id 71sm3357841pfw.157.2019.08.22.08.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 08:07:02 -0700 (PDT)
Date:   Thu, 22 Aug 2019 08:07:01 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        atull@kernel.org
Subject: Re: [PATCH v5 3/9] fpga: dfl: afu: convert platform_driver to use
 dev_groups
Message-ID: <20190822150701.GB22556@archbox>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
 <1565578204-13969-4-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565578204-13969-4-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hao,

On Mon, Aug 12, 2019 at 10:49:58AM +0800, Wu Hao wrote:
> This patch takes advantage of driver core which helps to create
> and remove sysfs attribute files, so there is no need to register
> sysfs entries manually in dfl-afu platform river code.
Same nit: s/river/driver
> 
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl-afu-main.c | 69 +++++++++++++++++++++++----------------------
>  1 file changed, 36 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index e50c45e..e955149 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -282,24 +282,17 @@ static int port_get_id(struct platform_device *pdev)
>  	&dev_attr_power_state.attr,
>  	NULL,
>  };
> -ATTRIBUTE_GROUPS(port_hdr);
> +
> +static const struct attribute_group port_hdr_group = {
> +	.attrs = port_hdr_attrs,
> +};
>  
>  static int port_hdr_init(struct platform_device *pdev,
>  			 struct dfl_feature *feature)
>  {
> -	dev_dbg(&pdev->dev, "PORT HDR Init.\n");
> -
>  	port_reset(pdev);
>  
> -	return device_add_groups(&pdev->dev, port_hdr_groups);
> -}
> -
> -static void port_hdr_uinit(struct platform_device *pdev,
> -			   struct dfl_feature *feature)
> -{
> -	dev_dbg(&pdev->dev, "PORT HDR UInit.\n");
> -
> -	device_remove_groups(&pdev->dev, port_hdr_groups);
> +	return 0;
>  }
>  
>  static long
> @@ -330,7 +323,6 @@ static void port_hdr_uinit(struct platform_device *pdev,
>  
>  static const struct dfl_feature_ops port_hdr_ops = {
>  	.init = port_hdr_init,
> -	.uinit = port_hdr_uinit,
>  	.ioctl = port_hdr_ioctl,
>  };
>  
> @@ -361,32 +353,37 @@ static void port_hdr_uinit(struct platform_device *pdev,
>  	&dev_attr_afu_id.attr,
>  	NULL
>  };
> -ATTRIBUTE_GROUPS(port_afu);
>  
> -static int port_afu_init(struct platform_device *pdev,
> -			 struct dfl_feature *feature)
> +static umode_t port_afu_attrs_visible(struct kobject *kobj,
> +				      struct attribute *attr, int n)
>  {
> -	struct resource *res = &pdev->resource[feature->resource_index];
> -	int ret;
> -
> -	dev_dbg(&pdev->dev, "PORT AFU Init.\n");
> +	struct device *dev = kobj_to_dev(kobj);
>  
> -	ret = afu_mmio_region_add(dev_get_platdata(&pdev->dev),
> -				  DFL_PORT_REGION_INDEX_AFU, resource_size(res),
> -				  res->start, DFL_PORT_REGION_READ |
> -				  DFL_PORT_REGION_WRITE | DFL_PORT_REGION_MMAP);
> -	if (ret)
> -		return ret;
> +	/*
> +	 * sysfs entries are visible only if related private feature is
> +	 * enumerated.
> +	 */
> +	if (!dfl_get_feature_by_id(dev, PORT_FEATURE_ID_AFU))
> +		return 0;
>  
> -	return device_add_groups(&pdev->dev, port_afu_groups);
> +	return attr->mode;
>  }
>  
> -static void port_afu_uinit(struct platform_device *pdev,
> -			   struct dfl_feature *feature)
> +static const struct attribute_group port_afu_group = {
> +	.attrs      = port_afu_attrs,
> +	.is_visible = port_afu_attrs_visible,
> +};
> +
> +static int port_afu_init(struct platform_device *pdev,
> +			 struct dfl_feature *feature)
>  {
> -	dev_dbg(&pdev->dev, "PORT AFU UInit.\n");
Thanks.
> +	struct resource *res = &pdev->resource[feature->resource_index];
>  
> -	device_remove_groups(&pdev->dev, port_afu_groups);
> +	return afu_mmio_region_add(dev_get_platdata(&pdev->dev),
> +				   DFL_PORT_REGION_INDEX_AFU,
> +				   resource_size(res), res->start,
> +				   DFL_PORT_REGION_MMAP | DFL_PORT_REGION_READ |
> +				   DFL_PORT_REGION_WRITE);
>  }
>  
>  static const struct dfl_feature_id port_afu_id_table[] = {
> @@ -396,7 +393,6 @@ static void port_afu_uinit(struct platform_device *pdev,
>  
>  static const struct dfl_feature_ops port_afu_ops = {
>  	.init = port_afu_init,
> -	.uinit = port_afu_uinit,
>  };
>  
>  static struct dfl_feature_driver port_feature_drvs[] = {
> @@ -748,9 +744,16 @@ static int afu_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct attribute_group *afu_dev_groups[] = {
> +	&port_hdr_group,
> +	&port_afu_group,
> +	NULL
> +};
> +
>  static struct platform_driver afu_driver = {
>  	.driver	= {
> -		.name    = DFL_FPGA_FEATURE_DEV_PORT,
> +		.name	    = DFL_FPGA_FEATURE_DEV_PORT,
> +		.dev_groups = afu_dev_groups,
>  	},
>  	.probe   = afu_probe,
>  	.remove  = afu_remove,
> -- 
> 1.8.3.1
> 

Thanks,
Moritz
