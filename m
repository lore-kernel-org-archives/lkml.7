Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086A6C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65E020830
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1vFD2Xt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfDHSBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:01:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39279 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHSBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:01:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id n9so3648808edt.6;
        Mon, 08 Apr 2019 11:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JzhYpQwzM8UmI2HqYGyqYI08FOU/Qjd+eHIpOz9l9Kc=;
        b=G1vFD2XtE9C62egRs0KG2mAI4iw4Mut0vYFiqR3sGLB1tCyzGFkgqZpME5KjyYjjXM
         HSW56Jn4NJFvFklZK117lqifSCw9nBn0+RmGMBDssof4OD7no5NRFn4xsuYJ33Jf/R3b
         a9qQW8WjCTI4HlcExhzyE057pKT9ifhs49xH8SSVvpvGGZE8XOiRB82MeV+kwXY8hwnp
         ijlT/9bNULzToEYXvyxHG/hNtYK3s6HVORsYLzkXQk8+WwcdqIBJoWj36yam126CZSvo
         4XybsgBWnEaJXY41rI3MFvytOOu/kZRiprdryvPNQ9Saz/zlHB/u2j/X5w/ZPqDX1mjX
         Hu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JzhYpQwzM8UmI2HqYGyqYI08FOU/Qjd+eHIpOz9l9Kc=;
        b=rhiqOKLgikaELr/WsB06ZnxqSosAAedWeDQvgeOS3L2F+aylednY9co2o5+HtXNjn8
         x6MnTKj1WxpztmaChy7P9CO5dAFcYG2NiUXMtqCx3QTTTPeYeWs8n8s/yFHYMZLDKffW
         y7hzfQPs7M82/J1uPHUQrPy0/o4+3iSo2zRqQpy/Hj3RwcSRlqTO9ZlLGq2BjWOU1OT6
         swdLh/EfCjbeoDQqi1C+PXTVMMtSF3ciYE/aR0S2tMrAzK/nacKKLCXE25YalWj2rFMD
         vmG8itccNJK5gmFiwBgB9PzkOet++QbJ0pdraw8Jq9wRc/NYGI9ZefAvXaUTH7SMxia7
         K5iw==
X-Gm-Message-State: APjAAAVqurt6KzMpNrfUkEUlsqXqd2VMFIupV6H+Obv6SeAHqYV+TZ+U
        m4A/iIWPl8vMlASmjMyePUc=
X-Google-Smtp-Source: APXvYqxU/cfCR+VAcF1LmJNvOmWNwqUBbgxTUwHXm1ykWHE0+cwnCdW6gLCU+GjZgQkj3y1eBFWw4g==
X-Received: by 2002:a17:906:4c95:: with SMTP id q21mr9581194eju.14.1554746473259;
        Mon, 08 Apr 2019 11:01:13 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id m12sm1064764edi.3.2019.04.08.11.01.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Apr 2019 11:01:12 -0700 (PDT)
Date:   Mon, 8 Apr 2019 11:01:10 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     jesper.nilsson@axis.com, lars.persson@axis.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@axis.com
Subject: Re: [PATCH -next] pinctrl: artpec6: Make two functions static
Message-ID: <20190408180110.GA15199@archlinux-ryzen>
References: <20190321150909.3576-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321150909.3576-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:09:09PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warnings:
> 
> drivers/pinctrl/pinctrl-artpec6.c:691:5: warning:
>  symbol 'artpec6_pmx_enable' was not declared. Should it be static?
> drivers/pinctrl/pinctrl-artpec6.c:705:6: warning:
>  symbol 'artpec6_pmx_disable' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/pinctrl/pinctrl-artpec6.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-artpec6.c b/drivers/pinctrl/pinctrl-artpec6.c
> index d89dc43..e836850 100644
> --- a/drivers/pinctrl/pinctrl-artpec6.c
> +++ b/drivers/pinctrl/pinctrl-artpec6.c
> @@ -688,8 +688,9 @@ static void artpec6_pmx_select_func(struct pinctrl_dev *pctldev,
>  	}
>  }
>  
> -int artpec6_pmx_enable(struct pinctrl_dev *pctldev, unsigned int function,
> -		       unsigned int group)
> +static int artpec6_pmx_enable(struct pinctrl_dev *pctldev,
> +			      unsigned int function,
> +			      unsigned int group)
>  {
>  	struct artpec6_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
>  
> @@ -702,8 +703,9 @@ int artpec6_pmx_enable(struct pinctrl_dev *pctldev, unsigned int function,
>  	return 0;
>  }
>  
> -void artpec6_pmx_disable(struct pinctrl_dev *pctldev, unsigned int function,
> -			 unsigned int group)
> +static void artpec6_pmx_disable(struct pinctrl_dev *pctldev,
> +				unsigned int function,
> +				unsigned int group)

On arm32 allyesconfig:

drivers/pinctrl/pinctrl-artpec6.c:706:13: error: unused function
'artpec6_pmx_disable' [-Werror,-Wunused-function]

This is the second time you've introduced an unused function warning by
making a function static[1], could you please be a little more vigilant
in your clean ups in the future?

[1]: https://lore.kernel.org/lkml/20190327050126.12064-1-natechancellor@gmail.com/

Linus/Jesper/Lars, should this function just be deleted? I'd be happy to
send a patch doing so if that's the right course of action.

Thanks,
Nathan

>  {
>  	struct artpec6_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
>  
> -- 
> 2.7.0
> 
> 
