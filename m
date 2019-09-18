Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EEDC4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7BB20856
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qS7h3ZDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfIRNjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:39:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43097 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfIRNjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:39:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so3179945pld.10;
        Wed, 18 Sep 2019 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3coPOKz829YesHs8WeDQ/ai4YhjPoVLGbSy497MH0Io=;
        b=qS7h3ZDAoTFnRgGv1UvQCSos0CEKYa1Ol1rQOd4jzD/JiSP6N5vVOwdF3Z8RuVSoZr
         1mDJJ7fYVFpPwIN02QXU82nX1V+QV9KrobEe4wkD83KdWXbj43Yh4BTcbIURV2Napwuy
         IgdbW27UiEIT0qhx5u4WUTm62RgWNpl+ewghEdfF28M0X8pHIJn5YRfGbPLFERi2EzQh
         uW5DYqh/4bV9ON4D8XGmAcLmkChMCsh/jlDakaMQu2SgxvoiopdjqpLss1xB9NPiOefk
         2VRAUUDEYjHdTJ8B2l6jpzLuUONFWHhdDDGzYQSKQr8A3J3URqnCeq/KL0chK7/u1pRV
         g+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3coPOKz829YesHs8WeDQ/ai4YhjPoVLGbSy497MH0Io=;
        b=Kltdnz/oPWoXL+8fZ1ElXfRLMvt1QFX9BCMRM2u596Q4cQQA5FW1pjYFogMKIYZQQA
         25MCD0YeO7uitWmVrMwwSKGv8w63NLnPySf7LL1DQTVaElu2fv9AWc5QR7mNg3I8J2Dj
         fxCtMFBWSj7COAUpuBVfuVU1I8GObVXotbUKMVYvvDuRfym+Ok5puktns4X02mJZeNfd
         tjzVDQKZrCqEVpb3dduPzFbmCHorsby/7JMPZyVIENW6Wg/uvNOhZmTtcSJYWxAFGYJB
         CgtttUA4/ucx/MA3UUcfVP4ELa2oBLwTdcjSv+9ckcmQR/ElyCfykuczeUJ8BIspwRmn
         eGTg==
X-Gm-Message-State: APjAAAVIlAkkwIbh8ZDCxbYl4EDLBd2Wii8cMFSeowV9ydGXIYbcCYtv
        vR6+v0Bw2LIGmkzGsLLjpl5qIEJX
X-Google-Smtp-Source: APXvYqx81mSybzdQj0FZPyN7+YBbDAJ170gLkLCt6Wq3XQvIapP6vM/UArMpEQXp4CHtzTBTBTmctA==
X-Received: by 2002:a17:902:8f90:: with SMTP id z16mr4266870plo.138.1568813953713;
        Wed, 18 Sep 2019 06:39:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 197sm18396233pge.39.2019.09.18.06.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 06:39:13 -0700 (PDT)
Date:   Wed, 18 Sep 2019 06:39:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Joel Stanley <joel@jms.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH] hwmon: (aspeed-pwm-tacho) Use
 devm_platform_ioremap_resource() in aspeed_pwm_tacho_probe()
Message-ID: <20190918133912.GA14788@roeck-us.net>
References: <cd5bab7b-9333-2a43-bcf0-a47bbbe719eb@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd5bab7b-9333-2a43-bcf0-a47bbbe719eb@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 10:20:09AM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Sep 2019 10:12:31 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/aspeed-pwm-tacho.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> --
> 2.23.0
> 
> diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
> index 40c489be62ea..33fb54845bf6 100644
> --- a/drivers/hwmon/aspeed-pwm-tacho.c
> +++ b/drivers/hwmon/aspeed-pwm-tacho.c
> @@ -891,17 +891,12 @@ static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
>  	struct device_node *np, *child;
>  	struct aspeed_pwm_tacho_data *priv;
>  	void __iomem *regs;
> -	struct resource *res;
>  	struct device *hwmon;
>  	struct clk *clk;
>  	int ret;
> 
>  	np = dev->of_node;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -ENOENT;
> -	regs = devm_ioremap_resource(dev, res);
> +	regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(regs))
>  		return PTR_ERR(regs);
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
