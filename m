Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCE1C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1682120865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DhN5LdLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390028AbfJCSgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:36:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40457 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbfJCSgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:36:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so2289117pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Re8qV2QdvbkLCeb2K8HW6hCEuJ7wbKTMp5YuNreyJxY=;
        b=DhN5LdLlc5xvMIxx+vE4iDLvGqtc3RN6Ll9kD5TCP0XPOUl9jAD6ivWCq31Q9jG1Dc
         xwLcQ3N40GFgAGHTDlvYM4TP9qXfOOW/CwEIZhxaAUqbwkhN16Ut+NgbbutBz9dX269C
         7BIlIfjg+RsItpnL7PVKdDy/aM6ypmt2kbppw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Re8qV2QdvbkLCeb2K8HW6hCEuJ7wbKTMp5YuNreyJxY=;
        b=EY2wEKDxat0zhEjptV41HGG+4+p67nScohNTj0Dbe+GPSEoq74KojEr/RoRwH2ABbA
         U5NPxqFdvvW/zZ1zcAH3i4R2Oo6hX3WFB1aykpIIFpJ7xHYw+aVsYj7h6dAx+E9d5KkK
         elhgW3bVTiJMEAX9SQaR9WlhkTs069bEBYes1Jp2nooA1wKKsbMzseNZzcBv5ulqOZQW
         Ndm2lz18ABuzzTehwienaexjFDRoWzENPJYCEoM0IEMaV0CwA8R11i8h8U+fbt91W0SL
         TOJy2SZGRt7C8Ofb2lPFFsYuplglokGqi59RxLvCJLxJhh3s8UkAjOzctMWg24symDqS
         4W5g==
X-Gm-Message-State: APjAAAXHXkpDMffmt+xAiTCXjZMiJRqQNfUUx39KmftNcaQGyduGmFZm
        Ju9ZDsmLxzPM2yuj/tgzJO1gDBwVFiRi/rWnJg7peUKJh6atfGsqmvgmsC8P5OQJxIBhGcjCNLB
        jDZrEnGDwO+h7L3TGwd3kc9V2W/pNDDujtlAfflHqGJXnS1IJwbvn2IwG4yF4kv2HMBe+nwrKAS
        djpRf7xKDy
X-Google-Smtp-Source: APXvYqwQam6eWnyNaRnvLC8IN79OfdtNQK6s5BG7GaJaxRKfpvaD0CESp4p/ah8VMpLvWn6AtodhCA==
X-Received: by 2002:a17:90b:8d1:: with SMTP id ds17mr12110001pjb.47.1570127811972;
        Thu, 03 Oct 2019 11:36:51 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id k8sm2795137pgm.14.2019.10.03.11.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 11:36:51 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] pinctrl: iproc: use unique name for irq chip
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linus.walleij@linaro.org, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        rayagonda.kokatanur@broadcom.com, li.jin@broadcom.com
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20191003000310.17099-1-chris.packham@alliedtelesis.co.nz>
 <20191003000310.17099-3-chris.packham@alliedtelesis.co.nz>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <3c03506b-8ac3-4f17-3784-fd0292e3d3ee@broadcom.com>
Date:   Thu, 3 Oct 2019 11:36:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191003000310.17099-3-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

looks fine

On 2019-10-02 5:03 p.m., Chris Packham wrote:
> Use the dev_name(dev) for the irqc->name so that we get unique names
> when we have multiple instances of this driver.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/pinctrl/bcm/pinctrl-iproc-gpio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
> index 8971fc54e974..c24d49d436ce 100644
> --- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
> +++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
> @@ -858,7 +858,7 @@ static int iproc_gpio_probe(struct platform_device *pdev)
>   		struct gpio_irq_chip *girq;
>   
>   		irqc = &chip->irqchip;
> -		irqc->name = "bcm-iproc-gpio";
> +		irqc->name = dev_name(dev);
>   		irqc->irq_ack = iproc_gpio_irq_ack;
>   		irqc->irq_mask = iproc_gpio_irq_mask;
>   		irqc->irq_unmask = iproc_gpio_irq_unmask;

