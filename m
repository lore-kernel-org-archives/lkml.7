Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E111FC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B3920675
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556228223;
	bh=HuV9UvpUxbLXeeTQfjRUNm8essZEcNP96aHEFmqA35Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lxdcAe2xHyJlkF8m+ecthUZbcpdLpZ1mO9gfQO1OVpYr1d7sLVxpIU/4zeXXsZ1no
	 7pAB1TEKY5ZXHt90vEbMDkJtlBONJd1G0IdOuGA/ApG5nD+9m7NUlV+mWBiiVEFE3+
	 dhAnQU267BT+pWolXywrybZnKp1w4jRgxtq6GRbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfDYVhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:37:01 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35504 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfDYVhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:37:01 -0400
Received: by mail-ot1-f65.google.com with SMTP id m10so897746otp.2;
        Thu, 25 Apr 2019 14:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hk1r+IVwxSo0Cb3NtR3Z2pyp3YJEoBDs1OgkjX9P97Y=;
        b=NfQTtb0pxahR9YnzcbrB4+YXrOVhA5p71qAti3dihytuOn/s+oSvlAiFZAQR0uvFqz
         VfT4OM8vlJoic6aKcfMCgXHQQWFuApli8bmrk/z+mjizwC0/EckawKof0J5cnlXnsYBR
         Zh4DDTXfoJAfmAY+vCMiZYVUVBTT+fnI3SejuJRU+Ot7qFolp84UCFc/a3GwthK+JSWv
         BUNsbk+YCc02h8eh39fzOh5fB+qYolMOjqFK+savxlVtLq+P7vm+C21DSVajSppQVb16
         3J3HnWp801M/TS2Jkz/nf35FLrI2EJ7uR/6GHhuDWgflUSyBRZVbDipza2zV1woCbubJ
         yLgA==
X-Gm-Message-State: APjAAAWHUnYjU5XZakoSdxMlSo/rrL+kibBgqe+x/WPXSkHalsPMaRXq
        yw68TXjlVlVv+8lnk/ue/g==
X-Google-Smtp-Source: APXvYqzCwz0AiXDeuE1MlYVSxG7LifGiAIwd4Y1Q0OYEZsOL/BJDGXz4/4hSKyIGxQXq5GYRvBWb8A==
X-Received: by 2002:a9d:6318:: with SMTP id q24mr12996657otk.95.1556228219180;
        Thu, 25 Apr 2019 14:36:59 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l23sm1431441otr.81.2019.04.25.14.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 14:36:58 -0700 (PDT)
Date:   Thu, 25 Apr 2019 16:36:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yu Chen <chenyu56@huawei.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        liuyu712@hisilicon.com, wanghu17@hisilicon.com,
        butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 03/13] usb: dwc3: dwc3-of-simple: Add support for dwc3
 of Hisilicon Soc Platform
Message-ID: <20190425213658.GB32028@bogus>
References: <20190420064019.57522-1-chenyu56@huawei.com>
 <20190420064019.57522-4-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420064019.57522-4-chenyu56@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 02:40:09PM +0800, Yu Chen wrote:
> This patch adds support for the poweron and shutdown of dwc3 core
> on Hisilicon Soc Platform.
> 
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
>  drivers/usb/dwc3/dwc3-of-simple.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> index 4c2771c5e727..0ed09d876542 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -98,7 +98,8 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>  	 * Some controllers need to toggle the usb3-otg reset before trying to
>  	 * initialize the PHY, otherwise the PHY times out.
>  	 */
> -	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
> +	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3") ||
> +			of_device_is_compatible(np, "hisilicon,hi3660-dwc3"))
>  		simple->need_reset = true;

Fine, I guess, but really this flag should be moved to the match table 
so we aren't doing compatible matching twice.

>  
>  	if (of_device_is_compatible(np, "amlogic,meson-axg-dwc3") ||
> @@ -243,6 +244,7 @@ static const struct of_device_id of_dwc3_simple_match[] = {
>  	{ .compatible = "amlogic,meson-axg-dwc3" },
>  	{ .compatible = "amlogic,meson-gxl-dwc3" },
>  	{ .compatible = "allwinner,sun50i-h6-dwc3" },
> +	{ .compatible = "hisilicon,hi3660-dwc3" },
>  	{ /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, of_dwc3_simple_match);
> -- 
> 2.15.0-rc2
> 
