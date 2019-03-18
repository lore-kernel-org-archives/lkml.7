Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF08C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA2A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfCRRck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:32:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44469 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCRRcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:32:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id x10so11083916edh.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kBwDaDVGq7k3sjvpBHQNXFBR+N6tX3aOiM06y7JO6gg=;
        b=nEyqYPOg09iEKW9rrQ4U9IpXl2qvr6dnHmdwFW38GixpR27c3XhrN8v+vugRJJhV+f
         msxV0Ju58dOHfgF7+Yd0D9rA9Ea+icrwGPrAuVdQWmp0f5yIfWIf7hUw+lrRtGqcKxH5
         b6Ex1ZyH+yp+26shH7ji4yMtVP4bOnix9HbXR0REWog7S2FNiBL9H0GkQvuKPqkePP1S
         K1GsNwwu2yBsoaugGovRptits8DRhRZzY7kQXfKrJX9rEkSjL2cwJZo7/n+KKoNuR1DZ
         xOqulgyQ63kv/raP0YYEvfiW65iHAb55s7viDuTjGJe1vAVSbvJOiYpu5u2r9w98VfEQ
         a3wA==
X-Gm-Message-State: APjAAAWhm6VYhseCQrn4pALiYTYJ1ZFUmgv0vXWZLnl9VAGNdpT2bjjw
        DPyQ8hLwuLseZhOjs8YXeDjFCrra2/w=
X-Google-Smtp-Source: APXvYqzk6IpYEIP68OVgZtg3lPYOludgyb4VQ4VTNsECCUmL4A/6DDxqrEc1A+M/LdW3qtdvA/YUoA==
X-Received: by 2002:a17:906:6014:: with SMTP id o20mr11733390ejj.7.1552930357358;
        Mon, 18 Mar 2019 10:32:37 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id i1sm2443778edi.15.2019.03.18.10.32.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 10:32:36 -0700 (PDT)
Subject: Re: [PATCH] power: supply: axp288_charger: Fix unchecked return value
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190318161439.GA6245@embeddedor>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e42cdec8-911d-950a-8b06-3b1aefaba74c@redhat.com>
Date:   Mon, 18 Mar 2019 18:32:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190318161439.GA6245@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18-03-19 17:14, Gustavo A. R. Silva wrote:
> Currently there is no check on platform_get_irq() return value
> in case it fails, hence never actually reporting any errors and
> causing unexpected behavior when using such value as argument
> for function regmap_irq_get_virq().
> 
> Fix this by adding a proper check, a message reporting any errors
> and returning *pirq*
> 
> Addresses-Coverity-ID: 1443940 ("Improper use of negative value")
> Fixes: 843735b788a4 ("power: axp288_charger: axp288 charger driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/power/supply/axp288_charger.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
> index f8c6da9277b3..00b961890a38 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -833,6 +833,10 @@ static int axp288_charger_probe(struct platform_device *pdev)
>   	/* Register charger interrupts */
>   	for (i = 0; i < CHRG_INTR_END; i++) {
>   		pirq = platform_get_irq(info->pdev, i);
> +		if (pirq < 0) {
> +			dev_err(&pdev->dev, "Failed to get IRQ: %d\n", pirq);
> +			return pirq;
> +		}
>   		info->irq[i] = regmap_irq_get_virq(info->regmap_irqc, pirq);
>   		if (info->irq[i] < 0) {
>   			dev_warn(&info->pdev->dev,
> 

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

