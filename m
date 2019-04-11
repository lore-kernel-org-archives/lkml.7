Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D192C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A66221841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9VbMSkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfDKFHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:07:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33350 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKFHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:07:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so2794079plo.0;
        Wed, 10 Apr 2019 22:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lSALp5rePL6mY7r/pqcUzoJ2ZuxIV7HQ3tqr5InLjgY=;
        b=u9VbMSkT+Bhx0J2vDV4QOeUoAYv/4iQ1xu0/6bztiU9k+qj4uxjKE0rK7zmyNc9ZiC
         ZvBec+OuWRauVqgW+8AXtnN335cIDroGt5H+chQfFNsj7swhcsN+2mBVT/38Iy45cVqR
         Fbs/Op9jAinrF3Vz/2pZDvkH/LHYQ+EBd7KKXvsmqvd6wLM2Ft9H/T5LqhNsKlQYp5cj
         S9d+AeO701S0qMH62zk0cnhBXCKGKuKDJBdH9h+xiFsbW+8JP0HLb3vP8AJsd9g9/1vw
         Ao6ZDxPFHOhuJClOgH4ATWJsTkX9a6i/p/eup+F3F+2wrYmLjwIbUUeW9eT0fZYdPBLe
         pECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lSALp5rePL6mY7r/pqcUzoJ2ZuxIV7HQ3tqr5InLjgY=;
        b=PPXDj8ZhXhO4hmWRbzHLe+8bN5TX/7H2M0zWVMsy28oeA8duCtAspJl35JUZCL0oBJ
         Ujcv3hw7ynUbG5m738EApoOiXVb2rhCyG/AZwDdZVKBdXj4X8UHUn7qQwIcN7WWrbEiC
         y+f4+mHlCQf8WhulyvPXY3zhGNA/VwNndW+nZp0wUHiJ/gayiFoPtr79xj7Hv2NGeVUR
         5xZnYdxFm9vVtxtYre9LAsUt+mwUbbWXxy0auAElhcx2nS9JGqHHWMXdO5vOt4E1Gw8O
         i9qIbGWzb8cl1U2RzgFCyau7Q9Vrl4EKnUkBGp548qR5xgTaUAG1ioj2ngibchRgVVcw
         rNOw==
X-Gm-Message-State: APjAAAXef5DLdoTyQffPY5tKoUgBe/dFDwTpGx0+tq5+EhJw2jEITjdn
        cLz+2ZN9c4gtu6Im9JEovU4=
X-Google-Smtp-Source: APXvYqyjY81uKJV+apK/Di2E6lTBAva0jxWTERVWnUwpbJuiU7IPflmRcQx5Xiv4XJdalA8g4GRY0A==
X-Received: by 2002:a17:902:7883:: with SMTP id q3mr48273077pll.60.1554959221080;
        Wed, 10 Apr 2019 22:07:01 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id e126sm89891573pfh.35.2019.04.10.22.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 22:07:00 -0700 (PDT)
Subject: Re: [PATCH] of: fix expression using sizeof(void)
To:     xiaojiangfeng <xiaojiangfeng@huawei.com>, robh+dt@kernel.org,
        robh@kernel.org, grant.likely@secretlab.ca
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1554947255-80031-1-git-send-email-xiaojiangfeng@huawei.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <d15a80a2-4a32-4475-3044-33b8e8696405@gmail.com>
Date:   Wed, 10 Apr 2019 22:06:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554947255-80031-1-git-send-email-xiaojiangfeng@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 6:47 PM, xiaojiangfeng wrote:
> problem detected by sparse:
> drivers/of/fdt.c:1094:34: warning: expression using sizeof(void)
> 
> Signed-off-by: xiaojiangfeng <xiaojiangfeng@huawei.com>
> ---
>  drivers/of/fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 4734223..75c6c55 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1091,7 +1091,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  	/* Retrieve command line */
>  	p = of_get_flat_dt_prop(node, "bootargs", &l);
>  	if (p != NULL && l > 0)
> -		strlcpy(data, p, min((int)l, COMMAND_LINE_SIZE));
> +		strlcpy(data, p, COMMAND_LINE_SIZE);
>  
>  	/*
>  	 * CONFIG_CMDLINE is meant to be a default in case nothing else
> 

The fuller discussion is in the thread where you first attempted to fix an
issue with the line of code and I reported a sparse error against this line.

After digging deeper, your first patch is valid, removing min() here is not
the correct approach.  I will add my Reviewed-by to the first patch and I
will pursue the sparse warning separately.

Thanks,

Frank
