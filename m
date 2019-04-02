Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8E1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E27920645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554220223;
	bh=gQRxqZTrsWernSTVuhn6VHimU97NbrGFWxSbL87cn1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CFcAtj4zpAja61uQwx/40T3fPPLwr5YOmoB2sfVP6FcTT2JUgvLzgWi7OWW0Sd2wR
	 v1HAlCmMYuLajhLdGiKE9PQr2kP+GfxzxJSid93dJfih/3lvtusPRheAHWptye51zd
	 E434v/sQrk7/GWiBTW+qD4bLEmtFiTF5bV99gp3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfDBPuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:50:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35775 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbfDBPuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:50:21 -0400
Received: by mail-oi1-f196.google.com with SMTP id j132so10904398oib.2;
        Tue, 02 Apr 2019 08:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vr7Xurvr8ZOIpnzirFsanXxgCrh1Xd6RlJrJHylNDj4=;
        b=efRZqcYPOsYwj5oB6uWrr0tTMWLYMbxdAX5JadC49q6tnTIeW6Voq62qVzJc0Rb2E9
         TKYNXxj7rI7261KcbX+8/sYNKpnsK1e0kuenkeTzkoHOO1IfunszSrB6OSelwiyeRK6j
         MDj7qhXktB7Lr0yYGvacXPPkEIfowt5kY+42M/txUIh1TavoBdUlw8x+6hmC6Hv+3ltb
         qmOAsXz3phyORB61AE2+qSmmXThsdqwVf9kkW9DxOMnkEJRkHYBcf7fWwWrh6MhTzIh9
         7UtfYXS+r6ioJzeNyCiykoq1tJLLjA1GsW00KXYzDHBvaZ2+/29HhF6+lGFpl5cN3BVg
         iCDQ==
X-Gm-Message-State: APjAAAUzJv0ii9YRCgPr+SE8zRDoI/8M4f+m88yTH9n369g9YM7s6/r7
        bI5amDDezWaoUXBgjQtNNbQ=
X-Google-Smtp-Source: APXvYqw/FafyvHl5sUxc6eDglu2m7EoY7WdzMeh23pojbHGL/Cb7QePA1qCCqsEp/d6OTmqOtmS23Q==
X-Received: by 2002:aca:e8c4:: with SMTP id f187mr8270335oih.158.1554220219982;
        Tue, 02 Apr 2019 08:50:19 -0700 (PDT)
Received: from localhost ([130.164.62.212])
        by smtp.gmail.com with ESMTPSA id g21sm5807120otk.12.2019.04.02.08.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 08:50:19 -0700 (PDT)
Date:   Tue, 2 Apr 2019 08:50:18 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 10/17] fpga: dfl: afu: export __port_enable/disable
 function.
Message-ID: <20190402155018.GA1453@archbook>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-11-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553483264-5379-11-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 11:07:37AM +0800, Wu Hao wrote:
> As these two functions are used by other private features. e.g.
> in error reporting private feature, it requires to check port status
> and reset port for error clearing.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl-afu-main.c | 25 ++++++++++++++-----------
>  drivers/fpga/dfl-afu.h      |  3 +++
>  2 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 2916876..e727d9b 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -24,14 +24,16 @@
>  #define DRV_VERSION	"0.8"
>  
>  /**
> - * port_enable - enable a port
> + * __port_enable - enable a port
>   * @pdev: port platform device.
>   *
>   * Enable Port by clear the port soft reset bit, which is set by default.
>   * The AFU is unable to respond to any MMIO access while in reset.
> - * port_enable function should only be used after port_disable function.
> + * __port_enable function should only be used after __port_disable function.
> + *
> + * The caller needs to hold lock for protection.
>   */
> -static void port_enable(struct platform_device *pdev)
> +void __port_enable(struct platform_device *pdev)
>  {
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>  	void __iomem *base;
> @@ -54,13 +56,14 @@ static void port_enable(struct platform_device *pdev)
>  #define RST_POLL_TIMEOUT 1000 /* us */
>  
>  /**
> - * port_disable - disable a port
> + * __port_disable - disable a port
>   * @pdev: port platform device.
>   *
> - * Disable Port by setting the port soft reset bit, it puts the port into
> - * reset.
> + * Disable Port by setting the port soft reset bit, it puts the port into reset.
> + *
> + * The caller needs to hold lock for protection.
>   */
> -static int port_disable(struct platform_device *pdev)
> +int __port_disable(struct platform_device *pdev)
>  {
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>  	void __iomem *base;
> @@ -106,9 +109,9 @@ static int __port_reset(struct platform_device *pdev)
>  {
>  	int ret;
>  
> -	ret = port_disable(pdev);
> +	ret = __port_disable(pdev);
>  	if (!ret)
> -		port_enable(pdev);
> +		__port_enable(pdev);
>  
>  	return ret;
>  }
> @@ -810,9 +813,9 @@ static int port_enable_set(struct platform_device *pdev, bool enable)
>  
>  	mutex_lock(&pdata->lock);
>  	if (enable)
> -		port_enable(pdev);
> +		__port_enable(pdev);
>  	else
> -		ret = port_disable(pdev);
> +		ret = __port_disable(pdev);
>  	mutex_unlock(&pdata->lock);
>  
>  	return ret;
> diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
> index 0c7630a..35e60c5 100644
> --- a/drivers/fpga/dfl-afu.h
> +++ b/drivers/fpga/dfl-afu.h
> @@ -79,6 +79,9 @@ struct dfl_afu {
>  	struct dfl_feature_platform_data *pdata;
>  };
>  
> +void __port_enable(struct platform_device *pdev);
> +int __port_disable(struct platform_device *pdev);
> +
>  void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
>  int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
>  			u32 region_index, u64 region_size, u64 phys, u32 flags);
> -- 
> 2.7.4
> 
