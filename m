Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6A8C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C67A22CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566358131;
	bh=h62B4j2FOwWirHP1+DzSufc6oo0jCD2jub9yu/4xYcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1ubZIbwjLciJ2k72V1w9unLiaZJ6CR7qoQsyOtWt1Lq4R3cDcLpIatYeJm9rk1PPi
	 ybXj1c5Z6vqxygh5kxHGY7JVszg1gT3lL6vUwctfVYkRyAjWNLw1zMvJwaIowILSEX
	 SuztCadtefGYiukI/SZhuzxjhFiou2BIP5Y9mwZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfHUD2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 23:28:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35794 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfHUD2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:28:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id d85so471230pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 20:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O3GThF6qgBBSbkZwWRayRKD2MaFCahuUCpZzRTM/BR0=;
        b=lJgU+v+sqA7ICZrgm6EtvUbPg6RV0D/rlVzKAHBUZ3jGKY6icNFnV9hua8bDKvWSV4
         jJMkdzTaCzjqRpAU9u9SxsXGXv+OtTj8wXiMyMl7RvaII7t37QeFNoAYChY34V8A+a8k
         tlWixTEF0bI/1uW3KcZ/IjSsrIsBQhrc6EsDvNMCSmzvEeWUZKjJ4vU6L8Mx2NHh4b+8
         tzzhXYiN0yuquUEm+iW4xJyeCeO6syveLxGlFthL2hcahJCxUl913ZKEiXNCgmPgGown
         bj7mqLAIwYX0FDO9bEjjL95aio/ML2UI8lbjeUr8I5rs7z2f//sJrzFvX7E4MD5moTJj
         xMLA==
X-Gm-Message-State: APjAAAVX5+3wtW98mL9cI6z/ypLjAZLBztdKMSXvi7+qFWzTnBY7LJK1
        75YgAJymR52CGrfuQPTujzR2dw==
X-Google-Smtp-Source: APXvYqyumJYFLBjxpJaHCd0soNjhTEab8KG/HJBqQQUsiVKxWCzrF4y9BztwfhrVQnKH/j++9l8dVQ==
X-Received: by 2002:a17:90a:cd03:: with SMTP id d3mr3221239pju.117.1566358129061;
        Tue, 20 Aug 2019 20:28:49 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id b6sm18402890pgq.26.2019.08.20.20.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 20:28:48 -0700 (PDT)
Date:   Tue, 20 Aug 2019 20:28:47 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        atull@kernel.org
Subject: Re: [PATCH v5 2/9] fpga: dfl: fme: convert platform_driver to use
 dev_groups
Message-ID: <20190821032847.GB28625@archbox>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
 <1565578204-13969-3-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565578204-13969-3-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hao,

On Mon, Aug 12, 2019 at 10:49:57AM +0800, Wu Hao wrote:
> This patch takes advantage of driver core which helps to create
> and remove sysfs attribute files, so there is no need to register
> sysfs entries manually in dfl-fme platform river code.
Nit: s/river/driver
> 
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl-fme-main.c | 29 ++---------------------------
>  1 file changed, 2 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index f033f1c..bf8114d 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -129,30 +129,6 @@ static ssize_t socket_id_show(struct device *dev,
>  };
>  ATTRIBUTE_GROUPS(fme_hdr);
>  
> -static int fme_hdr_init(struct platform_device *pdev,
> -			struct dfl_feature *feature)
> -{
> -	void __iomem *base = feature->ioaddr;
> -	int ret;
> -
> -	dev_dbg(&pdev->dev, "FME HDR Init.\n");
> -	dev_dbg(&pdev->dev, "FME cap %llx.\n",
> -		(unsigned long long)readq(base + FME_HDR_CAP));
> -
> -	ret = device_add_groups(&pdev->dev, fme_hdr_groups);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
> -static void fme_hdr_uinit(struct platform_device *pdev,
> -			  struct dfl_feature *feature)
> -{
> -	dev_dbg(&pdev->dev, "FME HDR UInit.\n");
> -	device_remove_groups(&pdev->dev, fme_hdr_groups);
> -}
> -
>  static long fme_hdr_ioctl_release_port(struct dfl_feature_platform_data *pdata,
>  				       unsigned long arg)
>  {
> @@ -199,8 +175,6 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
>  };
>  
>  static const struct dfl_feature_ops fme_hdr_ops = {
> -	.init = fme_hdr_init,
> -	.uinit = fme_hdr_uinit,
>  	.ioctl = fme_hdr_ioctl,
>  };
>  
> @@ -361,7 +335,8 @@ static int fme_remove(struct platform_device *pdev)
>  
>  static struct platform_driver fme_driver = {
>  	.driver	= {
> -		.name    = DFL_FPGA_FEATURE_DEV_FME,
> +		.name       = DFL_FPGA_FEATURE_DEV_FME,
> +		.dev_groups = fme_hdr_groups,
>  	},
>  	.probe   = fme_probe,
>  	.remove  = fme_remove,
> -- 
> 1.8.3.1
> 
Thanks,
Moritz
