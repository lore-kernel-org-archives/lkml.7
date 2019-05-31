Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D0EC28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 00:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4C9262F7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 00:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UYD6a11T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfEaARg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 20:17:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42754 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfEaARf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 20:17:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id g24so2096226eds.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 17:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KilQgTmnb5nYWh7a+i+EYwFVHm8qNkHvjaIrcsYy+bQ=;
        b=UYD6a11T0faxUH6FuHYRubUy66uwhxQIFEQHBDNi6Hm0rsKXch8bTe4qbEogjYXF12
         +tAXmYQJ2h0kxzyQiD4t336y85hpXCAo42Kpxvof+f9lePbWvaCcWzpiUJcAHGhnIRYb
         0uJU5TwEMlTC8awpUo4J5raGlGPbw6sNU0C0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KilQgTmnb5nYWh7a+i+EYwFVHm8qNkHvjaIrcsYy+bQ=;
        b=kAVclDGmM3YzTewjw8Ebin2ZnX7leX5NvMda+amFGUfR+wyDQMzf0ktq0hhUTnV/CK
         +mYbgwzGqXifHhk0LaY8tZUGJWWldy/P5u3CaX/v1n6msyJf5nzMKNisJt4jl6BwiZ3Q
         LzeiKy4+vzZVJNsvB+C1zXMb8AiNneLfCkJ7Djv6s6TyfcaG+8UuKfUsMmpf7q2ujgvh
         KXb5rdfXvr5GOoi1wPEoxwljhCw5RbbHYTbgZC9SCtb7jzUPloFXbE3DGWla9gZWjt7Q
         cqBlgNTkBc/rJMGVHVlhR060HbChbWb4KsV2uBKfByXTM5Qw15K7VPTMRhCiaXoZXCpD
         QP4Q==
X-Gm-Message-State: APjAAAWc/IPQ20RfSztwsO44nJwdbfhQuj4R7pKDMGXHX4xUi825YY1/
        OGJTuzOOd6ia7v0YLY1QTfc976z/EpNBVOZjJpYbSrY+PngI6toIOJl6aNpFedM4eHZ6S3ffTzV
        tK9GCJCIZOxca9JHTcVC4md9YrOsrsceh1WUX2+BRk6gQkm7RIwgWRjuQMQIffrtLxZjMPqdU33
        MvAmM=
X-Google-Smtp-Source: APXvYqxpHaDuapqKKB2H8FRfUx2YJNboFSFW9NVWgRnsRiE5ANLJDWfQM9va4NxyzqJDXI1k3Rd8FQ==
X-Received: by 2002:a17:906:843:: with SMTP id f3mr6346472ejd.70.1559261853687;
        Thu, 30 May 2019 17:17:33 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id o2sm684618ejz.22.2019.05.30.17.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 17:17:32 -0700 (PDT)
Subject: Re: [PATCH] pinctrl: ns2: Fix potential NULL dereference
To:     Young Xiao <92siuyang@gmail.com>, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1559097838-26070-1-git-send-email-92siuyang@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <ace57d13-6194-df8e-d2e8-fbc85d9ce21a@broadcom.com>
Date:   Thu, 30 May 2019 17:17:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559097838-26070-1-git-send-email-92siuyang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2019 7:43 PM, Young Xiao wrote:
> platform_get_resource() may fail and return NULL, so we should
> better check it's return value to avoid a NULL pointer dereference
> a bit later in the code.
> 
> Signed-off-by: Young Xiao <92siuyang@gmail.com>
> ---
>  drivers/pinctrl/bcm/pinctrl-ns2-mux.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/bcm/pinctrl-ns2-mux.c b/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
> index 4b5cf0e..2bf6af7 100644
> --- a/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
> +++ b/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
> @@ -1048,6 +1048,8 @@ static int ns2_pinmux_probe(struct platform_device *pdev)
>  		return PTR_ERR(pinctrl->base0);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res)
> +		return -EINVAL;

Right, usually not needed if devm_ioremap_resource is used since it was
checked there. But in this case, I do think it needs to be checked. This
change looks good to me. Thanks.

>  	pinctrl->base1 = devm_ioremap_nocache(&pdev->dev, res->start,
>  					resource_size(res));
>  	if (!pinctrl->base1) {
> 

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
