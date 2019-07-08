Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C801EC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9647D20665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kVwkmPHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfGHGgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 02:36:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51478 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbfGHGgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 02:36:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so14487593wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 23:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4XQUJtwFCPubD2c81CREAUVgFw9rYm1UoaxaFdnnNdo=;
        b=kVwkmPHNEJB2whTCj7Hri7TN3H0Ok4sdeM5HMvBye0w8ir6Vt3JF8ZnYJ0jyORbsIE
         rMB0Kp4pC5ErQmTNwAoFY8UUjUcq6wuQocxvHv5VTlPRQvkeiu8SXeVry9qJnNu6iW+B
         h1hOBOkABCBZ9unLqhCzvqwOP/X/HrP+UveABdIk9TBKC+idtVWe7HAaroxPCu1q4rXT
         2urnOQkRWuUq5EBl77zqXXVrXmYIg2uCNMtVeMAGYiqgChJQpm2m8341qu9qFoFDQ74q
         6hmOW1VwzmlED5el7XISCNx8xRy4LQagIJyt/i3RoEzXWtO5mJphXxVQXtkIhS44SmlA
         7cDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4XQUJtwFCPubD2c81CREAUVgFw9rYm1UoaxaFdnnNdo=;
        b=AJ50CqL20q1vPeDcbXz6YtOotvAzJM1DGEbJ/r73Xn+Oa0mNSduplvw052j+j0wmaB
         UPB0e5iDpuOJglwcnoYePtXFGCwwmJOsEoaNpGmrWmtJwLrul80625ChKjwrktq/Nifu
         HJOLubpKuJPOyap+McQ7wDrjzIGFZE/gQu0AIfEhqRTN6GK8R6Reps+2B80XQbrwP8tK
         2XLTV9/34mUlwXt/zmMu/q+VTS2CzRIOKXB50pm8A06JIitoME5kbRj7XEgxLdYswpq+
         j254O81Yq4AYNWtYKr7SASyb47UHg1mu9/hNgbYTqh+OtyJHGAHQ+nYCphOvu+oKRIzt
         u7SA==
X-Gm-Message-State: APjAAAUhf9nO6UTF9LvLP/gBl0lQxSq0eIEMe7sY/uU8/9/m3VOv7oGD
        Cm+6nFXv4f00nh8Qb7dHjy0VWA==
X-Google-Smtp-Source: APXvYqwSNgc9S2iC3V5CvgiU/2zkAD/yGZ0BqC+lBVBbcliz34DQX1ZB4h5yyXS0VjK2R2oLvwvezQ==
X-Received: by 2002:a1c:228b:: with SMTP id i133mr15042590wmi.140.1562567811920;
        Sun, 07 Jul 2019 23:36:51 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id f12sm16775878wrg.5.2019.07.07.23.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jul 2019 23:36:51 -0700 (PDT)
Date:   Mon, 8 Jul 2019 07:36:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] mfd: asic3: One function call less in asic3_irq_probe()
Message-ID: <20190708063649.GA4800@dell>
References: <01f6a8cd-0205-8d34-2aa3-e4b691e7eb95@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01f6a8cd-0205-8d34-2aa3-e4b691e7eb95@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Jul 2019, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 5 Jul 2019 20:22:26 +0200
> 
> Avoid an extra function call by using a ternary operator instead of
> a conditional statement.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/mfd/asic3.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
> index 83b18c998d6f..50f5368fb170 100644
> --- a/drivers/mfd/asic3.c
> +++ b/drivers/mfd/asic3.c
> @@ -401,11 +401,10 @@ static int __init asic3_irq_probe(struct platform_device *pdev)
>  	irq_base = asic->irq_base;
> 
>  	for (irq = irq_base; irq < irq_base + ASIC3_NR_IRQS; irq++) {
> -		if (irq < asic->irq_base + ASIC3_NUM_GPIOS)
> -			irq_set_chip(irq, &asic3_gpio_irq_chip);
> -		else
> -			irq_set_chip(irq, &asic3_irq_chip);
> -
> +		irq_set_chip(irq,
> +			     (irq < asic->irq_base + ASIC3_NUM_GPIOS)
> +			     ? &asic3_gpio_irq_chip
> +			     : &asic3_irq_chip);

The comparison better suits an if statement IMHO.

How about:

  		struct irq_chip *chip;

		if (irq < asic->irq_base + ASIC3_NUM_GPIOS)
			chip = &asic3_gpio_irq_chip;
		else
			chip = &asic3_irq_chip);

		irq_set_chip(irq, chip);

>  		irq_set_chip_data(irq, asic);
>  		irq_set_handler(irq, handle_level_irq);
>  		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
