Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C430C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 00:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A44721479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 00:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXVd4PE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfFSAVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 20:21:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45342 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfFSAVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 20:21:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id bi6so6372536plb.12;
        Tue, 18 Jun 2019 17:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QKQ5dtYnqxmy6bgOfqdi46t1jOuoHpggM28BRKB8AQ8=;
        b=MXVd4PE57vRHp+k2WFV6t5QMzwcjpc2Cx5sWT5JMVgZSA/6sqNrHJ6MkXMCDejw1k9
         5Nv/3cwpodbSEmrnvkK5R9k8kad/UqNjySudhE+pupt+Z47AKNVIfMT9aWdLNUjCKFW7
         erbVlptf9+0sIrJN3Aj5WKZxILBfK31F0MsT2qTNTR/ZRBiRx2i1VanSDIYyBEvvOiA6
         1d/UapBC7obDjxE5JVbqb8p+KtmBjK1isDQAGYHOz6FpEFTeM5et4zw94hoEmSb7ueWJ
         lTfecVYclMek/1DSs64Dwq29XuAHVUzWWeKaMoEvPlA7XcOAZMrGf/QXD81eZ5BtNXeT
         BiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QKQ5dtYnqxmy6bgOfqdi46t1jOuoHpggM28BRKB8AQ8=;
        b=rKovPo27TacFCI3JtE38usojquGbWwc1ZJbNIdG6X0mYhRi3Mog8M0r/5guTpM9ONN
         ueMhG2kZBDQaYTfqCqtA+VpwqIzkKDachqbP41rcCMu/kgc0GeqcHNZ0zqIz1AwRC7jr
         HKwlP9cvNF949+RK6kFjir23Bugy/WlbBDFW2WTEd6A8alfTLRKjI1KnIPQm4+AYKMiK
         mxQG8F0a+qRZPXcdVsqy74LOzbtlV7BIEgBgIG1TyeTq5xZEO93lw8qhX6n8m7GDOYsy
         Y9krFS44Z4HxiBKB/lj24jflwV3gvcihI//A0/JBYbDZrOxl9lmvishvwGuYfX6JX2+o
         PqOg==
X-Gm-Message-State: APjAAAUNAYWlTGv8DYarOJo43OSc73dGcgI8jEqmx1Q/EwYXHx3KVfb1
        tguFXLNCt0xSwpdkYlLq5itNITo5
X-Google-Smtp-Source: APXvYqwhwHh60c7Jq2c+bmQdh2Jk4gQ/goBNU1RRwAbHB5SSvohsQhuh6iDSuJBe+EK2aHszyV2Giw==
X-Received: by 2002:a17:902:24d:: with SMTP id 71mr119804933plc.166.1560903659966;
        Tue, 18 Jun 2019 17:20:59 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id g13sm15821370pfi.93.2019.06.18.17.20.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 17:20:59 -0700 (PDT)
Date:   Tue, 18 Jun 2019 17:20:57 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: gpio_keys - use struct_size() in devm_kzalloc()
Message-ID: <20190619002057.GB62571@dtor-ws>
References: <20190618152325.GA21504@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618152325.GA21504@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 10:23:25AM -0500, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct gpio_keys_drvdata {
> 	...
>         struct gpio_button_data data[0];
> };
> 
> 
> size = sizeof(struct gpio_keys_drvdata) + count * sizeof(struct gpio_button_data);
> instance = devm_kzalloc(dev, size, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = devm_kzalloc(dev, struct_size(instance, data, count), GFP_KERNEL);
> 
> Notice that, in this case, variable size is not necessary, hence it
> is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/gpio_keys.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 6cd199e8a370..c186c2552b04 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -774,7 +774,6 @@ static int gpio_keys_probe(struct platform_device *pdev)
>  	struct fwnode_handle *child = NULL;
>  	struct gpio_keys_drvdata *ddata;
>  	struct input_dev *input;
> -	size_t size;
>  	int i, error;
>  	int wakeup = 0;
>  
> @@ -784,9 +783,8 @@ static int gpio_keys_probe(struct platform_device *pdev)
>  			return PTR_ERR(pdata);
>  	}
>  
> -	size = sizeof(struct gpio_keys_drvdata) +
> -			pdata->nbuttons * sizeof(struct gpio_button_data);
> -	ddata = devm_kzalloc(dev, size, GFP_KERNEL);
> +	ddata = devm_kzalloc(dev, struct_size(ddata, data, pdata->nbuttons),
> +			     GFP_KERNEL);
>  	if (!ddata) {
>  		dev_err(dev, "failed to allocate state\n");
>  		return -ENOMEM;
> -- 
> 2.21.0
> 

-- 
Dmitry
