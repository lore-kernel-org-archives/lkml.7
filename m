Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5566DC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276B222DD6
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 03:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566357851;
	bh=U1ObGutqAEhoSSAYD+dBtzQrDTU0pfcjlItTW4YyWZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QijZYRtru+Aq7Oje96nq//e2rFTEHJkp7QgW+SKRw//ZSwW2BAI5X4+q0tAIr+mXb
	 lBrSp2NSYHmSZyVh9n2INZEWnE6N4a+kLFRkgS6dxjGIYNRS9v13DPLioNLIZSJF3h
	 J1x/Onkho5ITjL0W7NAeOmrLZvgDrXhTw0UvJ/jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfHUDYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 23:24:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44103 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbfHUDYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:24:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so460547pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 20:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jR0kd8E/wjsd/vD58hqG03ghBqWwRF++q3yiXcP3i4Q=;
        b=MB4SI5wBMeUQKbeFDn5OA3gM6UcYOy/GHOwRzBdq99+KcOkTQ/zJlH+NGIzo4hJpY6
         blxETi61z09X4NRK+oWq5CRxCgtls4wVh1ZyUWCwoNdeOpBmtLBhtU0XIk4M3r/kUCbp
         kZKCQ+u8ZG+ZK/Jit3SGLropfLbvakodW40NFMPVZX0iJfV3PaTiJ54GmfCraZe4YFfP
         swYvN0DVDlLPkwmEX1NxE92VUqALE4FIBIwZoUFSNDqs/jNaxf0gMP6wgCKRurElXWfm
         Vh8AdEDlviffYiu+nBtv1RaSSNZEDo64qL0zLAKnqOt/BYIfbU0AGv5HDr24u7DQQa6K
         Q8NQ==
X-Gm-Message-State: APjAAAUaVkZkIp1UTcfI5Sh6DxnLbmNr2NQqKNAomvc6aDilXVHbqIi5
        sCirf9gAjjlyFj5LUlA25krrHg==
X-Google-Smtp-Source: APXvYqx02TH2hHNKYt4nqEYXzwAFlFF9WoYyNeM00zGsD5tPI0GF1ZVQQYIRXONJRCZAIgaLN9mj5A==
X-Received: by 2002:a62:e910:: with SMTP id j16mr34286562pfh.123.1566357848815;
        Tue, 20 Aug 2019 20:24:08 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id c13sm22739750pfi.17.2019.08.20.20.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 20:24:07 -0700 (PDT)
Date:   Tue, 20 Aug 2019 20:24:06 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        atull@kernel.org
Subject: Re: [PATCH v5 1/9] fpga: dfl: make init callback optional
Message-ID: <20190821032406.GA28625@archbox>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
 <1565578204-13969-2-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565578204-13969-2-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 12, 2019 at 10:49:56AM +0800, Wu Hao wrote:
> This patch makes init callback of sub features optional. With
> this change, people don't need to prepare any empty init callback.
> 
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index c0512af..96a2b82 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -271,11 +271,13 @@ static int dfl_feature_instance_init(struct platform_device *pdev,
>  				     struct dfl_feature *feature,
>  				     struct dfl_feature_driver *drv)
>  {
> -	int ret;
> +	int ret = 0;
>  
> -	ret = drv->ops->init(pdev, feature);
> -	if (ret)
> -		return ret;
> +	if (drv->ops->init) {
> +		ret = drv->ops->init(pdev, feature);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	feature->ops = drv->ops;

You could swap it around maybe like so:

int dfl_feature_instance_init() ...
{
	feature->ops = drv->ops;
	if (drv->ops->init)
		return drv->ops->init(pdev, feature);

	return 0;
}

With the caveat that feature->ops gets always set ...

Your call.

Thanks,
Moritz
