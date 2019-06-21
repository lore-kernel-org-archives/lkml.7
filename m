Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AE6C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF6F208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="dEwA46sK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfFUI2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 04:28:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39103 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfFUI2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:28:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id v18so5227019ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 01:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y/byJ90aNdg3Pqz+FT01BYtKKMWzDXjNty5j77MnPKg=;
        b=dEwA46sKfRRhifrHIC27/RULTXBoKZ4uCeUXCJTtP0a9w+Nzc2qMNvCT8I2KZDdETX
         O8OWAWY/PITqJTflD8CLvfNKglM3MGJX6rw637njcWHvh52xJV0XaMAHI66NMbd5eMU8
         n3m5+8rF468uYmQrfXVQOBHXcSHjpokhO1xiGD0c/EIf1BscV2Ba53pKTDpxFSAY/ODO
         QJK4tHlKietA5IkWOkTRj/qdzEVV0bhWxgVgz5uQOGE0ESEMdLP5QkGNpEPMxONzQk48
         cDuvzbeWZgFEzH+h0Pa87g3CpqCBRY5XwUosBT1zOg15/+6PjUm1VwHiW2exg8aEWMP8
         JyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y/byJ90aNdg3Pqz+FT01BYtKKMWzDXjNty5j77MnPKg=;
        b=g4I9L7OR5Fl3OmlcV+ip6mj9IUlR8G92kAmj8L9xyxZcLgcAx/PnY6j4RvfG4In3ER
         Xt3AI5gM3Wj4uScqqIaXnSjis66V0m5DXn42fQkbI7SQ7yTuT8JOXrpiUJ0voDN6uAh+
         fPyZtyx1Tn4XGAt1iZWwuq5ghswP6ydMKwuc4GJvzPoS3Qjj2HyF9g0rL/wVY6xU8Ooh
         71cdPWs8qHlnsWT+kNoE4Dj2avMvkXFVgLac8oeAZZu9tas2G7YMH9PsrZ4o0dDALxTd
         ZMVrmY2ocJZomBGJQPZj50pjwyxA7Z6BNC/5Pbj2YLRFBODOdp/3ZCywzo4dH3Groocc
         43fg==
X-Gm-Message-State: APjAAAVH8fzwdXJ+DdgtKtwckkvXXAvScD9GuM9RLjDpVWilB/e8aUui
        cu6Se+Cb2zk5M8mk+E9f//Bsww==
X-Google-Smtp-Source: APXvYqwNSL1uHelWPTEWNV2IUQNYffRO96scF8rXsXvJoqpeVar8A9njpmcrYixAWbYA0AoFEG2tvg==
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr62098450lje.46.1561105714963;
        Fri, 21 Jun 2019 01:28:34 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.80.27])
        by smtp.gmail.com with ESMTPSA id r17sm291512ljb.77.2019.06.21.01.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 01:28:34 -0700 (PDT)
Subject: Re: [PATCH 6/6] usb: bdc: Update compatible match strings
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
References: <1561064991-16874-1-git-send-email-alcooperx@gmail.com>
 <1561064991-16874-7-git-send-email-alcooperx@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <facac509-1e64-e35b-ee25-5ba265a514c4@cogentembedded.com>
Date:   Fri, 21 Jun 2019 11:28:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1561064991-16874-7-git-send-email-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 21.06.2019 0:09, Al Cooper wrote:

> Remove "brcm,bdc-v0.16" because it was never used on any system.

    You're not really removing it, are you?

> Add "brcm,bdc-udc-v3.1" which exists for any STB system with BDC.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>   drivers/usb/gadget/udc/bdc/bdc_core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
> index 15e28790142d..e2b2628925e6 100644
> --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
> +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
> @@ -644,6 +644,7 @@ static SIMPLE_DEV_PM_OPS(bdc_pm_ops, bdc_suspend,
>   		bdc_resume);
>   
>   static const struct of_device_id bdc_of_match[] = {
> +	{ .compatible = "brcm,bdc-udc-v3.1" },
>   	{ .compatible = "brcm,bdc-v0.16" },
>   	{ .compatible = "brcm,bdc" },
>   	{ /* sentinel */ }

MBR, Sergei
