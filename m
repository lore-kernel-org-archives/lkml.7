Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9B7C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437C72086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HjYUlKzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbfJCSgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:36:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46704 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388309AbfJCSgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:36:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so2261335pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YFyTJ8BzR0j/Y9IcLHxBPvpd6JctIzAZJXdgxvtLnB4=;
        b=HjYUlKzlfPmLuOeVnGPU1fDy8FAs93KFB4BbrHc2eQ3zoY9a/AeHZZapnk0WReita+
         dvGoW+KaCndigpvJPQMiCF0AuNnvnfGzxp8pwXtIRFC1D++SCikoOlik7zow8WM/Ow9J
         IzktcyTzDwY3BB3ygRkVfzJmNy6zxHstm0+nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YFyTJ8BzR0j/Y9IcLHxBPvpd6JctIzAZJXdgxvtLnB4=;
        b=iIewJNcp19KHjnZB1jVsU3LYU8nHAf7oPHNTRxoVROC+dMaS2zNWg27mXhkOjEokF/
         p7RCfJv/yQkMonIkUu/kCkrMqKnYbAZYUeZdl6mGtBLl/c/ute+psvep7Gai1uH8iOm8
         u5ySwIC6/ak2NiqTN7wd+yFQ9EL/dCLTeXVKekCROpeg4tdr/OfIeZbr1GpwDyBV2d0o
         lrmGIDaTPprkiy8gqQeQkRXkKXNGHt9YdIf8i5KdtSnarHSJXlwE8p+E8GU9DDwl2kex
         YbNqt5b0RKXXJczUJ8yl1qowHhSphNvRTQJCk8hW1G9qtmJkk3YPmkbsYz/5BxBeQXhH
         Y4GQ==
X-Gm-Message-State: APjAAAWN2WRj1KlNdmDp7+bwAcSN7obM4Bp7UYFsW4lfxpHAEBZ2KmZt
        Ow64CrhrhnHRLAuxHXn2gUTEwiCiWC6/4Ig/AKgold+eJg3YtxriNMRFBD57Df8rXm4TG2TLgOs
        Aqes+W6Uk9w6GIViswTrtQQLHTInCADcXGUvD2IDyECZs/MUzC2IkI49Q0XfO4DUD3LxAzTbNrW
        xB9XNOOmS8
X-Google-Smtp-Source: APXvYqw/7fw6vP2s6NX9UHYGAKljiKQWnc4jhc+Ay4Tgk/hDnxvqm18CQECsXyauhzkcvzEEWggUGQ==
X-Received: by 2002:a17:90a:3d08:: with SMTP id h8mr12382854pjc.12.1570127768511;
        Thu, 03 Oct 2019 11:36:08 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b16sm4355458pfb.54.2019.10.03.11.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 11:36:07 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] pinctrl: iproc: allow for error from
 platform_get_irq()
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linus.walleij@linaro.org, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        rayagonda.kokatanur@broadcom.com, li.jin@broadcom.com
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20191003000310.17099-1-chris.packham@alliedtelesis.co.nz>
 <20191003000310.17099-2-chris.packham@alliedtelesis.co.nz>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <420179c4-3e8c-2ad9-4bdd-ee745cedd8d5@broadcom.com>
Date:   Thu, 3 Oct 2019 11:36:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191003000310.17099-2-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for fix.

On 2019-10-02 5:03 p.m., Chris Packham wrote:
> platform_get_irq() can return an error code. Allow for this when getting
> the irq.
>
> Fixes: 6f265e5d4da7 ("pinctrl: bcm-iproc: Pass irqchip when adding gpiochip")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/pinctrl/bcm/pinctrl-iproc-gpio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
> index 6f7d3a2f2e97..8971fc54e974 100644
> --- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
> +++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
> @@ -853,7 +853,7 @@ static int iproc_gpio_probe(struct platform_device *pdev)
>   
>   	/* optional GPIO interrupt support */
>   	irq = platform_get_irq(pdev, 0);
> -	if (irq) {
> +	if (irq > 0) {
>   		struct irq_chip *irqc;
>   		struct gpio_irq_chip *girq;
>   

