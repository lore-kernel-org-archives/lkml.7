Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B4DC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6619E2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXZfZHa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfDSUAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:00:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44366 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfDSUAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:00:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id y12so453987plk.11;
        Fri, 19 Apr 2019 13:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rUZIw2tPe+hpOOl2+ZOSAfQuqb/YcSro/1aIQBg9hEs=;
        b=fXZfZHa30Urc4YKh5tSKKxfRAV0Ip1iN9C92IvMSqBvreiA3q+AvMgUcEsMgjxFmE6
         GTTDyiY/+KEXGRsOVh8fp/76erqoICPE5SFas+HRWsHC33+KsXOWlO2K9wdd5oCHgzmR
         9nsNpH8xv7dA0XzBTCKDK7pPwy9slbtksAKm2+d1JKEr5OR3nIssmDxskp65mRpMk9bi
         ohNLsC3BFhzwXKTbOPGWlfZwgoxxRlKRlSpEPKqE+UI9vC2vO9VxtImpvZtTbEoDpeyF
         nALlChrGqVnAAgESd3PD642XnLmWASG90U/4yuMJzT2k709pP1JqB8YpwutGZZkBuRaA
         bUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rUZIw2tPe+hpOOl2+ZOSAfQuqb/YcSro/1aIQBg9hEs=;
        b=q2n32tIXXFhxpHJuvvJh/QlcISt2nzs6bKmKxbxvkpxdhkv9HwU+1Nkp2lA22k0mMu
         p/n6aExCT+9wuhUIDuKZcbzwENDVaoqmO6IfubbWKtO26ROUNtSdaB0LLTIcNnbLi786
         OqWQqwlX8ynTLAFoSDMjcBBi5MD/YUqPwf4J6TmNtQai1CB0SmU15G3o0tRq4Cu3dnEL
         t0HcWnEbUKRe46CkAwvycn7h4ofWCwwuNqrLxxkAberK1HwZKVkKyLSvRnYWOtiBrhKA
         BR3tanRH/LeLlt8Uk6Rr1x1fKh/jFmkRdda1lhfBLHkdqKswzJGRpV91mHmFO5vrWgL3
         X+jg==
X-Gm-Message-State: APjAAAVot6HBR3PtoFbI4RRXoH+kEec9CemuBHo3cwzQOvmYdEPmHPAt
        SI25QIExjsluFCWCw3Kyoz6GYLm6FTs=
X-Google-Smtp-Source: APXvYqyltZv9gqkabrdgx7QVeXL1tNmSjZzgZI9aG1yd5Cl8V9Dn5J5RIvXzkIUYtZzNtzmWMdQzkA==
X-Received: by 2002:a17:902:70c8:: with SMTP id l8mr2294480plt.177.1555659569962;
        Fri, 19 Apr 2019 00:39:29 -0700 (PDT)
Received: from localhost ([61.199.190.18])
        by smtp.gmail.com with ESMTPSA id a3sm4497450pgj.89.2019.04.19.00.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 00:39:28 -0700 (PDT)
Date:   Fri, 19 Apr 2019 07:39:23 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Nick Dyer <nick@shmanahar.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Input: synaptics-rmi4: fix possible double free
Message-ID: <20190419073923.6ojzx4ic5ylq3n3m@penguin>
References: <1555552715-34820-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555552715-34820-1-git-send-email-bianpan2016@163.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 09:58:35AM +0800, Pan Bian wrote:
> The RMI4 function structure has been released in rmi_register_function
> if error occurs. However, it will be released again in the function
> rmi_create_function, which may result in a double-free bug.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Applied, thank you.

> ---
>  drivers/input/rmi4/rmi_driver.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index fc3ab93..7fb358f 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -860,7 +860,7 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
>  
>  	error = rmi_register_function(fn);
>  	if (error)
> -		goto err_put_fn;
> +		return error;
>  
>  	if (pdt->function_number == 0x01)
>  		data->f01_container = fn;
> @@ -870,10 +870,6 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
>  	list_add_tail(&fn->node, &data->function_list);
>  
>  	return RMI_SCAN_CONTINUE;
> -
> -err_put_fn:
> -	put_device(&fn->dev);
> -	return error;
>  }
>  
>  void rmi_enable_irq(struct rmi_device *rmi_dev, bool clear_wake)
> -- 
> 2.7.4
> 
> 

-- 
Dmitry
