Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D27EC10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A34215EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mf3QWc+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfJBX3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:29:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41147 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfJBX3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:29:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so472958pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 16:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mfYTRE2wrHnGHdzN9pNRX0i1wlfEpry7vj/JNYrQ7CY=;
        b=Mf3QWc+S+bv5pPGAm5l5TcASwdcoob1IpAJzIYmCUhXcHc9GZtCIr3XT5pjbAuSPTS
         AWmeLFS3b+jY913B1ysUu3DmViojEU2i9R/tFiFtAV+95O7xfx1ymyUlCoel6td6Eh1e
         Aeti9QCjKm2ld4obHKXX8u4j/MNnSQabQF1YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mfYTRE2wrHnGHdzN9pNRX0i1wlfEpry7vj/JNYrQ7CY=;
        b=AY4jyaKVHK2Myffo7Zh4wBJ4BH9Mcdl4nE1vsDkkez3f07eRlt8Y6EVttvpm4rwGmM
         AMECtd0GuJFEO7ZDiYbrJRQxAGYvf8yyL55vIq22xzJo9wGxnZXDyZ0HC+5q3NAe9GcQ
         v8Zy89N2nKwTmvnX+MBu2UQxVakcG+oTeAMaYEPeUvMZKsrczpG5PUjvxJYkLhy/xSdh
         P+Y5/XUQhJOWWIXF9D+AuL0wfLCAkBsFzDu5yZG6mJ1MRuxOmCzBlyR1xMSU5Ya9cDQd
         VmjvjXAgGqpxn0FFIOdn6oeNKTLyc+ZGqzVYOJZDnC+4mIAnP54dJrijnMpPqssThbBh
         G7xA==
X-Gm-Message-State: APjAAAVnpNKIKrOIa0KweXF6iL1Ik9pxKWTOn9yKzAwBne2RHyB44BSL
        hxL6yCeEMruah80h+bXcRiszX9VGauKLqqPbvZueE0zC5VEs4hgqTLuC/ME/gpy7BMPZZTgN8aJ
        vE+yufBhsSXXZVSXhiE5Pl2AWIHubfkCELqcHP9rhOe3+VxKXFV5PXAjxx6GK2LnIwzfe0vGTMe
        wTuNnSp1AO
X-Google-Smtp-Source: APXvYqwb1v+OFwGH/X+Zf8U8nxSjb6n41/d9STpAf2augV7Q8TlFtC9GLo/vHrIL44A4Hqi6BErSww==
X-Received: by 2002:a63:e14:: with SMTP id d20mr6038229pgl.33.1570058977001;
        Wed, 02 Oct 2019 16:29:37 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l72sm342214pjb.7.2019.10.02.16.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 16:29:36 -0700 (PDT)
Subject: Re: [PATCH] pinctrl: iproc: improve error handling
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linus.walleij@linaro.org, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        rayagonda.kokatanur@broadcom.com, li.jin@broadcom.com
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20191002220034.2034-1-chris.packham@alliedtelesis.co.nz>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <045d67e2-5618-3742-5519-c4fb9518c118@broadcom.com>
Date:   Wed, 2 Oct 2019 16:29:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002220034.2034-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On 2019-10-02 3:00 p.m., Chris Packham wrote:
> platform_get_irq() can return an error code. Allow for this when getting
> the irq.
Above matches change in 1st line of commit.  Please add a Fixes: tag
for such fix.
>    While we're here use the dev_name(dev) for the irqc->name so
> that we get unique names when we have multiple instances of this driver.
The dev_name change should be in a different commit to keep things
bisectable.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> Noticed this while debugging another problem.
>
>   drivers/pinctrl/bcm/pinctrl-iproc-gpio.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
> index 6f7d3a2f2e97..c24d49d436ce 100644
> --- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
> +++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
> @@ -853,12 +853,12 @@ static int iproc_gpio_probe(struct platform_device *pdev)
>   
>   	/* optional GPIO interrupt support */
>   	irq = platform_get_irq(pdev, 0);
> -	if (irq) {
> +	if (irq > 0) {
>   		struct irq_chip *irqc;
>   		struct gpio_irq_chip *girq;
>   
>   		irqc = &chip->irqchip;
> -		irqc->name = "bcm-iproc-gpio";
> +		irqc->name = dev_name(dev);
>   		irqc->irq_ack = iproc_gpio_irq_ack;
>   		irqc->irq_mask = iproc_gpio_irq_mask;
>   		irqc->irq_unmask = iproc_gpio_irq_unmask;
Thanks,
Scott
